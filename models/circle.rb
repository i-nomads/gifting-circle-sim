class Circle < Sequel::Model
  plugin :timestamps, update_on_create: true

  one_to_many :users

  def self.next_round!
    db.transaction do
      round = User.max(:round).next
      order(:id).all.each { |c| c.birthday!(round) }

      User.dataset.update(level: Sequel[:level] - 1)
    end
  end

  def active?
    !users_dataset.empty?
  end

  def winner
    users_dataset.first(level: 1)
  end

  def birthday!(round)
    return true unless active?

    8.times do
      User.create(circle_id: id, round: round, level: 4, balance: -5000)
    end

    # Winner leaves the circle
    winner.update(circle_id: nil, balance: 40_000)

    # 2 new circles are created
    2.times do
      circle = Circle.create(name: "Circle #{Circle.max(:id).next}", round: round)

      { 2 => 1, 3 => 2, 4 => 4 }.each do |level, count|
        ids = users_dataset.where(level: level).order(:id).limit(count).select_map(:id)
        User.where(id: ids).update(circle_id: circle.id)
      end
    end
  end
end
