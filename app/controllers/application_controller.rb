class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  private

  def configure_permitted_parameters
    # サインアップ時に許可するパラメータを追加
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :profile, :occupation, :position])

    # アカウント更新時に許可するパラメータも必要なら追加
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile, :occupation, :position])
  end
end
