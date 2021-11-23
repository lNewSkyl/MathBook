module ArticlesHelper
	def no_answer?(article)
		current_user.solutions.find_by(article_id: article.id).nil? if current_user
	end
end
