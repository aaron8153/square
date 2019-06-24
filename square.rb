question = """

# Blaze Badge

## One - Weapons

In this game, we have a weapon system of Sword, Axe, and Lance. In this system:

* Sword beats Axe
* Axe beats Lance
* Lance beats Sword

Create a function that, given two weapons, will return the winning weapon.

f(String, String) -> String

Assumptions:

* Assume that all input is valid and in the right format (capitalized)
* In the case of a tie return 'Tie'

----------------------------------------------------------------------------

## Two - Warriors and Battles

* Create a Warrior that has a name and a weapon that can be one of the above.
* Create a function that, given two warriors, will return the winning warrior.

f(Warrior, Warrior) -> Warrior

Assumptions:

* In the case of a tie the first warrior will win

----------------------------------------------------------------------------

## Three - Damage

Create a new function which takes in two warriors and returns the amount of
damage the first warrior would do to the second.

Damage is defined as 5 (default damage) multiplied by an effectiveness modifier.

The effectiveness modifier is defined as:

* Not Effective (Sword vs Lance): 0.5x weak
* Effective (Sword vs Sword):     1.0x same
* Super Effective (Sword vs Axe): 1.5x strong

Such that a battle in which a Sword warrior attacks an Axe warrior, 7.5
damage is dealt to the Axe warrior.

Return the damage done.

f(attacking warrior, defending warrior) -> damage attacker does to defender
f(Warrior, Warrior) -> Float

----------------------------------------------------------------------------

## Four - Battle Loop

Give warriors HP, starting at 20.

Create a battle system. This battle should continue until one warrior has
0 HP remaining.

Log each step of the battle as it progresses. Each log should reflect the
damage done as well as the remaining HP of each Warrior, for example:

  'Foo vs Bar'
  '  Foo attacked Bar for 5 damage. Bar has 15HP'

HP is not allowed to go below 0. Upon either warrior's HP reaching 0,
the warrior with the most remaining HP should be returned as the winner.

The battle should continue until one Warrior wins.

Return the winning warrior.

f(Warrior, Warrior) -> Warrior

"""

class Blaze
  def battle(w1, w2)
    return "Tie" if w1 == w2

    if w1 == "Sword" && w2 == "Axe"
      w1
    elsif w1 == "Axe" && w2 == "Lance"
      w1
    elsif w1 == "Lance" && w2 == "Sword"
      w1
    else
      w2
    end
  end

  def warrior_battle(warrior1, warrior2)
    battle_result = battle(warrior1.weapon, warrior2.weapon)

    if battle_result == "Tie"
      warrior1
    elsif battle_result == warrior1.weapon
      warrior1
    else
      warrior2
    end
  end

  def damage(attacking, defending)
    base_damage = 5.0
    b = battle(attacking.weapon, defending.weapon)

    if b == attacking.weapon #strong
      base_damage * 1.5
    elsif b == defending.weapon #weak
      base_damage * 0.5
    else #equal
      base_damage * 1.0
    end
  end

  def log(attacker, defender, damage_done)
    "  #{attacker.name} attacked #{defender.name} for #{damage_done} damage." +
        " #{defender.name} has #{defender.hp}HP"
  end

  # w1 -> w2, w2 -> w1, ..., w1 wins!
  def full_battle(w1, w2)
    w1.heal
    w2.heal

    attacker = w1
    defender = w2

    puts "#{w1.name} vs #{w2.name}"

    while w1.alive? && w2.alive?  #both alive FIGHT!
      damage_done = damage(attacker, defender)
      defender.take_dmg(damage_done)

      puts log(attacker, defender, damage_done)

      #swap attacker and defender
      attacker, defender = [defender, attacker]
    end

    if w1.alive?
      puts "#{w1.name} Wins!"
      w1
    else
      puts "#{w2.name} Wins!"
      w2
    end
  end
end

class Warrior
  attr_reader :name, :weapon, :hp

  def initialize(name, weapon, hp = 20)
    @name = name
    @weapon = weapon
    @hp = hp
  end

  def alive?
    @hp > 0
  end

  def take_dmg(amt)
    @hp = hp - amt
  end

  # name (weapon)
  def to_s
    "#{name} (#{weapon})"
  end

  def heal
    @hp = 20
  end
end

# ----------------------------------------------------------------------

def title(number)
  "\nPart #{number}:\n\n"
end

b = Blaze.new

puts title("One")

puts Sword: b.battle("Sword", "Axe") # Sword
puts Axe:   b.battle("Axe", "Lance") # Axe
puts Lance: b.battle("Lance", "Sword") # Lance
puts Lance: b.battle("Sword", "Lance") # Lance
puts Tie:   b.battle("Sword", "Sword") # Tie

puts title("Two")

sword_warrior  = Warrior.new("Aaron", "Sword")
lance_warrior  = Warrior.new("Brandon", "Lance")
axe_warrior    = Warrior.new("Sarah", "Axe")
sword_warrior2 = Warrior.new("Allie", "Sword")

puts Sword:  b.warrior_battle(sword_warrior, axe_warrior).to_s # Sword
puts Axe:    b.warrior_battle(axe_warrior, lance_warrior).to_s # Axe
puts Lance:  b.warrior_battle(lance_warrior, sword_warrior).to_s # Lance
puts Lance:  b.warrior_battle(sword_warrior, lance_warrior).to_s # Lance
puts Sword1: b.warrior_battle(sword_warrior, sword_warrior2).to_s # Sword 1

puts title("Three")

puts "7.5": b.damage(sword_warrior, axe_warrior) # Sword
puts "7.5": b.damage(axe_warrior, lance_warrior) # Axe
puts "7.5": b.damage(lance_warrior, sword_warrior) # Lance
puts "2.5": b.damage(sword_warrior, lance_warrior) # Lance
puts "5.0": b.damage(sword_warrior, sword_warrior2) # Sword 1

puts title("Four")

puts Sword:  b.full_battle(sword_warrior, axe_warrior).to_s # Sword
puts
puts Axe:    b.full_battle(axe_warrior, lance_warrior).to_s # Axe
puts
puts Lance:  b.full_battle(lance_warrior, sword_warrior).to_s # Lance
puts
puts Lance:  b.full_battle(sword_warrior, lance_warrior).to_s # Lance
puts
puts Sword1: b.full_battle(sword_warrior, sword_warrior2).to_s # Sword 1
puts
