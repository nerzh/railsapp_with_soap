class MainController < ApplicationController
  authorize_resource :class => false

  def index
    @currencies = MainQueries.new(params).search
  end

end
