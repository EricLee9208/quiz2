FactoryBot.define do
    RANDOM_100_CHARS = "hello world hello world hello world hello world hello world hello world hello world hello hello worl hello world hello world"
    factory :idea do
      sequence(:title) {|n| Faker::Job.title + " #{n}"}
      #sequence -> like BigIncrement, increase id by 1 every sequence
      description { Faker::Lorem.sentence(word_count: 50)}
      association :user, factory: :user
  end
end
