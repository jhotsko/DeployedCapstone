class WorkoutsController < ApplicationController
  def create
    @cadet = Cadet.find(params[:cadet_id])
    @workout = @cadet.workouts.create(workout_params)
    if @workout.save
      redirect_to cadet_workouts_path(@cadet), success: "Workout was successfully created!"
    else
      redirect_to cadet_workouts_path(@cadet), warning: "Workout was not created"
    end
  end
    
  def destroy
    @cadet = Cadet.find(params[:cadet_id])
    @workout = @cadet.workouts.find(params[:id])
    @workout.destroy
    redirect_to cadet_workouts_path(@cadet), info: "Workout was successfully deleted."
  end
  
  def index
    @cadet = Cadet.find(params[:cadet_id])
    @workouts = @cadet.workouts.order(:workoutdate).page(params[:page]).per_page(15)
    
    @last_week_beginning = Date.today.last_week.beginning_of_week
    @last_week_end = Date.today.last_week.end_of_week
    
    @workout_list = ['Pushups', 'Pullups', 'Sit-ups', 'Run', 'Swim', 'Weights']
  end
 
  private
    def workout_params
      params.require(:workout).permit(:workoutType, :workoutdate, :repititions, :distance, :cadet_id)
    end
end
