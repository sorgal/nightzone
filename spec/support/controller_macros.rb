module ControllerMacros
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      @admin = FactoryGirl.create(:admin_user, email: "admin#{rand(1000)}@example.com")
      sign_in @admin
      @admin_id = @admin.id
    end
    after(:each) do
      AdminUser.find(@admin.id).destroy
    end
  end

  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = FactoryGirl.create(:user)
      sign_in @user
    end
    after(:each) do
      User.find(@user).destroy
    end
  end
end