# frozen_string_literal: true

class RemoveStatusFromComments < ActiveRecord::Migration[6.1]
  def change
    remove_column :comments, :status, :string
  end
end
