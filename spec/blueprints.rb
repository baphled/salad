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
  created_at { Time.now.last_year }
}

Feature.blueprint {
  title { Sham.title }
  as_a { "user" }
  in_order { Faker::Lorem.sentence }
  i_want { Faker::Lorem.sentence }
  path { "#{RAILS_ROOT}/features/plain/tag_cloud.feature" }
  created_at { Time.now.last_year }
}

Story.blueprint {
  scenario { Sham.title }
}

Step.blueprint {
  title { Sham.step }
}