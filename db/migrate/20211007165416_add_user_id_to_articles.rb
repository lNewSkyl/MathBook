# frozen_string_literal: true

class AddUserIdToArticles < ActiveRecord::Migration[6.1]
  def change
    change_table :articles do |t|
      t.belongs_to :user
    end
  end
end
