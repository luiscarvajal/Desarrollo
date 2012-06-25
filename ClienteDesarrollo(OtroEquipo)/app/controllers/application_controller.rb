class ApplicationController < ActionController::Base
#evita html inyection
  protect_from_forgery
#  session :session_key => '_my_project_id'
end
