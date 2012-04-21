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
    email
    email                  FactoryGirl.generate(:email)
    password              "foobar"
    password_confirmation "foobar"
    roles                  [:admin]
    updated_by_id 1
  end
end

FactoryGirl.define do
  factory :player do
    firstname                  "Fred"
    lastname                  FactoryGirl.generate(:lastname)
    position                  Player::POSITIONS.values.first
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
  factory :league do
    year                 2002
    name                 "my soccer league"
    organization { |org|  org.association(:organization) }
    created_by_id 1
    updated_by_id 1
  end
end

FactoryGirl.define do
  factory :teamstat do
    created_by_id 1
    team { |team|  team.association(:team, :name => FactoryGirl.generate(:name)) }
    league { |league|  league.association(:league) }
    updated_by_id 1
  end
end

FactoryGirl.define do
  factory :playerstat do
    player { |player|  player.association(:player) }
    game { |game|  game.association(:game) }
    team { |team|  team.association(:team) }
    created_by_id 1
    updated_by_id 1
  end
end

FactoryGirl.define do
  factory :roster do
    player { |player|  player.association(:player, :lastname => FactoryGirl.generate(:lastname)) }
    teamstat { |teamstat|  teamstat.association(:teamstat) }
    created_by_id 1
    updated_by_id { |user|  user.association(:user, :username => FactoryGirl.generate(:username)) }
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
end