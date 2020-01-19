class CadetsController < ApplicationController
  before_action :set_cadet, only: [:show, :edit, :update, :destroy]
  skip_before_action :authorized, only: [:new, :create]

  # GET /cadets
  # GET /cadets.json
  def index
    if params[:term]
      @cadets = Cadet.search_by_full_name(params[:term])
      if params[:term] == ''
        @cadets = Cadet.where(approved: true).order(:lastName)
      end
    else
      @cadets = Cadet.where(approved: true).order(:lastName)
    end
  end

  # GET /cadets/1
  # GET /cadets/1.json
  def show
     @cadets = Cadet.all.order(:lastName)
     @ord_attendance = @cadet.attendances
    
  end

  # GET /cadets/new
  def new
    @cadet = Cadet.new
    @schoolList = [['Xavier University','Xavier University'],['Delgado Community College','Delgado Community College'],['Dillard University','Dillard University'],['University of New Orleans','University of New Orleans'],['University of Holy Cross','University of Holy Cross'],['Lousiana State University Nursing School','Lousiana State University Nursing School'],['Southern University of New Orleans','Southern University of New Orleans'],['Tulane University','Tulane University']]
    @flightList = [['Alpha','Alpha'],['Bravo','Bravo']]
    @courseList = [['AS100','AS100'],['AS200','AS200'], ['AS250','AS250'], ['AS300','AS300'], ['AS400','AS400'], ['AS500','AS500']]
    @positionList = [['Cadet Wing Commander','Cadet Wing Commander'],['Mission Support Group Commander','Mission Support Group Commander'],['Operations Group Commander','Operations Group Commander'],['Squadron Commander','Squadron Commander'],['A Flight Commander','A Flight Commander'],['B Flight Commander','B Flight Commander'],['Cadet','Cadet']]
  end

  # GET /cadets/1/edit
  def edit
    @schoolList = [['Xavier University','Xavier University'],['Delgado Community College','Delgado Community College'],['Dillard University','Dillard University'],['University of New Orleans','University of New Orleans'],['University of Holy Cross','University of Holy Cross'],['Lousiana State University Nursing School','Lousiana State University Nursing School'],['Southern University of New Orleans','Southern University of New Orleans'],['Tulane University','Tulane University']]
    @flightList = [['Alpha','Alpha'],['Bravo','Bravo']]
    @courseList = [['AS100','AS100'],['AS200','AS200'], ['AS250','AS250'], ['AS300','AS300'], ['AS400','AS400'], ['AS500','AS500']]
    @positionList = [['Cadet Wing Commander','Cadet Wing Commander'],['Mission Support Group Commander','Mission Support Group Commander'],['Operations Group Commander','Operations Group Commander'],['Squadron Commander','Squadron Commander'],['A Flight Commander','A Flight Commander'],['B Flight Commander','B Flight Commander'],['Cadet','Cadet']]
  end

  # POST /cadets
  # POST /cadets.json
  def create
    @cadet = Cadet.new(cadet_params)
    
      if @cadet.save
        CadetMailer.with(cadet: @cadet).new_cadet_email.deliver_later
        
        @cwcc = Cadet.find_by position: 'Cadet Wing Commander'
        CadetMailer.with(cadet: @cwcc).new_cadet_admin.deliver_later
      
        redirect_to '/', success: "#{@cadet.firstName} #{@cadet.lastName} has been successfully added to the ROTC roster! Your account must be approved before login."
      else
        redirect_to '/cadets/new', danger: "Cadet was not added."
      end
  end

  # PATCH/PUT /cadets/1
  # PATCH/PUT /cadets/1.json
  def update
    if (Cadet.find_by(id: session[:cadet_id]).position != "Cadet")
      if @cadet.update(admin_update_params)
        if params[:password].blank?
          params.delete(:password)
        end
        redirect_to @cadet, success: "Cadet was successfully updated!"
      else
        redirect_to @cadet, warning: "Cadet was not updated!"
      end
    else
      if @cadet.update(cadet_update_params)
        redirect_to @cadet, success: "Cadet was successfully updated!"
      else
        redirect_to @cadet, warning: "Cadet was not updated!"
      end
    end
  end

  # DELETE /cadets/1
  # DELETE /cadets/1.json
  def destroy
    @cadet.attendances.destroy_all
    
    @cadet.destroy
    redirect_to cadets_url, info: "Cadet successfully removed from the ROTC roster."
  end
  
  def unapproved
    @cadets = Cadet.where(approved: false).order(:lastName)
  end
  
  def flights
    @cadets = []
    @flight = params[:flight]
    Cadet.where(flight: @flight).where(approved: true).find_each do |cadet|
      @cadets << cadet
    end
    
    @total_attendance = 0
    @pt_attendance = 0
    @llab_attendance = 0
    @llab_percent = 0
    @pt_percent = 0
    @total_percent = 0
    
    @num_otscs = 0
    
    @pt_points = 0
    
    @weekly_points = {}
    @last_week_beginning = Date.today.last_week.beginning_of_week
    @last_week_end = Date.today.last_week.end_of_week
    
    @cadets.each do |cadet|
      @pt_attendance += cadet.pt_attendance
      @llab_attendance += cadet.llab_attendance
      @total_attendance += (cadet.pt_attendance + cadet.llab_attendance)
      
      @num_otscs += cadet.otscs.all.count
      
      @pt_points += cadet.pt_points
      
      @weekly_points[cadet.weekly_pt_points] = cadet
    end
    @pt_percent = @pt_attendance.to_f / @cadets.count.to_f
    @llab_percent = @llab_attendance.to_f / @cadets.count.to_f
    @total_percent = @total_attendance.to_f / (@cadets.count.to_f * 2)
    
    @pt_cadet = @weekly_points[@weekly_points.keys().max]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cadet
      @cadet = Cadet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cadet_params
      params.require(:cadet).permit(:lastName, :firstName, :email, :phoneNumber, :school, :position, :course, :gradYear, :flight, :username, :password, :password_confirmation)
    end
    
    def cadet_update_params
      params.require(:cadet).permit(:lastName, :firstName, :email, :phoneNumber, :school, :position, :course, :gradYear, :flight, :username)
    end
    
    def admin_update_params
      params.require(:cadet).permit(:lastName, :firstName, :email, :phoneNumber, :school, :position, :course, :gradYear, :flight, :username, :password, :approved)
    end
end
