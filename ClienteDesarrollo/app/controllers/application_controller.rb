class ApplicationController < ActionController::Base
#evita html inyection
  protect_from_forgery
end
