player_path = File.expand_path("../player.rb", __FILE__)
require player_path

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
  :priest
]

SETUP_ORDER = [
  # :acolyte,
  :peeping_tom,
  :witch,
  :apprentice,
  :gambler,
  :oracle
  # :fortune_teller
  # :bomber
]

class Game
  attr_reader :players

  def roles(player_count)
    PLAYER_CLASS[0...player_count]
  end

  def get_input(string)
    puts string
    return gets.chomp.downcase
  end

  def initialize(list_of_player_names)
    players = list_of_player_names.shuffle
    roles = roles(list_of_player_names.count).shuffle
    witches_needed = WITCH_COUNT[list_of_player_names.count]

    @players = []
    players.each do |player|
      c = roles.pop
      if CLERGY.include? c
        role = :villager
      elsif witches_needed > 0 and
        role = :witch
        witches_needed -= 1
      else
        role = :villager
      end
      p = Player.new(role, c, player)
      @players << p
    end

    night_zero
  end

  def find_all(class_or_role) # should be a symbol
    a = []
    @players.each do |player|
      a << player if (player.player_class == class_or_role or player.role == class_or_role)
    end
    return a
  end

  def to_class(symbol)
    words = symbol.to_s.split("_")
    capitalized_word = words.inject("") { |existing, new_word| existing + new_word.capitalize }
    return Kernel.const_get(capitalized_word.to_sym)
  end

  def night_zero
    # TODO: charms
    SETUP_ORDER.each do |thing|
      participants = find_all(thing)
      participants.
  end

end
