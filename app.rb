require 'sinatra/base'
require 'faker'
require_relative 'db'
require_relative 'models/circle'
require_relative 'models/user'
require_relative 'seeds'

class GiftingCircleSim < Sinatra::Base
  set :root, __dir__

  helpers do
    def number_to_currency(amount)
      digits = amount.abs.to_s.reverse.scan(/\d{1,3}/).join(',').reverse
      "#{'-' if amount.negative?}$#{digits}"
    end
  end

  get '/' do
    circles = Circle.order(:id).eager(:users).all.select { |c| c.users.any? }
    erb :home, locals: { circles: circles }
  end

  post '/action/reset' do
    Seeds.reset!
    redirect to('/')
  end

  post '/action/next' do
    Circle.next_round!
    redirect to('/')
  end
end
