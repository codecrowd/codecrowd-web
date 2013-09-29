CodecrowdWeb::Application.routes.draw do

  constraints subdomain: 'madis' do
    mount Personal::Engine => '/'
  end

  root to: 'pages#index'
  resources :pages

end
