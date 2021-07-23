require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'user登録' do
    before do
      @user = FactoryBot.build(:user)
    end
    
    context '正常系' do
      it '登録できる' do
        expect(@user).to be_valid
      end
    end

    context '異常系' do
      it 'ニックネームが必須' do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'メールアドレスが必須' do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'メールアドレスが一意性' do
        another = FactoryBot.create(:user)
        @user.email = another.email
        @user.valid?
        expect(@user.errors.full_messages).to include("Email has already been taken")
      end

      it 'メールアドレスは、@を含む必要があると' do
        @user.email = 'aaa.co.jp'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end

      it 'パスワードが必須である' do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'パスワードは、6文字以上での入力が必須である' do
        @user.password = 'aa547'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end

      it 'パスワードが数字のみ' do
        @user.password = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end

      it 'パスワードがアルファベットのみ' do
        @user.password = 'aaaaaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end

      it 'パスワードは全角では登録できないこと' do
        @user.password = 'ｔｔｔｔｔｔｔｔ１２３４'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end

      it 'パスワードとパスワード（確認）は、値の一致が必須である' do
        @user.password = '123456aa'
        @user.password_confirmation = '987683ggg4'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'last_nameとfirst_nameは必須である' do
        @user.last_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
        @user.first_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it 'last_nameは全角（漢字・ひらがな・カタカナ)' do
        @user.last_name = 'naoki'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid")
      end

      it 'first_nameは全角（漢字・ひらがな・カタカナ）' do
        @user.first_name = 'naoki'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid")
      end

      it 'last_name_kanaとfirst_name_kanaとは必須である' do
        @user.last_name_kana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
        @user.first_name_kana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end

      it 'last_name_kanaは全角（カタカナ）でないと登録できない' do
        @user.last_name_kana = 'なおき'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid")
      end

      it 'first_name_kanaは全角（カタカナ）でないと登録できない' do
        @user.first_name_kana = '直樹'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid")
      end

      it 'last_name_kanaは半角(カタカナ)だと登録できない' do
        @user.last_name_kana = 'ﾅｵｷ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid")
      end

      it 'first_name_kanaは半角(カタカナ)だと登録できない' do
        @user.first_name_kana = 'ﾅｵｷ'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid")
      end

      it '生年月日が必須である' do
        @user.birth_date = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
      
    end
    end
  end