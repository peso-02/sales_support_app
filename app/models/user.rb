class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 役割の定義
  # general: 一般ユーザー（閲覧のみ）
  # assistant: アシスタント（編集可能）
  # approver: 承認者（マニュアル承認可能）
  # admin: 管理者（全権限）
  enum role: { general: 0, assistant: 1, approver: 2, admin: 3 }

  # デフォルトはgeneral
  after_initialize :set_default_role, if: :new_record?

  private

  def set_default_role
    self.role ||= :general
  end
end

