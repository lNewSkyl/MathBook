class AddAnswerToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :answer, :text
  end
end
