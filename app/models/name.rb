class Name
  attr_reader :title, :first, :middle, :last, :suffix

  def initialize(title, first, middle, last, suffix)
    @title, @first, @middle, @last, @suffix = title, first, middle, last, suffix
  end

  def initials
    first.chr + middle.chr + last.chr
  end

  def full_name
    "#{title} #{first} #{middle} #{last}, #{suffix}"
  end

  def ==(other)
    self.class == other.class &&
      title == other.title &&
      first == other.first &&
      middle == other.middle &&
      last == other.last &&
      suffix == other.suffix
  end
end
