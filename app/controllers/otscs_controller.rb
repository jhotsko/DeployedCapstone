class OtscsController < ApplicationController
  def create
    @cadet = Cadet.find(params[:cadet_id])
    @otsc = @cadet.otscs.create(otsc_params)
    @sqcc = Cadet.find_by position: 'Squadron Commander'
    @ogcc = Cadet.find_by position: 'Operations Group Commander'
    @cwcc = Cadet.find_by position: 'Cadet Wing Commander'
    
    if @otsc.save
      redirect_to cadet_otscs_path(@cadet), success: "OTSC was successfully created!"
      num_otscs = @cadet.otscs.all.count
      if num_otscs == 1
        CadetMailer.with(cadet: @cadet).otsc_one_email.deliver_later
        CadetMailer.with(cadet: @cadet, admin: @sqcc, otsc: @otsc).otsc_one_email.deliver_later
      elsif num_otscs == 2
        CadetMailer.with(cadet: @cadet).otsc_two_email.deliver_later
        CadetMailer.with(cadet: @cadet, admin: @sqcc, otsc: @otsc).otsc_one_email.deliver_later
        Task.create!(:date_created => @otsc.date, :date_due => @otsc.date.next_day(7), :description => "Memo for second OTSC", :completed => 0, :cadet_id => @cadet.id)
      elsif num_otscs == 3
        CadetMailer.with(cadet: @cadet).otsc_three_email.deliver_later
        CadetMailer.with(cadet: @cadet, admin: @sqcc, otsc: @otsc).otsc_one_email.deliver_later
        Task.create!(:date_created => @otsc.date, :date_due => @otsc.date.next_day(7), :description => "Verbal counseling for C/#{@cadet.firstName} #{@cadet.lastName} (third OTSC)", :completed => 0, :cadet_id => @sqcc.id)
      elsif num_otscs == 4
        CadetMailer.with(cadet: @cadet).otsc_four_email.deliver_later
        CadetMailer.with(cadet: @cadet, admin: @sqcc, otsc: @otsc).otsc_one_email.deliver_later
        Task.create!(:date_created => @otsc.date, :date_due => @otsc.date.next_day(7), :description => "LOC for C/#{@cadet.firstName} #{@cadet.lastName} (fourth OTSC)", :completed => 0, :cadet_id => @ogcc.id)
      elsif num_otscs == 5
        CadetMailer.with(cadet: @cadet).otsc_five_email.deliver_later
        CadetMailer.with(cadet: @cadet, admin: @sqcc, otsc: @otsc).otsc_one_email.deliver_later
        Task.create!(:date_created => @otsc.date, :date_due => @otsc.date.next_day(7), :description => "LOC for C/#{@cadet.firstName} #{@cadet.lastName} (fifth OTSC)", :completed => 0, :cadet_id => @cwcc.id)
      elsif num_otscs >= 6
        CadetMailer.with(cadet: @cadet).otsc_six_email.deliver_later
        CadetMailer.with(cadet: @cadet, admin: @sqcc, otsc: @otsc).otsc_one_email.deliver_later
        Task.create!(:date_created => @otsc.date, :date_due => @otsc.date.next_day(7), :description => "Cadre counseling for C/#{@cadet.firstName} #{@cadet.lastName} (sixth or more OTSC)", :completed => 0, :cadet_id => @cwcc.id)
      end
    else
      redirect_to cadet_otscs_path(@cadet), warning: "OTSC was not created"
    end
  end
    
  def destroy
    @cadet = Cadet.find(params[:cadet_id])
    @otsc = @cadet.otscs.find(params[:id])
    @otsc.destroy
    redirect_to cadet_otscs_path(@cadet), info: "OTSC was successfully deleted."
  end
    
  def index
    @cadet = Cadet.find(params[:cadet_id])
    @otscs = @cadet.otscs.order(:date)
  end
 
  private
    def otsc_params
      params.require(:otsc).permit(:date, :description, :cadet_id)
    end
end