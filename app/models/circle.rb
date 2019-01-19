class Circle < ApplicationRecord
  has_one :winner, -> { where(level: 1) }, class_name: 'User'
  has_many :users

  def self.next_round!
    round = User.maximum(:round).next
    all.each { |c| c.birthday!(round) }

    User.update_all("level = level - 1")
  end

  def active?
    reload.users.any?
  end

  def birthday!(round)
    return true unless active?

    8.times do
      users.create!(
        round: round,
        level: 4,
        balance: -5000
      )
    end

    # Winner leaves the circle
    winner.update(circle: nil, balance: 40000)

    # 2 new circles are created
    2.times.each do |i|
      circle = Circle.create!(name: "Circle #{Circle.last.id.next}", round: round)

      new_users = [
        users.reload.where(level: 2).limit(1),
        users.reload.where(level: 3).limit(2),
        users.reload.where(level: 4).limit(4),
      ].flatten

      new_users.each do |user|
        user.update(circle: circle)
      end
    end
  end
end
