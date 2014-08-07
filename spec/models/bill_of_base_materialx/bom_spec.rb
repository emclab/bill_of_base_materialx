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

    it "should reject 0 part_id" do
      c = FactoryGirl.build(:bill_of_base_materialx_bom, :part_id => 0)
      c.should_not be_valid
    end
    
  end
end
