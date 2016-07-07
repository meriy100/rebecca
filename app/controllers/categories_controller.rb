class CategoriesController < ApplicatinController
    before_action :set_task, only: [:update, :destroy]
    before_action :set_new_task, only: [:list]
    before_action :set_search, only: [:list]

    def list
        @category = @search.result.on_user.sort_by(:order_row)
    end

    def set_category
        @category = Category.on_user.find_by(id: params[:id])
    end

    def new
        @category = Category.new
    end

    def set_new_category
        @category = Category.new
    end

    def set_search
        @search = Category.search(params[:q])
    end
end