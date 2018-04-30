class Pet < ActiveRecord::Base
  belongs_to :user, optional: true

  validates :name, presence: true, length: { in: 3..25 }
  validates :breed, presence: true, length: { in: 3..255 }
  validates :age, presence: true
  validates :location, presence: true, length: { in: 3..255 }
  validates :about, presence: true, length: { in: 3..255 }
end
