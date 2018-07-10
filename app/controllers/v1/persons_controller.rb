class V1::PersonsController < ApplicationController
  before_action :set_person, only: [:show, :update, :destroy]

  # GET /persons
  def index
    @persons = Person.all
    # json_response(@persons)
  end

  # POST /persons
  def create
    @person = Person.create!(person_params)
    json_response(@person, :created)
  end

  # GET /persons/:id
  def show
    json_response(@person)
  end

  # PUT /persons/:id
  def update
    @person.update(person_params)
    head :no_content
  end


  # DELETE /persons/:id
  def destroy
    @person.destroy
    head :no_content
  end


  private

  def person_params
    # whitelist params
    params.permit(:first_name, :last_name, :email, :description, :person_type_id)
  end

  def set_person
    @person = Person.find(params[:id])
  end
end
