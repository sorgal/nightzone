require 'spec_helper'

describe Task do

  let(:game) {create :game}

  let(:task) {create :task}

  let(:hint) {create :hint}

  let(:user) {create :user}

  let!(:user_task) {create :user_task, user: user, task: task}

  let!(:task_hint) {create :task_hint, task: task, hint: hint}

  let(:hint2) {create :hint, hint_text: " wvgrawrfswf", queue_number: 2}

  let!(:task_hint2) {create :task_hint, task: task, hint: hint2}

  it "games validation checking" do
    task.should be_valid
  end

  describe "raise hint" do
    it "execute action " do
      expect {
        task.raise_hint
      }.to change(UserHint, :count).by(1)
    end

    it "raises first hint" do
      expect {
        task.raise_hint
      }.to change(UserHint, :count).by(1)
      expect(UserHint.last.hint_id).to eq(hint.id)
      expect(UserHint.count).to eq(1)
    end

    describe "hints count > 1" do
      let!(:user_hint) {create :user_hint, user: user, hint: hint}
      before(:each) do
        Hint.find(hint.id).update_attribute(:raised, Hint::RAISED)
      end
      it "raises second hint" do
        expect {
          task.raise_hint
        }.to change(UserHint, :count).by(1)
        expect(UserHint.last.hint_id).to eq(hint2.id)
        expect(UserHint.count).to eq(2)
      end

      describe "third hint" do
        let!(:user_hint2) {create :user_hint, user: user, hint: hint2}
        it "doesn't raise third hint" do
          Hint.find(hint2.id).update_attribute(:raised, Hint::RAISED)
          expect {
            task.raise_hint
          }.to change(UserHint, :count).by(0)
          expect(UserHint.last.hint_id).to eq(hint2.id)
          expect(UserHint.count).to eq(2)
        end
      end
    end
  end

end
