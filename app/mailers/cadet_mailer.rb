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
    
    def absent_email
        @cadet = params[:cadet]
        @event = params[:event]
        mail(to: @cadet.email, subject: "Attendance Update")
    end
    
    def tardy_email
        @cadet = params[:cadet]
        @event = params[:event]
        mail(to: @cadet.email, subject: "Attendance Update")
    end
    
    def present_email
        @cadet = params[:cadet]
        @event = params[:event]
        mail(to: @cadet.email, subject: "Attendance Update")
    end
    
    def task_created_email
        @cadet = params[:cadet]
        @task = params[:task]
        mail to: @cadet.email, :subject => 'New Task Created'
    end
    
    def task_updated_email
        @cadet = params[:cadet]
        @task = params[:task]
        mail to: @cadet.email, :subject => 'Task Updated'
    end
    
    def otsc_one_email
        @cadet = params[:cadet]
        @otsc = params[:otsc]
        mail to: @cadet.email, :subject => 'OTSC'
    end
    
    def otsc_two_email
        @cadet = params[:cadet]
        @otsc = params[:otsc]
        mail to: @cadet.email, :subject => 'OTSC'
    end
    
    def otsc_three_email
        @cadet = params[:cadet]
        @otsc = params[:otsc]
        mail to: @cadet.email, :subject => 'OTSC'
    end
    
    def otsc_four_email
        @cadet = params[:cadet]
        @otsc = params[:otsc]
        mail to: @cadet.email, :subject => 'OTSC'
    end
    
    def otsc_five_email
        @cadet = params[:cadet]
        @otsc = params[:otsc]
        mail to: @cadet.email, :subject => 'OTSC'
    end
    
    def otsc_six_email
        @cadet = params[:cadet]
        @otsc = params[:otsc]
        mail to: @cadet.email, :subject => 'OTSC'
    end
    
    def otsc_admin_email
        @cadet = params[:cadet]
        @admin = params[:admin]
        @otsc = params[:otsc]
        mail to: @admin.email, :subject => 'OTSC'
    end
end
