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

#include <math.h>

char *madBomberPalette =
//"  #8E8E8E\n"
". #484800\n"
"X #69690F\n"
"o #86861D\n"
"O #4A4A4A\n"
"+ #D5824A\n"
"@ #E39759\n"
"# #D6D6D6\n"
//"$ #527E2D\n"
;
char *madBomberPixels = 
"       ...........       \n"
"       ...........       \n"
"   XXXXXXXXXXXXXXXXXX    \n"
"   XXXXXXXXXXXXXXXXXX    \n"
"   oooooooooooooooooo    \n"
"   oooooooooooooooooo    \n"
"   OOOOOOOOOOOOOOOOOO    \n"
"   OOOOOOOOOOOOOOOOOO    \n"
"OOOOOOO    OOO    OOOOOOO\n"
"OOOOOOO    OOO    OOOOOOO\n"
"OOOOOOOOOOOOOOOOOOOOOOOOO\n"
"OOOOOOOOOOOOOOOOOOOOOOOOO\n"
"+++++++++++   +++++++++++\n"
"+++++++++++   +++++++++++\n"
"   @@@@@@@@   @@@@@@@    \n"
"   @@@@@@@@   @@@@@@@    \n"
"   @@@@@@@@@@@@@@@@@@    \n"
"   @@@@@@@@@@@@@@@@@@    \n"
"   @@@@@@@@   @@@@@@@    \n"
"   @@@@@@@@   @@@@@@@    \n"
"   @@@@    @@@    @@@    \n"
"   @@@@    @@@    @@@    \n"
"       @@@@@@@@@@@       \n"
"       @@@@@@@@@@@       \n"
"       +++++++++++       \n"
"       +++++++++++       \n"
"       OOOOOOOOOOO       \n"
"       OOOOOOOOOOO       \n"
"   ##################    \n"
"   ##################    \n"
"OOOOOOOOOOOOOOOOOOOOOOOOO\n"
"OOOOOOOOOOOOOOOOOOOOOOOOO\n"
"#########################\n"
"#########################\n"
"OOOOOOOOOOOOOOOOOOOOOOOOO\n"
"OOOOOOOOOOOOOOOOOOOOOOOOO\n"
"#########################\n"
"#########################\n"
"OOOOOOOOOOOOOOOOOOOOOOOOO\n"
"OOOOOOOOOOOOOOOOOOOOOOOOO\n"
"###    ###########   ####\n"
"###    ###########   ####\n"
"OOOOOOO    OOO    OOOOOOO\n"
"OOOOOOO    OOO    OOOOOOO\n"
"###    ###########   ####\n"
"###    ###########   ####\n"
"OOOOOOO    OOO    OOOOOOO\n"
"OOOOOOO    OOO    OOOOOOO\n"
"###    ###########   ####\n"
"###    ###########   ####\n"
"OOOOOOO    OOO    OOOOOOO\n"
"OOOOOOO    OOO    OOOOOOO\n"
"###    ###########   ####\n"
"###    ###########   ####\n"
"@@@                  @@@@\n"
"@@@                  @@@@\n"
"@@@$$$$$$$$$$$$$$$$$$@@@@\n"
"@@@$$$$$$$$$$$$$$$$$$@@@@\n"
"$$$@@@@$$$$$$$$$$$@@@$$$$\n"
"$$$@@@@$$$$$$$$$$$@@@$$$$\n"
;

char *bucketPalette = 
"  #527E2D\n"
". #A2A22A\n"
"X #545CD6\n"
"o #86861D\n"
"O #69690F\n"
;

char *bucketPixels =
"       ....................................       \n"
"       ....................................       \n"
"       XXXXXXXXXXXXXXXXXXXXXXXXXXXXX              \n"
"       XXXXXXXXXXXXXXXXXXXXXXXXXXXXX              \n"
".......       .......       ........       .......\n"
".......       .......       ........       .......\n"
".......       .......       ........       .......\n"
".......       .......       ........       .......\n"
"ooooooo       ooooooo       oooooooo       ooooooo\n"
"ooooooo       ooooooo       oooooooo       ooooooo\n"
"ooooooo       ooooooo       oooooooo       ooooooo\n"
"ooooooo       ooooooo       oooooooo       ooooooo\n"
"OOOOOOO       OOOOOOO       OOOOOOOO       OOOOOOO\n"
"OOOOOOO       OOOOOOO       OOOOOOOO       OOOOOOO\n"
"OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO\n"
"OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO\n"
;
char *splashPalette =
"# #545CD6\n"
;
char *splashPixels =
"................#######.......#######...............\n"
"................#######.......#######...............\n"
".########....................................#######\n"
".########....................................#######\n"
".......................#######......................\n"
".......................#######......................\n"
"................#####################...............\n"
"................#####################...............\n"
"....................................................\n"
"....................................................\n"
".########..............#######...............#######\n"
".########..............#######...............#######\n"
;
char *splash2Palette =
//"  #527E2D\n"
"# #545CD6\n"
;
char *splash2Pixels =
"########                                    ####### \n"
"########                                    ####### \n"
"                      #######                       \n"
"                      #######                       \n"
"                                                    \n"
"                                                    \n"
"                      #######                       \n"
"                      #######                       \n"
"########              #######               ####### \n"
"########              #######               ####### \n"
"                                                    \n"
"                                                    \n"
;
char *splash3Palette =
"$ #545CD6\n"
;
char *splash3Pixels =
"OOOOOOOO$$$$$$$OOOOOOOOOOOOOOOOOOOOO$$$$$$$$OOOOOOOO\n"
"OOOOOOOO$$$$$$$OOOOOOOOOOOOOOOOOOOOO$$$$$$$$OOOOOOOO\n"
"OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO\n"
"OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO\n"
"OOOOOOOOOOOOOOOOOOOOOO$$$$$$$OOOOOOOOOOOOOOOOOOOOOOO\n"
"OOOOOOOOOOOOOOOOOOOOOO$$$$$$$OOOOOOOOOOOOOOOOOOOOOOO\n"
"$$$$$$$$OOOOOOOOOOOOOO$$$$$$$OOOOOOOOOOOOOOO$$$$$$$O\n"
"$$$$$$$$OOOOOOOOOOOOOO$$$$$$$OOOOOOOOOOOOOOO$$$$$$$O\n"
"OOOOOOOO$$$$$$$OOOOOOOOOOOOOOOOOOOOO$$$$$$$$OOOOOOOO\n"
"OOOOOOOO$$$$$$$OOOOOOOOOOOOOOOOOOOOO$$$$$$$$OOOOOOOO\n"
"OOOOOOOOOOOOOOOOOOOOOO$$$$$$$OOOOOOOOOOOOOOOOOOOOOOO\n"
"OOOOOOOOOOOOOOOOOOOOOO$$$$$$$OOOOOOOOOOOOOOOOOOOOOOO\n"
"OOOOOOOOOOOOOOOOOOOOOO$$$$$$$OOOOOOOOOOOOOOOOOOOOOOO\n"
"OOOOOOOOOOOOOOOOOOOOOO$$$$$$$OOOOOOOOOOOOOOOOOOOOOOO\n"
;
char *bombPalette = 
//"  #527E2D\n"
". #AAAAAA\n"
"X #000000\n"
"o #4A4A4A\n"
"O #6F6F6F\n"
"+ #8E8E8E\n"
;
char *bombPixels = 
"                  \n"
"                  \n"
"                  \n"
"                  \n"
"                  \n"
"                  \n"
"   ....           \n"
"   ....           \n"
"       ...        \n"
"       ...        \n"
"          ....    \n"
"          ....    \n"
"          ....    \n"
"          ....    \n"
"       XXX        \n"
"       XXX        \n"
"   ooooooooooo    \n"
"   ooooooooooo    \n"
"   OOOOOOOOOOO    \n"
"   OOOOOOOOOOO    \n"
"++++++++++++++++++\n"
"++++++++++++++++++\n"
"++++++++++++++++++\n"
"++++++++++++++++++\n"
"   OOOOOOOOOOO    \n"
"   OOOOOOOOOOO    \n"
"   ooooooooooo    \n"
"   ooooooooooo    \n"
"       XXX        \n"
"       XXX        \n"
;
char *bomb2Palette =
"  #8E8E8E\n"
//". #527E2D\n"
"X #FC9090\n"
"o #AAAAAA\n"
"O #000000\n"
"+ #4A4A4A\n"
"@ #6F6F6F\n"
"# #A2A22A\n"
"$ #545CD6\n"
"% #86861D\n"
"& #69690F\n"
"* #FFFFFF\n"
;
char *bomb2Pixels = 
".......XXXX.......\n"
".......XXXX.......\n"
".......XXXXXXX....\n"
".......XXXXXXX....\n"
"...........XXX....\n"
"...........XXX....\n"
"...........ooo....\n"
"...........ooo....\n"
".......oooo.......\n"
".......oooo.......\n"
"....ooo...........\n"
"....ooo...........\n"
"....ooo...........\n"
"....ooo...........\n"
".......OOOO.......\n"
".......OOOO.......\n"
"....++++++++++....\n"
"....++++++++++....\n"
"....@@@@@@@@@@....\n"
"....@@@@@@@@@@....\n"
"                  \n"
"                  \n"
"                  \n"
"                  \n"
"....@@@@@@@@@@....\n"
"....@@@@@@@@@@....\n"
"....++++++++++....\n"
"....++++++++++....\n"
".......OOOO.......\n"
".......OOOO.......\n"
;
char *bomb3Palette =
"  #8E8E8E\n"
//". #527E2D\n"
"X #FC9090\n"
"o #AAAAAA\n"
"O #000000\n"
"+ #4A4A4A\n"
"@ #6F6F6F\n"
"# #A2A22A\n"
"$ #545CD6\n"
"% #86861D\n"
"& #69690F\n"
"* #FFFFFF\n"
;
char *bomb3Pixels =
"..................\n"
"..................\n"
"..................\n"
"..................\n"
"..................\n"
"..................\n"
"...oooo...........\n"
"...oooo...........\n"
".......oooo.......\n"
".......oooo.......\n"
"...........ooo....\n"
"...........ooo....\n"
"...........ooo....\n"
"...........ooo....\n"
".......OOOO.......\n"
".......OOOO.......\n"
"...+++++++++++....\n"
"...+++++++++++....\n"
"...@@@@@@@@@@@....\n"
"...@@@@@@@@@@@....\n"
"                  \n"
"                  \n"
"                  \n"
"                  \n"
"...@@@@@@@@@@@....\n"
"...@@@@@@@@@@@....\n"
"...+++++++++++....\n"
"...+++++++++++....\n"
".......OOOO.......\n"
".......OOOO.......\n"
;

@interface KaboomClone : IvarObject
{
    int _iteration;
    int _width;
    int _height;
    int _madBomberX;
    int _madBomberY;
    id _bombs;
    int _bucketX;
    int _bucketY;
    int _score;
    int _splash;
    int _droppingBombs;
    int _bombsExploding;
    id _bitmap;
}
@end

@implementation KaboomClone

- (id)init
{
    self = [super init];
    if (self) {
        _width = 640;
        _height = 400;
        _bitmap = [[[@"Bitmap" asClass] alloc] initWithWidth:_width height:_height];
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
    {
        double n = sin(M_PI/180.0*_iteration);
        _madBomberX = _width/2 + (_width/2)*0.8*n;
        _madBomberY = 50;
    }

    if (!_bucketX) {
        _bucketX = _width / 2;
    }
    _bucketY = _height-100;
    if (!_droppingBombs) {
        return;
    }
    int bucketHeight = [Definitions heightForCString:bucketPixels];
    Int4 bucketRect = [Definitions rectWithX:_bucketX y:_bucketY w:[Definitions widthForCString:bucketPixels] h:bucketHeight];

    if (_bombsExploding) {
        if (_bombsExploding % 5 == 0) {
            if ([_bombs length]) {
                [_bombs removeObjectAtIndex:0];
            }
            if (![_bombs length]) {
                _bombsExploding = 0;
                _droppingBombs = 0;
                return;
            }
        }
        _bombsExploding++;
    } else {
        _iteration++;
        if (_iteration % 29 == 0) {
            if (!_bombs) {
                [self setValue:nsarr() forKey:@"bombs"];
            }
            id bomb = nsdict();
            [bomb setValue:nsfmt(@"%d", _madBomberX+3) forKey:@"x"];
            [bomb setValue:nsfmt(@"%d", _madBomberY+46-14) forKey:@"y"];
            [_bombs addObject:bomb];
        }
        for (int i=0; i<[_bombs count]; i++) {
            id bomb = [_bombs nth:i];
            [bomb setValue:nsfmt(@"%d", [bomb intValueForKey:@"y"]+3) forKey:@"y"];
        }
        int bombWidth = [Definitions widthForCString:bombPixels];
        int bombHeight = [Definitions heightForCString:bombPixels];
        for (int i=0; i<[_bombs count]; i++) {
            id bomb = [_bombs nth:i];
            int x = [bomb intValueForKey:@"x"];
            int y = [bomb intValueForKey:@"y"];
            Int4 bombRect = [Definitions rectWithX:x y:y w:bombWidth h:bombHeight];
            if (y >= _height-bombHeight) {
                _bombsExploding = 1;
            }
            if ([Definitions doesRect:bombRect intersectRect:bucketRect]) {
                [bomb setValue:@"1" forKey:@"caught"];
                _splash += 5;
                _score++;
            }
        }
        id keepBombs = nsarr();
        for (int i=0; i<[_bombs count]; i++) {
            id bomb = [_bombs nth:i];
            if (![bomb intValueForKey:@"caught"]) {
                [keepBombs addObject:bomb];
            }
        }
        [self setValue:keepBombs forKey:@"bombs"];
    }
}

- (void)updateBitmap
{
    id bitmap = _bitmap;
    [bitmap setColor:@"#527E2D"];
    [bitmap fillRect:[Definitions rectWithX:0 y:0 w:_width h:_height]];
    
    [bitmap drawCString:madBomberPixels palette:madBomberPalette x:_madBomberX y:_madBomberY];

    id firstBomb = [_bombs nth:0];

    for (int i=0; i<[_bombs count]; i++) {
        id elt = [_bombs nth:i];
        if (_bombsExploding && (elt == firstBomb)) {
            if (_bombsExploding % 5 == 0) {
                [bitmap setColorIntR:0 g:0 b:0 a:255];
            } else if (_bombsExploding % 5 == 1) {
                [bitmap setColorIntR:255 g:0 b:0 a:255];
            } else if (_bombsExploding % 5 == 2) {
                [bitmap setColorIntR:0 g:255 b:0 a:255];
            } else if (_bombsExploding % 5 == 3) {
                [bitmap setColorIntR:0 g:0 b:255 a:255];
            } else {
                [bitmap setColorIntR:255 g:255 b:255 a:255];
            }
            [bitmap drawBitmapText:@"EXPLODE" x:[elt intValueForKey:@"x"] y:[elt intValueForKey:@"y"]];
    
            continue;
        }

        char *palette;
        char *pixels;
        if ((_iteration/3) % 3 == 0) {
            palette = bombPalette;
            pixels = bombPixels;
        } else if ((_iteration/3) % 3 == 1) {
            palette = bomb2Palette;
            pixels = bomb2Pixels;
        } else {
            palette = bomb3Palette;
            pixels = bomb3Pixels;
        }
        [bitmap drawCString:pixels palette:palette x:[elt intValueForKey:@"x"] y:[elt intValueForKey:@"y"]];
        [bitmap setColor:@"black"];
//        [bitmap strokeRectX:[elt intValueForKey:@"x"] y:[elt intValueForKey:@"y"]-[Definitions heightForCString:bombPixels]+1 w:[Definitions widthForCString:bombPixels] h:[Definitions heightForCString:bombPixels]];
    }
    [bitmap drawCString:bucketPixels palette:bucketPalette x:_bucketX y:_bucketY];
    [bitmap setColor:@"black"];
//    [bitmap strokeRectX:_bucketX y:_bucketY-[Definitions heightForCString:bucketPixels]+1 w:[Definitions widthForCString:bucketPixels] h:[Definitions heightForCString:bucketPixels]];
    if (_splash) {
        if ((_splash) % 3 == 0) {
            [bitmap drawCString:splashPixels palette:splashPalette x:_bucketX y:_bucketY-[Definitions heightForCString:splashPixels]];
        } else if ((_splash) % 3 == 1) {
            [bitmap drawCString:splash2Pixels palette:splash2Palette x:_bucketX y:_bucketY-[Definitions heightForCString:splash2Pixels]];
        } else if ((_splash) % 3 == 2) {
            [bitmap drawCString:splash3Pixels palette:splash3Palette x:_bucketX y:_bucketY-[Definitions heightForCString:splash3Pixels]];
        } 
        _splash--;
    }

    [bitmap setColorIntR:255 g:255 b:255 a:255];
    [bitmap drawBitmapText:nsfmt(@"Score: %d", _score) x:10.0 y:20.0];

}

- (void)handleMouseDown:(id)event
{
    NSLog(@"handleMouseDown");
    if (!_droppingBombs) {
        _droppingBombs = 1;
    }
}

- (void)handleMouseMoved:(id)event
{
    int x = [event intValueForKey:@"mouseX"];
    int viewWidth = [event intValueForKey:@"viewWidth"];
    x /= (double)viewWidth / (double)_width;
    _bucketX = x;
    if (_bucketX < 0) {
        _bucketX = 0;
    }
    int bucketWidth = [Definitions widthForCString:bucketPixels];
    if (_bucketX > _width - bucketWidth) {
        _bucketX = _width - bucketWidth;
    }
}
- (void)handleTouchesBegan:(id)event
{
    if (!_droppingBombs) {
        _droppingBombs = 1;
    }
}
- (void)handleTouchesMoved:(id)event
{
    int x = [event intValueForKey:@"touchX"];
    _bucketX = x;
}

- (void)handleScrollWheel:(id)event
{
    NSLog(@"scrollWheel:");
    int dx = [event intValueForKey:@"scrollingDeltaX"];
    NSLog(@"dx %d", dx);
    _bucketX -= dx;
}

@end
