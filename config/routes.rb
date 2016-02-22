Rails.application.routes.draw do
  root to: "game#bowling"
  get "/bowl" => "game#bowl", as: :bowl
end
