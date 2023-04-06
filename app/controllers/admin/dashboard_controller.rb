class Admin::DashboardController < Admin::BaseController
  def index
    @registered_users = User.registered_users
  end
end