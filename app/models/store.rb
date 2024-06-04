class Store < ApplicationRecord
  has_one :owner, dependent: :destroy
  has_many :employees, dependent: :destroy
  has_many :products, dependent: :destroy
  validates :name, presence: true
end
