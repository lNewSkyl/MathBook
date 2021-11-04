class SolutionsController < ApplicationController
	def create
		@article = Article.find(params[:article_id])
		@solutionpre = @article.solutions.build(solution_params)
		if @solutionpre.content.downcase.strip == @article.answer.downcase.strip
			@solution = current_user.solutions.new(solution_params)
			@solution.user_id = current_user.id
			redirect_to article_path(params[:article_id])
			flash[:notice] = "Correct! You are awesome"
			if !@solution.save
				flash[:notice] = @solution.errors.full_messages.to_sentence
			end
		else
			redirect_to article_path(params[:article_id])
			flash[:notice] = "Incorrect. Think harder and try again"

		end
	end


	def destroy
	   	if current_user.email == "atom-1121@mail.ru"
		    @article = Article.find(params[:article_id])
		    @solution = @article.solutions.find(params[:id])
		    @solution.destroy
		    redirect_to article_path(@article)
	    end
	end




	private

	def solution_params
		params
		.require(:solution)
		.permit(:content)
		.merge(article_id: params[:article_id])
	end


end
