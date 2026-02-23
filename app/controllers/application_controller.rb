class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :basic_auth

  # Punditで権限エラーが起きた時の処理
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end

  def user_not_authorized
    flash[:alert] = "この操作を行う権限がありません。"
    redirect_to(request.referrer || root_path)
  end
end