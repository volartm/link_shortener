Rails.application.routes.draw do
  get 'link_show/show'
  get 'link_shortener/shorten'
  get ':link_hash', to: 'link_show#ll'
end
