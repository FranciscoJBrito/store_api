class HomeController < ApplicationController
  def index
    redirect_to 'https://rails-store-api.readme.io'
  end

  def grettings
    render json: { grettings: I18n.t(:hello) }
  end
end
