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
        if check_already_inserted_code(matched_code.id)
          notice = "Compare for this code created early"
        else
          new_code_compare = @user.code_compares.build(code: matched_code)
          if new_code_compare.save
            notice = "Code was matched"
            if all_codes_input?
              task_hints_ids = @task.hints.pluck(:id)
              notice += ". #{next_task(@task.points - @user.hints.where("`hints`.`id` IN (?)", task_hints_ids).count)}"
            end
          end
        end
      end
    end

    unless notice
      notice = "Code or pass was not matched"
    end
    @notice = notice
  end

  def all_codes_input?
    if get_task_codes_count(@task, @user)[1] == 0
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
    change_task_result(points)
    if has_more_tasks?
      assign_next_task
      "Next task assigned"
    else
      end_game
      "Game completed"
    end
  end

  def has_more_tasks?
    untaken_tasks.any?
  end

  def assign_next_task
    @user.user_tasks.create(task: untaken_tasks.first)
  end

  def change_task_result(points)
    @user.user_tasks.last.update_attribute(:result, points)
  end

  def end_game
    get_current_game_tasks
    points = @user.user_tasks.where("`user_tasks`.`task_id` IN (?)", @current_game_tasks).pluck(:result).inject{|sum, num| sum += num}
    @user.user_games.where(game_id: self.id).first.update(state: UserGame::COMPLETED, result: points)
  end

  def untaken_tasks
    completed_ids = self.tasks.for_user(@user.id).pluck(:id)
    @untaken_tasks ||= self.tasks.where('`tasks`.`id` NOT IN (?)', completed_ids )
  end

  def start_game
    self.update(state: UserGame::CURRENT)
    #Для каждого user_game генерится user_task. Я не придумал как убрать цикл
    self.user_games.update_all(state: UserGame::CURRENT)
    self.user_games.each do |user_game|
      UserTask.create(user_id: user_game.user_id, task_id: self.tasks.first.id, result: 0)
    end
  end

  def get_current_game_tasks
    @current_game_tasks = self.tasks.pluck(:id)
  end

  def finish_game
    self.update(state: UserGame::COMPLETED)
    get_current_game_tasks
    #Здесь я тоже не придумал как убрать цикл
    self.user_games.each do |user_game|
      if user_game.state > 0
        points = UserTask.where("`user_tasks`.`task_id` IN (?)", @current_game_tasks).where(user_id: user_game.user_id).pluck(:result).inject{|sum, num| sum += num}
        user_game.update(state: UserGame::COMPLETED, result: points)
      end
    end
  end

  def check_already_inserted_code(code)
    if @user.code_compares.where(code_id: code).first
      return true
    else
      return false
    end
  end

  def get_task_codes_count(task, user)
    task_codes = task.codes.pluck(:id)
    code_compares = user.code_compares.where('`code_compares`.`code_id` IN (?)', task_codes).count
    return [code_compares, task_codes.count - code_compares]
  end

end
