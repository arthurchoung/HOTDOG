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

static id ramDiskPalette =
@"b #000000\n"
@". #000022\n"
@"X #FF8800\n"
@"o #0055AA\n"
@"O #FFFFFF\n"
;
static id ramDiskSelectedPalette =
@"b #000000\n"
@"O #000022\n"
@"o #FF8800\n"
@"X #0055AA\n"
@". #FFFFFF\n"
;
static id ramDiskPixels =
@"..........................      \n"
@"..........................      \n"
@"..OOOOOOXXXXXX....XXXXOO....    \n"
@"..OOOOOOXXXXXX....XXXXOO....    \n"
@"..OOOOOOXXXXXX....XXXXOOOO....  \n"
@"..OOOOOOXXXXXX....XXXXOOOO....  \n"
@"..OOOOOOXXXXXX....XXXXOOOOOO....\n"
@"..OOOOOOXXXXXX....XXXXOOOOOO....\n"
@"..OOOOOOXXXXXX....XXXXOOOOOOOO..\n"
@"..OOOOOOXXXXXX....XXXXOOOOOOOO..\n"
@"..OOOOOOXXXXXXXXXXXXXXOOOOOOOO..\n"
@"..OOOOOOXXXXXXXXXXXXXXOOOOOOOO..\n"
@"..OOOOOOOOOOOOOOOOOOOOOOOOOOOO..\n"
@"..OOOOOOOOOOOOOOOOOOOOOOOOOOOO..\n"
@"..OOOOOOOOOOOOOOOOOOOOOOOOOOOO..\n"
@"..OOOOOOOOOOOOOOOOOOOOOOOOOOOO..\n"
@"..OOOOOOOOOOOOOOOOOOOOOOOOOOOO..\n"
@"..OOOOOOOOOOOOOOOOOOOOOOOOOOOO..\n"
@"..OOOOOOOOOOOOOOOOOOOOOOOOOOOO..\n"
@"..OOOOOOOOOOOOOOOOOOOOOOOOOOOO..\n"
@"..OOOOOOOOOOOOOOOOOOOOOOOOOOOO..\n"
@"..OOOOOOOOOOOOOOOOOOOOOOOOOOOO..\n"
@"..OOOOOOOOOOOOOOOOOOOOOOOOOOOO..\n"
@"..OOOOOOOOOOOOOOOOOOOOOOOOOOOO..\n"
@"..OOOOOOOOOOOOOOOOOOOOOOOOOOOO..\n"
@"..OOOOOOOOOOOOOOOOOOOOOOOOOOOO..\n"
@"..OOOOOOOOOOOOOOOOOOOOOOOOOOOO..\n"
@"..OOOOOOOOOOOOOOOOOOOOOOOOOOOO..\n"
@"..OOOOOOOOOOOOOOOOOOOOOOOOOOOO..\n"
@"..OOOOOOOOOOOOOOOOOOOOOOOOOOOO..\n"
@"................................\n"
@"................................\n"
;

static id wbDiskPalette =
@"b #000000\n"
@". #000022\n"
@"X #FF8800\n"
@"o #0055AA\n"
@"O #FFFFFF\n"
;
static id wbDiskSelectedPalette =
@"b #000000\n"
@"O #000022\n"
@"o #FF8800\n"
@"X #0055AA\n"
@". #FFFFFF\n"
;

static id wbDiskPixels =
@".........XXXXXXXXXXXXXXXXX.......  \n"
@".........XXXXXXXXXXXXXXXXX.......  \n"
@".........XXXXXXXXXX....XXX........ \n"
@".........XXXXXXXXXX....XXX........ \n"
@".........XXXXXXXXXX....XXX.........\n"
@".........XXXXXXXXXX....XXX.........\n"
@".........XXXXXXXXXX....XXX.........\n"
@".........XXXXXXXXXX....XXX.........\n"
@".........XXXXXXXXXXXXXXXXX.........\n"
@".........XXXXXXXXXXXXXXXXX.........\n"
@"...................................\n"
@"...................................\n"
@"...................................\n"
@"...................................\n"
@"......OOOOOOO.X.X.X.O.o.OOOO.......\n"
@"......OOOOOOO.X.X.X.O.o.OOOO.......\n"
@"......OOOOOO.X.O.X.o.O.o.OOOO......\n"
@"......OOOOOO.X.O.X.o.O.o.OOOO......\n"
@"......OOOOO.X.O.X.O.o.O.o.OOO......\n"
@"......OOOOO.X.O.X.O.o.O.o.OOO......\n"
@"......OOOO.X.O.X.OOO.o.O.o.OO......\n"
@"......OOOO.X.O.X.OOO.o.O.o.OO......\n"
@"......OOO.X.O.X.OOOOOOOOOOOOO......\n"
@"......OOO.X.O.X.OOOOOOOOOOOOO......\n"
@"......OO.X.O.X.OOOOOOOOOOOOOO......\n"
@"......OO.X.O.X.OOOOOOOOOOOOOO......\n"
@"..oo..O.X.O.X.OOOOOOOOOOOOOOO......\n"
@"..oo..O.X.O.X.OOOOOOOOOOOOOOO......\n"
@"......OOOOOOOOOOOOOOOOOOOOOOO......\n"
@"......OOOOOOOOOOOOOOOOOOOOOOO......\n"
;

@implementation Definitions(hkukgfdfthfnvbchjgfjygikghjghfjgfjdksfjksdj)
+ (id)AmigaDrives
{
    id obj = [@"AmigaDrives" asInstance];
    return obj;
}
@end

@interface AmigaDrives : IvarObject
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
@implementation AmigaDrives
- (int)preferredWidth
{
    return 600;
}
- (int)preferredHeight
{
    return 360;
}
- (void)updateArray:(Int4)r
{
    id cmd = nsarr();
    [cmd addObject:@"hotdog-listBlockDevices.pl"];
    id lines = [[[cmd runCommandAndReturnOutput] asString] split:@"\n"];
    int x = 50;
    int y = 5;
    int w = [Definitions widthForCString:[wbDiskPixels UTF8String]];
    int h = [Definitions heightForCString:[wbDiskPixels UTF8String]];
    id results = nsarr();
    for (int i=0; i<[lines count]; i++) {
        id line = [lines nth:i];
        id device = [line valueForKey:@"device"];
        id mountpoint = [line valueForKey:@"mountpoint"];
        if (![device length] || ![mountpoint length]) {
            continue;
        }
        id dict = nsdict();
        [dict setValue:device forKey:@"device"];
        [dict setValue:mountpoint forKey:@"mountpoint"];
        [dict setValue:nsfmt(@"%d", x) forKey:@"x"];
        [dict setValue:nsfmt(@"%d", y) forKey:@"y"];
        [dict setValue:nsfmt(@"%d", w) forKey:@"w"];
        [dict setValue:nsfmt(@"%d", h) forKey:@"h"];
        [dict setValue:wbDiskPalette forKey:@"palette"];
        [dict setValue:wbDiskSelectedPalette forKey:@"selectedPalette"];
        [dict setValue:wbDiskPixels forKey:@"pixels"];
        [results addObject:dict];
        y += h + 30;
    }
    {
        id dict = nsdict();
        [dict setValue:@"RAM DISK" forKey:@"device"];
        [dict setValue:nsfmt(@"%d", x) forKey:@"x"];
        [dict setValue:nsfmt(@"%d", y) forKey:@"y"];
        [dict setValue:nsfmt(@"%d", [Definitions widthForCString:[ramDiskPixels UTF8String]]) forKey:@"w"];
        [dict setValue:nsfmt(@"%d", [Definitions heightForCString:[ramDiskPixels UTF8String]]) forKey:@"h"];
        [dict setValue:ramDiskPalette forKey:@"palette"];
        [dict setValue:ramDiskSelectedPalette forKey:@"selectedPalette"];
        [dict setValue:ramDiskPixels forKey:@"pixels"];
        [results addObject:dict];
        y += h + 30;
    }
    {
        id dict = nsdict();
        [dict setValue:@"Workbench1.3" forKey:@"device"];
        [dict setValue:nsfmt(@"%d", x) forKey:@"x"];
        [dict setValue:nsfmt(@"%d", y) forKey:@"y"];
        [dict setValue:nsfmt(@"%d", [Definitions widthForCString:[wbDiskPixels UTF8String]]) forKey:@"w"];
        [dict setValue:nsfmt(@"%d", [Definitions heightForCString:[wbDiskPixels UTF8String]]) forKey:@"h"];
        [dict setValue:wbDiskPalette forKey:@"palette"];
        [dict setValue:wbDiskSelectedPalette forKey:@"selectedPalette"];
        [dict setValue:wbDiskPixels forKey:@"pixels"];
        [results addObject:dict];
        y += h + 30;
    }
    {
        id dict = nsdict();
        [dict setValue:@"/" forKey:@"device"];
        [dict setValue:nsfmt(@"%d", x) forKey:@"x"];
        [dict setValue:nsfmt(@"%d", y) forKey:@"y"];
        [dict setValue:nsfmt(@"%d", [Definitions widthForCString:[wbDiskPixels UTF8String]]) forKey:@"w"];
        [dict setValue:nsfmt(@"%d", [Definitions heightForCString:[wbDiskPixels UTF8String]]) forKey:@"h"];
        [dict setValue:wbDiskPalette forKey:@"palette"];
        [dict setValue:wbDiskSelectedPalette forKey:@"selectedPalette"];
        [dict setValue:wbDiskPixels forKey:@"pixels"];
        [results addObject:dict];
    }
    [self setValue:results forKey:@"array"];
}

- (void)beginIteration:(id)event rect:(Int4)r
{
    if (!_timestamp) {
        _timestamp = 1;
        [self updateArray:r];
    }
}

- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    [bitmap useTopazFont];
    [bitmap setColor:@"#0055aa"];
    [bitmap fillRect:r];
    [bitmap setColor:@"white"];
    for (int i=0; i<[_array count]; i++) {
        id elt = [_array nth:i];
        int x = [elt intValueForKey:@"x"];
        int y = [elt intValueForKey:@"y"];
        int w = [elt intValueForKey:@"w"];
        int h = [elt intValueForKey:@"h"];
        if (_selected == elt) {
            id palette = [elt valueForKey:@"selectedPalette"];
            id pixels = [elt valueForKey:@"pixels"];
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
        id text = [elt valueForKey:@"device"];
        if ([text length]) {
            [bitmap drawBitmapText:text centeredAtX:x+w/2 y:y+h-8];
        }
    }
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
            if ([timestamp doubleValue] - [_buttonDownTimestamp doubleValue] <= 0.3) {
                id mountpoint = [_selected valueForKey:@"mountpoint"];
                if ([mountpoint length]) {
                    id cmd = nsarr();
                    [cmd addObject:@"hotdog"];
                    [cmd addObject:@"amigadir"];
                    [cmd addObject:mountpoint];
                    [cmd runCommandInBackground];
                } else {
                    id device = [_selected valueForKey:@"device"];
                    if ([device isEqual:@"RAM DISK"]) {
                        id cmd = nsarr();
                        [cmd addObject:@"hotdog"];
                        [cmd addObject:@"amigabuiltindir"];
                        [cmd addObject:device];
                        [cmd runCommandInBackground];
                    } else if ([device isEqual:@"Workbench1.3"]) {
                         id cmd = nsarr();
                        [cmd addObject:@"hotdog"];
                        [cmd addObject:@"amigabuiltindir"];
                        [cmd addObject:device];
                        [cmd runCommandInBackground];
                    } else if ([device isEqual:@"/"]) {
                         id cmd = nsarr();
                        [cmd addObject:@"hotdog"];
                        [cmd addObject:@"amigadir"];
                        [cmd addObject:device];
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

/*
static id ramDiskPixels =
@"..........................      \n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbb      \n"
@"..OOOOOOXXXXXX....XXXXOO....    \n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbb    \n"
@"..OOOOOOXXXXXX....XXXXOOOO....  \n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbb  \n"
@"..OOOOOOXXXXXX....XXXXOOOOOO....\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"..OOOOOOXXXXXX....XXXXOOOOOOOO..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"..OOOOOOXXXXXXXXXXXXXXOOOOOOOO..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"..OOOOOOOOOOOOOOOOOOOOOOOOOOOO..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"..OOOOOOOOOOOOOOOOOOOOOOOOOOOO..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"..OOOOOOOOOOOOOOOOOOOOOOOOOOOO..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"..OOOOOOOOOOOOOOOOOOOOOOOOOOOO..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"..OOOOOOOOOOOOOOOOOOOOOOOOOOOO..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"..OOOOOOOOOOOOOOOOOOOOOOOOOOOO..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"..OOOOOOOOOOOOOOOOOOOOOOOOOOOO..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"..OOOOOOOOOOOOOOOOOOOOOOOOOOOO..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"..OOOOOOOOOOOOOOOOOOOOOOOOOOOO..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"................................\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
;
static id wbDiskPixels =
@".........XXXXXXXXXXXXXXXXX.......  \n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb  \n"
@".........XXXXXXXXXX....XXX........ \n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb \n"
@".........XXXXXXXXXX....XXX.........\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@".........XXXXXXXXXX....XXX.........\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@".........XXXXXXXXXXXXXXXXX.........\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"...................................\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"...................................\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"......OOOOOOO.X.X.X.O.o.OOOO.......\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"......OOOOOO.X.O.X.o.O.o.OOOO......\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"......OOOOO.X.O.X.O.o.O.o.OOO......\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"......OOOO.X.O.X.OOO.o.O.o.OO......\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"......OOO.X.O.X.OOOOOOOOOOOOO......\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"......OO.X.O.X.OOOOOOOOOOOOOO......\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"..oo..O.X.O.X.OOOOOOOOOOOOOOO......\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"......OOOOOOOOOOOOOOOOOOOOOOO......\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
;
*/
