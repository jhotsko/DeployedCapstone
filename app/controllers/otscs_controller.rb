class OtscsController < ApplicationController
  def create
    @cadet = Cadet.find(params[:cadet_id])
    @otsc = @cadet.otscs.create(otsc_params)
    if @otsc.save
      redirect_to cadet_otscs_path(@cadet), success: "OTSC was successfully created!"
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