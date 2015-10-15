class Player
  attr_accessor :role, :player_class, :name

  def initialize(r, c, n)
    @role = r
    @player_class = c
    @name = n
  end

end
