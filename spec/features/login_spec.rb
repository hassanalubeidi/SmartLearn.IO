require 'rails_helper'

describe 'home page' do
	describe 'not logged in' do
		it 'asks you to sign in when visiting root' do
		    visit '/'
		    page.should have_content('You must be signed in to view this page.')
	  	end
	end
	describe 'logged in' do
		before(:each) do
			user = FactoryGirl.create(:user)
			login_as(user, :scope => :user)
		end
	  	it 'logs in successfully' do		
			visit '/'
			page.should have_content('Experiment v0.1.0')
			page.should_not have_content('You must be signed in to view this page.')
	  	end
	end
 end