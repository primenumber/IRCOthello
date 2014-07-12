require 'cinch'
require './board'

$game = nil
$black = nil
$white = nil

bot = Cinch::Bot.new do
  configure do |conf|
    conf.server = 'irc.freenode.org'
    conf.channels = ['#irc-othello']
    conf.nick = 'othello_bot'
  end

  on :message, /#newgame ([[:graph:]&&[:ascii:]]+) ([[:graph:]&&[:ascii:]]+)/ do |m, black, white|
    $black = black
    $white = white
    $game = Board.new
    m.reply "newgame #{black} vs. #{white}"
    m.reply $game.to_s
  end

  on :message, /#put (\d) (\d)/ do |m, i, j|
    if $game.state == "x" then
      if m.user.nick == $black then
        $game.put(i.to_i, j.to_i)
      end
    else
      if m.user.nick == $white then
        $game.put(i.to_i, j.to_i)
      end
    end
    m.reply "put #{i} #{j}"
    m.reply $game.to_s
    if $game.over? then
      m.reply "Game set"
      $game = nil
    else
      if $game.state == "x" then
        m.reply "next: #{$black}"
      else
        m.reply "next: #{$white}"
      end
    end
  end
end

bot.start
