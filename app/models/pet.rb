class Pet < ActiveRecord::Base
  belongs_to :user, optional: true

  validates :name, presence: true
  validates :breed, presence: true
  validates :age, presence: true
  validates :location, presence: true
  validates :about, presence: true
end
