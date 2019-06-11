class InputStrategy
  def initialize(script = nil)
    raise '#initialize has not been implemented'
  end

  def ask(value = nil)
    raise '#ask has not been implemented'
  end

  def select(question = nil, choices = [])
    raise '#select has not been implemented'
  end

  def multi_select(question = nil, choices = [])
  	raise '#multi_select has not been implemented'
  end

  def yes_or_no(question = nil)
    raise '#yes_or_no has not been implemented'
  end
end