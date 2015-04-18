class Prow < ActiveRecord::Base
	belongs_to :prescription
	has_many :box_parts
	belongs_to :drug
	has_one :consumption

end
