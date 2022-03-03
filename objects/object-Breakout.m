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

@implementation Definitions(nfejklwnfklsdfmk)
+ (id)Breakout
{
    return [@"Breakout" asInstance];
}
@end

char *brickHitPixels =
"        \n"
"b      b\n"
" b    b \n"
"        \n"
"        \n"
" b    b \n"
"b      b\n"
"        \n"
;

char *brickLeftPixels =
" \n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
" \n"
;
char *brickMiddlePixels =
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
;

char *paddlePalette = 
". #000000\n"
"b #ffffff\n"
;

char *paddlePixels =
"  bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb  \n"
" b....................................b \n"
"b..bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb..b\n"
"b.b.b.b.b.b.b.b.b.b.b.b.b.b.b.b.b.b.bb.b\n"
"b.bb.b.b.b.b.b.b.b.b.b.b.b.b.b.b.b.b.b.b\n"
"b.b.b.b.b.b.b.b.b.b.b.b.b.b.b.b.b.b.bb.b\n"
"b.bb.b.b.b.b.b.b.b.b.b.b.b.b.b.b.b.b.b.b\n"
"b.b.b.b.b.b.b.b.b.b.b.b.b.b.b.b.b.b.bb.b\n"
"b..bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb..b\n"
" b....................................b \n"
"  bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb  \n"
;

char *ballPalette = 
". #ffffff\n"
;

char *ballPixels = 
"  ....  \n"
" ...... \n"
"........\n"
"........\n"
"........\n"
"........\n"
" ...... \n"
"  ....  \n"
;

@interface Breakout : IvarObject
{
    int _iteration;
    Int4 _leftWallRect;
    Int4 _rightWallRect;
    Int4 _topWallRect;
    int _width;
    int _height;
    int _paddleX;
    int _paddleY;
    int _ballX;
    int _ballY;
    int _ballDeltaX;
    int _ballDeltaY;
    id _bricks;
    int _score;
    int _flash;
    id _bitmap;
}
@end

@implementation Breakout

- (id)init
{
    self = [super init];
    if (self) {
        _width = 640;
        _height = 400;
        [self setValue:[Definitions bitmapWithWidth:_width height:_height] forKey:@"bitmap"];
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
    [self setupBricks];
}

- (void)setupBall
{
    _ballX = 100;
    _ballY = _height / 2;
    _ballDeltaX = 3;
    _ballDeltaY = -3;
}

- (void)setupBricks
{
    int bricksPerRow = 25;
    int brickWidth = (_width-1) / 25;
    int wallWidth = (_width-1) % 25;
    if (!wallWidth) {
        brickWidth = (_width-1) / 26;
        wallWidth = 25;
    }
    int leftWallWidth = wallWidth/2;
    int rightWallWidth = wallWidth - leftWallWidth;
    _leftWallRect = [Definitions rectWithX:0 y:20 w:leftWallWidth h:_height-20];
    _rightWallRect = [Definitions rectWithX:_width-rightWallWidth y:20 w:rightWallWidth h:_height-20];
NSLog(@"_width %d wallWidth %d rightWallWidth %d", _width, wallWidth, rightWallWidth);
    _topWallRect = [Definitions rectWithX:0 y:20 w:_width h:7];
    id brickPalettes = nsarr();
    [brickPalettes addObject:@"b #ff0000\n"];
    [brickPalettes addObject:@"b #ff7f00\n"];
    [brickPalettes addObject:@"b #ffff00\n"];
    [brickPalettes addObject:@"b #00ff00\n"];
    [brickPalettes addObject:@"b #ffffbf\n"];
    int brickHeight = [Definitions heightForCString:brickMiddlePixels];
    id arr = nsarr();
    for (int j=0; j<[brickPalettes length]; j++) {
        for (int i=0; i<bricksPerRow; i++) {
            id dict = nsdict();
            [dict setValue:nsfmt(@"%d", leftWallWidth+1+brickWidth*i) forKey:@"x"];
            [dict setValue:nsfmt(@"%d", 50+(brickHeight+4)*j) forKey:@"y"];
            [dict setValue:nsfmt(@"%d", brickWidth-1) forKey:@"w"];
            [dict setValue:nsfmt(@"%d", brickHeight) forKey:@"h"];
            [dict setValue:[brickPalettes nth:j] forKey:@"palette"];
            [dict setValue:nsfmt(@"%d", [brickPalettes length]-j) forKey:@"points"];
            [arr addObject:dict];
        }
    }
    [self setValue:arr forKey:@"bricks"];
}

- (void)handleMouseDown:(id)event
{
    [self setupBall];
}

- (void)handleMouseMoved:(id)event
{
    int x = [event intValueForKey:@"mouseX"];
    int viewWidth = [event intValueForKey:@"viewWidth"];
    x /= (double)viewWidth / (double)_width;
    if (x < 8) {
        x = 8;
    }
    int paddleWidth = [Definitions widthForCString:paddlePixels];
    if (x > _width-7-paddleWidth-1) {
        x = _width-7-paddleWidth-1;
    }
    _paddleX = x;
}
- (void)handleTouchesBegan:(id)event
{
    [self setupBall];
}
- (void)handleTouchesMoved:(id)event
{
    int x = [event intValueForKey:@"touchX"];
    if (x < 8) {
        x = 8;
    }
    int paddleWidth = [Definitions widthForCString:paddlePixels];
    if (x > _width-7-paddleWidth-1) {
        x = _width-7-paddleWidth-1;
    }
    _paddleX = x;
}

- (BOOL)shouldAnimate
{
    return YES;
}
- (void)beginIteration:(id)event rect:(Int4)r
{
    _paddleY = _height - 50;
    _ballX += _ballDeltaX;
    _ballY += _ballDeltaY;
    int ballWidth = [Definitions widthForCString:ballPixels];
    int ballHeight = [Definitions heightForCString:ballPixels];
    Int4 ballRect = [Definitions rectWithX:_ballX y:_ballY-ballHeight+1 w:ballWidth h:ballHeight];
    int paddleWidth = [Definitions widthForCString:paddlePixels];
    int paddleHeight = [Definitions heightForCString:paddlePixels];
    Int4 paddleRect = [Definitions rectWithX:_paddleX y:_paddleY-paddleHeight+1 w:paddleWidth h:paddleHeight];
    if ([Definitions doesRect:ballRect intersectRect:_leftWallRect]) {
        _ballDeltaX = abs(_ballDeltaX);
    }
    if ([Definitions doesRect:ballRect intersectRect:_rightWallRect]) {
        _ballDeltaX = -abs(_ballDeltaX);
    }
    if ([Definitions doesRect:ballRect intersectRect:_topWallRect]) {
        _ballDeltaY = abs(_ballDeltaY);
    }
    if ([Definitions doesRect:ballRect intersectRect:paddleRect]) {
        _ballDeltaY = -abs(_ballDeltaY);
        if (ballRect.x < paddleRect.x+paddleRect.w/3) {
            if (_ballDeltaX < 0) {
                _ballDeltaX = -4;
            } else {
                _ballDeltaX = 2;
            }
        } else if (ballRect.x < paddleRect.x+(paddleRect.w/3)*2) {
            if (_ballDeltaX < 0) {
                _ballDeltaX = -3;
            } else {
                _ballDeltaX = 3;
            }
        } else {
            if (_ballDeltaX < 0) {
                _ballDeltaX = -2;
            } else {
                _ballDeltaX = 4;
            }
        }
    }
    for (int i=0; i<[_bricks count]; i++) {
        id elt = [_bricks nth:i];
        int hit = [elt intValueForKey:@"hit"];
        if (hit) {
            hit++;
            [elt setValue:nsfmt(@"%d", hit) forKey:@"hit"];
        }
    }
    if (_flash) {
        _flash--;
    }
    for (int i=0; i<[_bricks count]; i++) {
        id elt = [_bricks nth:i];
        if ([elt intValueForKey:@"hit"]) {
            continue;
        }
        Int4 brickRect = [Definitions rectWithX:[elt intValueForKey:@"x"] y:[elt intValueForKey:@"y"] w:[elt intValueForKey:@"w"] h:[elt intValueForKey:@"h"]];
        if ([Definitions doesRect:ballRect intersectRect:brickRect]) {
            [elt setValue:@"1" forKey:@"hit"];
            _score += [elt intValueForKey:@"points"];
            _flash += 5*[elt intValueForKey:@"points"];
            _ballDeltaY *= -1;
            int num = [Definitions randomInt:6];
            if (num == 0) {
                _ballDeltaX = -2;
            } else if (num == 1) {
                _ballDeltaX = -3;
            } else if (num == 2) {
                _ballDeltaX = -4;
            } else if (num == 3) {
                _ballDeltaX = 2;
            } else if (num == 4) {
                _ballDeltaX = 3;
            } else if (num == 5) {
                _ballDeltaX = 4;
            }
        }
    }
    id keepBricks = nsarr();
    for (int i=0; i<[_bricks count]; i++) {
        id brick = [_bricks nth:i];
        if ([brick intValueForKey:@"hit"] > 7) {
        } else {
            [keepBricks addObject:brick];
        }
    }
    [self setValue:keepBricks forKey:@"bricks"];
    if (![_bricks length]) {
        [self setupBricks];
        [self setupBall];
    }
    if (_ballY < 0) {
        _ballX = 0;
        _ballY = 0;
        _ballDeltaX = 0;
        _ballDeltaY = 0;
    }
//    [self autoMove];
    [self updateBitmap];
}

- (void)autoMove
{
    int paddleWidth = [Definitions widthForCString:paddlePixels];
    _paddleX = _ballX-paddleWidth/2;
    if (_paddleX < _leftWallRect.x+_leftWallRect.w) {
        _paddleX = _leftWallRect.x+_leftWallRect.w;
    }
    if (_paddleX > _rightWallRect.x-paddleWidth) {
        _paddleX = _rightWallRect.x-paddleWidth;
    }
}
- (void)updateBitmap
{
    id bitmap = _bitmap;
    [bitmap setColor:@"black"];
    [bitmap fillRect:[Definitions rectWithX:0 y:0 w:_width h:_height]];
    [bitmap setColor:@"white"];
    [bitmap fillRect:_leftWallRect];
    [bitmap fillRect:_rightWallRect];
    [bitmap fillRect:_topWallRect];

    if (_ballDeltaX || _ballDeltaY) {
        [bitmap drawCString:ballPixels palette:ballPalette x:_ballX y:_ballY];
    }

    int paddleHeight = [Definitions heightForCString:paddlePixels];
    [bitmap drawCString:paddlePixels palette:paddlePalette x:_paddleX y:_paddleY];

    int brickHitWidth = [Definitions widthForCString:brickHitPixels];

    for (int i=0; i<[_bricks count]; i++) {
        id elt = [_bricks nth:i];
        if ([elt intValueForKey:@"hit"]) {
            [bitmap drawCString:brickHitPixels palette:[[elt valueForKey:@"palette"] UTF8String] x:[elt intValueForKey:@"x"]+(([elt intValueForKey:@"w"]-brickHitWidth)/2) y:[elt intValueForKey:@"y"]];
        } else {
            [Definitions drawInBitmap:bitmap left:brickLeftPixels middle:brickMiddlePixels right:brickLeftPixels x:[elt intValueForKey:@"x"] y:[elt intValueForKey:@"y"] w:[elt intValueForKey:@"w"] palette:[[elt valueForKey:@"palette"] UTF8String]];
//            [bitmap drawCString:brickPixels palette:[[elt valueForKey:@"palette"] UTF8String] x:[elt intValueForKey:@"x"] y:[elt intValueForKey:@"y"]+[elt intValueForKey:@"h"]-1];
        }
    }
}
@end

