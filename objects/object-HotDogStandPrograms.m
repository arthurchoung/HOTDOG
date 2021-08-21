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

static id programsPalette =
@"b #000000\n"
@". #ff0000\n"
@"X #ffff00\n"
@"o #0000ff\n"
@"O #aa55aa\n"
@"+ #55aaaa\n"
@"@ #00ffff\n"
@"# #868a8e\n"
@"$ #c3c7cb\n"
@"% #ffffff\n"
;
static id programsPixels =
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbb \n"
@"b@$@$@$@$@$@$@$@$@$@$@$@$@$@$b#\n"
@"b$@$@$@$@$@$@$@$@$@$@$@$@$@$@b#\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbb#\n"
@"b%%%%%%%%%%%%%%%%%%%%%%%%%%%%b#\n"
@"b%%%%%%%%%%%%%%%%%%%%%%%%%%%%b#\n"
@"b%%%%bbb%%%%%%bbb%%%%%###b%%%b#\n"
@"b%%%b%%b%%%%%b++b%%%%%#oob%%%b#\n"
@"b%%bbbbbb%%%b++bb%%%%%#oob%%%b#\n"
@"b%%b$$$$b%%%#bb%b%%%%#####b%%b#\n"
@"b%%#bbbbb%%%%%bbb%%%%bbbbbb%%b#\n"
@"b%%%%%%%%%%%%%%%%%%%%%%%%%%%%b#\n"
@"b%%bbbbbb%%%bbbbbb%%%bbbbbb%%b#\n"
@"b%%%%%%%%%%%%%%%%%%%%%%%%%%%%b#\n"
@"b%%%%%%%%%%%%%%%%%%%%%%%%%%%%b#\n"
@"b%%%%%%b%%%%%b%%bb%%%%bbb%%%%b#\n"
@"b%%%%%OO%%%%b%%b.b%%%b@o@b%%%b#\n"
@"b%%%%O%O%%%%b%bXb%%%%b@oob%%%b#\n"
@"b%%%ObOb%%%%%bXb%%%%%b@@@b%%%b#\n"
@"b%%OO%%OO%%%%bb%%%%%%%bbb%%%%b#\n"
@"b%%%%%%%%%%%%%%%%%%%%%%%%%%%%b#\n"
@"b%%bbbbbb%%%bbbbbb%%%bbbbbb%%b#\n"
@"b%%%%%%%%%%%%%%%%%%%%%%%%%%%%b#\n"
@"b%%%%%%%%%%%%%%%%%%%%%%%%%%%%b#\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbb#\n"
@" ##############################\n"
;

@implementation Definitions(hkukgfddfjkfnvbchjgfjygikghjghfjgfjdksfjksfjdsklfjksdljfdkslmvdj)
+ (id)HotDogStandPrograms
{
    id obj = [@"HotDogStandPrograms" asInstance];
    return obj;
}
@end

@interface HotDogStandPrograms : IvarObject
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
@implementation HotDogStandPrograms
- (void)updateArray:(Int4)r
{
    id cmd = nsarr();
    [cmd addObject:@"hotdog-listBlockDevices.pl"];
    id lines = [[[cmd runCommandAndReturnOutput] asString] split:@"\n"];
    int x = 50;
    int y = 5;
    int w = [Definitions widthForCString:[programsPixels UTF8String]];
    int h = [Definitions heightForCString:[programsPixels UTF8String]];
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
        [dict setValue:programsPalette forKey:@"palette"];
        [dict setValue:programsPixels forKey:@"pixels"];
        [dict setValue:programsPalette forKey:@"selectedPalette"];
        [dict setValue:programsPixels forKey:@"selectedPixels"];
        [results addObject:dict];
        y += h + 30;
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
    [bitmap useWinSystemFont];
    [bitmap setColor:@"yellow"];
    [bitmap fillRect:r];
    for (int i=0; i<[_array count]; i++) {
        id elt = [_array nth:i];
        int x = [elt intValueForKey:@"x"];
        int y = [elt intValueForKey:@"y"];
        int w = [elt intValueForKey:@"w"];
        int h = [elt intValueForKey:@"h"];
        if (_selected == elt) {
            id palette = [elt valueForKey:@"palette"];
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
            if (_selected == elt) {
                int textWidth = [Definitions bitmapWidthForText:text];
                [bitmap setColor:@"black"];
                [bitmap fillRect:[Definitions rectWithX:x+w/2-textWidth/2 y:y+h+2 w:textWidth h:18]];
                [bitmap setColor:@"white"];
                [bitmap drawBitmapText:text centeredAtX:x+w/2 y:y+h-2];
            } else {
                [bitmap setColor:@"black"];
                [bitmap drawBitmapText:text centeredAtX:x+w/2 y:y+h-2];
            }
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
                    [cmd addObject:@"macclassicdir"];
                    [cmd addObject:mountpoint];
                    [cmd runCommandInBackground];
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

