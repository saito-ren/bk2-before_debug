Rails.application.routes.draw do
  resources :books
#   GET "/users/sign_in" にアクセスしようとしてるけど、GET "/users/:id" に "id" = "sign_in" としてアクセスしちゃってる・・・
# そして、 users#show はログインしていないとログインページに強制リダイレクトする設定になっているので、 GET "/users/sign_in" にアクセスして無限ループしてしまう。
# ルーティングも上から順番に処理を行うため、最初に引っかかるurlにヒットしてしまう。
# なので、この場合はdevise_for :usersを先に書かなければいけない。
# 以下、参考資料
  # https://qiita.com/miyazaki_yusuke/items/bcf6ecce829a5ebdb374
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update]
  root 'home#top'
  get 'home/about'
end