# frozen_string_literal: true

class Pet < ActiveRecord::Base
  belongs_to :user, optional: true

  validates :name,
            presence: true,
            length: { in: 3..25 }
  validates :breed,
            presence: true,
            length: { in: 3..255 }
  validates :age,
            presence: true
  validates :species,
            presence: true,
            length: { in: 3..50 }
  validates :location,
            presence: true,
            length: { in: 3..255 }
  validates :about,
            presence: true,
            length: { in: 3..255 }

end
