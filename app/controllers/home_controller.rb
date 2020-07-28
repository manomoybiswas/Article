class HomeController < ApplicationController
  layout "dashboard", only: [:overview]
  def index
  end

  def overview
  end
end
