module BillOfBaseMaterialx
  class Bom < ActiveRecord::Base
    attr_accessor :project_name, :category_name, :sub_category_name, :id_noupdate, :wf_comment, :part_name, :part_spec, :wf_event, :name, :spec, :part_num, :unit,
                  :part_name_autocomplete
    attr_accessible :about_cost, :brief_note, :estimated_total, :last_updated_by_id, :part_id, :preferred_mfr, :preferred_supplier, :project_id, :qty, :est_unit_price,
                    :wf_state, :name, :part_num, :spec, :unit, :project_name, :name, :spec, :part_num, :unit, :part_name_autocomplete,
                    :as => :role_new
    attr_accessible :about_cost, :brief_note, :estimated_total, :part_id, :preferred_mfr, :preferred_supplier, :qty, :wf_state, :est_unit_price,
                    :name, :part_num, :spec, :unit, :project_name, :name, :spec, :part_num, :unit, :part_name_autocomplete,
                    :as => :role_update
                    
    attr_accessor :start_date_s, :end_date_s, :name_s, :spec_s, :part_num_s, :part_id_s, :category_id_s, :sub_category_id_s, :project_id_s
    attr_accessible :start_date_s, :end_date_s, :name_s, :spec_s, :part_num_s, :part_id_s, :category_id_s, :sub_category_id_s, :project_id_s,
                    :as => :role_search_stats
                                    
    belongs_to :project, :class_name => BillOfBaseMaterialx.project_class.to_s
    belongs_to :part, :class_name => BillOfBaseMaterialx.part_class.to_s
    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    
    validates :part_id, :qty, :presence => true, :numericality => {:greater_than => 0, :only_integer => true}
    validates :part_id, :uniqueness => {:scope => :project_id, :case_sensitive => false, :message => I18n.t('Duplicate Part!')}   
    validates :project_id, :numericality => {:greater_than => 0, :only_integer => true}, :if => 'project_id.present?'
    validate :dynamic_validate 
    
    def dynamic_validate
      wf = Authentify::AuthentifyUtility.find_config_const('dynamic_validate', 'bill_of_base_materialx')
      eval(wf) if wf.present?
    end  
        
  end
end
