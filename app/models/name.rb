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

  def armenian?
    if last.end_with?('ian')
      'probably'
    else
      'probably not'
    end
  end

  def ==(other)
    self.class == other.class &&
      title == other.title &&
      first == other.first &&
      middle == other.middle &&
      last == other.last &&
      suffix == other.suffix
  end
  alias :eql? :==

  def hash
    @hash ||= title.hash ^ first.hash ^ middle.hash ^ last.hash ^ suffix.hash
  end
end
