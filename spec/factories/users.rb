FactoryBot.define do
  factory :user do
    email { 'francisco@gmail.com' }
    age { 18 }
    password { 'MyString' }
    store_attributes { { name: 'MyString' } }
    type { 'Owner' }
  end
end
