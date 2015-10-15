base_file = File.expand_path("../base_module.rb", __FILE__)
require base_file

player_file = File.expand_path("../player.rb", __FILE__)
require player_file

module Base
  class Game
    attr_reader :players

    def roles(player_count)
      PLAYER_CLASS[0...player_count]
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
        elsif witches_needed > 0
          role = :witch
          witches_needed -= 1
        else
          role = :villager
        end
        p = Player.new(role, c, player, list_of_player_names)
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

    def night_zero
      # TODO: charms

      # setup_acolyte
      # setup_peeping_tom
      setup_witch
      setup_apprentice
      setup_gambler
      setup_oracle
      # setup_fortune_teller
      # setup_bomber
    end

    def setup_witch
      # Tell all the witches about each other
      witches = find_all(:witch)
      witches.each do |witch|
        other_witches = witches - [witch]
        other_witches.each do |other_witch|
          witch.know_role(other_witch)
          witch.know_class(other_witch)
        end
      end
    end

    def setup_apprentice
      apprentices = find_all(:apprentice)
      resp = nil
      loop do
        resp = get_input("pick grave_digger or judge")
        break if ["grave_digger", "judge"].include? resp
        puts "Sorry, that's not one of the options."
      end

      teachers = find_all(resp.to_sym)
      teachers.each do |teacher|
        apprentices.each do |apprentice|
          apprentice.know_class(teacher)
          # needs more here, for when the teacher dies
        end
      end
    end

    def setup_gambler
      gamblers = find_all(:gambler)
      loop do
        resp = get_input("pick 1 for odd nights, 2 for even ones")
        break if ["1", "2"].include? resp
        puts "Sorry, that's not one of the options."
      end

      # needs more here, for when the gamber dies
    end

    def setup_oracle
      oracles = find_all(:oracle)
      villagers = find_all(:villager)

      oracles.each do |oracle|
        oracle.know_role(villagers.shuffle.first)
      end
    end

  end
end
