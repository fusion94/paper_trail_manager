{
  '6.0' => %w[11.1 12.2],
  '7.0' => %w[12.2],
}.each do |rails_version, paper_trail_versions|
  paper_trail_versions.each do |paper_trail_version|
    appraise "rails-#{rails_version}-paper_trail-#{paper_trail_version}" do
      gem 'rails', "~> #{rails_version}"
      gem 'sqlite3', '~> 1.4'
      gem 'paper_trail', "~> #{paper_trail_version}"
      gem 'kaminari'
    end
  end
end
