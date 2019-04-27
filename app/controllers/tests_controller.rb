class TestsController < Simpler::Controller

  def index
    @time = Time.now
  end

  def show

  end

  def plain
    render plain: 'message'
  end

  def create
  end

end
