# frozen_string_literal: true

module UsersHelper
  def ban_status(user)
    user.access_locked? ? 'Unban' : 'Ban'
  end

  def solutions_count(user)
    user.solutions.count
  end

  def all_articles_count(user)
    user.articles.count
  end
end
