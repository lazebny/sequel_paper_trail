module SequelPaperTrail
  # Config storage
  class Config
    include Singleton

    def initialize
      @mutex = Mutex.new
      @enabled = true
    end

    def enabled
      @mutex.synchronize { @enabled }
    end

    def enabled=(enable)
      @mutex.synchronize { @enabled = enable }
    end
  end
end
