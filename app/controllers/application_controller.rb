class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ProductsHelper

  def not_found
    render file: "public/404.html", status: 404, layout: false
  end
end
