class Product < ApplicationRecord
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
  

end
