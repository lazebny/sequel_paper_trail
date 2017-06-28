class SpecPaperDb
  def initialize
    # https://gist.github.com/studiorailsway/1561497
    @db = if RUBY_PLATFORM == 'java'
            Sequel.connect('jdbc:sqlite:db.sqlite3')
          else
            Sequel.sqlite(':memory:')
          end
  end

  def create_test_table
    @db.create_table!(:test_table) do
      primary_key :id
      column :name,     :text
      column :email,    :text
    end
  end

  def test_model
    Class.new(Sequel::Model(@db[:test_table]))
  end

  # rubocop:disable Metrics/MethodLength
  def create_versions_table
    @db.create_table!(:versions) do
      primary_key :id
      column 'item_type', :text
      column 'item_id', :integer
      column 'event', :text
      column 'whodunnit', :text
      column 'created_at', :text
      column 'transaction_id', :integer
      column 'object_changes', :text
      column 'object', :text
      column 'info', :text
      column 'other_info', :text
    end
  end
  # rubocop:enable Metrics/MethodLength

  def version_model
    Class.new(Sequel::Model(@db[:versions]))
  end

  def drop_all_tables
    @db.drop_table(:test_table)
    @db.drop_table(:versions)
  end
end
