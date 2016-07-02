module ApplicationHelper
  def sidebar_current(target)
    "current" if action_name == target.to_s
  end

  def current_path
    if controller_name == "tasks"
      url_for
    else
      tasks_path
    end
  end

  def filter_title
    {
      "today" => "今日のタスク",
      "weekly" => "今週のタスク"
    }[action_name]
  end
end
