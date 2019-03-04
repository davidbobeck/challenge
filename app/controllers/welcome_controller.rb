class WelcomeController < ApplicationController

  #-------------------------------------
  def index
    render plain: 'Welcome to the challenge!'
  end

end