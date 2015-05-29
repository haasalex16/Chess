##Terminal Chess

To play please download this repo and run 'bundle install' (to include the colorize gem) and then 'ruby chess.rb' in your terminal

Chess is a 2-player, logic driven game built in Ruby with:
* User input error catching
* Class inheritance from a generic piece class into more specific sliding/stepping/pawn piece classes
* Error checking for legal move based on chosen piece
* Error checking to ensure player does not put oneself into 'check'
* Utilizes ['colorize'](https://github.com/fazibear/colorize) Gem to create checkered board
* Utilized Unicode for chess piece icons

**chess.rb** - contains code regarding to only running the game and requires only the 'board' class.

**board.rb** - contains all information pertaining to the current including rendering the board and all individual piece locations.  Also includes error checking of user input.

**pieces.rb** - contains all universal piece code including initializing, rendering, moving, and identifying valid moves.

**stepping_pieces.rb, sliding_pieces.rb, pawns.rb** - inherits from the Piece class and then adds on individual class methods such as possible moves (depending on each piece class's limitations)

Breaking into separate classes allows the code length to be minimized and DRY out the code as much as possible.
