class Game < ActiveRecord::Base

  has_one :admin_game, dependent: :destroy
  has_many :user_games, dependent: :destroy
  has_many :game_tasks, dependent: :destroy
  has_many :tasks, through: :game_tasks

  validate :title, :start_date, presence: true

  def process(user, task, try_text)
    @user = user
    @task = task
    if pass_matching(try_text)
      notice = "Pass was matched. #{next_task(0)}"
    else
      if matched_code = @task.codes.where(code_string: try_text).first
        new_code_compare = @user.code_compares.build(code: matched_code)
        if new_code_compare.save
          if all_codes_input?
            notice = "Code was matched. #{next_task(@task.points - @user.hints.count)}"
          end
        end
      end
    end

    if notice == ""
      notice += "Code or pass was not matched"
    end
    @notice = notice
  end

  def all_codes_input?
    if @user.code_compares.count == @task.codes.count
      return true
    else
      return false
    end
  end

  def pass_matching(text)
    if User.find(@user.id).valid_password?(text)
      return true
    else
      return false
    end
  end

  def next_task(points)
    if has_more_tasks?
      assign_next_task(points)
      "Next task assigned"
    else
      end_game
      "Game completed"
    end
  end

  def has_more_tasks?
    untaken_tasks.any?
  end

  def assign_next_task(points)
    @user.user_tasks.last.update_attribute(:result, points)
    @user.user_tasks.create(task: untaken_tasks.first)
  end

  def end_game
    @user.user_games.where(state: UserGame::CURRENT).first.update_attribute(:state, UserGame::COMPLETED)
  end

  def untaken_tasks
    completed_ids = self.tasks.for_user(@user.id).pluck(:id)
    @untaken_tasks ||= self.tasks.where('`tasks`.`id` NOT IN (?)', completed_ids.join(',') )
  end

  def start_game
    self.update(state: UserGame::CURRENT)
    #Для каждого user_game генерится user_task. Я не придумал как убрать цикл
    self.user_games.update_all(state: UserGame::CURRENT)
    self.user_games.each do |user_game|
      UserTask.create(user_id: user_game.id, task_id: self.tasks.first.id, result: 0)
    end
  end

  def finish_game
    self.update(state: UserGame::COMPLETED)
    #Здесь я тоже не придумал как убрать цикл
    self.user_games.each do |user_game|
      points = UserTask.where(user_id: user_game.user_id).pluck(:result).inject{|sum, num| sum += num}
      user_game.update(state: UserGame::COMPLETED, result: points)
    end
  end
  
end
