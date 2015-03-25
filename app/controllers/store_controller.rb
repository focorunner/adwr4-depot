class StoreController < ApplicationController
  before_action :increment_product_index_counter

  def index
    @products = Product.order(:title)
  end

  private
    def increment_product_index_counter
      if session[:counter].nil?
        session[:counter] = 1
      else
        session[:counter] += 1
      end
    end
end
