# frozen_string_literal: true

module Shared
  module Infrastructure
    module Repositories
      class BaseRepository
        private

        def transaction(&block)
          ActiveRecord::Base.transaction(&block)
        end

        def lock(record, &block)
          record.with_lock(&block)
        end
      end
    end
  end
end
