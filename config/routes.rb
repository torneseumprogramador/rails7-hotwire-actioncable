Rails.application.routes.draw do
  resources :fornecedors
  get "/clientes/criar_novo_cliente_hotwire", to: "clientes#criar_novo_cliente_hotwire", as: :criar_novo_cliente_hotwire
  get "/view-component", to: "view_componentes#index"
  
  resources :clientes
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "clientes#index"

end
