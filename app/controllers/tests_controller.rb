class TestsController < Simpler::Controller

  def index
    headers['Content-Type'] = 'text/plain'
    @time = Time.now
  end

  def create
  end

end
