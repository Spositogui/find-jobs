FactoryBot.define do
  factory :candidate_profile do
    name { 'Alan Turing' }
    nickname { 'Turing' }
    date_of_birth { 30.years.ago }
    candidate_formation
    description { 'Cras iaculis urna vel lacus.' }
    experience { 'Praesent luctus tristique arcu ac.' }
    candidate
  end
end