 class ArticlesController < ApplicationController
     before_action :set_article, only: [:show, :edit, :update, :destroy]
     
     def show
     end
     
     def index
      if user_signed_in?
       if params[:category].blank?
     			 @articles = Article.where(:user_id => current_user.id).order("created_at DESC")
     		else
     		 @category_id = Category.find_by(name: params[:category]).id
			     @articles = Article.where(:category_id => @category_id, :user_id => current_user.id ).order("created_at DESC")	 
     		end
     	else
       if params[:category].blank?
     			 @articles = Article.where(:public => 1).order("created_at DESC")
     		else
     		 @category_id = Category.find_by(name: params[:category]).id
			     @articles = Article.where(:category_id => @category_id, :public => 1).order("created_at DESC")	 
     		end
     	end
     end
     
     def new
      @article = Article.new()
      @categories = Category.all.map{ |c| [c.name, c.id] }
      
     end
     
     def edit
      @categories = Category.all.map{ |c| [c.name, c.id] }
     end
     
     def create
       @article = current_user.article.build(article_params)

       
       if @article.save
        flash[:notice] = "Article has been saved successfully"
        redirect_to @article
       else
        render 'new'
       end
     end
     
     def update
      if @article.update(article_params)
       flash[:notice] = "Article has been updated successfully"
       redirect_to @article
      else
       render 'edit'
      end
     end
     
     def destroy
      @article.destroy
      redirect_to articles_path
     end
     
     private
     
     def set_article
      @article = Article.find(params[:id])
     end
     
     def article_params
      params.require(:article).permit(:title, :description, :category_id, :public, :page_number)
     end
     
 end 