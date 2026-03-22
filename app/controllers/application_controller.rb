class ApplicationController < ActionController::Base
  include Pundit::Authorization

  # Basic認証
  before_action :basic_auth, if: :production?

  # ログイン後のリダイレクト先
  def after_sign_in_path_for(resource)
    root_path
  end

  # Punditで権限エラーが起きた時の処理
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private
  def production?
    Rails.env.production?
  end

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