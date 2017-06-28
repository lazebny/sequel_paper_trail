require 'singleton'
require 'sequel_paper_trail/version'
require 'sequel_paper_trail/config'

# Paper Trail config interface
module SequelPaperTrail
  class << self
    attr_accessor :whodunnit
    attr_accessor :info_for_paper_trail

    # Set versioning state.
    #
    # Boolean -> Boolean
    #
    def enabled=(enable)
      Config.instance.enabled = enable
    end

    # Check if versioning enabled.
    #
    # Boolean
    #
    def enabled?
      Config.instance.enabled
    end

    # Execute block with or without versioning.
    #
    # Boolean -> Proc -> Boolean
    #
    def with_versioning(enable = true)
      was_enabled = enabled?
      self.enabled = enable
      yield
    ensure
      self.enabled = was_enabled
    end
  end
end

# Default Configuration
SequelPaperTrail.enabled = true
SequelPaperTrail.whodunnit = nil
SequelPaperTrail.info_for_paper_trail = {}
