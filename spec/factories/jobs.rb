FactoryBot.define do
  factory :job do
    title {'Desenvolvedor Ruby'}
    description {'Vestibulum ornare non lectus finibus vehicula.'}
    skills_description {'Nulla ac elementum quam. Nam quis eros interdum, fringilla ipsum eget, consequat erat.'}
    salary { 2500.0 }
    experience_level
    hiring_type
    address {'Av. Ruby, nº 263'}
    registration_end_date {10.days.from_now}
    head_hunter
  end
end