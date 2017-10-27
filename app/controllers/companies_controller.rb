class CompaniesController < ApplicationController
  def index
    render json: { data: Company.all }
  end

  def alphabetically
    render json: { data: Company.order(:name)}
  end
end
