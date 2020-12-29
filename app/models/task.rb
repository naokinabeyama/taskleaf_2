class Task < ApplicationRecord
	# コールバック
	# before_validation :set_nameless_name

	validates :name, presence: true, length: { maximum: 30 }
	validate :validate_name_not_including_conma

	private

	def validate_name_not_including_conma
		errors.add(:name, 'にカンマを含めることはできません') if name&.include?(',')
	end

	# コールバック、「名前なし」を自動追加
	# def set_nameless_name
	# 	self.name = '名前なし' if name.blank?
	# end
end
