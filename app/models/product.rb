class Product < ApplicationRecord
  has_many :images
  has_many :orders
  belongs_to :supplier

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, length: { maximum: 255 }
  validates :price, presence: true
  validates :price, numericality: { greater_than: 0, less_than: 100_000 }
  validates :description, length: { in: 10..500 }
  validates :image_url, length: { maximum: 255 }

  def is_discounted?
    price < 50
  end

  def tax
    price * 0.09
  end

  def total
    tax + price
  end
end
