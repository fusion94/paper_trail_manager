{
  "4.2.2" => %w[3.0 4.0 5.0 6.0 7.0 8.0],
  "5.0.0" => %w[5.0 6.0 7.0 8.0],
  "5.1.0" => %w[7.0 8.0 9.0 10.0],
  "5.2.0" => %w[9.0 10.0],
  "6.0.0" => %w[10.0],
}.each do |rails_version, paper_trail_versions|
  paper_trail_versions.each do |paper_trail_version|
    appraise "rails-#{rails_version}-paper_trail-#{paper_trail_version}-will-paginate" do
      gem "rails", "~> #{rails_version}"
      gem "jquery-rails"
      gem "sqlite3", rails_version == "6.0.0" ? "~> 1.4" : "~> 1.3.6"
      gem "paper_trail", "~> #{paper_trail_version}"
      gem "will_paginate", "~> 3.0"
    end

    appraise "rails-#{rails_version}-paper_trail-#{paper_trail_version}-kaminari" do
      gem "rails", "~> #{rails_version}"
      gem "jquery-rails"
      gem "sqlite3", rails_version == "6.0.0" ? "~> 1.4" : "~> 1.3.6"
      gem "paper_trail", "~> #{paper_trail_version}"
      gem "kaminari", ">= 0.16"
    end
  end
end
