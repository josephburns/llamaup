class CompaniesController < ApplicationController
  def index
    render json: { data: Company.all }
  end

  def alphabetically
    render json: { data: Company.order(:name)}
  end

  def with_modern_plan
    render json: { data: Company.where.not(plan_level: ['custom', 'legacy']) }
  end

  def not_trialing
    render json: { data: Company.all.map{|x| x.trial_status ? nil : x }.compact}
  end
  
  def created_last_month
    last_month = (Date.today << 1).month
    last_month_year = (last_month.month == 12 ? Date.today.prev_year : Date.today.year)
    companies_created_last_month = Company.all.map{ |x|
      created = x['created_at']
      created.month == last_month && created.year == last_month_year ? x : nil
    }.compact
    render json: { data: companies_created_last_month }
  end
end
