# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bill_of_base_materialx_bom, :class => 'BillOfBaseMaterialx::Bom' do
    part_id 1
    project_id 1
    qty 1
    #unit "MyString"
    preferred_mfr "MyText"
    preferred_supplier ""
    #last_updated_by_id 1
    wf_state "MyString"
    estimated_total "9.99"
    #status_id 1
    brief_note "MyText"
    about_cost "MyText"
    est_unit_price 12.3
  end
end
