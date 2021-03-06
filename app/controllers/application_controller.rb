class ApplicationController < ActionController::Base
  protect_from_forgery

  skip_before_filter  :verify_authenticity_token
  after_action :allow_iframe

  # Ask shop to authorize app again if additional permissions are required
  # rescue_from ActiveResource::ForbiddenAccess do
  #   session[:shopify] = nil
  #   flash[:notice] = "This app requires additional permissions, please log in and authorize it."
  #   redirect_to controller: :sessions, action: :create
  # end

  private
  def local_login
    params[:shop]  ||= ENV['SHOP']
    params[:token] ||= ENV['TOKEN']
    if params[:shop] && params[:token]
      session[:shopify] ||= ShopifyAPI::Session.new(params[:shop].dup, params[:token].dup)
    end
  end

  def allow_iframe
    unless response.headers.frozen?
      response.headers.except! 'X-Frame-Options'
    end
  end

  def shop_id
    if shop = params[:shop]
      shop.split('.').first
    end
  end
end
