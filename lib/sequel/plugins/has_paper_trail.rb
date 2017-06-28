module Sequel
  module Plugins
    # Add Paper Trail versioning callbacks to model.
    #
    # Usage:
    #
    #   # Enable versioning for all models.
    #   Sequel::Model.plugin :has_paper_trail
    #
    #   # Make the Album class be able to versioning.
    #   Album.plugin :has_paper_trail, item_class_name: Album, class_name: 'Album::Version'
    #
    module HasPaperTrail
      # rubocop:disable Metrics/MethodLength
      def self.configure(model, opts = {})
        paper_trail_item_class_name = opts.fetch(:item_class_name) { model.name }
        paper_trail_version_class_name = opts.fetch(:class_name) { 'SequelPaperTrail::Version' }

        model.plugin :dirty
        model.one_to_many :versions,
                          class: paper_trail_version_class_name,
                          key: :item_id,
                          conditions: { item_type: paper_trail_item_class_name }

        model.instance_eval do
          @paper_trail_item_class_name = paper_trail_item_class_name
          @paper_trail_version_class_name = paper_trail_version_class_name
        end
      end
      # rubocop:enable Metrics/MethodLength

      # rubocop:disable Style/Documentation
      module ClassMethods
        Sequel::Plugins.inherited_instance_variables(
          self,
          :@paper_trail_item_class_name => :dup,
          :@paper_trail_version_class_name => :dup
        )

        # The class name of item for versioning
        attr_reader :paper_trail_item_class_name

        # The version class name
        attr_reader :paper_trail_version_class_name
      end
      # rubocop:enable Style/Documentation

      # rubocop:disable Style/Documentation
      module InstanceMethods
        def after_create
          super

          return unless SequelPaperTrail.enabled?

          attrs = {
            item_id: id,
            event: :create,
            object_changes: values.to_json,
            object: nil
          }

          PaperTrailHelpers.create_version(model, attrs)
        end

        def after_update
          super

          return unless SequelPaperTrail.enabled?
          return if column_changes.empty?

          attrs = {
            item_id: id,
            event: :update,
            object_changes: column_changes.to_json,
            object: values.merge(initial_values).to_json
          }

          PaperTrailHelpers.create_version(model, attrs)
        end

        def after_destroy
          super

          return unless SequelPaperTrail.enabled?

          attrs = {
            item_id: id,
            event: :destroy,
            object_changes: nil,
            object: values.to_json
          }

          PaperTrailHelpers.create_version(model, attrs)
        end
      end
      # rubocop:enable Style/Documentation

      # rubocop:disable Style/Documentation
      module PaperTrailHelpers
        def self.create_version(model, attrs)
          default_attrs = {
            item_type: model.paper_trail_item_class_name.to_s,
            whodunnit: SequelPaperTrail.whodunnit,
            created_at: Time.now.utc.iso8601,
            transaction_id: nil
          }

          create_attrs = default_attrs
                         .merge(SequelPaperTrail.info_for_paper_trail)
                         .merge(attrs)

          version_class(model.paper_trail_version_class_name).create(create_attrs)
        end

        private_class_method

        def self.version_class(class_name)
          if class_name.is_a?(String)
            Kernel.const_get(class_name)
          else
            class_name
          end
        end
      end
      # rubocop:enable Style/Documentation
    end
  end
end
