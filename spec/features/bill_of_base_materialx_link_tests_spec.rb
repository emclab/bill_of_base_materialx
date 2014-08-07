require 'spec_helper'

describe "LinkTests" do
  describe "GET /bill_of_base_materialx_link_tests" do
    mini_btn = 'btn btn-mini '
    ActionView::CompiledTemplates::BUTTONS_CLS =
        {'default' => 'btn',
         'mini-default' => mini_btn + 'btn',
         'action'       => 'btn btn-primary',
         'mini-action'  => mini_btn + 'btn btn-primary',
         'info'         => 'btn btn-info',
         'mini-info'    => mini_btn + 'btn btn-info',
         'success'      => 'btn btn-success',
         'mini-success' => mini_btn + 'btn btn-success',
         'warning'      => 'btn btn-warning',
         'mini-warning' => mini_btn + 'btn btn-warning',
         'danger'       => 'btn btn-danger',
         'mini-danger'  => mini_btn + 'btn btn-danger',
         'inverse'      => 'btn btn-inverse',
         'mini-inverse' => mini_btn + 'btn btn-inverse',
         'link'         => 'btn btn-link',
         'mini-link'    => mini_btn +  'btn btn-link'
        }
    before(:each) do
      @pagination_config = FactoryGirl.create(:engine_config, :engine_name => nil, :engine_version => nil, :argument_name => 'pagination', :argument_value => 30)
      piece_unit = FactoryGirl.create(:engine_config, :engine_name => nil, :engine_version => nil, :argument_name => 'piece_unit', :argument_value => "set, piece")
      z = FactoryGirl.create(:zone, :zone_name => 'hq')
      type = FactoryGirl.create(:group_type, :name => 'employee')
      ug = FactoryGirl.create(:sys_user_group, :user_group_name => 'ceo', :group_type_id => type.id, :zone_id => z.id)
      @role = FactoryGirl.create(:role_definition)
      ur = FactoryGirl.create(:user_role, :role_definition_id => @role.id)
      ul = FactoryGirl.build(:user_level, :sys_user_group_id => ug.id)
      @u = FactoryGirl.create(:user, :user_levels => [ul], :user_roles => [ur])
      
      user_access = FactoryGirl.create(:user_access, :action => 'index', :resource =>'bill_of_base_materialx_boms', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "BillOfBaseMaterialx::Bom.order('created_at DESC')")
        
      user_access = FactoryGirl.create(:user_access, :action => 'create', :resource =>'bill_of_base_materialx_boms', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
      user_access = FactoryGirl.create(:user_access, :action => 'update', :resource =>'bill_of_base_materialx_boms', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
      user_access = FactoryGirl.create(:user_access, :action => 'show', :resource =>'bill_of_base_materialx_boms', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "record.last_updated_by_id == session[:user_id]")
      user_access = FactoryGirl.create(:user_access, :action => 'destroy', :resource =>'bill_of_base_materialx_boms', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
      user_access = FactoryGirl.create(:user_access, :action => 'create_bom', :resource => 'commonx_logs', :role_definition_id => @role.id, :rank => 1,
      :sql_code => "")
      
        
      #@pur_sta = FactoryGirl.create(:commonx_misc_definition, 'for_which' => 'bom_status')
      @proj = FactoryGirl.create(:ext_construction_projectx_project)
      @part = FactoryGirl.create(:base_materialx_part) 
      
      
      visit '/'
      #save_and_open_page
      fill_in "login", :with => @u.login
      fill_in "password", :with => @u.password
      click_button 'Login'
    end
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      task = FactoryGirl.create(:bill_of_base_materialx_bom, :project_id => @proj.id, :part_id => @part.id, :last_updated_by_id => @u.id, :status_id => nil)
      visit boms_path
      #save_and_open_page
      page.should have_content('BOMs')
      click_link 'Edit'
      page.should have_content('Edit BOM')
      save_and_open_page
      fill_in 'bom_qty', :with => 122
      click_button 'Save'
      visit boms_path
      page.should have_content(122)
      #with wrong data
      visit boms_path
      #save_and_open_page
      page.should have_content('BOMs')
      click_link 'Edit'
      fill_in 'bom_qty', :with => 'test again'
      click_button 'Save'
      #save_and_open_page
      visit boms_path
      page.should_not have_content('test again')
      
      visit boms_path
      click_link task.id.to_s
      #save_and_open_page
      page.should have_content('BOM Info')
      click_link 'New Log'
      #save_and_open_page
      page.should have_content('Log')
      
      visit boms_path(:project_id => @proj.id)
      save_and_open_page
      click_link 'New Part'
      page.should have_content('New BOM')
      fill_in 'bom_part_id', :with => @part.id + 1
      fill_in 'bom_qty', :with => 100
      click_button 'Save'
      save_and_open_page
      visit boms_path
      
      page.should have_content(100)
      #with wrong data
      visit boms_path(:project_id => @proj.id)
      click_link 'New Part'
      fill_in 'bom_part_id', :with => ''
      fill_in 'bom_qty', :with => 199
      click_button 'Save'
      #save_and_open_page
      visit boms_path
      page.should_not have_content(199)           
    end
    
    it "should delete" do
      task = FactoryGirl.create(:bill_of_base_materialx_bom, :project_id => @proj.id, :part_id => @part.id, :last_updated_by_id => @u.id, :status_id => nil)
      visit boms_path
      click_link task.id.to_s
      #save_and_open_page
      page.should have_content('BOM Info')
      click_link 'Delete'
      save_and_open_page
    end
  end
end
