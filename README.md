IRCOthello
==========

IRC上でオセロをするためのbot

## How to play

IRCの指定されたチャンネルで

    #newgame user1 user2

と発言すると、user1が黒番、user2が白番でゲームが始まります。
自分の手番で

    #put 5 3

と発言すると、上から0-indexedで5番目、左から0-indexedで3番目に石を置きます。

一度に同時にできるのは1試合だけです。試合が行われている間に新しいゲームを始めると、現状では元のゲームの情報は消えてしまうので注意してください。

## Install

    git clone https://github.com/primenumber/IRCOthello.git
    cd IRCOthello
    bundle install
    ruby irc_othello.rb

## TODO

- ゲームが行われている最中にnewgameできないように
- 時間制限の実装
- 存在しないnickを指定したら無視するように

## License

GPL v3

## Author

- primenumber (prime@kmc.gr.jp)
