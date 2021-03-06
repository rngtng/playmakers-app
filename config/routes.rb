PlaymakersApp::Application.routes.draw do
  controller :sessions do
    get    'login'                 => :new
    post   'login'                 => :new
    get    'auth/shopify/callback' => :show
    delete 'logout'                => :destroy
  end

  get 'products/show' => redirect { |params, req|
    "/products/#{req.query_parameters['id']}"
  }

  get  'products/:id/variants/:variant_id/image.:format' => 'images#variant'

  get  'import'   => 'products#update_variant_quantities'

  get  'products/:id' => 'products#show'
  get  'products/edit' => 'products#edit'

  # get 'welcome' => 'home#welcome'
  # get 'design'  => 'home#design'
  # get  'images'               => 'images#show'
  # get  'products/metafields'  => 'products#metafields'
  # post 'products/metafields'  => 'products#metafields'



  root :to => 'home#index'
end
