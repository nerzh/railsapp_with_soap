class Currency < ActiveRecord::Base
  has_and_belongs_to_many :countries

  def exist!
    self.update(exist: true)
  end

  def absent
    self.update(exist: false)
  end
end
