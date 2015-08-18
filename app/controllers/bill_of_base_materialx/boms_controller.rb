require_dependency "bill_of_base_materialx/application_controller"

module BillOfBaseMaterialx
  class BomsController < ApplicationController
    before_action :require_employee
    before_action :load_parent_record
        
    def index
      @title = t('BOMs')
      @boms = params[:bill_of_base_materialx_boms][:model_ar_r]  #returned by check_access_right
      @boms = @boms.where(:part_id => @part.id) if @part
      @boms = @boms.where(:project_id => @project.id) if @project       
      @boms = @boms.page(params[:page]).per_page(@max_pagination) 
      @erb_code = find_config_const('bom_index_view', 'bill_of_base_materialx')
    end
  
    def new
      @title = t('New BOM')
      @bom = BillOfBaseMaterialx::Bom.new()
      @erb_code = find_config_const('bom_new_view', 'bill_of_base_materialx')
      @js_erb_code = find_config_const('bom_new_js_view', 'bill_of_base_materialx')
    end
  
    def create
      @bom = BillOfBaseMaterialx::Bom.new(new_params)
      @bom.last_updated_by_id = session[:user_id]
      if @bom.save
        redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=Successfully Saved!")
      else
        @project = BillOfBaseMaterialx.project_class.find_by_id(params[:bom][:project_id]) if params[:bom].present? && params[:bom][:project_id].present?
        @part = BillOfBaseMaterialx.part_class.find_by_id(params[:bom][:part_id].to_i) if params[:bom].present? && params[:bom][:part_id].present?
        @erb_code = find_config_const('bom_new_view', 'bill_of_base_materialx')
        @js_erb_code = find_config_const('bom_new_js_view', 'bill_of_base_materialx')
        flash[:notice] = t('Data Error. Not Saved!')
        render 'new'
      end
    end
  
    def edit
      @title = t('Update BOM')
      @bom = BillOfBaseMaterialx::Bom.find_by_id(params[:id])
      @part_id = params[:bom][:part_id] if params[:bom].present?
      @erb_code = find_config_const('bom_edit_view', 'bill_of_base_materialx')
      @js_erb_code = find_config_const('bom_edit_js_view', 'bill_of_base_materialx')
      #if @bom.wf_state.present? && @bom.current_state != :initial_state
       # redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=NO Update. Record Being Processed!")
      #end
    end
  
    def update
      @bom = BillOfBaseMaterialx::Bom.find_by_id(params[:id])
      @bom.last_updated_by_id = session[:user_id]
      if @bom.update_attributes(edit_params)
        redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=Successfully Updated!")
      else
        @erb_code = find_config_const('bom_edit_view', 'bill_of_base_materialx')
        @js_erb_code = find_config_const('bom_edit_js_view', 'bill_of_base_materialx')
        flash[:notice] = t('Data Error. Not Updated!')
        render 'edit'
      end
    end
  
    def show
      @title = t('BOM Info')
      @bom = BillOfBaseMaterialx::Bom.find_by_id(params[:id])
      @erb_code = find_config_const('bom_show_view', 'bill_of_base_materialx')
    end
    
    def destroy     
      BillOfBaseMaterialx::Bom.delete(params[:id].to_i)
      redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=Successfully Deleted!")
    end
    
    def autocomplete
      @boms = BillOfBaseMaterialx::Bom.joins(:part).order(:name).where("name like ?", "%#{params[:term]}%")
      render json: @boms.map {|f| "#{f.part.name} -    #{f.part.spec}"}    #return string of 2 fields. format []-[][][][]    
    end  
    
    def bom_status
      @boms = BillOfBaseMaterialx::Bom.where('bill_of_base_materialx_boms.project_id = ?', @project.id).order('id')
      @erb_code = find_config_const('bom_bom_status_view', 'bill_of_base_materialx')
    end
    
    protected
    def load_parent_record
      @part = BillOfBaseMaterialx.part_class.find_by_id(params[:part_id]) if params[:part_id].present?
      @project = BillOfBaseMaterialx.project_class.find_by_id(params[:project_id]) if params[:project_id].present?
      @project = BillOfBaseMaterialx.project_class.find_by_id(BillOfBaseMaterialx::Bom.find_by_id(params[:id]).project_id) if params[:id].present?
      @part = BillOfBaseMaterialx.part_class.find_by_id(BillOfBaseMaterialx::Bom.find_by_id(params[:id]).part_id) if params[:id].present?
    end
    
    private
    
    def new_params
      params.require(:bom).permit(:about_cost, :brief_note, :total_reference, :last_updated_by_id, :part_id, :preferred_mfr, :preferred_supplier, 
                     :project_id, :qty, :unit_price_reference, :wf_state, :name, :part_num, :spec, :unit)
    end
    
    def edit_params
      params.require(:bom).permit(:about_cost, :brief_note, :total_reference, :part_id, :preferred_mfr, :preferred_supplier, :qty, :wf_state, 
                     :unit_price_reference, :part_num, :spec, :unit,  :name)
    end
     
  end
end
