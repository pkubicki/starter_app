module ActionView
  module Helpers
    class InstanceTag
      remove_const :DEFAULT_FIELD_OPTIONS
      DEFAULT_FIELD_OPTIONS = {}
    end
  end
end