require 'rails_helper'

RSpec.describe Product, type: :model do
  describe '商品出品機能' do
    before do
      @product = FactoryBot.build(:product)
      @product.image = fixture_file_upload('public/images/test_image.png')
    end

    it '全ての項目を入力すれば出品できる' do
      expect(@product).to be_valid
    end

    it '画像が空だと登録できない' do
      @product.image = nil
      @product.valid?
      expect(@product.errors.full_messages).to include("Image can't be blank")
    end

    it '商品名が空だと登録できない' do
      @product.name = nil
      @product.valid?
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it '商品の説明が空だと登録できない' do
      @product.explanation = nil
      @product.valid?
      expect(@product.errors.full_messages).to include("Explanation can't be blank")
    end

    it 'カテゴリーが選択されていないと登録できない' do
      @product.category_id = 1
      @product.valid?
      expect(@product.errors.full_messages).to include('Category select')
    end

    it '商品状態が選択されていなければ登録できない' do
      @product.status_id = 1
      @product.valid?
      expect(@product.errors.full_messages).to include('Status select')
    end

    it '配送料の負担が選択されていなければ登録できない' do
      @product.shipping_fee_id = 1
      @product.valid?
      expect(@product.errors.full_messages).to include('Shipping fee select')
    end

    it '配送元の地域が選択されていなければ登録できない' do
      @product.prefecture_id = 1
      @product.valid?
      expect(@product.errors.full_messages).to include('Prefecture select')
    end

    it '発送までの日数が選択されていなければ登録できない' do
      @product.day_id = 1
      @product.valid?
      expect(@product.errors.full_messages).to include('Day select')
    end

    it '価格が空だと登録できない' do
      @product.price = nil
      @product.valid?
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it '価格が300円以下だと登録できない' do
      @product.price = 299
      @product.valid?
      expect(@product.errors.full_messages).to include('Price Out of setting range')
    end

    it '価格が9999999円以上だと登録できない' do
      @product.price = 10_000_000
      @product.valid?
      expect(@product.errors.full_messages).to include('Price Out of setting range')
    end

    it '販売価格は半角数字以外では登録できない' do
      @product.price = '１０００'
      @product.valid?
      expect(@product.errors.full_messages).to include('Price Out of setting range')
    end
  end
end
