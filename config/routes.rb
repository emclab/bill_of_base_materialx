BillOfBaseMaterialx::Engine.routes.draw do
  
  resources :boms do
    collection do
      get :search
      get :search_results
      get :bom_status
    end  
  end
  
  root :to => 'boms#index'
end
