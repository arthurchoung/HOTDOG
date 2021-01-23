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

// Solver from https://rosettacode.org/wiki/15_puzzle_solver

#import "HOTDOG.h"

static char *backgroundCString = 
"    bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb    \n"
"   b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b   \n"
"  b bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb b  \n"
" b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b \n"
"b bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb b\n"
"bb b                                                                                   b bb\n"
"bbb b                                                                                 b bbb\n"
"bb b                                                                                   b bb\n"
"b bbb                                                                                 bbb b\n"
"bb b                                                                                   b bb\n"
"bbb b                                                                                 b bbb\n"
"bb b                                                                                   b bb\n"
"b bbb                                                                                 bbb b\n"
"bb b                                                                                   b bb\n"
"bbb b                                                                                 b bbb\n"
"bb b                                                                                   b bb\n"
"b bbb                                                                                 bbb b\n"
"bb b                                                                                   b bb\n"
"bbb b                                                                                 b bbb\n"
"bb b                                                                                   b bb\n"
"b bbb                                                                                 bbb b\n"
"bb b                                                                                   b bb\n"
"bbb b                                                                                 b bbb\n"
"bb b                                                                                   b bb\n"
"b bbb                                                                                 bbb b\n"
"bb b                                                                                   b bb\n"
"bbb b                                                                                 b bbb\n"
"bb b                                                                                   b bb\n"
"b bbb                                                                                 bbb b\n"
"bb b                                                                                   b bb\n"
"bbb b                                                                                 b bbb\n"
"bb b                                                                                   b bb\n"
"b bbb                                                                                 bbb b\n"
"bb b                                                                                   b bb\n"
"bbb b                                                                                 b bbb\n"
"bb b                                                                                   b bb\n"
"b bbb                                                                                 bbb b\n"
"bb b                                                                                   b bb\n"
"bbb b                                                                                 b bbb\n"
"bb b                                                                                   b bb\n"
"b bbb                                                                                 bbb b\n"
"bb b                                                                                   b bb\n"
"bbb b                                                                                 b bbb\n"
"bb b                                                                                   b bb\n"
"b bbb                                                                                 bbb b\n"
"bb b                                                                                   b bb\n"
"bbb b                                                                                 b bbb\n"
"bb b                                                                                   b bb\n"
"b bbb                                                                                 bbb b\n"
"bb b                                                                                   b bb\n"
"bbb b                                                                                 b bbb\n"
"bb b                                                                                   b bb\n"
"b bbb                                                                                 bbb b\n"
"bb b                                                                                   b bb\n"
"bbb b                                                                                 b bbb\n"
"bb b                                                                                   b bb\n"
"b bbb                                                                                 bbb b\n"
"bb b                                                                                   b bb\n"
"bbb b                                                                                 b bbb\n"
"bb b                                                                                   b bb\n"
"b bbb                                                                                 bbb b\n"
"bb b                                                                                   b bb\n"
"bbb b                                                                                 b bbb\n"
"bb b                                                                                   b bb\n"
"b bbb                                                                                 bbb b\n"
"bb b                                                                                   b bb\n"
"bbb b                                                                                 b bbb\n"
"bb b                                                                                   b bb\n"
"b bbb                                                                                 bbb b\n"
"bb b                                                                                   b bb\n"
"bbb b                                                                                 b bbb\n"
"bb b                                                                                   b bb\n"
"b bbb                                                                                 bbb b\n"
"bb b                                                                                   b bb\n"
"bbb b                                                                                 b bbb\n"
"bb b                                                                                   b bb\n"
"b bbb                                                                                 bbb b\n"
"bb b                                                                                   b bb\n"
"bbb b                                                                                 b bbb\n"
"bb b                                                                                   b bb\n"
"b bbb                                                                                 bbb b\n"
"bb b                                                                                   b bb\n"
"bbb b                                                                                 b bbb\n"
"bb b                                                                                   b bb\n"
"b bbb                                                                                 bbb b\n"
"bb b                                                                                   b bb\n"
"bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb\n"
" bbb b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b bbb \n"
"  bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb bbb  \n"
"   bbb b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b b bbb   \n"
"    bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb    \n"
;
static char *gridCString = 
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                   b                   b                   b                   b\n"
"b                                                                               b\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
;
static char *borderCString =
"bbbbbbbbbbbbbbbbbbbbb\n"
"b                   b\n"
"b                   b\n"
"b                   b\n"
"b                   b\n"
"b                   b\n"
"b                   b\n"
"b                   b\n"
"b                   b\n"
"b                   b\n"
"b                   b\n"
"b                   b\n"
"b                   b\n"
"b                   b\n"
"b                   b\n"
"b                   b\n"
"b                   b\n"
"b                   b\n"
"b                   b\n"
"b                   b\n"
"bbbbbbbbbbbbbbbbbbbbb\n"
;
static char *puzzleCStrings[] = {
"                   \n"
"  b   b   b   b   b\n"
"                   \n"
"b   b   b   b   b  \n"
"                   \n"
"  b   b   b   b   b\n"
"                   \n"
"b   b   b   b   b  \n"
"                   \n"
"  b   b   b   b   b\n"
"                   \n"
"b   b   b   b   b  \n"
"                   \n"
"  b   b   b   b   b\n"
"                   \n"
"b   b   b   b   b  \n"
"                   \n"
"  b   b   b   b   b\n"
"                   \n"
,
"                   \n"
"                   \n"
"                   \n"
"          bbb      \n"
"         bb b      \n"
"         b  b      \n"
"         bb b      \n"
"          b b      \n"
"          b b      \n"
"          b b      \n"
"          b b      \n"
"         bb bb     \n"
"         b   b     \n"
"         bbbbb     \n"
"                   \n"
"                   \n"
"                   \n"
"                   \n"
"                   \n"
,

"                   \n"
"                   \n"
"                   \n"
"        bbbbb      \n"
"       bb   bb     \n"
"       b bbb b     \n"
"       bbb b b     \n"
"          bb b     \n"
"         bb bb     \n"
"        bb bb      \n"
"       bb bbbb     \n"
"       b bbb b     \n"
"       b     b     \n"
"       bbbbbbb     \n"
"                   \n"
"                   \n"
"                   \n"
"                   \n"
"                   \n"
,

"                   \n"
"                   \n"
"                   \n"
"         bbbb      \n"
"        bb  bb     \n"
"        b bb b     \n"
"        bbbb b     \n"
"         bb bb     \n"
"         b  bb     \n"
"         bbb bb    \n"
"           bb b    \n"
"            b b    \n"
"       bbb bb b    \n"
"       b bbb bb    \n"
"       bb   bb     \n"
"        bbbbb      \n"
"                   \n"
"                   \n"
"                   \n"
,

"                   \n"
"                   \n"
"                   \n"
"           bbb     \n"
"          bb b     \n"
"         bb bb     \n"
"        bb bbb     \n"
"       bb bb b     \n"
"       b bbb bb    \n"
"       b      b    \n"
"       bbbbb bb    \n"
"          bb bb    \n"
"          b   b    \n"
"          bbbbb    \n"
"                   \n"
"                   \n"
"                   \n"
"                   \n"
"                   \n"
,

"                   \n"
"                   \n"
"                   \n"
"       bbbbbbb     \n"
"       b     b     \n"
"       b bbbbb     \n"
"       b bbbb      \n"
"       b    bb     \n"
"       bbbbb bb    \n"
"           bb b    \n"
"            b b    \n"
"           bb b    \n"
"          bb bb    \n"
"       bbbb bb     \n"
"       b   bb      \n"
"       bbbbb       \n"
"                   \n"
"                   \n"
"                   \n"
,

"                   \n"
"                   \n"
"         bbbb      \n"
"        bb  b      \n"
"       bb bbb      \n"
"       b bbbb      \n"
"       b b  bb     \n"
"       b  bb bb    \n"
"       b bbbb b    \n"
"       b b  b b    \n"
"       b bbbb b    \n"
"       bb bb bb    \n"
"        bb  bb     \n"
"         bbbb      \n"
"                   \n"
"                   \n"
"                   \n"
"                   \n"
"                   \n"
,

"                   \n"
"                   \n"
"                   \n"
"       bbbbbbbb    \n"
"       b      b    \n"
"       b bbbb b    \n"
"       bbb b bb    \n"
"          bb b     \n"
"          b bb     \n"
"         bb b      \n"
"         b bb      \n"
"         b b       \n"
"         b b       \n"
"         bbb       \n"
"                   \n"
"                   \n"
"                   \n"
"                   \n"
"                   \n"
,

"                   \n"
"                   \n"
"                   \n"
"         bbbb      \n"
"        bb  bb     \n"
"        b bb b     \n"
"        b bb b     \n"
"        bb  bb     \n"
"       bb bb bb    \n"
"       b bbbb b    \n"
"       b b  b b    \n"
"       b bbbb b    \n"
"       bb bb bb    \n"
"        bb  bb     \n"
"         bbbb      \n"
"                   \n"
"                   \n"
"                   \n"
"                   \n"
,

"                   \n"
"                   \n"
"                   \n"
"         bbbb      \n"
"        bb  bb     \n"
"       bb bb bb    \n"
"       b bbbb b    \n"
"       b b  b b    \n"
"       b bbbb b    \n"
"       bb bb  b    \n"
"        bb  b b    \n"
"         bbbb b    \n"
"         bbb bb    \n"
"         b  bb     \n"
"         bbbb      \n"
"                   \n"
"                   \n"
"                   \n"
"                   \n"
,

"                   \n"
"                   \n"
"                   \n"
"    bbb     bbbb   \n"
"   bb b    bb  bb  \n"
"   b  b   bb bb bb \n"
"   bb b   b bbbb b \n"
"    b b   b b  b b \n"
"    b b   b b  b b \n"
"    b b   b b  b b \n"
"    b b   b bbbb b \n"
"   bb bb  bb bb bb \n"
"   b   b   bb  bb  \n"
"   bbbbb    bbbb   \n"
"                   \n"
"                   \n"
"                   \n"
"                   \n"
"                   \n"
,

"                   \n"
"                   \n"
"                   \n"
"    bbb      bbb   \n"
"   bb b     bb b   \n"
"   b  b     b  b   \n"
"   bb b     bb b   \n"
"    b b      b b   \n"
"    b b      b b   \n"
"    b b      b b   \n"
"    b b      b b   \n"
"   bb bb    bb bb  \n"
"   b   b    b   b  \n"
"   bbbbb    bbbbb  \n"
"                   \n"
"                   \n"
"                   \n"
"                   \n"
"                   \n"
,
"                   \n"
"                   \n"
"                   \n"
"    bbb    bbbbb   \n"
"   bb b   bb   bb  \n"
"   b  b   b bbb b  \n"
"   bb b   bbb b b  \n"
"    b b      bb b  \n"
"    b b     bb bb  \n"
"    b b    bb bb   \n"
"    b b   bb bbbb  \n"
"   bb bb  b bbb b  \n"
"   b   b  b     b  \n"
"   bbbbb  bbbbbbb  \n"
"                   \n"
"                   \n"
"                   \n"
"                   \n"
"                   \n"
,

"                   \n"
"                   \n"
"                   \n"
"    bbb     bbbb   \n"
"   bb b    bb  bb  \n"
"   b  b    b bb b  \n"
"   bb b    bbbb b  \n"
"    b b     bb bb  \n"
"    b b     b  bb  \n"
"    b b     bbb bb \n"
"    b b       bb b \n"
"   bb bb       b b \n"
"   b   b  bbb bb b \n"
"   bbbbb  b bbb bb \n"
"          bb   bb  \n"
"           bbbbb   \n"
"                   \n"
"                   \n"
"                   \n"
,

"                   \n"
"                   \n"
"                   \n"
"    bbb       bbb  \n"
"   bb b      bb b  \n"
"   b  b     bb bb  \n"
"   bb b    bb bbb  \n"
"    b b   bb bb b  \n"
"    b b   b bbb bb \n"
"    b b   b      b \n"
"    b b   bbbbb bb \n"
"   bb bb     bb bb \n"
"   b   b     b   b \n"
"   bbbbb     bbbbb \n"
"                   \n"
"                   \n"
"                   \n"
,

"                   \n"
"                   \n"
"                   \n"
"    bbb   bbbbbbb  \n"
"   bb b   b     b  \n"
"   b  b   b bbbbb  \n"
"   bb b   b bbbb   \n"
"    b b   b    bb  \n"
"    b b   bbbbb bb \n"
"    b b       bb b \n"
"    b b        b b \n"
"   bb bb      bb b \n"
"   b   b     bb bb \n"
"   bbbbb  bbbb bb  \n"
"          b   bb   \n"
"          bbbbb    \n"
"                   \n"
"                   \n"
"                   \n"
,
};

static int Nr[16] = {3, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3};
static int Nc[16] = {3, 0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2};

@interface FifteenPuzzle : IvarObject
{
    int _x[16];
    int _y[16];
    int _flash;
    id _bitmap;
    int _piece[16];
    int _transition[16];
    int _transitionCurrentFrame;
    int _transitionMaxFrame;
    int n;
    int _n;
    int N0[100];
    int N3[100];
    int N4[100];
    unsigned long long N2[100];
    id _moves;
}
@end
@implementation FifteenPuzzle
+ (id)classMenu
{
    id arr = nsarr();
    id dict;
    dict = nsdict();
    [dict setValue:@"scramble" forKey:@"message"];
    [arr addObject:dict];
    dict = nsdict();
    [dict setValue:@"solve" forKey:@"message"];
    [arr addObject:dict];
    return arr;
}

- (BOOL)GL_NEAREST
{
    return YES;
}

- (BOOL)shouldAnimate
{
    if (_transitionCurrentFrame < _transitionMaxFrame) {
        return YES;
    }
    if ([_moves count]) {
        return YES;
    }
    return (_flash) ? YES : NO;
}
- (void)beginIteration:(id)event rect:(Int4)r
{
    if (_flash > 0) {
        _flash--;
    }
    if (_transitionCurrentFrame < _transitionMaxFrame) {
        _transitionCurrentFrame++;
    } else {
        [self automaticallyMovePiece];
    }
    [self updateBitmap];
}
- (id)init
{
    self = [super init];
    if (self) {
        _bitmap = [[[@"Bitmap" asClass] alloc] initWithWidth:[self bitmapWidth] height:[self bitmapHeight]];
        for (int i=0; i<16; i++) {
            int y = i/4;
            int x = i%4;
            _x[i] = 6+20*x;
            _y[i] = 6+20*y;
            _piece[i] = i+1;
        }
        _piece[15] = 0;
    }
    return self;
}
- (int)preferredWidth
{
    return 91*3;
}
- (int)preferredHeight
{
    return 91*3;
}
- (int)bitmapWidth
{
    return 91;
}
- (int)bitmapHeight
{
    return 91;
}
- (unsigned char *)pixelBytesRGBA8888
{
    return [_bitmap pixelBytes];
}
- (void)updateBitmap
{
    char blackChar = 'b';
    char whiteChar = ' ';
    if ((_flash/2)%2==1) {
        blackChar = ' ';
        whiteChar = 'b';
    }
    id bitmap = _bitmap;
    [bitmap drawCString:backgroundCString x:0 y:0 c:'b' r:0 g:0 b:0 a:255];
    [bitmap drawCString:backgroundCString x:0 y:0 c:' ' r:255 g:255 b:255 a:255];

    if (_transitionCurrentFrame < _transitionMaxFrame) {
        [bitmap drawCString:gridCString x:5 y:5 c:blackChar r:0 g:0 b:0 a:255];
        [bitmap drawCString:gridCString x:5 y:5 c:whiteChar r:255 g:255 b:255 a:255];

        int fromTable[16];
        int toTable[16];
        for (int i=0; i<16; i++) {
            fromTable[_transition[i]] = i;
            toTable[_piece[i]] = i;
        }
        [bitmap drawCString:puzzleCStrings[0] x:_x[fromTable[0]] y:_y[fromTable[0]] c:blackChar r:0 g:0 b:0 a:255];
        if (fromTable[0] != toTable[0]) {
            [bitmap drawCString:puzzleCStrings[0] x:_x[toTable[0]] y:_y[toTable[0]] c:blackChar r:0 g:0 b:0 a:255];
        }
        for (int i=1; i<16; i++) {
            char *cstr = puzzleCStrings[i];
            int from = fromTable[i];
            int to = toTable[i];
            if (from == to) {
                [bitmap drawCString:cstr x:_x[to] y:_y[to] c:blackChar r:0 g:0 b:0 a:255];
            } else {
                int fromX = _x[from];
                int fromY = _y[from];
                int toX = _x[to];
                int toY = _y[to];
                double pct = (double)_transitionCurrentFrame / (double)_transitionMaxFrame;
                int diffX = toX - fromX;
                int diffY = toY - fromY;
                int x = fromX+diffX*pct;
                int y = fromY+diffY*pct;
                [bitmap drawCString:borderCString x:x-1 y:y-1 c:blackChar r:0 g:0 b:0 a:255];
                [bitmap drawCString:borderCString x:x-1 y:y-1 c:whiteChar r:255 g:255 b:255 a:255];
                [bitmap drawCString:cstr x:x y:y c:blackChar r:0 g:0 b:0 a:255];
            }
        }
    } else {
        [bitmap drawCString:gridCString x:5 y:5 c:blackChar r:0 g:0 b:0 a:255];
        [bitmap drawCString:gridCString x:5 y:5 c:whiteChar r:255 g:255 b:255 a:255];

        for (int i=0; i<16; i++) {
            char *cstr = puzzleCStrings[_piece[i]];
            [bitmap drawCString:cstr x:_x[i] y:_y[i] c:blackChar r:0 g:0 b:0 a:255];
        }
    }
}
- (int)indexForEmptySpace
{
    for (int i=0; i<16; i++) {
        if (_piece[i] == 0) {
            return i;
        }
    }
    return 0;
}

- (void)movePieces:(int)i :(int *)buf
{
    int x = i%4;
    int y = i/4;
    int spaceIndex = [self indexForEmptySpace];
    int spaceX = spaceIndex%4;
    int spaceY = spaceIndex/4;
    if ((x == spaceX) && (y == spaceY)) {
        return;
    }
    if (x == spaceX) {
        if (y < spaceY) {
            for (int j=spaceY; j>y; j--) {
                int dstIndex = j*4+spaceX;
                int srcIndex = (j-1)*4+spaceX;
                buf[dstIndex] = buf[srcIndex];
                buf[srcIndex] = 0;
            }
        } else {
            for (int j=spaceY; j<y; j++) {
                int dstIndex = j*4+spaceX;
                int srcIndex = (j+1)*4+spaceX;
                buf[dstIndex] = buf[srcIndex];
                buf[srcIndex] = 0;
            }
        }
    } else if (y == spaceY) {
        if (x < spaceX) {
            for (int j=spaceX; j>x; j--) {
                int dstIndex = spaceY*4+j;
                int srcIndex = y*4+j-1;
                buf[dstIndex] = buf[srcIndex];
                buf[srcIndex] = 0;
            }
        } else {
            for (int j=spaceX; j<x; j++) {
                int dstIndex = spaceY*4+j;
                int srcIndex = y*4+j+1;
                buf[dstIndex] = buf[srcIndex];
                buf[srcIndex] = 0;
            }
        }
    }
}
- (void)handleMouseDown:(id)event
{
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    for (int i=0; i<16; i++) {
        Int4 r;
        r.x = _x[i];
        r.y = _y[i];
        r.w = 19;
        r.h = 19;
        if ([Definitions isX:mouseX y:mouseY insideRect:r]) {
            [self setupTransition];
            [self movePieces:i :_piece];
        }
    }
    if ([self isWinner]) {
        _flash = 31;
    }
}
- (BOOL)isWinner
{
    for (int i=0; i<15; i++) {
        if (_piece[i]-1 != i) {
            return NO;
        }
    }
    if (_piece[15] == 0) {
        return YES;
    }
    return NO;
}

- (BOOL)fY
{
    if (N2[n]==0x123456789abcdef0) {
        id arr = nsarr();
        for (int g=1; g<=n; g++) {
            [arr addObject:nsfmt(@"%c", (char)N3[g])];
        }
        [self setValue:arr forKey:@"moves"];
        return YES;
    }
    if (N4[n]<=_n) {
        return [self fN];
    }
    return NO;
}
- (BOOL)fN
{
    if (N3[n]!='u' && N0[n]/4<3) { 
        [self fI];
        n++;
        if ([self fY]) {
            return YES;
        }
        n--;
    }
    if (N3[n]!='d' && N0[n]/4>0) {
        [self fG];
        n++;
        if ([self fY]) {
            return YES;
        }
        n--;
    }
    if (N3[n]!='l' && N0[n]%4<3) {
        [self fE];
        n++;
        if ([self fY]) {
            return YES;
        }
        n--;
    }
    if (N3[n]!='r' && N0[n]%4>0) {
        [self fL];
        n++;
        if ([self fY]) {
            return YES;
        }
        n--;
    }
    return NO;
}

- (void)fI
{
    int g = (11-N0[n])*4;
    unsigned long long a = N2[n]&((unsigned long long)15<<g);
    N0[n+1]=N0[n]+4;
    N2[n+1]=N2[n]-a+(a<<16);
    N3[n+1]='d';
    N4[n+1]=N4[n]+(Nr[a>>g]<=N0[n]/4?0:1);
} 

- (void)fG
{
    int g = (19-N0[n])*4;
    unsigned long long a = N2[n]&((unsigned long long)15<<g);
    N0[n+1]=N0[n]-4;
    N2[n+1]=N2[n]-a+(a>>16);
    N3[n+1]='u';
    N4[n+1]=N4[n]+(Nr[a>>g]>=N0[n]/4?0:1);
} 
- (void)fE
{
    int g = (14-N0[n])*4;
    unsigned long long a = N2[n]&((unsigned long long)15<<g);
    N0[n+1]=N0[n]+1;
    N2[n+1]=N2[n]-a+(a<<4);
    N3[n+1]='r';
    N4[n+1]=N4[n]+(Nc[a>>g]<=N0[n]%4?0:1);
} 
- (void)fL
{
    int g = (16-N0[n])*4;
    unsigned long long a = N2[n]&((unsigned long long)15<<g);
    N0[n+1]=N0[n]-1;
    N2[n+1]=N2[n]-a+(a>>4);
    N3[n+1]='l';
    N4[n+1]=N4[n]+(Nc[a>>g]>=N0[n]%4?0:1);
}
- (void)solve
{
    int spaceIndex = [self indexForEmptySpace];
NSLog(@"spaceIndex %d", spaceIndex);
    N0[0] = spaceIndex;
    N2[0] = 0;
    for (int i=0; i<16; i++) {
        N2[0] <<= 4;
        N2[0] |= (unsigned long long)(_piece[i]&0xf);
    }
    for(; ![self fY]; _n++) {
    }
    [_moves addObject:@"flash"];
NSLog(@"moves %@", _moves);
}
- (void)setupTransition
{
    for (int i=0; i<16; i++) {
        _transition[i] = _piece[i];
    }
    _transitionCurrentFrame = 0;
    _transitionMaxFrame = 12;
}
- (void)automaticallyMovePiece
{
NSLog(@"automaticallyMovePiece");
    if (![_moves count]) {
        return;
    }
    id move = [_moves nth:0];
NSLog(@"move %@", move);
    id moves = [_moves subarrayFromIndex:1];
    [self setValue:moves forKey:@"moves"];
    [self setupTransition];
    [self movePiece:move];
}
- (void)movePiece:(id)move
{
    int spaceIndex = [self indexForEmptySpace];
    int x = spaceIndex%4;
    int y = spaceIndex/4;
    if ([move isEqual:@"r"]) {
        if (x != 3) {
            [self movePieces:spaceIndex+1 :_piece];
        }
    } else if ([move isEqual:@"l"]) {
        if (x != 0) {
            [self movePieces:spaceIndex-1 :_piece];
        }
    } else if ([move isEqual:@"d"]) {
        if (y != 3) {
            [self movePieces:spaceIndex+4 :_piece];
        }
    } else if ([move isEqual:@"u"]) {
        if (y != 0) {
            [self movePieces:spaceIndex-4 :_piece];
        }
    } else if ([move isEqual:@"flash"]) {
        _flash = 31;
    }
}
- (void)scramble
{
    for (int i=0; i<16*1000; i++) {
        id moves = [@"u d l r" split];
        id move = [moves randomObject];
        [self movePiece:move];
    }
}
@end

