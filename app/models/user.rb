class User < ActiveRecord::Base
  has_one :item
  devise :omniauthable
end
