# frozen_string_literal: true

class SolutionsController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    @solutionpre = @article.solutions.build(solution_params)
    return handle_correct_answer if @solutionpre.content.downcase.strip == @article.answer.downcase.strip

    handle_incorrect_answer
  end

  def destroy
    return unless current_user.email == 'atom-1121@mail.ru'

    @article = Article.find(params[:article_id])
    @solution = @article.solutions.find(params[:id])
    @solution.destroy
    redirect_to article_path(@article)
  end

  private

  def solution_params
    params.require(:solution).permit(:content).merge(article_id: params[:article_id])
  end

  def handle_correct_answer
    @solution = current_user.solutions.new(solution_params)
    @solution.user_id = current_user.id
    redirect_to article_path(params[:article_id])
    flash[:notice] = 'Correct! You are awesome'
    display_solution_errors unless @solution.save
  end

  def handle_incorrect_answer
    redirect_to article_path(params[:article_id])
    flash[:notice] = 'Incorrect. Think harder and try again'
  end

  def display_solution_errors
    current_user.solutions.create!(article_id: @article.id)
    flash[:notice] = @solution.errors.full_messages.to_sentence
  end
end
