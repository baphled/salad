require 'machinist/active_record'
require 'sham'
require 'faker'

Sham.title { Faker::Lorem.words(3).join(' ') }
Sham.feature { Faker::Lorem.sentence }
Sham.scenario { Faker::Lorem.sentence }
Sham.step { "Given #{Faker::Lorem.words(3).join(' ')}" }

Project.blueprint {
  title { Sham.title }
  aim { 'An aim' }
  description { 'A description' }
  location { "#{RAILS_ROOT}" }
}

Feature.blueprint {
  title { Sham.title }
  as_a { "user" }
  in_order { Faker::Lorem.sentence }
  i_want { Faker::Lorem.sentence }
}

Story.blueprint {
  scenario { Sham.title }
}

Step.blueprint {
  title { Sham.step }
}

def machine_fixtures
  3.times {
    Project.make
  }
end

def project_with_features(attributes = {})
  Project.make(attributes) do |project|
    3.times { project.features.make }    
  end
end