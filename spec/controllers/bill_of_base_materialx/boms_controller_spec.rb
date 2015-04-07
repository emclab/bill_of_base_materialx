require 'rails_helper'

module BillOfBaseMaterialx
  RSpec.describe BomsController, type: :controller do
    routes {BillOfBaseMaterialx::Engine.routes}
    before(:each) do
      expect(controller).to receive(:require_signin)
      expect(controller).to receive(:require_employee)
           
    end
    before(:each) do
      @pagination_config = FactoryGirl.create(:engine_config, :engine_name => nil, :engine_version => nil, :argument_name => 'pagination', :argument_value => 30)
      z = FactoryGirl.create(:zone, :zone_name => 'hq')
      type = FactoryGirl.create(:group_type, :name => 'employee')
      ug = FactoryGirl.create(:sys_user_group, :user_group_name => 'ceo', :group_type_id => type.id, :zone_id => z.id)
      @role = FactoryGirl.create(:role_definition)
      ur = FactoryGirl.create(:user_role, :role_definition_id => @role.id)
      ul = FactoryGirl.build(:user_level, :sys_user_group_id => ug.id)
      @u = FactoryGirl.create(:user, :user_levels => [ul], :user_roles => [ur])
      
      @proj = FactoryGirl.create(:ext_construction_projectx_project) 
      @part = FactoryGirl.create(:base_materialx_part)
      @part1 = FactoryGirl.create(:base_materialx_part, :name => 'a new name')
      
    end
    
    render_views
    
    describe "GET 'index'" do
      it "returns parts" do
        user_access = FactoryGirl.create(:user_access, :action => 'index', :resource =>'bill_of_base_materialx_boms', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "BillOfBaseMaterialx::Bom.order('created_at DESC')")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        task = FactoryGirl.create(:bill_of_base_materialx_bom, :project_id => @proj.id, :part_id => @part.id)
        task1 = FactoryGirl.create(:bill_of_base_materialx_bom, :project_id => @proj.id, :part_id => @part1.id)
        get 'index'
        expect(assigns[:boms]).to match_array([task, task1])
      end
      
      it "should only return the part for a project_id" do
        user_access = FactoryGirl.create(:user_access, :action => 'index', :resource =>'bill_of_base_materialx_boms', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "BillOfBaseMaterialx::Bom.order('created_at DESC')")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        task = FactoryGirl.create(:bill_of_base_materialx_bom, :project_id => @proj.id)
        task1 = FactoryGirl.create(:bill_of_base_materialx_bom, :project_id => @proj.id + 1, part_id: @part1.id)
        get 'index', {:project_id => @proj.id}
        expect(assigns[:boms]).to eq([task])
      end
      
      it "should only return the part for part_id" do
        user_access = FactoryGirl.create(:user_access, :action => 'index', :resource =>'bill_of_base_materialx_boms', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "BillOfBaseMaterialx::Bom.order('created_at DESC')")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        task = FactoryGirl.create(:bill_of_base_materialx_bom, :project_id => @proj.id, :part_id => @part.id)
        task1 = FactoryGirl.create(:bill_of_base_materialx_bom, :project_id => @proj.id, :part_id => @part1.id)
        get 'index', {:part_id => @part.id}
        expect(assigns[:boms]).to  match_array([task])
      end
            
    end
  
    describe "GET 'new'" do
      it "returns bring up new page" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource =>'bill_of_base_materialx_boms', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        get 'new', { :project_id => @proj.id}
        expect(response).to be_success
      end
      
    end
  
    describe "GET 'create'" do
      it "should create and redirect after successful creation" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource =>'bill_of_base_materialx_boms', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        task = FactoryGirl.attributes_for(:bill_of_base_materialx_bom, :project_id => @proj.id )  
        get 'create', {:bom => task, :project_id => @proj.id, :part_id => @part.id}
        expect(response).to redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Saved!")
      end
      
      it "should render 'new' if data error" do        
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource =>'bill_of_base_materialx_boms', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        task = FactoryGirl.attributes_for(:bill_of_base_materialx_bom, :project_id => @proj.id, :part_id => nil)
        get 'create', {:bom => task}
        expect(response).to render_template('new')
      end
    end
  
    describe "GET 'edit'" do
      it "returns edit page" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource =>'bill_of_base_materialx_boms', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        task = FactoryGirl.create(:bill_of_base_materialx_bom, :project_id => @proj.id)
        get 'edit', {:id => task.id}
        expect(response).to be_success
      end
      
    end
  
    describe "GET 'update'" do
      it "should return success and redirect" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource =>'bill_of_base_materialx_boms', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        task = FactoryGirl.create(:bill_of_base_materialx_bom, :project_id => @proj.id)
        get 'update', {:id => task.id, :bom => {:name => 'new name'}}
        expect(response).to redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Updated!")
      end
      
      it "should render edit with data error" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource =>'bill_of_base_materialx_boms', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        task = FactoryGirl.create(:bill_of_base_materialx_bom, :project_id => @proj.id)
        get 'update', {:id => task.id, :bom => {:part_id => ''}}
        expect(response).to render_template('edit')
      end
    end
  
    describe "GET 'show'" do
      it "returns http success" do
        user_access = FactoryGirl.create(:user_access, :action => 'show', :resource =>'bill_of_base_materialx_boms', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "record.last_updated_by_id == session[:user_id]")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        task = FactoryGirl.create(:bill_of_base_materialx_bom, :project_id => @proj.id, :last_updated_by_id => @u.id)
        get 'show', {:id => task.id}
        expect(response).to be_success
      end
    end
    
    describe "GET 'destroy'" do
      it "returns http success" do
        user_access = FactoryGirl.create(:user_access, :action => 'destroy', :resource => 'bill_of_base_materialx_boms', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        q = FactoryGirl.create(:bill_of_base_materialx_bom)
        get 'destroy', {:id => q.id }
        expect(response).to redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Deleted!")
      end
    end
    
    describe "GET bom_status" do
      it "should success" do
        user_access = FactoryGirl.create(:user_access, :action => 'bom_status', :resource =>'bill_of_base_materialx_boms', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        q_i = FactoryGirl.build(:purchase_orderx_order_item, spec: 'MyString')
        q = FactoryGirl.create(:purchase_orderx_order, :order_items => [q_i], :project_id => @proj.id)
        task = FactoryGirl.create(:bill_of_base_materialx_bom, :project_id => @proj.id, :last_updated_by_id => @u.id, part_id: @part.id)
        get 'bom_status', {:project_id => @proj.id}
        expect(response).to be_success
      end
    end
  
  end
end
