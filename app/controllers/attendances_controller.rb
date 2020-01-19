class AttendancesController < ApplicationController
  before_action :set_attendance, only: [:edit, :update, :destroy, :send_email]
    
    def create
      @event = Event.find(params[:event_id])
      @attendance = @event.attendances.create(attendance_params)
      
      if @attendance.save
        redirect_to @event, success: "New attendance record has been successfully created."
      else
        redirect_to @event, danger: "Attendance not created."
      end
    end
    
    def destroy
      @attendance.destroy
    end
    
    def edit
    end
    
    def update
      @attendance.update(attendance_params)
    end
    
  private
  
    def set_attendance
      @attendance = Attendance.find(params[:id])
    end
  
    def attendance_params
     params.require(:attendance).permit(:attended, :cadet_id, :event_id)
    end
end
