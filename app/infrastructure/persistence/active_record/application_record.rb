module Infrastructure
  module Persistence
    module ActiveRecord
      class ApplicationRecord < ::ActiveRecord::Base
        self.abstract_class = true
      end
    end
  end
end
