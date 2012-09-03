FactoryGirl.define do
  factory :configuration, class: Base::Configuration do
    filename Rails.root.join('spec', 'fixtures', 'ternary.qlf')
  factory :digit, class: Digit do
    initialize_with {new(rand(100))}
  end
end
