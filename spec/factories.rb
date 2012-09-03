FactoryGirl.define do
  factory :configuration, class: Base::Configuration do
    filename  'ternary.qlf'
    initialize_with {new(fixture_path(filename))}                              
  end

  factory :specification, class: Base::Specification do
    association :configuration, :strategy => :build
  end

  factory :digit, class: Digit do
    initialize_with {new(rand(100))}
  end
end
