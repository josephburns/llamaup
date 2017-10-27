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
end
