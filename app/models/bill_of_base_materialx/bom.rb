module BillOfBaseMaterialx
  class Bom < ActiveRecord::Base
    attr_accessor :project_name, :category_name, :sub_category_name, :id_noupdate, :wf_comment, :wf_event, :part_name_autocomplete, :field_changed
                                    
    belongs_to :project, :class_name => BillOfBaseMaterialx.project_class.to_s
    belongs_to :part, :class_name => BillOfBaseMaterialx.part_class.to_s
    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    
    validates :name, :spec, :unit, :presence => true
    validates :qty, :presence => true, :numericality => {:greater_than => 0, :only_integer => true}
    validates :part_id, :uniqueness => {:scope => :project_id, :case_sensitive => false, :message => I18n.t('Duplicate Part!')}, :if => 'part_id.present?'   
    validates :part_id, :numericality => {:greater_than => 0, :only_integer => true}, :if => 'part_id.present?'
    validates :project_id, :numericality => {:greater_than => 0, :only_integer => true}, :if => 'project_id.present?'
    validates :unit_price_reference, :numericality => {:greater_than => 0}, :if => 'unit_price_reference.present?'
    validates :total_reference, :numericality => {:greater_than => 0}, :if => 'total_reference.present?'
    validates :bom_level_id, :numericality => {:greater_than => 0}, :if => 'bom_level_id.present?'
    validates :bom_level_parent_id, :numericality => {:greater_than => 0}, :if => 'bom_level_parent_id.present?'
    validate :dynamic_validate 
    
    def dynamic_validate
      wf = Authentify::AuthentifyUtility.find_config_const('dynamic_validate_part', 'bill_of_base_materialx')
      eval(wf) if wf.present?
    end  
        
  end
end
