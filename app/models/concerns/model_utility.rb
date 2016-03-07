module ModelUtility
  def currency_exist?
    self.currencies.includes(:countries).each do |currency|
      return currency.exist! if currency.countries.where(visited: false).empty?
      currency.absent
    end
  end

  def update_statuses
    self.complete? ? up : down
  end

  def up
    self.countries.includes(:currencies).each do |country|
      country.visited! and country.currencies.each { |currency| currency.exist! }
    end
  end

  def down
    self.countries.includes(:currencies).each do |country|
      country.unvisited and country.currencies.each { |currency| currency.absent }
    end
  end
end