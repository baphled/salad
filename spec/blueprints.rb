require 'machinist/active_record'
require 'sham'
require 'faker'

Sham.title { Faker::Lorem.words(3).join(' ') }

Project.blueprint {
  title { Sham.title }
  aim { 'An aim' }
  description { 'A description' }
  location { "#{RAILS_ROOT}" }
}

def machine_fixtures
  3.times {
    Project.make
  }
end