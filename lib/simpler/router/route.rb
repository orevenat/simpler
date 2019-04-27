module Simpler
  class Router
    class Route

      attr_reader :controller, :action

      def initialize(method, path, controller, action)
        @method = method
        @path = path
        @controller = controller
        @action = action
      end

      def match?(method, path)
        @method == method && !match(path).nil?
      end

      def path_params(path)
        match(path)
          .named_captures
          .inject({}) { |memo, (k, v)| memo[k.to_sym] = v; memo }
      end

      private

      def match(path)
        path.match(params_pattern)
      end

      def params_pattern
        @path
          .split('/')
          .map { |uri_item| uri_item.start_with?(':') ? "(?<#{uri_item.gsub(':', '')}>[^/]+?)" : uri_item }
          .join('/')
          .concat('$')
      end
    end
  end
end
