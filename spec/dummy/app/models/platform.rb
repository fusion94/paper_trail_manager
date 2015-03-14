class Platform < ActiveRecord::Base
  has_paper_trail

  attr_accessible :name, :status

  validates_presence_of :name
  validates_presence_of :status
end
