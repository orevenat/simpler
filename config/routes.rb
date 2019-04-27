Simpler.application.routes do
  get '/tests', 'tests#index'
  get '/tests/:id', 'tests#show'
  post '/tests', 'tests#create'
  get '/plain', 'tests#plain'
end
