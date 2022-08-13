require 'rails_helper'

RSpec.describe User, type: :model do
 describe 'ユーザー新規登録' do
  before do 
    @user = FactoryBot.build(:user)
  end

  it '全て正しく入力されれば登録できる' do
    expect(@user).to be_valid
  end

  it 'nicknameが空だと登録できない' do
    @user.nickname = nil
    @user.valid?
    expect(@user.errors.full_messages).to include("Nickname can't be blank")
  end

  it 'emailが空だと登録できない' do
    @user.email = nil
    @user.valid?
    expect(@user.errors.full_messages).to include("Email can't be blank")
  end

  it '重複したemailが存在する場合は登録できない' do
    @user.save
    another_user = FactoryBot.build(:user)
    another_user.email = @user.email
    another_user.valid?
    expect(another_user.errors.full_messages).to include('Email has already been taken')
  end

  it 'passwordが5文字以下では登録できない' do
    @user.password = '00000'
    @user.password_confirmation = '00000'
    @user.valid?
    expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
  end

  it 'passwordとpassword_confirmationが不一致では登録できない' do
    @user.password = '123456'
    @user.password_confirmation = '1234567'
    @user.valid?
    expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
  end

  it 'first_nameが空では登録できない' do
    @user.first_name = nil
    @user.valid?
    expect(@user.errors.full_messages).to include("First name 全角文字を使用してください")
  end

  it 'last_nameが空では登録できない' do
    @user.last_name = nil
    @user.valid?
    expect(@user.errors.full_messages).to include("Last name 全角文字を使用してください")
  end

  it 'first_name_kanaが空では登録できない' do
    @user.first_name_kana = nil
    @user.valid?
    expect(@user.errors.full_messages).to include("First name kana 全角文字を使用してください")
  end

  it 'last_name_kanaが空では登録できない' do
    @user.last_name_kana = nil
    @user.valid?
    expect(@user.errors.full_messages).to include("Last name kana 全角文字を使用してください")
  end

  it 'first_nameはアルファベットでは入力できない' do
    @user.first_name = 'Rena'
    @user.valid?
    expect(@user.errors.full_messages).to include("First name 全角文字を使用してください")
  end

  it 'last_nameはアルファベットでは入力できない' do
    @user.last_name = 'Hudson'
    @user.valid?
    expect(@user.errors.full_messages).to include("Last name 全角文字を使用してください")
  end

  it 'first_name_kanaはひらがなでは入力できない' do
    @user.first_name_kana = 'やまだ'
    @user.valid?
    expect(@user.errors.full_messages).to include("First name kana 全角文字を使用してください")
  end

  it 'last_name_kanaはひらがなでは入力できない' do
    @user.last_name_kana = 'はなこ'
    @user.valid?
    expect(@user.errors.full_messages).to include("Last name kana 全角文字を使用してください")
  end

  it 'birthdayが空では登録できない' do
    @user.birthday = nil
    @user.valid?
    expect(@user.errors.full_messages).to include("Birthday can't be blank")
  end
end  
end
