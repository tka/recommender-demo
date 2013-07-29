class User < ActiveRecord::Base
  belongs_to :occupation
  has_many   :ratings
  has_many   :movies, through: :ratings
  
  recommends :movies
end
