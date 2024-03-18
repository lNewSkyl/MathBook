# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build(comment_params)
    @comment.user = current_user.email
    if @comment.content.length >= 1
      @comment.save!
    else
      flash[:alert] = 'You forget to write your comment!'
    end
    redirect_to article_path(@article)
  end

  def destroy
    return unless current_user.email == 'atom-1121@mail.ru'

    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end

  private

  def comment_params
    :user => current_user
    params.require(:comment).permit(:content, :user)
  end
end
