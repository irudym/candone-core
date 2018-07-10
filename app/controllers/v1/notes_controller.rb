class V1::NotesController < ApplicationController
  before_action :set_note, only: [:show, :update, :destroy]
  before_action :set_participants, only: [:create, :update]

  # GET /notes
  def index
    @notes = Note.all
    # json_response NoteSerializer.new(@notes).serialized_json
  end

  # GET /notes/:id
  def show
    #json_fields_response(@note, :ok, :id, :markdown, :created_at, :persons, :tasks)
  end

  # POST /notes
  def create
    # TODO: need to move the code below to Model create_with... method
    # at first lets create tasks
    tasks = nil
    unless params[:actions].nil?
      tasks = params[:actions].inject([]) do |acc, action|
        task = Task.create_with_persons!(action[:person_ids], title: action[:title], description: "Action from a note", urgency: 0)
        acc << task
      end
    end

    # at first find participants
    participants = Person.where(id: params[:participants])

    @note = Note.create!(note_params)
    @note.tasks << tasks if tasks
    @note.persons = participants unless participants.empty?

    render :show, status: 201
  end

  def update
    @note.update_with_tasks_persons(params[:actions], params[:participants], note_params)
    render :show, status: 202
  end

  def destroy
    @note.destroy
    head :no_content
  end

  private

  def set_note
    @note = Note.find(params[:id])
  end

  def set_participants
    @participants = Person.where(id: params[:participants])
  end

  def note_params
    params.permit(:markdown, :participants, :actions)
  end
end
