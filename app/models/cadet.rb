class Cadet < ApplicationRecord
    has_many :attendances, dependent: :destroy
    has_many :otscs, dependent: :destroy
    has_many :workouts, dependent: :destroy
    has_many :tasks, dependent: :destroy
    has_many :grades, dependent: :destroy
    has_many :events, through: :attendances
    has_many :warriorknowledges, through: :grades
    has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100#" }, :default_url => 'profile_pic.png'
    has_secure_password
    validates :password, confirmation: { case_sensitive: true }
    validates :username, :uniqueness => { :case_sensitive => false }
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
    validates :school, :position, :course, :gradYear, :flight, :presence => true
    
    validates :lastName,
        presence: true,
        length: {maximum: 50},
        allow_nil: false
        
    validates :firstName,
        presence: true,
        length: {maximum: 50},
        allow_nil: false
        
    validates :email,
        presence: true,
        length: {maximum: 50},
        allow_nil: false,
        format: { with: URI::MailTo::EMAIL_REGEXP } 
        
    validates :phoneNumber,
        presence: true,
        length: {maximum: 10, minimum: 10},
        allow_nil: false
        
    validates :username,
        presence: true,
        length: {maximum: 50},
        allow_nil: false,
        :uniqueness => { :case_sensitive => false }
    
    validates :password,
        :if => :password,
        presence: true,
        length: {maximum: 50, minimum: 8},
        allow_nil: false
    
    
    include PgSearch
    pg_search_scope :search_by_full_name, against: [:firstName, :lastName],
        using: {
            tsearch: {
                prefix: true
            }
        }
        
    def pt_attendance
    
        @PT_percent = 0
        @total_PT = 0
        @pres_PT = 0
        @attendances = self.attendances
    
        @attendances.each do |attendance|
            if attendance.event.primaryType == "PT"
                @total_PT += 1
                if attendance.attended == 1 || attendance.attended == 3 || attendance.attended == 4
                    @pres_PT += 1
                elsif attendance.attended == 2
                    @pres_PT += 0.5
                end
            end
        end
        if @total_PT != 0
            @PT_percent = @pres_PT.to_f / @total_PT.to_f * 100
        end
        @PT_percent
    end
    
    def llab_attendance
    
        @llab_percent = 0
        @total_llab = 0
        @pres_llab = 0
        @attendances = self.attendances
    
        @attendances.each do |attendance|
            if attendance.event.primaryType == "LLAB"
                @total_llab += 1
                
                if attendance.attended == 1 || attendance.attended == 3 || attendance.attended == 4
                    @pres_llab += 1
                elsif attendance.attended == 2
                    @pres_llab += 0.5
                end
            end
        end
        if @total_llab != 0
            @llab_percent = @pres_llab.to_f / @total_llab.to_f * 100
        end
        @llab_percent
    end
    
    def pt_points
        @workouts = self.workouts.all
        @points = 0
        
        @workouts.each do |workout|
            @points += (workout.repititions.to_i * 1) + (workout.distance.to_i * 50)
        end
        
        @points
    end
    
    def weekly_pt_points
        @workouts = self.workouts.all
        @points = 0
    
        @last_week_beginning = Date.today.last_week.beginning_of_week
        @last_week_end = Date.today.last_week.end_of_week
        
        @workouts.each do |workout|
            if workout.workoutdate.between?(@last_week_beginning, @last_week_end)
                @points += (workout.repititions.to_i * 1) + (workout.distance.to_i * 50)
            end
        end
        
        @points
    end
    
    def grade_average
        @grades = self.grades
        @avg = 0
        
        @grades.each do |grade|
            @avg += grade.score
        end
        @avg = (@avg.to_f / @grades.all.count.to_f).round(2)
        @avg
    end
    
    def send_password_reset
      generate_token(:password_reset_token)
      self.password_reset_sent_at = Time.zone.now
      save!(validate: false)
      CadetMailer.forgot_password(self).deliver# This sends an e-mail with a link for the user to reset the password
    end

    # This generates a random password reset token for the user
    def generate_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while Cadet.exists?(column => self[column])
    end
end