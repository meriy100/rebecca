module TasksAction
  extend ActiveSupport::Concern

  def task_params
    params.require(:task).permit(:user_id, :title, :is_done, :weight, :deadline_at)
  end
end
