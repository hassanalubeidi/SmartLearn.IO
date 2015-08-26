require 'rails_helper'

describe 'instantiation' do
    let!(:subject) { build(:subject) }
    let!(:test) { build(:user_with_subjects) }

    it 'instantiates a list' do
      expect(subject.class.name).to eq("Subject")
    end

    it 'creates a subject with the name Chemistry' do
      expect(subject.name).to eq("Chemistry")
    end

    it 'test' do
      expect(test.subjects.count).to eq(5)
    end
  end