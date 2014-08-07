require "bill_of_base_materialx/engine"

module BillOfBaseMaterialx
  mattr_accessor :project_class, :part_class, :customer_class 
  
  def self.project_class
    @@project_class.constantize
  end
  
  def self.part_class
    @@part_class.constantize
  end
  
  def self.customer_class
    @@customer_class.constantize
  end
  
end
