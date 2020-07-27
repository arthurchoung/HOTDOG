/*

 PEEOS

 Copyright (c) 2020 Arthur Choung. All rights reserved.

 Email: arthur -at- peeos.org

 This file is part of PEEOS.

 PEEOS is free software: you can redistribute it and/or modify it
 under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <https://www.gnu.org/licenses/>.

 */

#import "PEEOS.h"

char *playerPalette = 
". #0000ff\n"
"o #ffffff\n"
;

char *playerPixels = 
"   .   \n"
"   .   \n"
"   o   \n"
"  ooo  \n"
" ..o.. \n"
"o..o..o\n"
"ooooooo\n"
" ooooo \n"
"  ooo  \n"
"  ooo  \n"
;
char *playerDeadPixels = 
"       \n"
"       \n"
"       \n"
" .   . \n"
"  . .  \n"
"       \n"
"       \n"
"  . .  \n"
" .   . \n"
"       \n"
;

char *bulletPalette = 
". #ffffff\n"
;

char *bulletPixels =
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
;

char *mushroomPalette = 
"o #ff0000\n"
"X #ffffff\n"
;
char *mushroom2Palette = 
"o #000000\n"
;

char *mushroomPixels =
"  oooo  \n"
" oXXXXo \n"
"oXXXXXXo\n"
"oXXXXXXo\n"
"oooooooo\n"
"  oXXo  \n"
"  oXXo  \n"
"  oooo  \n"
;
char *mushroom2Pixels =
"  ....  \n"
" .XXXX. \n"
".XXXXXX.\n"
".XXXXXX.\n"
".o......\n"
"oo.XX.oo\n"
"oooXoooo\n"
"oooooooo\n"
;
char *mushroom3Pixels =
"  ....  \n"
" .XXXX. \n"
".XXXXXX.\n"
".XXXXXX.\n"
".o.o.o.o\n"
"oo.ooooo\n"
"oooooooo\n"
"oooooooo\n"
;
char *mushroom4Pixels =
"  ....  \n"
" .XXXX. \n"
".XXoXXX.\n"
".oXoXoX.\n"
"oooooooo\n"
"oooooooo\n"
"oooooooo\n"
"oooooooo\n"
;
char *centipedePalette = 
". #ffffff\n"
"X #00ff00\n"
"o #ffffff\n"
;

#define CENTIPEDE1PIXELS \
" .     \n"\
"  XXoo \n"\
" XXXooX\n"\
"XXXXXXX\n"\
"XXXXXXX\n"\
" XXXooX\n"\
"  XXoo \n"\
" .     \n"

#define CENTIPEDE2PIXELS \
"  .    \n"\
"  XXoo \n"\
" XXXooX\n"\
"XXXXXXX\n"\
"XXXXXXX\n"\
" XXXooX\n"\
"  XXoo \n"\
"  .    \n"

#define CENTIPEDE3PIXELS \
"   .   \n"\
"  XXoo \n"\
" XXXooX\n"\
"XXXXXXX\n"\
"XXXXXXX\n"\
" XXXooX\n"\
"  XXoo \n"\
"   .   \n"

#define CENTIPEDE4PIXELS \
"    .  \n"\
"  XXoo \n"\
" XXXooX\n"\
"XXXXXXX\n"\
"XXXXXXX\n"\
" XXXooX\n"\
"  XXoo \n"\
"    .  \n"

#define CENTIPEDE5PIXELS \
"     . \n"\
"  XXoo \n"\
" XXXooX\n"\
"XXXXXXX\n"\
"XXXXXXX\n"\
" XXXooX\n"\
"  XXoo \n"\
"     . \n"

char *centipedePixels[8] = {
    CENTIPEDE1PIXELS,
    CENTIPEDE2PIXELS,
    CENTIPEDE3PIXELS,
    CENTIPEDE4PIXELS,
    CENTIPEDE5PIXELS,
    CENTIPEDE4PIXELS,
    CENTIPEDE3PIXELS,
    CENTIPEDE2PIXELS,
};


#define MAX_CENTIPEDE 20

@interface CentipedeClone : IvarObject
{
    int _mouseDown;
    int _mushroomGridWidth;
    int _mushroomGridHeight;
    char *_mushroomGrid;
    int _centipedeX[MAX_CENTIPEDE];
    int _centipedeY[MAX_CENTIPEDE];
    int _centipedeDeltaX[MAX_CENTIPEDE];
    int _centipedeDeltaY[MAX_CENTIPEDE];
    int _centipedeTurn[MAX_CENTIPEDE];
    int _playerDead;
    int _iteration;
    int _width;
    int _height;
    int _score;
    int _flash;
    int _playerX;
    int _playerY;
    int _bulletX;
    int _bulletY;
    int _bulletDeltaY;
    id _bitmap;
}
@end

@implementation CentipedeClone

- (void)dealloc
{
    if (_mushroomGrid) {
        free(_mushroomGrid);
        _mushroomGrid = NULL;
    }
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        _width = 256;
        _height = 240;
        _bitmap = [[[@"Bitmap" asClass] alloc] initWithWidth:_width height:_height];
        [self setupMushrooms];
    }
    return self;
}

- (int)bitmapWidth
{
    return _width;
}
- (int)bitmapHeight
{
    return _height;
}
- (unsigned char *)pixelBytesRGBA8888
{
    return [_bitmap pixelBytes];
}

- (void)setup
{
}

- (void)setupMushrooms
{
    if (_mushroomGrid) {
        free(_mushroomGrid);
        _mushroomGrid = NULL;
    }
    if (!_width || !_height) {
        return;
    }
    int mushroomWidth = [Definitions widthForCString:mushroomPixels];
    int mushroomHeight = [Definitions heightForCString:mushroomPixels];
    _mushroomGridWidth = _width / mushroomWidth;
    _mushroomGridHeight = _height / mushroomHeight;

    _mushroomGrid = malloc(_mushroomGridWidth*_mushroomGridHeight*100);
    if (!_mushroomGrid) {
        return;
    }
    memset(_mushroomGrid, 0, _mushroomGridWidth*_mushroomGridHeight);
    for (int i=0; i<_mushroomGridWidth*_mushroomGridHeight/50; i++) {
        int n = [Definitions randomInt:(_mushroomGridWidth*((_mushroomGridHeight/3)*2))];
        _mushroomGrid[n] = 1;
    }
}

- (int)indexOfPartialMushroom
{
    if (!_mushroomGrid) {
        return -1;
    }
    for (int i=0; i<_mushroomGridWidth*_mushroomGridHeight; i++) {
        if (_mushroomGrid[i] > 1) {
            return i;
        }
    }
    return -1;
}

- (int)numberOfMushrooms
{
    if (!_mushroomGrid) {
        return 0;
    }
    int count = 0;
    for (int i=0; i<_mushroomGridWidth*_mushroomGridHeight; i++) {
        if (_mushroomGrid[i]) {
            count++;
        }
    }
    return count;
}

- (void)setupCentipede
{
    int mushroomWidth = [Definitions widthForCString:mushroomPixels];
    int mushroomHeight = [Definitions heightForCString:mushroomPixels];
    for (int i=0; i<MAX_CENTIPEDE; i++) {
        _centipedeX[i] = mushroomWidth+i*mushroomWidth;
        _centipedeY[i] = 0;
        _centipedeDeltaX[i] = 1;
        _centipedeDeltaY[i] = 1;
    }
    for (int i=0; i<MAX_CENTIPEDE*2; i++) {
        _mushroomGrid[i] = 0;
    }
}

- (int)numberOfCentipede
{
    int count = 0;
    for (int i=0; i<MAX_CENTIPEDE; i++) {
        if (_centipedeDeltaX[i]) {
            count++;
        }
    }
    return count;
}

- (void)handleMouseDown:(id)event
{
    _mouseDown = 1;
}

- (void)handleMouseUp:(id)event
{
    _mouseDown = 0;
}

- (void)handleMouseMoved:(id)event
{
    if (_playerDead) {
        return;
    }
    int mushroomWidth = [Definitions widthForCString:mushroomPixels];
    int mushroomHeight = [Definitions heightForCString:mushroomPixels];
    int playerWidth = [Definitions widthForCString:playerPixels];
    int playerHeight = [Definitions heightForCString:playerPixels];
    int x = [event intValueForKey:@"mouseX"];
    int y = [event intValueForKey:@"mouseY"];
    int viewWidth = [event intValueForKey:@"viewWidth"];
    int viewHeight = [event intValueForKey:@"viewHeight"];
    x /= (double)viewWidth / (double)_width;
    y /= (double)viewHeight / (double)_height;
    if (x < 0) {
        x = 0;
    }
    if (x > _width-1-playerWidth) {
        x = _width-1-playerWidth;
    }
/*
    if (y < playerHeight) {
        y = playerHeight;
    }
*/
    if (y > _height-playerHeight) {
        y = _height-playerHeight;
    }
    if (y < _height-mushroomHeight*6) {
        y = _height-mushroomHeight*6;
    }
    _playerX = x;
    _playerY = y;
}
- (void)handleTouchesBegan:(id)event
{
    _mouseDown = 1;
}
- (void)handleTouchesEnded:(id)event
{
    _mouseDown = 0;
}
- (void)handleTouchesCancelled:(id)event
{
    _mouseDown = 0;
}
- (void)handleTouchesMoved:(id)event
{
    if (_playerDead) {
        return;
    }
    int mushroomWidth = [Definitions widthForCString:mushroomPixels];
    int mushroomHeight = [Definitions heightForCString:mushroomPixels];
    int playerWidth = [Definitions widthForCString:playerPixels];
    int playerHeight = [Definitions heightForCString:playerPixels];
    int x = [event intValueForKey:@"touchX"];
    int y = [event intValueForKey:@"touchY"];
    if (x < 0) {
        x = 0;
    }
    if (x > _width-1-playerWidth) {
        x = _width-1-playerWidth;
    }
/*
    if (y < playerHeight) {
        y = playerHeight;
    }
*/
    if (y < 1) {
        y = 1;
    }
    if (y > mushroomHeight*6) {
        y = mushroomHeight*6;
    }
    _playerX = x;
    _playerY = y;
}

- (void)moveCentipede
{
    int mushroomWidth = [Definitions widthForCString:mushroomPixels];
    int mushroomHeight = [Definitions heightForCString:mushroomPixels];
    for (int i=0; i<MAX_CENTIPEDE; i++) {
        if (_centipedeTurn[i]) {
            if (_centipedeTurn[i] == mushroomWidth/2) {
                _centipedeDeltaX[i] *= -1;
            }
            _centipedeX[i] += _centipedeDeltaX[i];
            _centipedeY[i] += _centipedeDeltaY[i];
            _centipedeTurn[i]--;
            if (!_centipedeTurn[i]) {
                if (_centipedeDeltaY[i] == 1) {
                    if (_centipedeY[i] / mushroomHeight == 29) {
                        _centipedeDeltaY[i] *= -1;
                    }
                } else if (_centipedeY[i] / mushroomHeight == 20) {
                    _centipedeDeltaY[i] *= -1;
                }
            }
            continue;
        }
        if (_centipedeDeltaX[i]) {
            _centipedeX[i] += _centipedeDeltaX[i];
            if (_centipedeDeltaX[i] > 0) {
                int gridX = (_centipedeX[i]+mushroomWidth) / mushroomWidth;
                int gridY = _centipedeY[i] / mushroomHeight;
                int index = gridY*_mushroomGridWidth+gridX;
                if ((gridX > _mushroomGridWidth-1) || _mushroomGrid[index]) {
                    _centipedeTurn[i] = mushroomHeight;
                }
            } else {
                int gridX = ((_centipedeX[i]+(mushroomWidth/2)) / mushroomWidth)-1;
                int gridY = _centipedeY[i] / mushroomHeight;
                int index = gridY*_mushroomGridWidth+gridX;
                if ((gridX < 0) || _mushroomGrid[index]) {
                    _centipedeTurn[i] = mushroomHeight;
                }
            }
        }
    }
}
- (void)checkCentipedeCollision
{
    if (_playerDead) {
        return;
    }
    if (!_playerY) {
        return;
    }
    int playerWidth = [Definitions widthForCString:playerPixels];
    int playerHeight = [Definitions heightForCString:playerPixels];
    int centipedeWidth = [Definitions widthForCString:centipedePixels[0]];
    int centipedeHeight = [Definitions heightForCString:centipedePixels[0]];
    Int4 playerRect = [Definitions rectWithX:_playerX y:_playerY w:playerWidth h:playerHeight];
    for (int i=0; i<MAX_CENTIPEDE; i++) {
        Int4 centipedeRect = [Definitions rectWithX:_centipedeX[i] y:_centipedeY[i] w:centipedeWidth h:centipedeHeight];
        if ([Definitions doesRect:playerRect intersectRect:centipedeRect]) {
            _playerDead = 1;
            break;
        }
    }
}
- (BOOL)shouldAnimate
{
    return YES;
}
- (void)beginIteration:(id)event rect:(Int4)r
{
    [self updateState];
    [self updateBitmap];
}
- (void)updateState
{
    int playerWidth = [Definitions widthForCString:playerPixels];
    int mushroomWidth = [Definitions widthForCString:mushroomPixels];
    int mushroomHeight = [Definitions heightForCString:mushroomPixels];
    if (!_playerY) {
        if (_width && _height) {
            _playerX = _width/2;
            _playerY = mushroomHeight*8;
        }
    }
    _iteration++;
    if (_mouseDown && !_playerDead && !_bulletDeltaY) {
        _bulletX = _playerX+playerWidth/2;
        _bulletY = _playerY;
        _bulletDeltaY = 8;
    }
    if (_bulletDeltaY) {
        int cellWidth = _width / _mushroomGridWidth;
        int cellHeight = _height / _mushroomGridHeight;
        int cellX = _bulletX / cellWidth;
        for (int i=0; i<_bulletDeltaY; i++) {
            _bulletY--;
            if (_bulletY < 0) {
                _bulletX = 0;
                _bulletY = 0;
                _bulletDeltaY = 0;
                break;
            }
            int cellY = _bulletY / cellHeight;
            int index = cellY*_mushroomGridWidth+cellX;
            if (_mushroomGrid[index]) {
                _bulletX = 0;
                _bulletY = 0;
                _bulletDeltaY = 0;
                if (_mushroomGrid[index] == 4) {
                    _mushroomGrid[index] = 0;
                    _score--;
                } else {
                    _mushroomGrid[index]++;
                }
                break;
            }
            for (int j=MAX_CENTIPEDE-1; j>=0; j--) {
                if (!_centipedeDeltaX[j]) {
                    continue;
                }
                if ((_bulletX >= _centipedeX[j]) && (_bulletX < _centipedeX[j]+mushroomWidth) && (_bulletY == _centipedeY[j])) {
                    int gridX = _centipedeX[j] / mushroomWidth;
                    int gridY = _centipedeY[j] / mushroomHeight;
                    int index = gridY*_mushroomGridWidth+gridX;
                    _mushroomGrid[index] = 1;
                    _centipedeX[j] = 0;
                    _centipedeY[j] = 0;
                    _centipedeDeltaX[j] = 0;
                    _bulletX = 0;
                    _bulletY = 0;
                    _bulletDeltaY = 0;
                    _score++;
                    i = _bulletDeltaY;
                    break;
                }
            }
        }
    }
    for (int i=0; i<2; i++) {
        [self moveCentipede];
        [self checkCentipedeCollision];
    }
    if (![self numberOfMushrooms]) {
        [self setupMushrooms];
    }
    if (![self numberOfCentipede]) {
        [self setupCentipede];
    }
    if (_playerDead) {
        _playerDead++;
        if (_playerDead % 10 == 0) {
            int index = [self indexOfPartialMushroom];
            if (index == -1) {
                if (_playerDead >= 60) {
                    _playerDead = 0;
                    [self setupCentipede];
                }
            } else {
                _mushroomGrid[index] = 1;
            }
        }
    }
}

- (void)updateBitmap
{
    id bitmap = _bitmap;
    [bitmap setColor:@"black"];
    [bitmap fillRect:[Definitions rectWithX:0 y:0 w:_width h:_height]];
    int playerWidth = [Definitions widthForCString:playerPixels];
    int playerHeight = [Definitions heightForCString:playerPixels];
    int bulletHeight = [Definitions heightForCString:bulletPixels];
    int mushroomWidth = [Definitions widthForCString:mushroomPixels];
    int mushroomHeight = [Definitions heightForCString:mushroomPixels];
    int centipedeWidth = [Definitions widthForCString:centipedePixels[0]];
    int centipedeHeight = [Definitions heightForCString:centipedePixels[0]];
    {
        char *pixels = (_playerDead) ? playerDeadPixels : playerPixels;
        [bitmap drawCString:pixels palette:playerPalette x:_playerX y:_playerY];
    }
    if (_bulletDeltaY) {
        [bitmap drawCString:bulletPixels palette:bulletPalette x:_bulletX y:_bulletY];
    }

    for (int j=0; j<_mushroomGridHeight; j++) {
        for (int i=0; i<_mushroomGridWidth; i++) {
            int index = j*_mushroomGridWidth+i;
            if (_mushroomGrid[index]) {
                [bitmap drawCString:mushroomPixels palette:mushroomPalette x:mushroomWidth*i y:mushroomHeight*j+1];
                if (_mushroomGrid[index] == 2) {
                    [bitmap drawCString:mushroom2Pixels palette:mushroom2Palette x:mushroomWidth*i y:mushroomHeight*j+1];
                } else if (_mushroomGrid[index] == 3) {
                    [bitmap drawCString:mushroom3Pixels palette:mushroom2Palette x:mushroomWidth*i y:mushroomHeight*j+1];
                } else if (_mushroomGrid[index] == 4) {
                    [bitmap drawCString:mushroom4Pixels palette:mushroom2Palette x:mushroomWidth*i y:mushroomHeight*j+1];
                }
            }
        }
    }

    for (int i=0; i<MAX_CENTIPEDE; i++) {
        if (_centipedeDeltaX[i]) {
            [bitmap drawCString:centipedePixels[((_iteration/3)+i)%8] palette:centipedePalette x:_centipedeX[i] y:_centipedeY[i]+1];
        }
    }
    [bitmap setColorIntR:255 g:255 b:255 a:255];
    [bitmap drawBitmapText:nsfmt(@"Score: %d", _score) x:10 y:0];
}

@end

