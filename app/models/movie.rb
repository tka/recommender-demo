class Movie < ActiveRecord::Base
  has_many :ratings
  has_many :users, through: :ratings
  has_and_belongs_to_many :categories
end
