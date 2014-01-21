module ControllerMacros
  def login_admin
    let!(:admin) {create :admin_user, email: "admin#{rand(1000)}@example.com"}
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      @admin = admin
      sign_in @admin
    end
    after(:each) do
      AdminUser.find(@admin.id).destroy
    end
  end

  def login_user
    let!(:user) {create :user}
    before(:each) do
      @user = user
      sign_in @user
    end
    after(:each) do
      #User.find(@user).destroy
    end
  end
end