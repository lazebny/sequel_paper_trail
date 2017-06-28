require 'spec_helper'

describe SequelPaperTrail do
  let(:paper_db) { SpecPaperDb.new }
  let(:db) { Sequel.sqlite(':memory:') }

  let(:item_class) { paper_db.test_model(db) }
  let(:version_class) { paper_db.version_model(db) }

  before do
    paper_db.create_test_table(db)
    paper_db.create_versions_table(db)

    item_class.plugin :has_paper_trail,
                      item_class_name: 'TestClass',
                      class_name: version_class
  end

  after do
    paper_db.drop_all_tables(db)
  end

  context '.with_versioning' do
    it 'enabled' do
      described_class.with_versioning(true) do
        item = item_class.create(name: 'test')
        expect(item.versions).not_to be_empty
      end
    end

    it 'disabled' do
      described_class.with_versioning(false) do
        item = item_class.create(name: 'test')
        expect(item.versions).to be_empty
      end
    end
  end
end
