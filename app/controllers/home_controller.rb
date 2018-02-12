class HomeController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index]
  #authorize_resource class: false
  def index
    @user = current_user
  end
end
