RAILS_VERSIONS = ["3.2.0", "4.0.0", "4.1.0", "4.2.2"]
PAPER_TRAIL_VERSIONS = ["3.0", "4.0"]

RAILS_VERSIONS.each do |rails_version|
  PAPER_TRAIL_VERSIONS.each do |paper_trail_version|
    appraise "rails-#{rails_version}-paper_trail-#{paper_trail_version}-will-paginate" do
      gem "rails", "~> #{rails_version}"
      gem "paper_trail", "~> #{paper_trail_version}"
      gem "will_paginate", "~> 3.0"
      gem "test-unit", "~> 3.0" if rails_version == "3.2.0"
    end

    appraise "rails-#{rails_version}-paper_trail-#{paper_trail_version}-kaminari" do
      gem "rails", "~> #{rails_version}"
      gem "paper_trail", "~> #{paper_trail_version}"
      gem "kaminari", "~> 0.16"
      gem "test-unit", "~> 3.0" if rails_version == "3.2.0"
    end
  end
end
