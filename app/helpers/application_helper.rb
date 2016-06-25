module ApplicationHelper
  def sidebar_current(target)
    "current" if action_name == target.to_s
  end
end
