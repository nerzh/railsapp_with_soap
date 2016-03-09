class Currency < ActiveRecord::Base
  has_and_belongs_to_many :countries

  validates :name, presence: true
  validates :code, presence: true, uniqueness: true

  def exist!
    self.update(exist: true)
  end

  def absent!
    self.update(exist: false)
  end
end
