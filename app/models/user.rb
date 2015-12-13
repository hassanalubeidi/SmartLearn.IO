class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable
  attr_accessor :login
  has_many :improvements
  has_many :subjects
  has_many :attempts
  has_many :answers
  
  #->Prelang (user_login:devise/username_login_support)
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", {value: login.downcase}]).first
    else
      where(conditions).first
    end
  end


  devise authentication_keys: [:login]
  def is_admin?
    if self.id == 1 then
      true
    else
      false 
    end
  end
  def all_interventions
    interventions = []
    self.answers.each do |answer|
      if answer.interventions.count > 0 then
        interventions.push answer.interventions.last
      end
    end
    return interventions.uniq
  end

  def answered_objectives
    questions = Question.all.select{ |question| question.answer(self) != nil }
    answered_objectives = []
    questions.each do |question|
      question.main_question.objectives.each do |obj|
        answered_objectives.push obj
      end
    end
    return answered_objectives.uniq
  end
  def answered_topics
    questions = Question.all.select{ |question| question.answer(self) != nil }
    answered_objectives = []
    questions.each do |question|
      question.main_question.objectives.each do |obj|
        answered_objectives.push obj.topic
      end
    end
    return answered_objectives.uniq
  end
end
