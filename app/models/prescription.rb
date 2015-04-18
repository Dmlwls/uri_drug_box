class Prescription < ActiveRecord::Base
	belongs_to :user
	has_many :prows
end
