# All Administrate controllers inherit from this `Admin::ApplicationController`,
# making it the ideal place to put authentication logic or other
# before_filters.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
module Admin
  class ApplicationController < Administrate::ApplicationController
    before_filter :authenticate_admin

    def authenticate_admin
      if current_user then
        if current_user.power != "admin" then
          render text: "#{current_user.username}, can you please not try to hack SmartLearn???"
        end
      else
        render text: "you're not even logged in. Did you really think we'd let you in here???"
      end
    end

    # Override this value to specify the number of elements to display at a time
    # on index pages. Defaults to 20.
    # def records_per_page
    #   params[:per_page] || 20
    # end
  end
end
