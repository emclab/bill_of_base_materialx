# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :purchase_orderx_order_item, :class => 'PurchaseOrderx::OrderItem' do
    order_id 1
    qty 1
    unit "MyString"
    unit_price "9.99"
    item_total "9.99"
    name "MyString"
    spec "MyText"
    item_category_id 1
    item_note "MyString"
  end
end
