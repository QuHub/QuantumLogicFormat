FactoryGirl.define do
  factory :configuration, class: Base::Configuration do
    filename Rails.root.join('spec', 'fixtures', 'ternary.qlf')
  end
end
