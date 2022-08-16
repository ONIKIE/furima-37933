class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :day
  belongs_to_active_hash :shipping_fee
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :status
  has_one_attached :image


  belongs_to :user
 

  validates :image,           presence: true
  validates :name,            presence: true
  validates :explanation,     presence: true
  validates :price,           presence: true
  validates :category_id,     presence: true
  validates :status_id,       presence: true
  validates :shipping_fee_id, presence: true
  validates :prefecture_id,   presence: true
  validates :day_id,          presence: true

  with_options numericality: { other_than: 1, message: 'select' } do
    validates :category_id
    validates :day_id
    validates :shipping_fee_id
    validates :prefecture_id
    validates :status_id
  end

validates :price, format: { with: /\A[0-9]+\z/, message: 'Price Half-width number' }, inclusion: { in: (300..9_999_999), message: 'Out of setting range' }
end
