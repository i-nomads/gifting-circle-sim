class GameController < ApplicationController
  def reset
    [User, Circle].each(&:delete_all)
    Rails.application.load_seed
    redirect_to root_path
  end

  def next
    Circle.next_round!
    redirect_to root_path
  end
end
