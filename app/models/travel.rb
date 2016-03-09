class Travel < ActiveRecord::Base
  include ModelUtility
  has_and_belongs_to_many :countries
  after_save :update_statuses

  validates :date, presence: true
  validates :description, length: { within: 1..255 }, presence: true

  def complete?
    complete_date ? true : false
  end

end
