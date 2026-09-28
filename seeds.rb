module Seeds
  def self.reset!
    DB.transaction do
      User.dataset.delete
      Circle.dataset.delete
      load!
    end
  end

  def self.load!
    circle = Circle.create(name: 'First Circle', round: 1)

    User.create(name: 'Da Winner', circle_id: circle.id, round: 1, level: 1, balance: 0)
    2.times { User.create(circle_id: circle.id, round: 1, level: 2, balance: 0) }
    4.times { User.create(circle_id: circle.id, round: 1, level: 3, balance: 0) }
  end
end
