gem 'paper_trail_viewer', path: __FILE__ + '/../../../'

generate 'paper_trail:install'
generate 'resource', 'entity name:string status:string --no-controller-specs --no-helper-specs'
generate 'resource', 'platform name:string status:string --no-controller-specs --no-helper-specs'

remove_file 'spec/models/entity_spec.rb'
remove_file 'spec/models/platform_spec.rb'

model_body = <<-RUBY
  has_paper_trail

  validates_presence_of :name
  validates_presence_of :status
RUBY

inject_into_class 'app/models/entity.rb', 'Entity', model_body
inject_into_class 'app/models/platform.rb', 'Platform', model_body

route 'mount PaperTrailViewer::Engine => "/changes"'

rake 'db:migrate db:test:prepare'
