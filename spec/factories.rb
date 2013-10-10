FactoryGirl.define do
  sequence :username do |n|
    "user#{n}"
  end
end

FactoryGirl.define do
  sequence :email do |n|
    "person-#{n}@example.com"
  end
end

FactoryGirl.define do
  sequence :name do |n|
    "some Team FC-#{n}"
  end
end

FactoryGirl.define do
  sequence :lastname do |n|
    "Van Playerson#{n}"
  end
end

FactoryGirl.define do
  factory :user do
    username               FactoryGirl.generate(:username)
    email                  FactoryGirl.generate(:email)
    password              "foobar"
    password_confirmation "foobar"
    roles                  [:admin]
    updated_by_id 1
  end
end

FactoryGirl.define do
  factory :person do
    firstname                  "Fred"
    lastname                  FactoryGirl.generate(:lastname)
    position                  Person::POSITIONS.values.last
    birth_date                  "09/22/1981"
    nationality                  "USA"
    created_by_id 1
    updated_by_id 1
  end
end

FactoryGirl.define do
  factory :team do
    name                  "Austin FC"
    address1                  "123 Main St."
    address2                  "Apt A"
    city                  "Austin"
    state                  "TX"
    zip                  "78704"
    phone                  "512-123-4567"
    website                  "http://foo.com"
    email                  "test@foo.com"
    created_by_id 1
    updated_by_id 1
  end
end

FactoryGirl.define do
  factory :organization do
    founded                 1913
    name                 "United States Soccer Federation"
    created_by_id 1
    updated_by_id 1
  end
end

FactoryGirl.define do
  factory :league_simple, class: League do
    year                 2002
    name                 "my soccer league"
    organization_id 1
    created_by_id 1
    updated_by_id 1
  end
end

FactoryGirl.define do
  factory :league do
    from_year                 2002
    to_year                 2003
    name                 "my soccer league"
    organization { |org|  org.association(:organization) }
    created_by_id 1
    updated_by_id 1
  end
end

FactoryGirl.define do
  factory :leaguezone do
    name                 "relegation"
    description          "description"
    start_rank                 18
    end_rank                 20
    style                "foo"
    league { |league|  league.association(:league) }
    created_by_id 1
    updated_by_id 1
  end
end

FactoryGirl.define do
  factory :teamstat do
    team { |team|  team.association(:team, :name => FactoryGirl.generate(:name)) }
    league { |league|  league.association(:league) }
    created_by_id 1
    updated_by_id 1
  end
end

FactoryGirl.define do
  factory :playinglocation do
    teamstat { |teamstat|  teamstat.association(:teamstat) }
    venue { |teamstat|  teamstat.association(:venue) }
    created_by_id 1
    updated_by_id 1
  end
end

FactoryGirl.define do
  factory :playerstat do
    person { |person|  person.association(:person) }
    game { |game|  game.association(:game) }
    team { |team|  team.association(:team) }
    created_by_id 1
    updated_by_id 1
  end
end

FactoryGirl.define do
  factory :roster do
    person { |person|  person.association(:person, :lastname => FactoryGirl.generate(:lastname)) }
    teamstat { |teamstat|  teamstat.association(:teamstat) }
    created_by_id 1
    updated_by_id 1
  end
end

FactoryGirl.define do
  factory :game do
    league { |league|  league.association(:league) }
    visiting_team { |visiting_team|  visiting_team.association(:team, :name => FactoryGirl.generate(:name))  }
    home_team { |home_team|  home_team.association(:team, :name => FactoryGirl.generate(:name))  }
    created_by_id 1
    updated_by_id 1
  end

  FactoryGirl.define do
    factory :venue do
      name                  "my soccer field"
      coordinate_lat "51.481667"
      coordinate_long "-0.191111"
      surface "grass"
      built 1999
      created_by_id 1
      updated_by_id 1
    end
  end
end