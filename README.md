[![Travis](https://api.travis-ci.org/nicklockwood/Chess.svg?branch=master)](https://travis-ci.org/nicklockwood/Chess)
[![Platforms](https://img.shields.io/badge/platforms-iOS-lightgray.svg)]()
[![Swift 5.2](https://img.shields.io/badge/swift-5.2-red.svg?style=flat)](https://developer.apple.com/swift)
[![License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://opensource.org/licenses/MIT)
[![Twitter](https://img.shields.io/badge/twitter-@nicklockwood-blue.svg)](http://twitter.com/nicklockwood)

![Screenshot](Screenshot.png?raw=true)

Swift Chess
------------

- Forked from 
Nick Lockwood @nicklockwood

This is a simple chess game for iPhone and iPad, designed for novice players. That I'll be using as an artificial intelligence project

Algorithms Implemented:
- [ ] Basic Reflex -  From original code with a few changes to accomadate newer algorithms
- [ ] Minimax - Analyzing player moves and comparing them based on a consistent heuristic
- [ ] Alpha Beta pruning -  Pruning unnecessary moves generated by minimax
- [ ] Evaluating different heuristics and their combinations
  - [ ] Material Balance: Relative value of pieces on the board
  - [ ] King safety: Prioritize protecting the king in each move
  - [ ] Pawn Structure: Focus on the pawn positions and aim for promotion
  - [ ] Center Control: Prioritize controlling the middle of the board
  - [ ] Mobility: Prioritie increasing number of possible moves and distance that the pieces can make
- [ ] Quiescent Search - Take quiet positions into consideration when evaluating moves.

Results:
