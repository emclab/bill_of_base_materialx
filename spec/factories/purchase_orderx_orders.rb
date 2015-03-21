# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :purchase_orderx_order, :class => 'PurchaseOrderx::Order' do
    #last_updated_by_id 1
    wf_state "new"
    supplier_id 1
    delivery_date "2013-11-14"
    brief_note "My note Text"
    delivered false
    actual_delivery_date "2013-11-14"
    po_date "2013-11-14"
    po_requirement "My po requirement Text"
    po_total "9.99"
    shipping_cost "9.99"
    tax "9.99"
    other_cost "9.99"
    po_num 'po##'
    requested_by_id 1
    project_id 1
  end
end
