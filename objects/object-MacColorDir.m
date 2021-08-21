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
- (void)updateFromCurrentDirectory:(Int4)r
{
    id bitmap = [[[[@"Bitmap" asClass] alloc] initWithWidth:1 height:1] autorelease];
    [bitmap useMonacoFont];
    id arr = [@"." contentsOfDirectory];
    arr = [arr asFileArray];
    int x = 20;
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
        int textWidth = [Definitions bitmapWidthForText:[elt valueForKey:@"filePath"]];
        if (textWidth > w) {
            if (x + textWidth + 5 >= r.w) {
                x = 20;
                y += h + 30;
            }
            x += (textWidth - w) / 2;
            [elt setValue:nsfmt(@"%d", x) forKey:@"x"];
            [elt setValue:nsfmt(@"%d", y) forKey:@"y"];
            [elt setValue:nsfmt(@"%d", w) forKey:@"w"];
            [elt setValue:nsfmt(@"%d", h) forKey:@"h"];
            x += w + ((textWidth - w) / 2) + 20;
        } else {
            if (x + w + 5 >= r.w) {
                x = 20;
                y += h + 30;
            }
            [elt setValue:nsfmt(@"%d", x) forKey:@"x"];
            [elt setValue:nsfmt(@"%d", y) forKey:@"y"];
            [elt setValue:nsfmt(@"%d", w) forKey:@"w"];
            [elt setValue:nsfmt(@"%d", h) forKey:@"h"];
            x += w + 20;
        }
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
                id filePath = [_selected valueForKey:@"filePath"];
                if ([filePath length]) {
                    if ([filePath isDirectory]) {
                        id cmd = nsarr();
                        [cmd addObject:@"hotdog"];
                        [cmd addObject:@"maccolordir"];
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

