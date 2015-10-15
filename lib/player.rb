class Player
  attr_accessor :role, :player_class, :name, :info

  INFO_SKELETON = {
    :name => nil,
    :role => nil,
    :player_class => nil
  }

  def initialize(r, c, n, i)
    @role = r
    @player_class = c
    @name = n

    @info = {}
    (i - [@name]).each do |name|
      @info[name] = INFO_SKELETON
    end
  end

  def know_role(other_player)
    @info[other_player.name] = other_player.role
  end

  def know_class(other_player)
    @info[other_player.name] = other_player.player_class
  end

end
