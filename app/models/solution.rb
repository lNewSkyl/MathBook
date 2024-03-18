# frozen_string_literal: true

class Solution < ApplicationRecord
  belongs_to :article
  belongs_to :user
end
