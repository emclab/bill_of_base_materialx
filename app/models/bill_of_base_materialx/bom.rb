module BillOfBaseMaterialx
  class Bom < ActiveRecord::Base
    attr_accessor :project_name, :status_name, :id_noupdate, :wf_comment, :part_name, :part_spec, :wf_event
    attr_accessor :name, :part_num, :spec, :unit
    attr_accessible :about_cost, :brief_note, :estimated_total, :last_updated_by_id, :part_id, :preferred_mfr, :preferred_supplier, :project_id, :qty, 
                    :status_id, :wf_state, :name, :part_num, :spec, :unit, :project_name,
                    :as => :role_new
    attr_accessible :about_cost, :brief_note, :estimated_total, :part_id, :preferred_mfr, :preferred_supplier, :qty, :status_id, :wf_state,
                    :name, :part_num, :spec, :unit, :project_name,
                    :as => :role_update
                                    
    belongs_to :project, :class_name => BillOfBaseMaterialx.project_class.to_s
    belongs_to :part, :class_name => BillOfBaseMaterialx.part_class.to_s
    belongs_to :status, :class_name => 'Commonx::MiscDefinition'
    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    
    validates :project_id, :part_id, :qty, :presence => true, :numericality => {:greater_than => 0, :only_integer => true}
    validates :part_id, :uniqueness => {:scope => :project_id, :case_sensitive => false, :message => I18n.t('Duplicate Part!')}   
    validate :dynamic_validate 
    
    def dynamic_validate
      wf = Authentify::AuthentifyUtility.find_config_const('dynamic_validate', 'bill_of_base_materialx')
      eval(wf) if wf.present?
    end  
    
    def part_name_autocomplete
      self.part.try(:name)
    end

    def part_name_autocomplete=(name)
      self.part = BillOfBaseMaterialx.part_class.find_by_name(name) if name.present?
    end        
  end
end
