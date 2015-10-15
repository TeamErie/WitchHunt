setup_file = File.expand_path("../../lib/setup.rb", __FILE__)
require setup_file

include Base

test = Game.new(PLAYERS)
