class WarriorknowledgesController < ApplicationController
  before_action :set_warriorknowledge, only: [:show, :edit, :update, :destroy]

  # GET /warriorknowledges
  # GET /warriorknowledges.json
  def index
    @warriorknowledges = Warriorknowledge.all.order(date_assigned: :desc).page(params[:page]).per_page(15)
  end

  # GET /warriorknowledges/1
  # GET /warriorknowledges/1.json
  def show
  end

  # GET /warriorknowledges/new
  def new
    @warriorknowledge = Warriorknowledge.new
  end

  # GET /warriorknowledges/1/edit
  def edit
  end

  # POST /warriorknowledges
  # POST /warriorknowledges.json
  def create
    @warriorknowledge = Warriorknowledge.new(warriorknowledge_params)
    
    if @warriorknowledge.save
      redirect_to @warriorknowledge, success: "Warrior knowledge quiz successfully created."
    else
      redirect_to '/warriorknowledges/new', danger: "Warrior knowledge quiz was not created."
    end
  end

  # PATCH/PUT /warriorknowledges/1
  # PATCH/PUT /warriorknowledges/1.json
  def update
    if @warriorknowledge.update(warriorknowledge_params)
      redirect_to @warriorknowledge, success: "Warrior knowledge quiz was successfully updated."
    else
      redirect_to edit_warriorknowledge_path(@warriorknowledge), danger: "Warrior knowledge quiz was not updated."
    end
  end

  # DELETE /warriorknowledges/1
  # DELETE /warriorknowledges/1.json
  def destroy
    @warriorknowledge.destroy
    redirect_to warriorknowledges_url, info: "Warrior knowledge quiz was successfully deleted."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_warriorknowledge
      @warriorknowledge = Warriorknowledge.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def warriorknowledge_params
      params.require(:warriorknowledge).permit(:num_questions, :num_correct, :date_assigned, :name, :cadet_id)
    end
end
