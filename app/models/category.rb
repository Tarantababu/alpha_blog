class Category < ApplicationRecord
    has_many :article
    belongs_to :user
end
