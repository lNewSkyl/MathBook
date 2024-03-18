# frozen_string_literal: true

class DropSolvedArticles < ActiveRecord::Migration[6.1]
  def change
    drop_table :solved_articles do |t|
      t.integer :user_id
      t.integer :article_id

      t.timestamps
    end
  end
end
