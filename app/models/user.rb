class User < ApplicationRecord
  after_initialize :set_default_role, :if => :new_record?
  validates_presence_of :first_name, :last_name, :sex, :birthdate, :address
  validates :phone_number , :presence => true,
                            :numericality => true,
                            :length => { :minimum => 10, :maximum => 15 }
  validate :check_parents

  has_many :user_parents, class_name: Parent
  has_many :parents, through: :user_parents, 
            source: :parent

  has_one :sibling, class_name: "User", foreign_key: "kinsfolk_id" 
  belongs_to :kinsfolk, class_name: "User", optional: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: [:user, :admin]
  enum sex: [:male, :female]
  
  def to_s
  	full_name
  end

  def set_default_role
    self.role ||= :user
  end

  def full_name
  	first_name + " " + last_name
  end

  def age
  	now = Time.now.utc.to_date
  	now.year - birthdate.year - ((now.month > birthdate.month || (now.month >= birthdate.month && now.day >= birthdate.day)) ? 0 : 1)
  end

  def parents_names
  	parents.pluck(:first_name)
  end

  def check_parents
  	if parents.size > 2
  	  errors.add(:parents, "can't be more than two parents")
  	elsif parents.size == 2 && parents.pluck(:sex).uniq.size != 2
  	  errors.add(:parents, "can't be the same sex")
  	end
  end

end
