module UsersHelper
	def ban_status(user)
		if user.access_locked?
			'Unban'
		else
			'Ban'
		end
	end

    def solutions_count(user)
        user.solutions.count
    end

 	def all_articles_count(user)
		user.articles.count
 	end

end