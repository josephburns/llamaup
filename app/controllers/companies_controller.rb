class CompaniesController < ApplicationController
  def index
    render json: { data: Company.all }
  end
end
