class Article < ApplicationRecord
    belongs_to :user
    belongs_to :category
    validates :title, presence:true, length: { minimum:6, maximum:100}
    validates :description, presence:true, length: { minimum:10, maximum:300}
    validates :page_number, numericality: { only_integer: true }
end 