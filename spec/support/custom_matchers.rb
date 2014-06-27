# Matchers for render(:nothing => true)
class RenderNothingMatcher
  def initialize
  end

  def matches?(response)
    @actual = response.body
    @actual == ' '
  end

  def failure_message
    return "render_nothing expected (render :nothing => true), got #{@actual.inspect}"
  end

  def failure_message_when_negated
    return "render_nothing expected (render :nothing => true) not to equal #{@actual.inspect}"
  end
end

def render_nothing
  RenderNothingMatcher.new
end