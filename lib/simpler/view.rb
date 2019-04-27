require_relative 'view/html_renderer'
require_relative 'view/plain_renderer'

module Simpler
  class View
    VIEW_BASE_PATH = 'app/views'.freeze
    RENDERERS = { plain: PlainRenderer, html: HtmlRenderer }.freeze

    def initialize(env)
      @env = env
    end

    def render(binding)
      renderer = RENDERERS[template_type] || RENDERERS[:html]
      renderer.new(@env).render(binding)
    end

    private

    def template_type
      @env['simpler.template_type']
    end
  end
end
