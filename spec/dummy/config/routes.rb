Rails.application.routes.draw do

  mount BillOfBaseMaterialx::Engine => "/bill_of_base_materialx"
  mount Commonx::Engine => "/commonx"
  mount Authentify::Engine => '/authentify'
  mount Kustomerx::Engine => '/customer'
  mount ExtConstructionProjectx::Engine => '/project'
  mount Searchx::Engine => '/search'
  mount BaseMaterialx::Engine => 'base_material'
  mount PurchaseOrderx::Engine => 'po'
  #mount InQuotex::Engine => '/in_quote'
  mount StateMachineLogx::Engine => '/sm_log'
  mount BizWorkflowx::Engine => '/biz_wf'
  mount Supplierx::Engine => '/supplier'
  #mount EventTaskx::Engine => '/task'
  
  resource :session
  
  root :to => "authentify::sessions#new"
  match '/signin',  :to => 'authentify::sessions#new'
  match '/signout', :to => 'authentify::sessions#destroy'
  match '/user_menus', :to => 'user_menus#index'
  match '/view_handler', :to => 'authentify::application#view_handler'
end
