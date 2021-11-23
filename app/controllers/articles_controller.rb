class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy, :edit]
  
  def index
    @articles = Article.paginate(page: params[:page], per_page:5)
    @articles_scoped_by_rate = Article.all.order(cached_votes_score: :desc)
    @articles_pag_rate = @articles_scoped_by_rate.paginate(page: params[:page], per_page:5)
    @articles_scoped_by_date = Article.all.order(created_at: :desc)
    @articles_pag_date = @articles_scoped_by_date.paginate(page: params[:page], per_page:5)
  end

  def show
    @article = Article.find(params[:id])
  end
    


  def purge_avatar
    @article = Article.find(params[:id])
    @article.avatar.purge
    redirect_to @article, notice: "Avatar deleted"
  end


  def new
    if user_signed_in?
      @article = Article.new
    else
      redirect_to new_user_session_path
    end
  end

  def create
    @article = current_user.articles.new(article_params)
    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
    if current_user.email == "atom-1121@mail.ru" || current_user.email  == @article.user.email
    end
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    if current_user.email == "atom-1121@mail.ru" || current_user.email  == @article.user.email
      @article.destroy
      redirect_to home_path
    end
  end

  def downvote
    if user_signed_in?
      @article = Article.find(params[:id])
      if current_user.voted_down_on? @article, vote_scope: 'like'
        @article.unvote_by current_user, vote_scope: 'like'
      else 
        @article.downvote_by current_user, vote_scope: 'like'
      end
      render "vote.js.erb"
    end
  end

  def upvote
    if user_signed_in?
      @article = Article.find(params[:id])
      if current_user.voted_up_on? @article, vote_scope: 'like'
        @article.unvote_by current_user, vote_scope: 'like'
      else 
        @article.upvote_by current_user, vote_scope: 'like'
      end
      render "vote.js.erb"
    end
  end

  def search
    @articles = Article.where("title LIKE ?","%" + params[:q] + "%")
  end


  private
    def article_params
      params.require(:article).permit(:title, :body, :description, :answer, :status, :avatar, images: [])
    end

    def correct_user
      @article = current_user.articles.find_by(id: params[:id])
      redirect_to home_path if @article.nil?
    end
end