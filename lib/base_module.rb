require 'pry'

module Base

  PLAYERS = [
    "Josh",
    "Lincoln",
    "Jenny",
    "Jennifer",
    "Anna",
    "test1",
    "test2"
  ]

  PLAYER_CLASS = [
    :priest,
    :judge,
    :grave_digger,
    :apprentice,
    :survivalist,
    :dirty_old_bastard,
    :gambler,
    :fanatic,
    :oracle,
    :watchman,
    :hunter,
    :peeping_tom,
    :loose_cannon
  ]

  WITCH_COUNT = {
    7 => 2,
    8 => 2,
    9 => 3,
    10 => 3,
    11 => 3,
    12 => 3,
    13 => 3
  }

  CLERGY = [
    :priest,
    :fanatic,
    :watchman
  ]

  def get_input(string)
    puts string
    return gets.chomp.downcase
  end

  def to_object(symbol)
    words = symbol.to_s.split("_")
    capitalized_word = words.inject("") { |existing, new_word| existing + new_word.capitalize }
    return Kernel.const_get(capitalized_word.to_sym)
  end

end
