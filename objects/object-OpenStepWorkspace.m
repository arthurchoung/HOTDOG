/*

 HOT DOG Linux

 Copyright (c) 2024 Arthur Choung. All rights reserved.

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

static char *scrollBarPalette =
"  #000000\n"
". #555555\n"
"o #AAAAAA\n"
;

static char *scrollBarMiddlePixels =
" oo.o.o.o.o.o.o.o.o \n"
" o.o.o.o.o.o.o.o.oo \n"
;
static char *scrollBarBottomPixels =
" oooooooooooooooooo \n"
;

static char *leftBorderPalette =
". #555555\n"
"o #AAAAAA\n"
;

static char *leftBorderPixels =
"oooooooo.\n"
;

static char *rightBorderPalette =
"o #AAAAAA\n"
"O #ffffff\n"
;

static char *rightBorderPixels =
"Ooooooooo"
;

static char *topOfBoxPalette =
"  #000000\n"
". #555555\n"
"o #AAAAAA\n"
"O #ffffff\n"
;
static char *topOfBoxLeftPixels =
"oooooooo.\n"
"oooooooo.\n"
;
static char *topOfBoxMiddlePixels =
".\n"
" \n"
;
static char *topOfBoxRightPixels =
".Ooooooooo\n"
".Ooooooooo\n"
;

static char *bottomOfMiddleBoxPalette =
"  #000000\n"
". #555555\n"
"X #555577\n"
"o #AAAAAA\n"
"O #ffffff\n"
;
static char *bottomOfMiddleBoxLeftPixels =
"oooooooo.  \n"
"oooooooo. o\n"
"oooooooo. o\n"
"oooooooo. o\n"
"oooooooo. o\n"
"oooooooo. o\n"
"oooooooo. o\n"
"oooooooo. o\n"
"oooooooo. o\n"
"oooooooo. o\n"
"oooooooo. o\n"
"oooooooo. o\n"
"oooooooo. o\n"
"oooooooo. o\n"
"oooooooo. o\n"
"oooooooo. o\n"
"oooooooo. o\n"
"oooooooo. o\n"
"oooooooo..o\n"
"ooooooooOOO\n"
;
static char *bottomOfMiddleBoxMiddlePixels =
"  \n"
"oo\n"
".o\n"
"o.\n"
".o\n"
"o.\n"
".o\n"
"o.\n"
".o\n"
"o.\n"
".o\n"
"o.\n"
".o\n"
"o.\n"
".o\n"
"o.\n"
".o\n"
"o.\n"
"oo\n"
"OO\n"
;
static char *bottomOfMiddleBoxRightPixels =
" oOoooooooo\n"
"ooOoooooooo\n"
"ooOoooooooo\n"
"ooOoooooooo\n"
"ooOoooooooo\n"
"ooOoooooooo\n"
"ooOoooooooo\n"
"ooOoooooooo\n"
"ooOoooooooo\n"
"ooOoooooooo\n"
"ooOoooooooo\n"
"ooOoooooooo\n"
"ooOoooooooo\n"
"ooOoooooooo\n"
"ooOoooooooo\n"
"ooOoooooooo\n"
"ooOoooooooo\n"
"ooOoooooooo\n"
"ooOoooooooo\n"
"OOOoooooooo\n"
;

static char *borderMiddleBoxPalette =
"  #000000\n"
". #555555\n"
"o #AAAAAA\n"
"O #ffffff\n"
;
static char *leftBorderMiddleBoxPixels =
"oooooooo. \n"
;
static char *rightBorderMiddleBoxPixels =
"Ooooooooo\n"
;

static char *topOfMiddleBoxPalette =
"  #000000\n"
". #555555\n"
"o #AAAAAA\n"
"O #ffffff\n"
;
static char *topOfMiddleBoxLeftPixels =
"oooooooo.\n"
"oooooooo.\n"
;
static char *topOfMiddleBoxMiddlePixels =
".\n"
" \n"
;
static char *topOfMiddleBoxRightPixels =
".Ooooooooo\n"
".Ooooooooo\n"
;

static char *chevronPalette =
"b #000000\n"
". #555555\n"
"X #AAAAAA\n"
"o #ffffff\n"
;
static char *chevronPixels =
"b.     \n"
"bX..   \n"
"bXXX.. \n"
"bXXXXXo\n"
"bXXXoo \n"
"bXoo   \n"
"bo     \n"
;
static char *shelfKnobPalette =
"b #000000\n"
". #555555\n"
"X #AAAAAA\n"
"o #ffffff\n"
;
static char *shelfKnobPixels =
"      \n"
"      \n"
" .bbb \n"
".b....\n"
"b..XXX\n"
"b.XXoo\n"
"b.Xooo\n"
" .Xoo \n"
"      \n"
"      \n"
;

static char *amigaDrawerIconPalette =
"b #000000\n"
". #000022\n"
"* #ff8800\n"
"X #0055aa\n"
"o #ffffff\n"
;

static char *amigaDrawerIconPixels =
"              ...........................................................\n"
"              ...........................................................\n"
"          ....oooooooooooooooooooooooooooooooooooooooooooooooooooooo...o.\n"
"          ....oooooooooooooooooooooooooooooooooooooooooooooooooooooo...o.\n"
"      ....oooooooooooooooooooooooooooooooooooooooooooooooooooooooo...oo..\n"
"      ....oooooooooooooooooooooooooooooooooooooooooooooooooooooooo...oo..\n"
"   ................................................................ooo.o.\n"
"   ................................................................ooo.o.\n"
"   ..oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo..oooo..\n"
"   ..oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo..oooo..\n"
"   ..ooo......................................................ooo..ooo.o.\n"
"   ..ooo......................................................ooo..ooo.o.\n"
"   ..ooo..oooooooooooooooooooooooooooooooooooooooooooooooooo..ooo..oo.o..\n"
"   ..ooo..oooooooooooooooooooooooooooooooooooooooooooooooooo..ooo..oo.o..\n"
"   ..ooo..oooooooooooooooooooooooooooooooooooooooooooooooooo..ooo..ooo.o.\n"
"   ..ooo..oooooooooooooooooooooooooooooooooooooooooooooooooo..ooo..ooo.o.\n"
"   ..ooo..ooooooooooooooooo...oooooooooo...ooooooooooooooooo..ooo..oo.o..\n"
"   ..ooo..ooooooooooooooooo...oooooooooo...ooooooooooooooooo..ooo..oo.o..\n"
"   ..ooo..oooooooooooooooo................oooooooooooooooooo..ooo..o.o.. \n"
"   ..ooo..oooooooooooooooo................oooooooooooooooooo..ooo..o.o.. \n"
"   ..ooo..oooooooooooooooooooooooooooooooooooooooooooooooooo..ooo..oo..  \n"
"   ..ooo..oooooooooooooooooooooooooooooooooooooooooooooooooo..ooo..oo..  \n"
"   ..ooo..oooooooooooooooooooooooooooooooooooooooooooooooooo..ooo..o..   \n"
"   ..ooo..oooooooooooooooooooooooooooooooooooooooooooooooooo..ooo..o..   \n"
"   ..ooo......................................................ooo....    \n"
"   ..ooo......................................................ooo....    \n"
"   ..oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo...     \n"
"   ..oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo...     \n"
"   ................................................................      \n"
"   ................................................................      \n"
"                                                                         \n"
"                                                                         \n"
"                                                                         \n"
"                                                                         \n"
;
static char *amigaOpenDrawerIconPalette =
"b #000000\n"
". #000022\n"
"* #ff8800\n"
"X #0055aa\n"
"o #ffffff\n"
;

static char *amigaOpenDrawerIconPixels =
"              ...........................................................\n"
"              ...........................................................\n"
"          ....oooooooooooooooooooooooooooooooooooooooooooooooooooooo...o.\n"
"          ....oooooooooooooooooooooooooooooooooooooooooooooooooooooo...o.\n"
"      ....oooooooooooooooooooooooooooooooooooooooooooooooooooooooo...oo..\n"
"      ....oooooooooooooooooooooooooooooooooooooooooooooooooooooooo...oo..\n"
"   ................................................................ooo.o.\n"
"   ................................................................ooo.o.\n"
"   ..oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo..oooo..\n"
"   ..oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo..oooo..\n"
"   ..ooo......................................................ooo..ooo.o.\n"
"   ..ooo......................................................ooo..ooo.o.\n"
"   ..o...  .. . . . . . . . . . . . . . . . . . . . . . . ....ooo..oo.o..\n"
"   ..o...  .. . . . . . . . . . . . . . . . . . . . . . . ....ooo..oo.o..\n"
"  .... . . ..  . . . . . . . . . . . . . . . . . . . . . ..o..ooo..ooo.o.\n"
"  .... . . ..  . . . . . . . . . . . . . . . . . . . . . ..o..ooo..ooo.o.\n"
"..........................................................oo..ooo..oo.o..\n"
"..........................................................oo..ooo..oo.o..\n"
"..oooooooooooooooooooooooooooooooooooooooooooooooooooooo..oo..ooo..o.o.. \n"
"..oooooooooooooooooooooooooooooooooooooooooooooooooooooo..oo..ooo..o.o.. \n"
"..oooooooooooooooooooooooooooooooooooooooooooooooooooooo..oo..ooo..oo..  \n"
"..oooooooooooooooooooooooooooooooooooooooooooooooooooooo..oo..ooo..oo..  \n"
"..oooooooooooooooooooooooooooooooooooooooooooooooooooooo..oo..ooo..o..   \n"
"..oooooooooooooooooooooooooooooooooooooooooooooooooooooo..oo..ooo..o..   \n"
"..ooooooooooooooooooo...oooooooooo...ooooooooooooooooooo..oo..ooo....    \n"
"..ooooooooooooooooooo...oooooooooo...ooooooooooooooooooo..oo..ooo....    \n"
"..oooooooooooooooooo................oooooooooooooooooooo..o..oooo...     \n"
"..oooooooooooooooooo................oooooooooooooooooooo..o..oooo...     \n"
"..oooooooooooooooooooooooooooooooooooooooooooooooooooooo...........      \n"
"..oooooooooooooooooooooooooooooooooooooooooooooooooooooo...........      \n"
"..oooooooooooooooooooooooooooooooooooooooooooooooooooooo...              \n"
"..oooooooooooooooooooooooooooooooooooooooooooooooooooooo...              \n"
"..........................................................               \n"
"..........................................................               \n"
;





static char *macFolderIconPalette =
"b #000000\n"
". #ffffff\n"
;
static char *macFolderIconPixels =
"     bbbbbbb                   \n"
"    b.......b                  \n"
"   b.........b                 \n"
"  b...........b                \n"
" bbbbbbbbbbbbbbbbbbbbbbbbbbbbb \n"
"b.............................b\n"
"b.............................b\n"
"b.............................b\n"
"b.............................b\n"
"b.............................b\n"
"b.............................b\n"
"b.............................b\n"
"b.............................b\n"
"b.............................b\n"
"b.............................b\n"
"b.............................b\n"
"b.............................b\n"
"b.............................b\n"
"b.............................b\n"
"b.............................b\n"
"b.............................b\n"
"b.............................b\n"
"b.............................b\n"
"b.............................b\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
;

static char *amigaComputerIconPalette =
". #000022\n"
"X #FF8800\n"
"o #ffffff\n"
;
static char *amigaComputerIconPixels =
" ............................................................. \n"
" ............................................................. \n"
"..oooooooooooooooo.ooooooooooooooooooooo.oooooooooooooooooooo..\n"
"..oooooooooooooooo.ooooooooooooooooooooo.oooooooooooooooooooo..\n"
"..oooooooooooooooo.ooooooooooooooooooooo.ooo..............ooo..\n"
"..oooooooooooooooo.ooooooooooooooooooooo.ooo..............ooo..\n"
"..oooooooooooooooo.ooooooooooooooooooooo.oooooooooooooooooooo..\n"
"..oooooooooooooooo.ooooooooooooooooooooo.oooooooooooooooooooo..\n"
"..ooXXoooooooooooo.ooooooooooooooooooooo.ooooooooooooooooXXoo..\n"
"..ooXXoooooooooooo.ooooooooooooooooooooo.ooooooooooooooooXXoo..\n"
"..oooooooooooooooo.ooooooooooooooooooooo.oooooooooooooooooooo..\n"
"..oooooooooooooooo.ooooooooooooooooooooo.oooooooooooooooooooo..\n"
" ..oo.....................................................oo.. \n"
" ..oo.....................................................oo.. \n"
"  ....                                                   ....  \n"
"  ....                                                   ....  \n"
;
static char *macComputerIconPalette =
"b #000000\n"
". #ffffff\n"
;
static char *macComputerIconPixels =
"  bbbbbbbbbbbbbbbbbbbbb  \n"
" b.....................b \n"
"b.......................b\n"
"b...bbbbbbbbbbbbbbbbb...b\n"
"b..b.................b..b\n"
"b..b.................b..b\n"
"b..b.................b..b\n"
"b..b....b...b...b....b..b\n"
"b..b....b...b...b....b..b\n"
"b..b........b........b..b\n"
"b..b........b........b..b\n"
"b..b.......bb........b..b\n"
"b..b.................b..b\n"
"b..b.....b....b......b..b\n"
"b..b......bbbb.......b..b\n"
"b..b.................b..b\n"
"b..b.................b..b\n"
"b...bbbbbbbbbbbbbbbbb...b\n"
"b.......................b\n"
"b.......................b\n"
"b.......................b\n"
"b.......................b\n"
"b..bb..........bbbbbb...b\n"
"b.......................b\n"
"b.......................b\n"
"b.......................b\n"
"b.......................b\n"
" bbbbbbbbbbbbbbbbbbbbbbb \n"
" b.....................b \n"
" b.....................b \n"
" b.....................b \n"
" bbbbbbbbbbbbbbbbbbbbbbb \n"
;



@implementation Definitions(fmeklwfmklsdmklfmsdkfl)
+ (id)OpenStepWorkspace
{
    id obj = [@"OpenStepWorkspace" asInstance];
    [obj updateColumns];
    return obj;
}
@end

@interface OpenStepWorkspace : IvarObject
{
    id _columns;
    int _mouseDown;
    int _mouseDownX;
    int _mouseDownY;
    id _iconMode;
    int _numberOfColumns;
    id _command;
}
@end
@implementation OpenStepWorkspace
- (id)init
{
    self = [super init];
    if (self) {
        _numberOfColumns = 3;
    }
    return self;
}
- (id)contextualMenu
{
    id arr = nsarr();
    id dict;
    dict = nsdict();
    [dict setValue:@"addColumn" forKey:@"messageForClick"];
    [dict setValue:@"Add Column" forKey:@"displayName"];
    [arr addObject:dict];
    dict = nsdict();
    [dict setValue:@"removeColumn" forKey:@"messageForClick"];
    [dict setValue:@"Remove Column" forKey:@"displayName"];
    [arr addObject:dict];
    dict = nsdict();
    [arr addObject:dict];
    dict = nsdict();
    [dict setValue:@"setValue:'mac' forKey:'iconMode'" forKey:@"messageForClick"];
    [dict setValue:@"Use Mac icons" forKey:@"displayName"];
    [arr addObject:dict];
    dict = nsdict();
    [dict setValue:@"setValue:'amiga' forKey:'iconMode'" forKey:@"messageForClick"];
    [dict setValue:@"Use Amiga icons" forKey:@"displayName"];
    [arr addObject:dict];
    dict = nsdict();
    [dict setValue:@"setNilValueForKey:'iconMode'" forKey:@"messageForClick"];
    [dict setValue:@"Use default icons" forKey:@"displayName"];
    [arr addObject:dict];
    dict = nsdict();
    [arr addObject:dict];
    dict = nsdict();
    [dict setValue:@"setValue:['hotdog-testListObjC.pl'] forKey:'command';updateColumns" forKey:@"messageForClick"];
    [dict setValue:@"Use hotdog-testListObjC.pl command" forKey:@"displayName"];
    [arr addObject:dict];
    dict = nsdict();
    [dict setValue:@"setNilValueForKey:'command';updateColumns" forKey:@"messageForClick"];
    [dict setValue:@"Use default command" forKey:@"displayName"];
    [arr addObject:dict];
    return arr;
}
- (void)addColumn
{
    _numberOfColumns++;
}
- (void)removeColumn
{
    _numberOfColumns--;
    if (_numberOfColumns < 1) {
        _numberOfColumns = 1;
    }
}
- (id)runCommandForPath:(id)path
{
    id cmd = nsarr();
//    [cmd addObject:@"hotdog-testListObjC.pl"];
    if ([_command count]) {
        [cmd addObjectsFromArray:_command];
    } else {
        [cmd addObject:@"ls"];
        [cmd addObject:@"-p"];
        [cmd addObject:@"-L"];
    }
    [cmd addObject:path];
    return [[[cmd runCommandAndReturnOutput] asString] split:@"\n"];
}
- (void)updateColumns
{
    id pathName = @"/";
    id results = [self runCommandForPath:pathName];
    id arr = nsarr();
    for (int i=0; i<[results count]; i++) {
        id elt = [results nth:i];
        id dict = nsdict();
        [dict setValue:elt forKey:@"displayName"];
        [arr addObject:dict];
    }
    id columns = nsarr();
    id dict = nsdict();
    [dict setValue:pathName forKey:@"filePath"];
    [dict setValue:arr forKey:@"array"];
    [columns addObject:dict];

    [self setValue:columns forKey:@"columns"];
}
- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    int columnWidth = 200;
    if (_numberOfColumns) {
        int topOfBoxLeftWidth = [Definitions widthForCString:topOfBoxLeftPixels];
        int topOfBoxRightWidth = [Definitions widthForCString:topOfBoxRightPixels];
        columnWidth = (r.w-topOfBoxLeftWidth-topOfBoxRightWidth)/_numberOfColumns;//200;
    }

    [bitmap setColor:@"#aaaaaa"];
    [bitmap fillRect:r];

    int cursorY = r.y+76;

    int shelfKnobWidth = [Definitions widthForCString:shelfKnobPixels];
    [bitmap drawCString:shelfKnobPixels palette:shelfKnobPalette x:r.x+(r.w-shelfKnobWidth)/2 y:cursorY];
    cursorY += [Definitions heightForCString:shelfKnobPixels];

    [Definitions drawInBitmap:bitmap left:topOfMiddleBoxLeftPixels middle:topOfMiddleBoxMiddlePixels right:topOfMiddleBoxRightPixels x:r.x y:cursorY w:r.w palette:topOfMiddleBoxPalette];
    cursorY += [Definitions heightForCString:topOfMiddleBoxMiddlePixels];

    int middleBoxY = cursorY;

    [Definitions drawInBitmap:bitmap top:leftBorderMiddleBoxPixels palette:borderMiddleBoxPalette middle:leftBorderMiddleBoxPixels palette:borderMiddleBoxPalette bottom:leftBorderMiddleBoxPixels palette:borderMiddleBoxPalette x:r.x y:cursorY h:76];
    int rightBorderMiddleBoxWidth = [Definitions widthForCString:rightBorderMiddleBoxPixels];
    [Definitions drawInBitmap:bitmap top:rightBorderMiddleBoxPixels palette:borderMiddleBoxPalette middle:rightBorderMiddleBoxPixels palette:borderMiddleBoxPalette bottom:rightBorderMiddleBoxPixels palette:borderMiddleBoxPalette x:r.x+r.w-rightBorderMiddleBoxWidth y:cursorY h:76];
    cursorY += 76;

    [Definitions drawInBitmap:bitmap left:bottomOfMiddleBoxLeftPixels middle:bottomOfMiddleBoxMiddlePixels right:bottomOfMiddleBoxRightPixels x:r.x y:cursorY w:r.w palette:bottomOfMiddleBoxPalette];
    cursorY += [Definitions heightForCString:bottomOfMiddleBoxMiddlePixels];

    cursorY += 6;

    [Definitions drawInBitmap:bitmap left:topOfBoxLeftPixels middle:topOfBoxMiddlePixels right:topOfBoxRightPixels x:r.x y:cursorY w:r.w palette:topOfBoxPalette];
    cursorY += [Definitions heightForCString:topOfBoxMiddlePixels];

    int leftBorderWidth = [Definitions widthForCString:leftBorderPixels];
    int rightBorderWidth = [Definitions widthForCString:rightBorderPixels];

    [Definitions drawInBitmap:bitmap top:leftBorderPixels palette:leftBorderPalette middle:leftBorderPixels palette:leftBorderPalette bottom:leftBorderPixels palette:leftBorderPalette x:r.x y:cursorY h:r.h];

    int columnY = cursorY;
    for (int x=0; x<(r.w-leftBorderWidth-rightBorderWidth); x+=columnWidth) {
        [Definitions drawInBitmap:bitmap top:scrollBarMiddlePixels palette:scrollBarPalette middle:scrollBarMiddlePixels palette:scrollBarPalette bottom:scrollBarBottomPixels palette:scrollBarPalette x:r.x+leftBorderWidth+x y:cursorY h:r.h];
    }

    [Definitions drawInBitmap:bitmap top:rightBorderPixels palette:rightBorderPalette middle:rightBorderPixels palette:rightBorderPalette bottom:rightBorderPixels palette:rightBorderPalette x:r.x+r.w-rightBorderWidth y:cursorY h:r.h];



    int scrollBarWidth = [Definitions widthForCString:scrollBarMiddlePixels];

    int textHeight = [bitmap bitmapHeightForText:@"X"];
    for (int i=0; i<[_columns count]; i++) {
        id column = [_columns nth:i];
        int x = r.x+leftBorderWidth+columnWidth*i+2+scrollBarWidth;
        int w = columnWidth-scrollBarWidth-2-2;


        int chevronWidth = [Definitions widthForCString:chevronPixels];
        int chevronHeight = [Definitions heightForCString:chevronPixels];

        {
            id filePath = [column valueForKey:@"filePath"];

            char *pixels;
            char *palette;
            int iconWidth;
            int iconHeight;
            if ([_iconMode isEqual:@"mac"]) {
                if ([filePath isEqual:@"/"]) {
                    pixels = macComputerIconPixels;
                    palette = macComputerIconPalette;
                } else {
                    pixels = macFolderIconPixels;
                    palette = macFolderIconPalette;
                }
            } else {
                if ([filePath isEqual:@"/"]) {
                    pixels = amigaComputerIconPixels;
                    palette = amigaComputerIconPalette;
                } else {
                    pixels = amigaOpenDrawerIconPixels;
                    palette = amigaOpenDrawerIconPalette;
                }
            }
            iconWidth = [Definitions widthForCString:pixels];
            iconHeight = [Definitions heightForCString:pixels];

            int y = middleBoxY+(76-2-iconHeight-textHeight)/2;

            [bitmap drawCString:pixels palette:palette x:x+(w-iconWidth)/2 y:y];
            [bitmap setColor:@"black"];
            id text = [filePath lastPathComponent];
            int textWidth = [bitmap bitmapWidthForText:text];
            [bitmap drawBitmapText:text x:x+(w-textWidth)/2 y:y+iconHeight+2];

            if (i+1 < [_columns count]) {
                [bitmap drawCString:chevronPixels palette:chevronPalette x:x+w-2-chevronWidth y:middleBoxY+26];
            }
        }


        id arr = [column valueForKey:@"array"];
        for (int j=0; j<[arr count]; j++) {
            id elt = [arr nth:j];
            id displayName = [elt valueForKey:@"displayName"];
            displayName = [[[bitmap fitBitmapString:displayName width:w-2-chevronWidth-4] split:@"\n"] nth:0];
            int y = columnY+2+textHeight*j;
            int isSelected = [elt intValueForKey:@"isSelected"];
            if (isSelected) {
                [bitmap setColor:@"white"];
                [bitmap fillRectangleAtX:x y:y w:w h:textHeight];
            }
            [bitmap setColor:@"black"];
            [bitmap drawBitmapText:displayName x:x y:y];

            if ([displayName hasSuffix:@"/"]) {
                [bitmap drawCString:chevronPixels palette:chevronPalette x:x+w-2-chevronWidth y:y+(textHeight-chevronHeight)/2];
            }

            [elt setValue:nsfmt(@"%d", x) forKey:@"x"];
            [elt setValue:nsfmt(@"%d", y) forKey:@"y"];
            [elt setValue:nsfmt(@"%d", w) forKey:@"w"];
            [elt setValue:nsfmt(@"%d", textHeight) forKey:@"h"];
        }
    }
}
- (void)handleMouseDown:(id)event
{
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    for (int i=0; i<[_columns count]; i++) {
        id column = [_columns nth:i];
        id arr = [column valueForKey:@"array"];
        for (int j=0; j<[arr count]; j++) {
            id elt = [arr nth:j];
            Int4 r;
            r.x = [elt intValueForKey:@"x"];
            r.y = [elt intValueForKey:@"y"];
            r.w = [elt intValueForKey:@"w"];
            r.h = [elt intValueForKey:@"h"];
            if ([Definitions isX:mouseX y:mouseY insideRect:r]) {
                for (int k=0; k<[arr count]; k++) {
                    [[arr nth:k] setValue:nil forKey:@"isSelected"];
                }
                [elt setValue:@"1" forKey:@"isSelected"];
                _mouseDown = 1;
                _mouseDownX = mouseX;
                _mouseDownY = mouseY;
                return;
            }
        }
    }
}
- (void)handleMouseMoved:(id)event
{
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    if (_mouseDown) {
        for (int i=0; i<[_columns count]; i++) {
            id column = [_columns nth:i];
            id arr = [column valueForKey:@"array"];
            for (int j=0; j<[arr count]; j++) {
                id elt = [arr nth:j];
                Int4 r;
                r.x = [elt intValueForKey:@"x"];
                r.y = [elt intValueForKey:@"y"];
                r.w = [elt intValueForKey:@"w"];
                r.h = [elt intValueForKey:@"h"];
                if ([Definitions isX:mouseX y:mouseY insideRect:r]) {
                    [elt setValue:@"1" forKey:@"isSelected"];
                    return;
                }
            }
        }
    }
}
- (void)handleMouseUp:(id)event
{
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    if (_mouseDown) {
        _mouseDown = 0;
        for (int i=0; i<[_columns count]; i++) {
            id column = [_columns nth:i];
            id arr = [column valueForKey:@"array"];
            for (int j=0; j<[arr count]; j++) {
                id elt = [arr nth:j];
                Int4 r;
                r.x = [elt intValueForKey:@"x"];
                r.y = [elt intValueForKey:@"y"];
                r.w = [elt intValueForKey:@"w"];
                r.h = [elt intValueForKey:@"h"];
                if ([Definitions isX:_mouseDownX y:_mouseDownY insideRect:r]) {
                    for (int k=0; k<[arr count]; k++) {
                        id kelt = [arr nth:k];
                        int isSelected = [kelt intValueForKey:@"isSelected"];
                        if (isSelected) {
                            for (int l=[_columns count]-1; l>i; l--) {
                                [_columns removeObjectAtIndex:l];
                            }

                            id pathName = nsfmt(@"%@/%@", [column valueForKey:@"filePath"], [kelt valueForKey:@"displayName"]);
                            id results = [self runCommandForPath:pathName];
                            id arr = nsarr();
                            for (int i=0; i<[results count]; i++) {
                                id elt = [results nth:i];
                                id dict = nsdict();
                                [dict setValue:elt forKey:@"displayName"];
                                [arr addObject:dict];
                            }
                            id dict = nsdict();
                            [dict setValue:pathName forKey:@"filePath"];
                            [dict setValue:arr forKey:@"array"];
                            [_columns addObject:dict];

                        }
                    }
                    return;
                }
            }
        }
    }
}
@end

