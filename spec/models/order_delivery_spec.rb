require 'rails_helper'

RSpec.describe OrderDelivery, type: :model do
  describe '購入情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_delivery = FactoryBot.build(:order_delivery, user_id: user.id, item_id: item.id)
    end
    context '内容に問題がない場合' do
      it 'すべての値が正しく入力されていれば保存できる' do
        expect(@order_delivery).to be_valid
      end
      it '建物名は空でも保存できる' do
        @order_delivery.building = ''
        expect(@order_delivery).to be_valid
      end
    end
    context '内容に問題がある場合' do
      it '郵便番号が空だと保存できない' do
        @order_delivery.post_code = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('郵便番号を入力してください')
      end
      it '郵便番号が「3桁ハイフン4桁」の半角文字列でなければ保存できない' do
        @order_delivery.post_code = '1234567'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('郵便番号はハイフン(-)を含めて半角で入力してください')
      end
      it '都道府県に「---」が選択されている場合は保存できない' do
        @order_delivery.delivery_area_id = 1
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('都道府県を選択してください')
      end
      it '市区町村が空だと保存できない' do
        @order_delivery.city = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('市区町村を入力してください')
      end
      it '番地が空だと保存できない' do
        @order_delivery.address = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('番地を入力してください')
      end
      it '電話番号が空だと保存できない' do
        @order_delivery.phone_number = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('電話番号を入力してください')
      end
      it '電話番号が半角数値でなければ保存できない' do
        @order_delivery.phone_number = '０９０１２３４５６７８'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('電話番号は半角数字を使用してください')
      end
      it '電話番号が10桁未満だと保存できない' do
        @order_delivery.phone_number = '090123456'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('電話番号は10文字以上で入力してください')
      end
      it '電話番号が11桁を超えると保存できない' do
        @order_delivery.phone_number = '090123456789'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('電話番号は11文字以内で入力してください')
      end
      it 'ユーザーが紐付いていないと保存できない' do
        @order_delivery.user_id = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('Userを入力してください')
      end
      it '商品が紐付いていないと保存できない' do
        @order_delivery.item_id = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('Itemを入力してください')
      end
      it 'クレジットカード情報が空だと保存できない' do
        @order_delivery.token = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('クレジットカード情報を入力してください')
      end
    end
  end
end
