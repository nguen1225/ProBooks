module AllCategories
	extend ActiveSupport::Concern

	private
	def all_categories
		@categories = Category.all
	end
end