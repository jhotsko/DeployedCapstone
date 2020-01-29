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
    @cadet = Cadet.find_by(id: session[:cadet_id])
    if @cadet.course == @warriorknowledge.tag || @warriorknowledge.tag == "All"
      @my_grade = @warriorknowledge.grades.find_by(cadet_id: session[:cadet_id]).score
    else
      @my_grade = "N/A"
    end
  end

  # GET /warriorknowledges/new
  def new
    @warriorknowledge = Warriorknowledge.new
    @tagList = [['All','All'],['POC','POC'],['GMC','GMC']]
  end

  # GET /warriorknowledges/1/edit
  def edit
    @tagList = [['All','All'],['POC','POC'],['GMC','GMC']]
  end

  # POST /warriorknowledges
  # POST /warriorknowledges.json
  def create
    @warriorknowledge = Warriorknowledge.new(warriorknowledge_params)
    
    if @warriorknowledge.save
      if @warriorknowledge.tag == "All"
        @cadets = Cadet.all
      elsif @warriorknowledge.tag == "POC"
        @cadets = Cadet.where(course: ["AS300", "AS400", "AS500"])
      else
        @cadets = Cadet.where(course: ["AS100", "AS200", "AS250"])
      end
      
      @cadets.each do |cadet|
        if cadet.approved == true
          Grade.create!(:num_correct => @warriorknowledge.num_questions, :cadet_id => cadet.id, :warriorknowledge_id => @warriorknowledge.id)
          CadetMailer.with(warriorknowledge: @warriorknowledge, cadet: cadet).quiz_email.deliver_later
        end
      end
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
    @warriorknowledge.grades.destroy_all
    
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
      params.require(:warriorknowledge).permit(:num_questions, :date_assigned, :name, :tag, grades_attributes: [:id, :num_correct, :cadet_id, :warriorknowledge_id, :created_at, :updated_at])
    end
end
