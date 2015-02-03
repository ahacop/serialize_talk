# Serializing Value Objects in Rails
![](http://www.leanitup.com/wp-content/uploads/2012/09/Cereal-Boxes.jpg)

---

![](https://avatars3.githubusercontent.com/u/1678968?v=3&s=460)
# Ara Hacopian
[@ahacop](http://www.twitter.com/ahacop/) ![inline](https://g.twimg.com/Twitter_logo_blue.png) ![inline](https://raw.githubusercontent.com/github/media/master/octocats/octocat.png)
[SmartLogic](http://www.smartlogic.io/)
:copyright: 2015

---

# [fit] Fat
# [fit] Models

^ tendancy to attract business logic associated with the model
^ Objects that are inherently responsible for persistence become the de facto owner of all business logic as well.

---

> [An] argument against Active Record is the fact that it couples the object design to the database design. This makes it more difficult to refactor either design...

--

---

> [An] argument against Active Record is the fact that it couples the object design to the database design. This makes it more difficult to refactor either design...

-- Martin Fowler, "Patterns of Enterprise Application Architecture", **inventor** of the Active Record pattern

^ the Rails “conventions” that don’t scale, or, more specifically, the lack of conventions for managing complexity beyond what the Active Record pattern can elegantly handle

---

# [fit] Single
# [fit] Responsibility
# [fit] Principle

---

## There should never be more than one reason for a class to change

^ If you can think of more than one motive for changing a class, then that class has more than one responsibility
^ SRP reduces churn and makes for more robust classes (i.e. classes that do not change do not break).

---

## ~~All the methods that have to do with a person go into the Person model~~

---

```ruby
class Person < ActiveRecord::Base
  def initials
    first_name.chr + middle_name.chr + last_name.chr
  end

  def full_name
    "#{title} #{first_name} #{middle_name} #{last_name}, #{suffix}"
  end

  def weight_in_pounds
    weight
  end

  def weight_in_kilograms
    (weight * 0.453592).round
  end

  def weight_in_stone
    (weight * 0.07142).round
  end
end
```

^ name stuff may be presentation concern

---

# [fit] Cohesion

^ The degree to which the elements of a module belong together. High cohesion is associated with several desirable traits of software including robustness, reliability, reusability, and understandability whereas low cohesion is associated with undesirable traits such as being difficult to maintain, test, reuse, and even understand. Measurement

^ Rule of thumb: does a method use all the ivars of the class?

---

# "Where should this method go?"

```ruby
class Person < ActiveRecord::Base
  def initials
    first_name.chr + middle_name.chr + last_name.chr
  end

  def full_name
    "#{title} #{first_name} #{middle_name} #{last_name}, #{suffix}"
  end

  def weight_in_pounds
    weight
  end

  def weight_in_kilograms
    (weight * 0.453592).round
  end

  def weight_in_stone
    (weight * 0.07142).round
  end
end
```

^ string manipulation if View concern -> view helper -> "good" separation

^ Later, more string manipulation, outside view ->

^ If different than view helper method -> add to model,
but now: similiar methods in different places based on call site

^ If exactly the same as view helper method -> don't duplicate (not DRY),
-> include view helper in model -> lose benefit of the extraction.

^ The model becomes fat again, all the methods are defined on the class, they just
reside in a different file.

---

# has_one?

```ruby
class Person < ActiveRecord::Base
  has_one :weight
end

class Weight < ActiveRecord::Base
  belongs_to :person
end
```

^ Because we want a smaller interface on the object and separate our
concerns we are forced into by the framework into a particular
persistance system

---

# Value Objects

^ is a small object that represents a simple entity whose equality is
not based on identity

^ Examples: addresses, money, names.

^ Our domain is a good example: Names are the same, but people are
different.

^ Value objects should be immutable: this is required for the
implicit contract that two value objects created equal, should remain
equal.

---

```ruby
class Weight
  include Comparable

  def <=>(other)
    self.class == other.class && pounds <=> other.pounds
  end

  def hash
    pounds.hash
  end
end
```

---

# Serialize

^ a class method that allows an attribute to be saved in the database and
later retrieved as an object.

---

```ruby
class Person < ActiveRecord::Base
  def weight_in_pounds
    weight
  end

  def weight_in_kilograms
    (weight * 0.453592).round
  end

  def weight_in_stone
    (weight * 0.07142).round
  end
end
```

---

```ruby
class Person < ActiveRecord::Base
  serialize :weight, Weight
end
```

---

```ruby
class Weight
  class << self
    def dump(weight)
      weight.pounds
    end

    def load(pounds)
      new(pounds)
    end
  end

  def initialize(pounds)
    @pounds = pounds
  end
```

---

```ruby
  attr_reader :pounds

  def kilograms
    (pounds * 0.453592).round
  end

  def stone
    (pounds * 0.07142).round
  end
end
```

---

```ruby
class Weight
  include Comparable

  attr_reader :pounds

  class << self
    def dump(weight)
      weight.pounds
    end

    def load(pounds)
      new(pounds)
    end
  end

  def initialize(pounds)
    @pounds = pounds
  end

  def kilograms
    (pounds * 0.453592).round
  end

  def stone
    (pounds * 0.07142).round
  end

  def <=>(other)
    self.class == other.class && pounds <=> other.pounds
  end

  def hash
    pounds.hash
  end
end
```

---
## Using the value object with ActiveRecord

```ruby
weight = Weight.new(150)
person = Person.create(weight: weight)
```

---

# Virtual attributes

---

```ruby
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

  def hash
    pounds.hash
  end
end
```

^ Remove load/dump, put serialize/deserialize stuff in the ActiveRecord
object class

---

```ruby
 Person < ActiveRecord::Base
  def weight
    @weight ||= Weight.new(weight_value)
  end

  def weight=(other_weight)
    self.weight_value = other_weight.pounds

    @weight = other_weight
  end
end
```

---

```ruby
class Person < ActiveRecord::Base
  def name
    @name ||= Name.new(title, first_name, middle_name, last_name,
suffix)
  end

  def name=(other_name)
    self.title = other_name.title
    self.first_name = other_name.first
    self.middle_name = other_name.middle
    self.last_name = other_name.last
    self.suffix = other_name.suffix

    @name = other_name
  end
end
```

---

# composed_of

^ Active Record implements aggregation through a macro-like class method called composed_of for representing attributes as value objects. It expresses relationships like "Account [is] composed of Money [among other things]" or "Person [is] composed of [an] address". Each call to the macro adds a description of how the value objects are created from the attributes of the entity object (when the entity is initialized either as a new object or from finding an existing object) and how it can be turned back into attributes (when the entity is saved to the database).

---

```ruby
class Person < ActiveRecord::Base
  composed_of :name,
    allow_nil: true,
    mapping: [
      %w(title title),
      %w(first_name first),
      %w(middle_name middle),
      %w(last_name last),
      %w(suffix suffix)
    ]

  composed_of :weight,
    allow_nil: true,
    mapping: %w(weight_value pounds)
end
```

^ By default value objects are initialized by calling the new constructor of the value class passing each of the mapped attributes, in the order specified by the :mapping option, as arguments. If the value class doesn't support this convention then composed_of allows a custom constructor to be specified.

---

```ruby
class Name
  attr_reader :title, :first, :middle, :last, :suffix

  def initialize(title, first, middle, last, suffix)
    @title, @first, @middle, @last, @suffix = title, first, middle,
last, suffix
  end

  def initials
    first.chr + middle.chr + last.chr
  end

  def full_name
    "#{title} #{first} #{middle} #{last}, #{suffix}"
  end
```

---

```ruby
  def ==(other)
    self.class == other.class &&
      title == other.title &&
      first == other.first &&
      middle == other.middle &&
      last == other.last &&
      suffix == other.suffix
  end

  def hash
    @hash ||= [title, first, middle, last, suffix].hash
  end
end
```

---

![autoplay loop mute](http://www.youtube.com/watch?v=mDMs4gLn9rc)
# Questions?
