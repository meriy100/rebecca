class CategoriesController < ApplicatinController
  before_action :set_category, only: [:update, :destroy]

  def set_category
    @category = Category.on_user.find(params[:id])
  end
end
