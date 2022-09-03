require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.create(:user)
      @product = FactoryBot.build(:product)
      @product.image = fixture_file_upload('public/images/test_image.png')
      @product.save
      @purchase = FactoryBot.build(:purchase_address, product_id: @product.id, user_id: @user.id)
      sleep 0.1
    end
    # 購入関連
    it '必須項目を全て入力すれば購入ができる' do
      expect(@purchase).to  be_valid
    end

    it '郵便番号が空だと登録できない' do
      @purchase.postal_code = nil
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("Postal code can't be blank")
    end

    it '都道府県が「---」だと登録できない' do
      @purchase.prefecture_id = 1
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include('Prefecture select')
    end

    it '都道府県が空だと保存できないこと' do
      @purchase.prefecture_id = nil
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("Prefecture can't be blank")
    end

    it '市区町村が空だと登録できない' do
      @purchase.municipality = nil
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("Municipality can't be blank")
    end

    it '番地が空だと登録できない' do
      @purchase.address = nil
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("Address can't be blank")
    end

    it '電話番号が空だと登録できない' do
      @purchase.phone_number = nil
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("Phone number can't be blank")
    end

    it '電話番号にハイフンがあると登録できない' do
      @purchase.phone_number = '000-0000-0000'
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include('Phone number is invalid')
    end

    it '電話番号が12桁以上あると保存できないこと' do
      @purchase.phone_number = 12_345_678_910_123_111
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include('Phone number is invalid')
    end

    it '郵便番号にハイフンがないと登録できない' do
      @purchase.postal_code = '7777777'
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include('Postal code Input correctly')
    end
  end
end
