require 'rails_helper'

describe 'creating a testpaper' do
	describe ', logged in' do
		before(:each) do
			user = FactoryGirl.create(:user)
			login_as(user, :scope => :user)
		end
	  	it ', successfully' do	
	  		url = 'http://content.doublestruck.eu/?headermarks=31&doclist=%7CQS09%2E1%2E03%7CQS09%2E1%2E06%7CQS09%2E1%2E07%7CQS09%2E1%2E01&headertime=34&lk=7791329cade35e1b6486d27ee17cb14d&headercomment=&headerauthor=&subject=AA_PA_D&headertitle=&type=QMEN&dl=false&headersubtitle=&returntype=1&headerdate='	
			visit '/test_papers/upload'
			fill_in "test_paper_url", with: "http://www.google.com"
			click_button("Upload")
			current_path.should == '/test_papers/upload/show'
	  	end
	end
 end