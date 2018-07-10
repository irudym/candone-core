class V1::PersonTypesController < ApplicationController
  before_action :set_person_type, only: [:show, :update, :destroy]

  # GET /person_types
  def index
    @person_types = PersonType.all
    json_response(@person_types)
  end

  # POST /persons
  def create
    @person_type = PersonType.create!(person_type_params)
    json_response(@person_type, :created)
  end

  # GET /persons/:id
  def show
    json_response(@person_type)
  end

  # PUT /persons/:id
  def update
    PersonType.update(person_type_params)
    head :no_content
  end


  # DELETE /persons/:id
  def destroy
    @person_type.destroy
    head :no_content
  end


  private

  def person_type_params
    # whitelist params
    params.permit(:name)
  end

  def set_person_type
    @person_type = PersonType.find(params[:id])
  end
end
