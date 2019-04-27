module Simpler
  class View
    class PlainRenderer
      def initialize(env)
        @env = env
      end

      def render(binding)
        value
      end

      private

      def value
        @env['simpler.value']
      end
    end
  end
end
