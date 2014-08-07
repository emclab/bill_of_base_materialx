BillOfBaseMaterialx::Engine.routes.draw do
  
  resources :boms do
    collection do
      get :search
      get :search_results
    end  
  end
  
  root :to => 'boms#index'
end
