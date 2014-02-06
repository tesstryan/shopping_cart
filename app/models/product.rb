class Product < ActiveRecord::Base

	has_many :line_items

	before_destroy :ensure_not_referenced_by_any_line_item

validates :title, :description, :image, presence: true

validates :price, numericality: {greater_than_or_equal_to: 0.01}

validates :title, uniqueness: true

validates :image, allow_blank: true, format: {
	with: %r{\.(gif\jpg\png\png)\Z}i, 
	message: "must be a URL for GIL, JPG, or PNG image."
}


private 

def ensure_not_referenced_by_any_line_item
	 if line_items.empty?
	 	return true 
	 else 
	 	errors.add(:base, "Line Items preset")
	 	return false 
	end 
end

end
