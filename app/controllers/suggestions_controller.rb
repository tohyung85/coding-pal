class SuggestionsController < ApplicationController
  def create
    Suggestion.create(suggestion_params)
    redirect_to root_path
  end

  private

  def suggestion_params
    params.require(:suggestion).permit(:user_email, :title, :description)
  end
end
