Rails.application.routes.draw do

 resources :keys, only: [:index, :destroy] do

   member do
     put 'unblock'
     put 'preserve'
   end

   collection do
    put 'generate'
    put 'show_random_unblocked'
   end


 end

end

#   root "keys#index"
#   get "/generate", to: "keys#generate"
#   put "/show", to: "keys#show"
#   put "/unblock/:id", to: "keys#unblock"
#   delete "/delete/:id", to: "keys#delete"
#   put "/preserve/:id", to: "keys#preserve"
  
# end
