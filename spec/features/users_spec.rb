require 'spec_helper'

describe "Splash Page" do
	describe "GET /" do
		context "valid signup" do
			it "should be valid" do
				user = FactoryGirl.build(:user)
				expect(user).to be_valid
			end
		end
		context "invalid signup" do
			it "should be valid" do
				user = FactoryGirl.build(:user, email: "")
				expect(user).not_to be_valid
			end
		end
		# it "works! (now write some real specs)" do
		#   # get posts_path
		#   # expect(response.status).to be(200)
		#   visit '/'
		#   expect(page).to have_content('commoncast')
		# end
	end
end
