class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 役割の定義
  # assistant: アシスタント（編集申請可能）
  # approver: 承認者（編集申請＋承認可能）
  # admin: 管理者（全権限＋ユーザー管理）
  enum role: { assistant: 1, approver: 2, admin: 3 }

  def role_i18n
    I18n.t("enums.user.role.#{role}")
  end

  # デフォルトはassistant
  after_initialize :set_default_role, if: :new_record?

  private

  def set_default_role
    self.role ||= :assistant
  end
end