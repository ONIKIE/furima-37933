require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  describe '商品購入機能' do
    before do
      @user = FactoryBot.create(:user)
      @product = FactoryBot.build(:product)
      @product.image = fixture_file_upload('public/images/test_image.png')
      @product.save
      @purchase = FactoryBot.build(:purchase_address, product_id: @product.id, user_id: @user.id)
    end


      context '内容に問題がない場合' do
        it 'すべての値が正しく入力されていれば保存できる' do
          expect(@purchase).to be_valid
        end

        it 'user_idが空でなければ保存できる' do
          @purchase.user_id = 1
          expect(@purchase).to be_valid
        end

        it 'product_idが空でなければ保存できる' do
          @purchase.product_id = 1
          expect(@purchase).to be_valid
        end

        it '建物名が空でも保存できる' do
          @purchase.building_name = nil
          expect(@purchase).to be_valid
        end
      end


      context '内容に問題がある場合' do
        it 'user_idが空だと保存できない' do
          @purchase.user_id = nil
          @purchase.valid?
          expect(@purchase.errors.full_messages).to include("User can't be blank")
        end

        it 'product_idが空だと保存できない' do
          @purchase.product_id = nil
          @purchase.valid?
          expect(@purchase.errors.full_messages).to include("Product can't be blank")
        end

        it '郵便番号が空だと保存できない' do
          @purchase.postal_code = nil
          @purchase.valid?
          expect(@purchase.errors.full_messages).to include("Postal code can't be blank", "Postal code Input correctly")
        end

        it '郵便番号にハイフンがないと保存できない' do
          @purchase.postal_code = 1234567
          @purchase.valid?
          expect(@purchase.errors.full_messages).to include("Postal code Input correctly")
        end


        it '郵便番号が半角数字以外だと保存できない' do
          @purchase.postal_code = '１２３−４５６７'
          @purchase.valid?
          expect(@purchase.errors.full_messages).to include("Postal code Input correctly")
        end

        it '都道府県が「---」だと保存できない' do
          @purchase.prefecture_id = 1
          @purchase.valid?
          expect(@purchase.errors.full_messages).to include("Prefecture select")
        end

        it '都道府県が空だと保存できない' do
          @purchase.prefecture_id = nil
          @purchase.valid?
          expect(@purchase.errors.full_messages).to include("Prefecture can't be blank")
        end

        it '市区町村が空だと保存できない' do
          @purchase.municipality = nil
          @purchase.valid?
          expect(@purchase.errors.full_messages).to include("Municipality can't be blank")
        end

        it '番地が空だと保存できない' do
          @purchase.address = nil
          @purchase.valid?
          expect(@purchase.errors.full_messages).to include("Address can't be blank")
        end

        it '電話番号が空だと保存できない' do
          @purchase.phone_number = nil
          @purchase.valid?
          expect(@purchase.errors.full_messages).to include("Phone number can't be blank")
        end

        it '電話番号が12桁以上あると保存できない' do
          @purchase.phone_number = 12_345_678_910_123_111
          @purchase.valid?
          expect(@purchase.errors.full_messages).to include('Phone number is invalid')
        end

        it '電話番号が9桁以下だと保存できない' do
          @purchase.phone_number = 12_345_678_9
          @purchase.valid?
          expect(@purchase.errors.full_messages).to include('Phone number is invalid')
        end

        it '電話番号が半角数字以外だと保存できない' do
          @purchase.phone_number = '１２３４５６７８９１'
          @purchase.valid?
          expect(@purchase.errors.full_messages).to include('Phone number is invalid')
        end

        it 'トークンが空だと保存できない' do
          @purchase.token = nil
          @purchase.valid?
          expect(@purchase.errors.full_messages).to include("Token can't be blank")
        end
      end
    end
  end
