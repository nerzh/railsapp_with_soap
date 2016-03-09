module ModelUtility
  def currency_exist?
    self.currencies.includes(:countries).each do |currency|
      return currency.exist! if currency.countries.where(visited: false).empty?
      currency.absent!
    end
  end

  def update_statuses
    self.complete? ? true! : false!
  end

  def true!
    self.countries.includes(:currencies).each do |country|
      country.visited! and country.currencies.each { |currency| currency.exist! }
    end
  end

  def false!
    self.countries.includes(:currencies).each do |country|
      country.unvisited! and country.currencies.each { |currency| currency.absent! }
    end
  end
end