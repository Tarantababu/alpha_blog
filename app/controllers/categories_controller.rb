class CategoriesController < ApplicationController
     before_action :set_category, only: [:show, :edit, :update, :destroy]
     
     def show
     end
     
     def index
        if user_signed_in?
     	    @categories = Category.where(:user_id => current_user.id).order("created_at DESC")
     	else
			@categories = Category.all
     	end
     end
     
     def new
      @category = Category.new()
     end
     
     def edit
     end
     
     def create
       @category = current_user.category.build(article_params)
     
       if @category.save
        flash[:notice] = "Category has been saved successfully"
        redirect_to @category
       else
        render 'new'
       end
     end
     
     def update
      if @category.update(article_params)
       flash[:notice] = "Category has been updated successfully"
       redirect_to @category
      else
       render 'edit'
      end
     end
     
     def destroy
      @category.destroy
      redirect_to categories_path
     end
     
     private
     
     def set_category
      @category = Category.find(params[:id])
     end
     
     def article_params
      params.require(:category).permit(:name, :description)
     end
end
