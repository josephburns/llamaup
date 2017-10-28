Rails.application.routes.draw do
  get 'companies/index'

  get 'companies/alphabetically'

  get 'companies/with_modern_plan'

  get 'companies/not_trialing'

  get 'companies/created_last_month'
end
