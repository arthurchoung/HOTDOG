/*

 HOT DOG Linux

 Copyright (c) 2020 Arthur Choung. All rights reserved.

 Email: arthur -at- hotdoglinux.com

 This file is part of HOT DOG Linux.

 HOT DOG Linux is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <https://www.gnu.org/licenses/>.

 */

#import "HOTDOG.h"

#define BOARD_WIDTH 7
#define BOARD_HEIGHT 6

#define CELL_WIDTH 19
#define CELL_HEIGHT 19

/*
static char *cString = 
"bbbbbbbbbbbbbbbbbbb\n"
"bbbbbb.......bbbbbb\n"
"bbbb...........bbbb\n"
"bbb.............bbb\n"
"bb...............bb\n"
"bb...............bb\n"
"b.................b\n"
"b.................b\n"
"b.................b\n"
"b.................b\n"
"b.................b\n"
"b.................b\n"
"b.................b\n"
"bb...............bb\n"
"bb...............bb\n"
"bbb.............bbb\n"
"bbbb...........bbbb\n"
"bbbbbb.......bbbbbb\n"
"bbbbbbbbbbbbbbbbbbb\n"
;
*/
static char *cString = 
"bbbbbbbbbbbbbbbbbbb\n"
"bbbbbbXXXXXXXbbbbbb\n"
"bbbbXX.......XXbbbb\n"
"bbbX...........Xbbb\n"
"bbX.............Xbb\n"
"bbX.............Xbb\n"
"bX...............Xb\n"
"bX...............Xb\n"
"bX...............Xb\n"
"bX...............Xb\n"
"bX...............Xb\n"
"bX...............Xb\n"
"bX...............Xb\n"
"bbX.............Xbb\n"
"bbX.............Xbb\n"
"bbbX...........Xbbb\n"
"bbbbXX.......XXbbbb\n"
"bbbbbbXXXXXXXbbbbbb\n"
"bbbbbbbbbbbbbbbbbbb\n"
;

@implementation Definitions(gyubhjhghjkgyjghjghjkgybhbjbxdsdf)
+ (id)ConnectFour
{
    id obj = [@"ConnectFour" asInstance];
    return obj;
}
@end

@interface ConnectFour : IvarObject
{
    id _bitmap;
    int _board[BOARD_HEIGHT*BOARD_WIDTH];
    int _potentialX;
    int _potentialY;
    int _winner;
    int _tie;
    int _playerValueScore;
    int _computerValueScore;
    int _buttonDownX;
    int _buttonHoverX;
}
@end

@implementation ConnectFour

- (BOOL)glNearest
{
    return YES;
}

- (id)init
{
    self = [super init];
    if (self) {
        id bitmap = [Definitions bitmapWithWidth:BOARD_WIDTH*CELL_WIDTH height:BOARD_HEIGHT*CELL_HEIGHT];
        [self setValue:bitmap forKey:@"bitmap"];
        _potentialX = -1;
        _potentialY = -1;
        _buttonDownX = -1;
    }
    return self;
}

- (int)preferredWidth
{
    return [self bitmapWidth]*4;
}
- (int)preferredHeight
{
    return [self bitmapHeight]*4;
}
- (int)bitmapWidth
{
    return BOARD_WIDTH*CELL_WIDTH;
}
- (int)bitmapHeight
{
    return BOARD_HEIGHT*CELL_HEIGHT;
}
- (unsigned char *)pixelBytesRGBA8888
{
    return [_bitmap pixelBytes];
}

- (void)beginIteration:(id)event rect:(Int4)r
{
    [self updateBitmap];
}

- (void)updateBitmap
{
    id bitmap = _bitmap;
    for (int j=0; j<BOARD_HEIGHT; j++) {
        for (int i=0; i<BOARD_WIDTH; i++) {
            int cellX = CELL_WIDTH*i;
            int cellY = CELL_HEIGHT*j;
            if (_board[j*BOARD_WIDTH+i] == 1) {
                char *palette = "b #0000ff\n. #ff0000\nX #ff0000\n";
                [bitmap drawCString:cString palette:palette x:cellX y:cellY];
            } else if (_board[j*BOARD_WIDTH+i] == 2) {
                char *palette = "b #0000ff\n. #ffff00\nX #ffff00\n";
                [bitmap drawCString:cString palette:palette x:cellX y:cellY];
            } else if ((_potentialX == i) && (_potentialY == j)) {
                if (!_winner && !_tie) {
                    if (_buttonDownX == _buttonHoverX) {
                        char *palette = "b #0000ff\n. #770000\nX #ff0000\n";
                        [bitmap drawCString:cString palette:palette x:cellX y:cellY];
                    } else {
                        char *palette = "b #0000ff\n. #330000\nX #cc0000\n";
                        [bitmap drawCString:cString palette:palette x:cellX y:cellY];
                    }
                }
            } else {
                char *palette = "b #0000ff\n. #000000\nX #000000\n";
                [bitmap drawCString:cString palette:palette x:cellX y:cellY];
            }
        }
    }
    if (_winner || _tie) {
        id str = (_winner == 1) ? @"You win!" : @"Computer wins!";
        if (_winner == 1) {
            str = @"You win!";
        } else if (_winner == 2) {
            str = @"Computer wins!";
        } else if (_tie) {
            str = @"Tie game";
        }
        str = nsfmt(@"%@\n\nClick to play again", str);
        [bitmap setColor:@"black"];
        [bitmap drawBitmapText:str x:1 y:1];
        [bitmap drawBitmapText:str x:2 y:1];
        [bitmap drawBitmapText:str x:3 y:1];
        [bitmap drawBitmapText:str x:1 y:2];
        [bitmap drawBitmapText:str x:2 y:2];
        [bitmap drawBitmapText:str x:3 y:2];
        [bitmap drawBitmapText:str x:1 y:3];
        [bitmap drawBitmapText:str x:2 y:3];
        [bitmap drawBitmapText:str x:3 y:3];
        [bitmap setColor:@"white"];
        [bitmap drawBitmapText:str x:2 y:2];
    }
    
//    [bitmap setColorIntR:255 g:255 b:255 a:255];
//    [bitmap drawBitmapText:nsfmt(@"Value Score: %d %d", _playerValueScore, _computerValueScore) x:10 y:70];
}

- (void)clearAllBoardValues
{
    for (int i=0; i<BOARD_WIDTH*BOARD_HEIGHT; i++) {
        _board[i] = 0;
    }
}

- (void)setValue:(int)val board:(int *)board x:(int)x y:(int)y
{
    if ((x >= 0) && (x < BOARD_WIDTH)) {
        if ((y >= 0) && (y < BOARD_HEIGHT)) {
            board[y*BOARD_WIDTH+x] = val;
        }
    }
}
- (int)valueForBoard:(int *)board x:(int)x y:(int)y
{
    if ((x >= 0) && (x < BOARD_WIDTH)) {
        if ((y >= 0) && (y < BOARD_HEIGHT)) {
            return board[y*BOARD_WIDTH+x];
        }
    }
    return -1;
}

- (int)nextPossibleYForX:(int)x
{
    return [self nextPossibleYForX:x board:_board];
}
- (int)nextPossibleYForX:(int)x board:(int *)board
{
    for (int y=BOARD_HEIGHT-1; y>=0; y--) {
        int val = [self valueForBoard:board x:x y:y];
        if (val == -1) {
            return val;
        }
        if (val == 0) {
            return y;
        }
    }
    return -1;
}

- (int)checkForWinner
{
    for (int i=1; i<=2; i++) {
        int val = [self checkForWinner:i];
        if (val) {
            return val;
        }
    }
    return 0;
}
- (int)checkForTie
{
    return [self checkForTieForBoard:_board];
}
- (int)checkForTieForBoard:(int *)board
{
    for (int x=0; x<BOARD_WIDTH; x++) {
        for (int y=0; y<BOARD_HEIGHT; y++) {
            int val = [self valueForBoard:board x:x y:y];
            if (val == 0) {
                return 0;
            }
        }
    }
    return 1;
}

- (int)checkForWinner:(int)player
{
    return [self checkForWinner:player board:_board];
}
- (int)checkForWinner:(int)player board:(int *)board
{
    /* check vertically */
    for (int x=0; x<BOARD_WIDTH; x++) {
        int count = 0;
        for (int y=0; y<BOARD_HEIGHT; y++) {
            int val = [self valueForBoard:board x:x y:y];
            if (val == -1) {
                break;
            }
            if (val == player) {
                count++;
                if (count == 4) {
                    return player;
                }
            } else {
                count = 0;
            }
        }
    }
    /* check horizontally */
    for (int y=0; y<BOARD_HEIGHT; y++) {
        int count = 0;
        for (int x=0; x<BOARD_WIDTH; x++) {
            int val = [self valueForBoard:board x:x y:y];
            if (val == -1) {
                break;
            }
            if (val == player) {
                count++;
                if (count == 4) {
                    return player;
                }
            } else {
                count = 0;
            }
        }
    }
    /* check diagonally up */
    for (int x=0; x<BOARD_WIDTH; x++) {
        for (int y=0; y<BOARD_HEIGHT; y++) {
            int count = 0;
            for(int offset=0;; offset++) {
                int val = [self valueForBoard:board x:x+offset y:y+offset];
                if (val == -1) {
                    break;
                }
                if (val == player) {
                    count++;
                    if (count == 4) {
                        return player;
                    }
                } else {
                    count = 0;
                }
            }
        }
    }
    /* check diagonally down */
    for (int x=0; x<BOARD_WIDTH; x++) {
        for (int y=0; y<BOARD_HEIGHT; y++) {
            int count = 0;
            for(int offset=0;; offset++) {
                int val = [self valueForBoard:board x:x+offset y:y-offset];
                if (val == -1) {
                    break;
                }
                if (val == player) {
                    count++;
                    if (count == 4) {
                        return player;
                    }
                } else {
                    count = 0;
                }
            }
        }
    }
    return 0;
}


- (void)handleComputer
{
    // if computer can win, go there
    for (int x=0; x<BOARD_WIDTH; x++) {
        int possibleBoard[BOARD_HEIGHT*BOARD_WIDTH];
        for (int i=0; i<BOARD_HEIGHT*BOARD_WIDTH; i++) {
            possibleBoard[i] = _board[i];
        }
        int y = [self nextPossibleYForX:x board:possibleBoard];
        if (y == -1) {
            continue;
        }
        possibleBoard[y*BOARD_WIDTH+x] = 2;
        if ([self checkForWinner:1 board:possibleBoard]) {
            _board[y*BOARD_WIDTH+x] = 2;
            return;
        }
    }

    // if player has chance to win, block it
    for (int x=0; x<BOARD_WIDTH; x++) {
        int possibleBoard[BOARD_HEIGHT*BOARD_WIDTH];
        for (int i=0; i<BOARD_HEIGHT*BOARD_WIDTH; i++) {
            possibleBoard[i] = _board[i];
        }
        int y = [self nextPossibleYForX:x board:possibleBoard];
        if (y == -1) {
            continue;
        }
        possibleBoard[y*BOARD_WIDTH+x] = 1;
        if ([self checkForWinner:1 board:possibleBoard]) {
            _board[y*BOARD_WIDTH+x] = 2;
            return;
        }
    }

    id possibleMoves = nsarr();
    for (int x=0; x<BOARD_WIDTH; x++) {
        int possibleBoard[BOARD_HEIGHT*BOARD_WIDTH];
        for (int i=0; i<BOARD_HEIGHT*BOARD_WIDTH; i++) {
            possibleBoard[i] = _board[i];
        }
        int y = [self nextPossibleYForX:x board:possibleBoard];
        if (y == -1) {
            continue;
        }
        possibleBoard[y*BOARD_WIDTH+x] = 2;
        int playerScore = [self countNumberOfWins:1 board:possibleBoard];
        int computerScore = [self countNumberOfWins:2 board:possibleBoard];
        if (computerScore >= 10000) {
            [possibleMoves removeAllObjects];
            id dict = nsdict();
            [dict setValue:nsfmt(@"%d", x) forKey:@"x"];
            [dict setValue:nsfmt(@"%d", playerScore) forKey:@"playerScore"];
            [dict setValue:nsfmt(@"%d", computerScore) forKey:@"computerScore"];
            [dict setValue:nsfmt(@"%d", computerScore) forKey:@"score"];
            [possibleMoves addObject:dict];
            break;
        }
        id dict = nsdict();
        [dict setValue:nsfmt(@"%d", x) forKey:@"x"];
        [dict setValue:nsfmt(@"%d", playerScore) forKey:@"playerScore"];
        [dict setValue:nsfmt(@"%d", computerScore) forKey:@"computerScore"];
        [dict setValue:nsfmt(@"%d", playerScore) forKey:@"score"];
        [possibleMoves addObject:dict];
    }
    possibleMoves = [possibleMoves sortedWithKey:@"score"];
NSLog(@"possibleMoves %@", possibleMoves);
    int x = [[possibleMoves nth:0] intValueForKey:@"x"];
    int y = [self nextPossibleYForX:x];
    if (y == -1) {
    } else {
        _board[y*BOARD_WIDTH+x] = 2;
    }
}

- (int)countNumberOfWins:(int)player
{
    return [self countNumberOfWins:player board:_board];
}
- (int)countNumberOfWins:(int)player board:(int *)board
{
//    NSLog(@"countNumberOfWins:%d", player);
    int numberOfWins = 0;
    
    /* check vertically */
    for (int x=0; x<BOARD_WIDTH; x++) {
        for (int y=0; y<BOARD_HEIGHT; y++) {
            int count = 0;
            int multiplier = 10000;
            for (int offset=0; offset<4; offset++) {
                int val = [self valueForBoard:board x:x y:y+offset];
                if (val == -1) {
                    break;
                }
                if (val == 0) {
                    val = player;
                    multiplier /= 10;
                }
                if (val == player) {
                    count++;
                } else {
                    break;
                }
            }
            if (count == 4) {
                numberOfWins += multiplier;
//                NSLog(@"vertical x %d y %d multiplier %d", x, y, multiplier);
            }
        }
    }
    /* check horizontally */
    for (int x=0; x<BOARD_WIDTH; x++) {
        for (int y=0; y<BOARD_HEIGHT; y++) {
            int count = 0;
            int multiplier = 10000;
            for (int offset=0; offset<4; offset++) {
                int val = [self valueForBoard:board x:x+offset y:y];
                if (val == -1) {
                    break;
                }
                if (val == 0) {
                    val = player;
                    multiplier /= 10;
                }
                if (val == player) {
                    count++;
                } else {
                    break;
                }
            }
            if (count == 4) {
                numberOfWins += multiplier;
//                NSLog(@"horizontal x %d y %d multiplier %d", x, y, multiplier);
            }
        }
    }
    /* check diagonally up */
    for (int x=0; x<BOARD_WIDTH; x++) {
        for (int y=0; y<BOARD_HEIGHT; y++) {
            int count = 0;
            int multiplier = 10000;
            for(int offset=0; offset<4; offset++) {
                int val = [self valueForBoard:board x:x+offset y:y+offset];
                if (val == -1) {
                    break;
                }
                if (val == 0) {
                    val = player;
                    multiplier /= 10;
                }
                if (val == player) {
                    count++;
                } else {
                    break;
                }
            }
            if (count == 4) {
                numberOfWins += multiplier;
//                NSLog(@"diagonally up x %d y %d multiplier %d", x, y, multiplier);
            }
        }
    }
    /* check diagonally down */
    for (int x=0; x<BOARD_WIDTH; x++) {
        for (int y=0; y<BOARD_HEIGHT; y++) {
            int count = 0;
            int multiplier = 10000;
            for(int offset=0; offset<4; offset++) {
                int val = [self valueForBoard:board x:x+offset y:y-offset];
                if (val == -1) {
                    break;
                }
                if (val == 0) {
                    val = player;
                    multiplier /= 10;
                }
                if (val == player) {
                    count++;
                } else {
                    break;
                }
            }
            if (count == 4) {
                numberOfWins += multiplier;
//                NSLog(@"diagonally down x %d y %d multiplier %d", x, y, multiplier);
            }
        }
    }
    return numberOfWins;
}

- (void)handleMouseMoved:(id)event
{
    if (_winner || _tie) {
        _buttonHoverX = -1;
        return;
    }
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    int x = mouseX / CELL_WIDTH;
    _buttonHoverX = x;
    int y = [self nextPossibleYForX:x];
    if (y == -1) {
    } else {
        if (_buttonDownX == -1) {
            _potentialX = x;
            _potentialY = y;
        }
    }
}

- (void)handleMouseDown:(id)event
{
    if (_winner || _tie) {
        _buttonDownX = -1;
        return;
    }
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    int x = mouseX / CELL_WIDTH;
    _buttonDownX = x;
}

- (void)handleMouseUp:(id)event
{
    if (_winner || _tie) {
        _buttonDownX = -1;
        [self clearAllBoardValues];
        _winner = 0;
        _tie = 0;
        return;
    }
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    int x = mouseX / CELL_WIDTH;
    if (x != _buttonDownX) {
        _buttonDownX = -1;
        int y = [self nextPossibleYForX:x];
        if (y == -1) {
        } else {
            _potentialX = x;
            _potentialY = y;
        }
        return;
    }

    int y = [self nextPossibleYForX:x];
    if (y == -1) {
    } else {
        _board[y*BOARD_WIDTH+x] = 1;
        _winner = [self checkForWinner];
        _tie = [self checkForTie];
        if (_winner || _tie) {
        } else {
            [self handleComputer];
            _winner = [self checkForWinner];
            _tie = [self checkForTie];
            if (!_winner && !_tie) {
                [self handleMouseMoved:event];
            }
        }
    }
    _buttonDownX = -1;
}

@end

