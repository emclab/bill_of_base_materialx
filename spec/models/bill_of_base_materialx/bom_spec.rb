require 'spec_helper'

module BillOfBaseMaterialx
  describe Bom do
    it "should be OK" do
      c = FactoryGirl.build(:bill_of_base_materialx_bom)
      c.should be_valid
    end
        
    it "should reject dup part_id for same project" do
      c = FactoryGirl.create(:bill_of_base_materialx_bom)
      c1 = FactoryGirl.build(:bill_of_base_materialx_bom, :project_id => c.project_id)
      c1.should_not be_valid
    end
    
    it "should reject 0 qty" do
      c = FactoryGirl.build(:bill_of_base_materialx_bom, :qty => 0)
      c.should_not be_valid
    end
    
    it "should reject 0 project_id" do
      c = FactoryGirl.build(:bill_of_base_materialx_bom, :project_id => 0)
      c.should_not be_valid
    end
    
    it "should allow nil project_id" do
      c = FactoryGirl.build(:bill_of_base_materialx_bom, :project_id => nil)
      c.should be_valid
    end

    it "should reject 0 part_id" do
      c = FactoryGirl.build(:bill_of_base_materialx_bom, :part_id => 0)
      c.should_not be_valid
    end
    
    it "should not take 0 unit price reference" do
      c = FactoryGirl.build(:bill_of_base_materialx_bom, :unit_price_reference => 0)
      c.should_not be_valid
    end
    
    it "should not take 0 total reference" do
      c = FactoryGirl.build(:bill_of_base_materialx_bom, :total_reference => 0)
      c.should_not be_valid
    end
    
    it "should eval dynamic validate" do
      dv = "errors.add(:project_id, I18n.t('Must be numeric'))if project_id.blank?"
      FactoryGirl.create(:engine_config, :engine_name => 'bill_of_base_materialx', :engine_version => nil, :argument_name => 'dynamic_validate', :argument_value => dv)
      c = FactoryGirl.build(:bill_of_base_materialx_bom, :project_id => nil)
      c.should_not be_valid 
    end
    
  end
end
