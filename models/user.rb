class User < Sequel::Model
  plugin :timestamps, update_on_create: true

  many_to_one :circle

  dataset_module do
    def sent     = where(balance: -5000)
    def received = where(balance: 40_000)
    def insiders = where(insider: true)
  end

  def before_create
    self.name = Faker::Internet.username
    self.insider = true if round < 6
    super
  end
end
