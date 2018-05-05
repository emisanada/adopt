# frozen_string_literal: true

FactoryBot.define do
  factory :pet do
    name 'Growlithe'
    species 'Pokemon'
    breed 'Puppy pokemon'
    age '2 years'
    location 'Kanto, Route 7'
    adopted false
    user_id 1
    about 'Growlithe, a Puppy Pokémon of pleasant demeanor and great diligence. It drives enemies away with barks and bites.'
  end
end
