# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: User do
    name 'Link Link'
    email 'link@legendofzelda.com'
    location 'Hyrule'
    about '...'
    username 'link3f'
    password 'Link3Force'
    password_confirmation 'Link3Force'
  end

  factory :user_admin, class: User do
    name 'Zelda Hyrule'
    email 'zelda@princess.com'
    location 'Hyrule'
    about 'We must win! The fate of Hyrule depends on it!'
    username 'pzelda'
    password 'Sh3ikah'
    password_confirmation 'Sh3ikah'
    admin true
  end
end
