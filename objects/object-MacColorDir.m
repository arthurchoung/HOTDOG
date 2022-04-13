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

#include <sys/time.h>

static id folderPalette =
@"b #000000\n"
@". #9999ff\n"
@"X #ccccff\n"
@"o #ffffff\n"
;
static id selectedFolderPalette = 
@"b #000000\n"
@". #26267f\n"
@"X #33337f\n"
@"o #7f7f7f\n"
;
static id folderPixels =
@"     bbbbbbb                   \n"
@"    bXXXXXXXb                  \n"
@"   bXXXXXXXXXb                 \n"
@"  bXXXXXXXXXXXb                \n"  
@" bXXXXXXXXXXXXXbbbbbbbbbbbbbbb \n"
@"bXXXXXXXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"booooooooooooooooooooooooooooob\n"
@"boXoXoXoXoXoXoXoXoXoXoXoXoXoX.b\n"
@"bXoXoXoXoXoXoXoXoXoXoXoXoXoXo.b\n"
@"boXoXoXoXoXoXoXoXoXoXoXoXoXoX.b\n"
@"bXoXoXoXoXoXoXoXoXoXoXoXoXoXo.b\n"
@"boXoXoXoXoXoXoXoXoXoXoXoXoXoX.b\n"
@"bXoXoXoXoXoXoXoXoXoXoXoXoXoXo.b\n"
@"boXoXoXoXoXoXoXoXoXoXoXoXoXoX.b\n"
@"bXoXoXoXoXoXoXoXoXoXoXoXoXoXo.b\n"
@"boXoXoXoXoXoXoXoXoXoXoXoXoXoX.b\n"
@"bXoXoXoXoXoXoXoXoXoXoXoXoXoXo.b\n"
@"boXoXoXoXoXoXoXoXoXoXoXoXoXoX.b\n"
@"bXoXoXoXoXoXoXoXoXoXoXoXoXoXo.b\n"
@"boXoXoXoXoXoXoXoXoXoXoXoXoXoX.b\n"
@"bXoXoXoXoXoXoXoXoXoXoXoXoXoXo.b\n"
@"boXoXoXoXoXoXoXoXoXoXoXoXoXoX.b\n"
@"bXoXoXoXoXoXoXoXoXoXoXoXoXoXo.b\n"
@"boXoXoXoXoXoXoXoXoXoXoXoXoXoX.b\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
;

static id documentPalette =
@"b #000000\n"
@". #cccccc\n"
@"X #eeeeee\n"
@"o #ffffff\n"
;
static id selectedDocumentPalette =
@"b #000000\n"
@". #666666\n"
@"X #777777\n"
@"o #ffffff\n"
;
static id documentPixels =
@"bbbbbbbbbbbbbbbbbbb      \n"
@"bXXXXXXXXXXXXXXXXXbb     \n"
@"bXXXXXXXXXXXXXXXXXb.b    \n"
@"bXXXXXXXXXXXXXXXXXb..b   \n"
@"bXXXXXXXXXXXXXXXXXb...b  \n"
@"bXXXXXXXXXXXXXXXXXb....b \n"
@"bXXXXXXXXXXXXXXXXXbbbbbbb\n"
@"bXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"bXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"bXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"bXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"bXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"bXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"bXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"bXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"bXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"bXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"bXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"bXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"bXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"bXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"bXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"bXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"bXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"bXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"bXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"bXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"bXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"bXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"bXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"bXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbb\n"
;
static id readmePalette =
@"b #000000\n"
@". #777777\n"
@"X #888888\n"
@"o #eeeeee\n"
@"O #ffffff\n"
;
static id selectedReadmePalette =
@"b #000000\n"
@". #3b3b3b\n"
@"X #444444\n"
@"o #777777\n"
@"O #7f7f7f\n"
;
static id readmePixels =
@"OOOOOOOOOOOOOOOOOOOOOOOOOOOOOO \n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbb \n"
@"boooooooooooooooooooooooooooobO\n"
@"bo....ooOboooooooooooooo....obb\n"
@"boooooooboobbobbbobbobboooooobb\n"
@"bo....obobobbobobobbobbo....obb\n"
@"bo....oooooboooooooooboo....obb\n"
@"boooooooooooooooooooooooooooobb\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"boooooooooooooooooooooooooooobb\n"
@"boobbboboobobbbboobbooobboobobb\n"
@"boobooooobooooooobooboboobobobb\n"
@"booooooobooooboooooboobobbooobb\n"
@"boobobobooboobooobooboboobobobb\n"
@"boooooooooooooooooooooooooooobb\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"boooooooooooooooooooooooooooobb\n"
@"bo......oobbbbbbbbbboo......obb\n"
@"bo......obObOOOOOOOObo......obb\n"
@"boooooooobbbbbbbbbbbboooooooobb\n"
@"bo......obXXXXXXXXXXbo......obb\n"
@"boooooooobXXXXXXXXXXboooooooobb\n"
@"bo......obXXXXXXXXXXbo......obb\n"
@"boooooooobXXXXXXXXXXboooooooobb\n"
@"bo......obXXXXXXXXXXbo......obb\n"
@"booooooooobbbbbbbbbbooooooooobb\n"
@"bo......oooooooooooooo......obb\n"
@"boooooooooo........oooooooooobb\n"
@" ooooooooooooooooooooooooooooo \n"
;

@implementation Definitions(hkukgfdfthfnvbchjgfjygikghjghfjgfjdksfjksdkdjkfsdkjfj)
+ (id)MacColorDir
{
    id obj = [@"MacColorDir" asInstance];
    return obj;
}
@end

@interface MacColorDir : IvarObject
{
    time_t _timestamp;
    id _array;
    id _buttonDown;
    int _buttonDownOffsetX;
    int _buttonDownOffsetY;
    id _buttonDownTimestamp;
    id _selected;
}
@end
@implementation MacColorDir
- (int)preferredWidth
{
    return 600;
}
- (int)preferredHeight
{
    return 360;
}
- (void)updateFromCurrentDirectory:(Int4)r
{
    id bitmap = [Definitions bitmapWithWidth:1 height:1];
    [bitmap useMonacoFont];
    id arr = [@"." contentsOfDirectory];
    arr = [arr asFileArray];
    int x = 40;
    int y = 5;
    for (int i=0; i<[arr count]; i++) {
        id elt = [arr nth:i];
        id palette = nil;
        id pixels = nil;
        id selectedPalette = nil;
        id selectedPixels = nil;
        id fileType = [elt valueForKey:@"fileType"];
        if ([fileType isEqual:@"file"]) {
            id filePath = [elt valueForKey:@"filePath"];
            if ([[filePath lowercaseString] hasSuffix:@".txt"]) {
                palette = readmePalette;
                pixels = readmePixels;
                selectedPalette = selectedReadmePalette;
                selectedPixels = readmePixels;
            } else {
                palette = documentPalette;
                pixels = documentPixels;
                selectedPalette = selectedDocumentPalette;
                selectedPixels = documentPixels;
            }
        } else if ([fileType isEqual:@"directory"]) {
            palette = folderPalette;
            pixels = folderPixels;
            selectedPalette = selectedFolderPalette;
            selectedPixels = folderPixels;
        }
        if (!palette || !pixels) {
            continue;
        }
        [elt setValue:palette forKey:@"palette"];
        [elt setValue:pixels forKey:@"pixels"];
        [elt setValue:selectedPalette forKey:@"selectedPalette"];
        [elt setValue:selectedPixels forKey:@"selectedPixels"];
        int w = [Definitions widthForCString:[pixels UTF8String]];
        int h = [Definitions heightForCString:[pixels UTF8String]];
        if (x + w + 5 >= r.w) {
            x = 40;
            y += h + 30;
        }
        [elt setValue:nsfmt(@"%d", x) forKey:@"x"];
        [elt setValue:nsfmt(@"%d", y) forKey:@"y"];
        [elt setValue:nsfmt(@"%d", w) forKey:@"w"];
        [elt setValue:nsfmt(@"%d", h) forKey:@"h"];
        x += w + 50 + 20;
    }
    [self setValue:arr forKey:@"array"];
}

- (void)handleBackgroundUpdate:(id)event
{
    time_t timestamp = [@"." fileModificationTimestamp];
    if (timestamp != _timestamp) {
        _timestamp = 0;
    }
}

- (void)beginIteration:(id)event rect:(Int4)r
{
    if (!_timestamp) {
        _timestamp = [@"." fileModificationTimestamp];
        [self updateFromCurrentDirectory:r];
    }
}

- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    [bitmap useMonacoFont];
    [bitmap setColor:@"white"];
    [bitmap fillRect:r];
    [bitmap setColor:@"black"];
    for (int i=0; i<[_array count]; i++) {
        id elt = [_array nth:i];
        int x = [elt intValueForKey:@"x"];
        int y = [elt intValueForKey:@"y"];
        int w = [elt intValueForKey:@"w"];
        int h = [elt intValueForKey:@"h"];
        if (_selected == elt) {
            id palette = [elt valueForKey:@"selectedPalette"];
            id pixels = [elt valueForKey:@"selectedPixels"];
            if (palette && pixels) {
                [bitmap drawCString:[pixels UTF8String] palette:[palette UTF8String] x:r.x+x y:r.y+y];
            }
        } else {
            id palette = [elt valueForKey:@"palette"];
            id pixels = [elt valueForKey:@"pixels"];
            if (palette && pixels) {
                [bitmap drawCString:[pixels UTF8String] palette:[palette UTF8String] x:r.x+x y:r.y+y];
            }
        }
        id filePath = [elt valueForKey:@"filePath"];
        [bitmap drawBitmapText:filePath centeredAtX:x+w/2 y:y+h-2];
    }
    [Definitions drawInactiveHorizontalScrollBarInBitmap:bitmap rect:[Definitions rectWithX:r.x y:r.y+r.h-15 w:r.w-15 h:15]];
    [Definitions drawInactiveVerticalScrollBarInBitmap:bitmap rect:[Definitions rectWithX:r.x+r.w-15 y:r.y w:15 h:r.h-15]];
}

- (void)handleMouseDown:(id)event
{
    [self setValue:nil forKey:@"selected"];
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    for (int i=0; i<[_array count]; i++) {
        id elt = [_array nth:i];
        int x = [elt intValueForKey:@"x"];
        int y = [elt intValueForKey:@"y"];
        int w = [elt intValueForKey:@"w"];
        int h = [elt intValueForKey:@"h"];
        if ((mouseX >= x) && (mouseX < x+w) && (mouseY >= y) && (mouseY < y+h)) {
            [self setValue:elt forKey:@"buttonDown"];
            [self setValue:elt forKey:@"selected"];
            _buttonDownOffsetX = mouseX - x;
            _buttonDownOffsetY = mouseY - y;
            struct timeval tv;
            gettimeofday(&tv, NULL);
            id timestamp = nsfmt(@"%ld.%06ld", tv.tv_sec, tv.tv_usec);
            if (_buttonDownTimestamp && ([timestamp doubleValue] - [_buttonDownTimestamp doubleValue] <= 0.3)) {
                id filePath = [_selected valueForKey:@"filePath"];
                if ([filePath length]) {
                    if ([filePath isDirectory]) {
                        id cmd = nsarr();
                        [cmd addObject:@"hotdog"];
                        [cmd addObject:@"dir"];
                        [cmd addObject:filePath];
                        [cmd runCommandInBackground];
                    }
                }
                [self setValue:nil forKey:@"buttonDownTimestamp"];
            } else {
                [self setValue:timestamp forKey:@"buttonDownTimestamp"];
            }
            break;
        }
    }
}

- (void)handleMouseMoved:(id)event
{
    if (_buttonDown) {
        int mouseX = [event intValueForKey:@"mouseX"];
        int mouseY = [event intValueForKey:@"mouseY"];
        [_buttonDown setValue:nsfmt(@"%d", mouseX - _buttonDownOffsetX) forKey:@"x"];
        [_buttonDown setValue:nsfmt(@"%d", mouseY - _buttonDownOffsetY) forKey:@"y"];
        [self setValue:nil forKey:@"buttonDownTimestamp"];
    }
}

- (void)handleMouseUp:(id)event
{
    [self setValue:nil forKey:@"buttonDown"];
}

@end

@implementation Definitions(fjeilmwfkldsmklfsdklmfm)
+ (char *)cStringForInactiveVerticalScrollBarPalette
{
    return
"b #000000\n"
"X #777777\n"
". #eeeeee\n"
;
}
+ (char *)cStringForInactiveVerticalScrollBarUpArrow
{
    return
"b..............\n"
"b..............\n"
"b......XX......\n"
"b.....X..X.....\n"
"b....X....X....\n"
"b...X......X...\n"
"b..X........X..\n"
"b.XXXX....XXXX.\n"
"b....X....X....\n"
"b....X....X....\n"
"b....X....X....\n"
"b....XXXXXX....\n"
"b..............\n"
"b..............\n"
"bXXXXXXXXXXXXXX\n"
;
}
+ (char *)cStringForInactiveVerticalScrollBarMiddle
{
    return
"b..............\n"
;
}
+ (char *)cStringForInactiveVerticalScrollBarDownArrow
{
    return
"bXXXXXXXXXXXXXX\n"
"b..............\n"
"b..............\n"
"b....XXXXXX....\n"
"b....X....X....\n"
"b....X....X....\n"
"b....X....X....\n"
"b.XXXX....XXXX.\n"
"b..X........X..\n"
"b...X......X...\n"
"b....X....X....\n"
"b.....X..X.....\n"
"b......XX......\n"
"b..............\n"
"b..............\n"
;
}
+ (char *)cStringForActiveScrollBarPalette
{
    return
"b #000000\n"
". #333366\n"
"X #555555\n"
"o #606060\n"
"O #777777\n"
"+ #666699\n"
"@ #a0a0a0\n"
"# #a4a4a4\n"
"$ #aaaaaa\n"
"% #bbbbbb\n"
"& #a3a3d7\n"
"* #dddddd\n"
"= #ccccff\n"
"- #eeeeee\n"
"; #ffffff\n"
;
}
+ (char *)cStringForActiveScrollBarLeftArrow
{
    return
"bbbbbbbbbbbbbbb\n"
";;;;;;;;;;;;;Ob\n"
";******.*****Ob\n"
";*****..*****Ob\n"
";****.&.*****Ob\n"
";***.&&.....*Ob\n"
";**.&&&&&&&.*Ob\n"
";*.&&&&&&&&.*Ob\n"
";**.&&&&&&&.*Ob\n"
";***.&&.....*Ob\n"
";****.&.*****Ob\n"
";*****..*****Ob\n"
";******.*****Ob\n"
";************Ob\n"
"OOOOOOOOOOOOOOb\n"
;
}
+ (char *)cStringForActiveScrollBarMiddle
{
    return
"bbbb\n"
"*O**\n"
"***O\n"
"*O**\n"
"***O\n"
"*O**\n"
"***O\n"
"*O**\n"
"***O\n"
"*O**\n"
"***O\n"
"*O**\n"
"***O\n"
"*O**\n"
"***O\n"
;
}

+ (char *)cStringForActiveScrollBarRightArrow
{
    return
"bbbbbbbbbbbbbbb\n"
"b;;;;;;;;;;;;;O\n"
"b;*****.******O\n"
"b;*****..*****O\n"
"b;*****.&.****O\n"
"b;*.....&&.***O\n"
"b;*.&&&&&&&.**O\n"
"b;*.&&&&&&&&.*O\n"
"b;*.&&&&&&&.**O\n"
"b;*.....&&.***O\n"
"b;*****.&.****O\n"
"b;*****..*****O\n"
"b;*****.******O\n"
"b;************O\n"
"bOOOOOOOOOOOOOO\n"
;
}

+ (char *)cStringForActiveScrollBarKnob
{
    return
"bbbbbbbbbbbbbbbb\n"
"X==============.\n"
"X=$$$$$$$$$$$$$.\n"
"X=$$$$$$$$$$$$$.\n"
"X=$$$$$$$$$$$$$.\n"
"X=$&=+=+=+=+=$$.\n"
"X=$&=+=+=+=+=$$.\n"
"X=$&=+=+=+=+=$$.\n"
"X=$&=+=+=+=+=$$.\n"
"X=$&=+=+=+=+=$$.\n"
"X=$&=+=+=+=+=$$.\n"
"X=$$$$$$$$$$$$$.\n"
"X=$$$$$$$$$$$$$.\n"
"X=$$$$$$$$$$$$$.\n"
"X...............\n"
"bbbbbbbbbbbbbbbb\n"
;
}

+ (char *)cStringForInactiveHorizontalScrollBarPalette
{
    return
"b #000000\n"
"X #777777\n"
". #eeeeee\n"
;
}

+ (char *)cStringForInactiveHorizontalScrollBarLeftArrow
{
    return
"bbbbbbbbbbbbbbb\n"
"..............X\n"
"......X.......X\n"
".....XX.......X\n"
"....X.X.......X\n"
"...X..XXXXX...X\n"
"..X.......X...X\n"
".X........X...X\n"
".X........X...X\n"
"..X.......X...X\n"
"...X..XXXXX...X\n"
"....X.X.......X\n"
".....XX.......X\n"
"......X.......X\n"
"..............X\n"
;
}
+ (char *)cStringForInactiveHorizontalScrollBarMiddle
{
   return
"b\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
;
}
+ (char *)cStringForInactiveHorizontalScrollBarRightArrow
{
    return
"bbbbbbbbbbbbbbb\n"
"X..............\n"
"X.......X......\n"
"X.......XX.....\n"
"X.......X.X....\n"
"X...XXXXX..X...\n"
"X...X.......X..\n"
"X...X........X.\n"
"X...X........X.\n"
"X...X.......X..\n"
"X...XXXXX..X...\n"
"X.......X.X....\n"
"X.......XX.....\n"
"X.......X......\n"
"X..............\n"
;
}
+ (void)drawActiveScrollBarInBitmap:(id)bitmap rect:(Int4)r pct:(double)pct
{
    char *palette = [Definitions cStringForActiveScrollBarPalette];

    char *left = [Definitions cStringForActiveScrollBarLeftArrow];
    char *middle = [Definitions cStringForActiveScrollBarMiddle];
    char *right = [Definitions cStringForActiveScrollBarRightArrow];
    char *knob = [Definitions cStringForActiveScrollBarKnob];

    int widthForLeft = [Definitions widthForCString:left];
    int widthForMiddle = [Definitions widthForCString:middle];
    int widthForRight = [Definitions widthForCString:right];
    int widthForKnob = [Definitions widthForCString:knob];

    int heightForMiddle = [Definitions heightForCString:middle];
    int heightForKnob = [Definitions heightForCString:knob];
    int middleYOffset = (r.h - heightForMiddle)/2.0;
    int knobYOffset = (r.h - heightForKnob)/2.0;

    [bitmap drawCString:left palette:palette x:r.x y:r.y+middleYOffset];
    int x;
    for (x=widthForLeft; x<r.w-widthForRight; x+=widthForMiddle) {
        [bitmap drawCString:middle palette:palette x:r.x+x y:r.y+middleYOffset];
    }
    [bitmap drawCString:right palette:palette x:r.x+r.w-widthForRight y:r.y+middleYOffset];
    int knobX = widthForLeft + (int)(r.w-widthForLeft-widthForRight-widthForKnob) * pct;
    [bitmap drawCString:knob palette:palette x:r.x+knobX y:r.y+knobYOffset];
}
+ (void)drawInactiveHorizontalScrollBarInBitmap:(id)bitmap rect:(Int4)r
{
    char *palette = [Definitions cStringForInactiveHorizontalScrollBarPalette];

    char *left = [Definitions cStringForInactiveHorizontalScrollBarLeftArrow];
    char *middle = [Definitions cStringForInactiveHorizontalScrollBarMiddle];
    char *right = [Definitions cStringForInactiveHorizontalScrollBarRightArrow];

    int widthForLeft = [Definitions widthForCString:left];
    int widthForMiddle = [Definitions widthForCString:middle];
    int widthForRight = [Definitions widthForCString:right];

    int heightForMiddle = [Definitions heightForCString:middle];
    int middleYOffset = (r.h - heightForMiddle)/2.0;

    [bitmap drawCString:left palette:palette x:r.x y:r.y+middleYOffset];
    int x;
    for (x=widthForLeft; x<r.w-widthForRight; x+=widthForMiddle) {
        [bitmap drawCString:middle palette:palette x:r.x+x y:r.y+middleYOffset];
    }
    [bitmap drawCString:right palette:palette x:r.x+r.w-widthForRight y:r.y+middleYOffset];
}
+ (void)drawInactiveVerticalScrollBarInBitmap:(id)bitmap rect:(Int4)r
{
    char *palette = [Definitions cStringForInactiveVerticalScrollBarPalette];

    char *top = [Definitions cStringForInactiveVerticalScrollBarUpArrow];
    char *middle = [Definitions cStringForInactiveVerticalScrollBarMiddle];
    char *bottom = [Definitions cStringForInactiveVerticalScrollBarDownArrow];
//    char *knob = [Definitions cStringForInactiveVerticalScrollBarKnob];

    int heightForTop = [Definitions heightForCString:top];
    int heightForMiddle = [Definitions heightForCString:middle];
    int heightForBottom = [Definitions heightForCString:bottom];
//    int heightForKnob = [Definitions heightForCString:knob];

    int widthForMiddle = [Definitions widthForCString:middle];
//    int widthForKnob = [Definitions widthForCString:knob];
    int middleXOffset = (r.w - widthForMiddle)/2;
//    int knobXOffset = (r.w - widthForKnob)/2;

    [bitmap drawCString:top palette:palette x:r.x+middleXOffset y:r.y];
    for (int y=r.y+heightForTop; y<r.y+r.h-heightForBottom; y+=heightForMiddle) {
        [bitmap drawCString:middle palette:palette x:r.x+middleXOffset y:y];
    }
    [bitmap drawCString:bottom palette:palette x:r.x+middleXOffset y:r.y+r.h-heightForBottom];
//    int knobX = widthForLeft + (int)(r.w-widthForLeft-widthForRight-widthForKnob) * pct;
//    [bitmap drawCString:knob palette:palette x:r.x+knobX y:r.y+r.h-1-knobYOffset];
}
@end
