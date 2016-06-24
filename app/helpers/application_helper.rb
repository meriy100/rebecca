module ApplicationHelper
  def sidebar_current(target)
    "current"if current_page?(action: target)
  end
end
