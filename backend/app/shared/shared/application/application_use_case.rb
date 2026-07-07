# frozen_string_literal: true

module Shared
  module Application
    class ApplicationUseCase
      class << self
        def call(*args, **kwargs)
          new.call(*args, **kwargs)
        end
      end
    end
  end
end
