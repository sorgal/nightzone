require 'spec_helper'

describe Task do

  before do
    @game = FactoryGirl.create(:game)
    @task = FactoryGirl.create(:task)
    @hint = FactoryGirl.create(:hint)
    @user = FactoryGirl.create(:user)
    @user_task = FactoryGirl.create(:user_task, user_id: @user.to_param, task_id: @task.to_param)
    @task_hint = FactoryGirl.create(:task_hint, task_id: @task.to_param, hint_id: @hint.to_param)
    @hint2 = FactoryGirl.create(:hint, hint_text: " wvgrawrfswf", queue_number: 2)
    @task_hint2 = FactoryGirl.create(:task_hint, task_id: @task.to_param, hint_id: @hint2.to_param)
  end

  it "games validation checking" do
    @task.should be_valid
  end

  describe "raise hint" do
    it "execute action " do
      expect {
        @task.raise_hint
      }.to change(UserHint, :count).by(1)
    end

    it "raises first hint" do
      expect {
        @task.raise_hint
      }.to change(UserHint, :count).by(1)
      expect(UserHint.last.hint_id).to eq(@hint.to_param.to_i)
      expect(UserHint.count).to eq(1)
    end

    describe "hints count > 1" do
      before(:each) do
        Hint.find(@hint.to_param.to_i).update_attribute(:raised, Hint::RAISED)
        @user_hint = FactoryGirl.create(:user_hint, user_id: @user.to_param, hint_id: @hint.to_param)
      end
      it "raises second hint" do
        expect {
          @task.raise_hint
        }.to change(UserHint, :count).by(1)
        expect(UserHint.last.hint_id).to eq(@hint2.to_param.to_i)
        expect(UserHint.count).to eq(2)
      end

      it "doesn't raise third hint" do
        Hint.find(@hint2.to_param.to_i).update_attribute(:raised, Hint::RAISED)
        @user_hint2 = FactoryGirl.create(:user_hint, user_id: @user.to_param, hint_id: @hint2.to_param)
        expect {
          @task.raise_hint
        }.to change(UserHint, :count).by(0)
        expect(UserHint.last.hint_id).to eq(@hint2.to_param.to_i)
        expect(UserHint.count).to eq(2)
      end
    end
  end

end
