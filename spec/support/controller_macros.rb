module ControllerMacros
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      @admin = FactoryGirl.create(:admin_user, email: "admin#{rand(1000)}@example.com}") # Using factory girl as an example
      sign_in @admin
      @admin_id = @admin.to_param
    end
  end

  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = FactoryGirl.build(:user)
      #@user.confirm!
      sign_in @user
      @user_id = @user.to_param
    end
    after(:each) do
      User.find(@user_id).destroy


    end
  end
end