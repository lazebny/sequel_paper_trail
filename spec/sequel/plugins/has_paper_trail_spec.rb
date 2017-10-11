require 'spec_helper'

describe Sequel::Plugins::HasPaperTrail do
  def without_fields(records, *fields)
    records.map do |record|
      record.to_hash.tap { |r| fields.each { |field| r.delete(field) } }
    end
  end

  let(:paper_db) { SpecPaperDb.new }
  let(:item_class) { paper_db.test_model }
  let(:version_class) { paper_db.version_model }

  before do
    paper_db.create_test_table
    paper_db.create_versions_table

    item_class.plugin :has_paper_trail,
                      item_class_name: 'TetsClass',
                      class_name: version_class

    SequelPaperTrail.whodunnit = 'Admin'
    SequelPaperTrail.info_for_paper_trail = {
      info: {
        'val' => 1
      }.to_json,
      other_info: '{}'
    }
  end

  after do
    paper_db.drop_all_tables
  end

  it 'creates versions on record create event' do
    record = item_class.create(name: 'test', email: 'test@test.com')
    expected = [
      {
        item_type: 'TetsClass',
        item_id: 1,
        event: 'create',
        whodunnit: 'Admin',
        created_at: Time.now.utc.iso8601,
        transaction_id: nil,
        object_changes: '{"name":[null,"test"],"email":[null,"test@test.com"],"id":[null,1]}',
        object: nil,
        info: '{"val":1}',
        other_info: '{}'
      }
    ]
    expect(without_fields(record.versions, :id)).to eql(expected)
  end

  it 'creates versions on record update event' do
    record = item_class.create(name: 'test', email: 'test@test.com')
    record.update(name: '2')
    expected = {
      item_type: 'TetsClass',
      item_id: 1,
      event: 'update',
      whodunnit: 'Admin',
      created_at: Time.now.utc.iso8601,
      transaction_id: nil,
      object_changes: '{"name":["test","2"]}',
      object: '{"id":1,"name":"test","email":"test@test.com"}',
      info: '{"val":1}',
      other_info: '{}'
    }
    expect(without_fields(record.versions, :id)).to be_include(expected)
  end

  it 'creates versions on record destroy event' do
    record = item_class.create(name: 'test', email: 'test@test.com')
    record.destroy
    expected = {
      item_type: 'TetsClass',
      item_id: 1,
      event: 'destroy',
      whodunnit: 'Admin',
      created_at: Time.now.utc.iso8601,
      transaction_id: nil,
      object_changes: nil,
      object: '{"id":1,"name":"test","email":"test@test.com"}',
      info: '{"val":1}',
      other_info: '{}'
    }
    expect(without_fields(record.versions, :id)).to be_include(expected)
  end
end
