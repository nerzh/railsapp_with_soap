class Country < ActiveRecord::Base
  include ModelUtility

  has_and_belongs_to_many :currencies
  has_and_belongs_to_many :travels

  validates :name, presence: true
  validates :code, presence: true, uniqueness: true

  after_update :currency_exist?

  def visited!
    self.update(visited: true)
  end

  def unvisited!
    self.update(visited: false)
  end

end
