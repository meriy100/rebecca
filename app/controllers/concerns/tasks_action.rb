module TasksAction
  extend ActiveSupport::Concern

  def task_params
    params.require(:task).permit(:user_id, :event_id, :sync_token, :title, :is_done, :weight, :deadline_at, :category_id, :created_at, :updated_at)
  end
end
