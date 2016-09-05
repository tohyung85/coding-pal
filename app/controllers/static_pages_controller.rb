class StaticPagesController < ApplicationController
  def landing_page
    @suggestion = Suggestion.new
  end
end
