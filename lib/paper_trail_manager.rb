require 'rails'
require 'paper_trail'

# = PaperTrailManager
#
# == Example usage
#
# To specify when reverts are allowed, write an initializer similar to this:
#
#   # config/initializers/paper_trail_manager.rb
#   PaperTrailManager.allow_revert_when do |controller, version|
#     controller.current_user and controller.current_user.admin?
#   end
#
#   To specify how to look up users/memebers/etc specified in Paper Trail's 'whodunnit' column:
#
#   PaperTrailManager.whodunnit_class = User
#   PaperTrailManager.whodunnit_name_method = :nicename   # defaults to :name
#
class PaperTrailManager < Rails::Engine
  @@whodunnit_name_method = :name
  cattr_accessor :whodunnit_class, :whodunnit_name_method

  (Pathname(__FILE__).dirname + '..').tap do |base|
    paths["app/controller"] = base + 'app/controllers'
    paths["app/view"] = base + 'app/views'
  end

  def self._allow_set(action, block)
    send(:class_variable_set, "@@allow_#{action}_block", block)
  end

  def self._allow_check(action, *args)
    begin
      block = send(:class_variable_get, "@@allow_#{action}_block")
    rescue NameError => e
      return true
    end

    return block.call(*args)
  end

  def self.allow_index_when(&block)
    _allow_set(:index, block)
  end

  def self.allow_index?(controller)
    _allow_check(:index, controller)
  end

  def self.allow_show_when(&block)
    _allow_set(:show, block)
  end

  def self.allow_show?(controller, version)
    _allow_check(:index, controller, version)
  end

  # Describe when to allow reverts. Call this with a block that accepts
  # arguments for +controller+ and +version+.
  def self.allow_revert_when(&block)
    _allow_set(:revert, block)
  end

  # Allow revert given the +controller+ and +version+? If no
  # ::allow_revert_when was specified, always return +true+.
  def self.allow_revert?(controller, version)
    _allow_check(:revert, controller, version)
  end
end
