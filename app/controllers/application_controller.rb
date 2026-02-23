class ApplicationController < ActionController::Base
  include Pundit::Authorization

  # Punditで権限エラーが起きた時の処理
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "この操作を行う権限がありません。"
    redirect_to(request.referrer || root_path)
  end
end