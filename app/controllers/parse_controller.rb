class ParseController < ApplicationController
	def subject_details

	end
	def create_subject_details
		topics = JSON.parse params[:JSON_data]
		subject = params[:subject_id]
	    topics.each do |topic|
	      t = Topic.create(name: topic["unit"].join, subject_id: subject)
	      topic["chapters"].each do |chapter|
	        Objective.create(topic_id: t.id, name: chapter.join)
	      end
	    end
	    render text: topics
	end
end
