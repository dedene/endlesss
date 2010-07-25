class Feed < ActiveRecord::Base
  has_many :shots
  belongs_to :site
end
