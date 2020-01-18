class CadetMailer < ApplicationMailer
    def new_cadet_email
        @cadet = params[:cadet]
        mail(to: @cadet.email, subject: "Welcome to ROTSee!")
    end
    
    def new_cadet_admin
        @cadet = params[:cadet]
        mail(to: @cadet.email, subject: "New Cadet")
    end
    
    def forgot_password(cadet)
      @cadet = cadet
      mail to: cadet.email, :subject => 'Reset password instructions'
    end
    
    def attendance_email
        @cadet = params[:cadet]
        @event = params[:event]
        @attendance = params[:attendance]
        mail(to: @cadet.email, subject: "Attendance Update")
    end
    
    def admin_attendance_email
        @event = params[:event]
        @admin = params[:admin]
        mail(to: @admin.email, subject: "Attendance Update")
    end
    
    def task_created_email
        @cadet = params[:cadet]
        @task = params[:task]
        mail(to: @cadet.email, :subject => 'New Task Created')
    end
    
    def task_updated_email
        @cadet = params[:cadet]
        @task = params[:task]
        mail(to: @cadet.email, :subject => 'Task Updated')
    end
    
    def otsc_email
        @cadet = params[:cadet]
        @otsc = params[:otsc]
        mail(to: @cadet.email, :subject => 'OTSC')
    end
    
    def otsc_admin_email
        @cadet = params[:cadet]
        @admin = params[:admin]
        @otsc = params[:otsc]
        mail(to: @admin.email, :subject => 'OTSC')
    end
end
