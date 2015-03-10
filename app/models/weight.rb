class Weight
  include Comparable

  attr_reader :pounds

  def initialize(pounds)
    @pounds = pounds
  end

  def kilograms
    (pounds * 0.453592).round
  end

  def stone
    (pounds * 0.0714286).round
  end

  def <=>(other)
    self.class == other.class && pounds <=> other.pounds
  end

  def eql?(other)
    self == other
  end

  def hash
    pounds.hash
  end
end
