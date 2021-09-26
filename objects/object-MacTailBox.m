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

@implementation Definitions(fjejfksdljfklsdjfkkwlfmkldsmfkldsjflkfjdskfjksd)
+ (id)testMacTailBox:(id)filePath
{
    id obj = [@"MacTailBox" asInstance];
    [obj setValue:@"TITLE" forKey:@"text"];
    [obj setValue:filePath forKey:@"path"];
    [obj setValue:@"OK" forKey:@"okText"];
    return obj;
}
@end
@interface MacTailBox : IvarObject
{
    id _path;
    time_t _timestamp;
    id _text;
    id _fileText;
    Int4 _okRect;
    Int4 _cancelRect;
    id _okText;
    id _cancelText;
    char _buttonDown;
    char _buttonHover;
    int _dialogMode;
}
@end
@implementation MacTailBox
- (int)preferredWidth
{
    return 480;
}
- (int)preferredHeight
{
    if (!_text && !_fileText) {
        return 288;
    }
    id bitmap = [Definitions bitmapWithWidth:1 height:1];
    id text1 = [bitmap fitBitmapString:_text width:480-89-18];
    int textHeight1 = [bitmap bitmapHeightForText:text1];
    id text2 = [bitmap fitBitmapString:_fileText width:480-89-18];
    int textHeight2 = [bitmap bitmapHeightForText:text2];
    int textHeight = 24 + textHeight1 + 16 + textHeight2 + 21 + 28 + 21;
    if (textHeight > 288) {
        return textHeight;
    }
    return 288;
}
- (void)handleBackgroundUpdate:(id)event
{
    time_t timestamp = [_path fileModificationTimestamp];
    if (timestamp != _timestamp) {
        _timestamp = 0;
    }
}
- (void)beginIteration:(id)event rect:(Int4)r
{
    if (!_timestamp) {
        _timestamp = [_path fileModificationTimestamp];
        id text = [_path stringFromFile];
        [self setValue:text forKey:@"fileText"];
    }
}
- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    [Definitions drawAlertBorderInBitmap:bitmap rect:r];
    char *palette = "b #000000\n. #ffffff\n";
    [bitmap drawCString:[Definitions cStringForBitmapMessageIcon] palette:palette x:28 y:28];

    int x = 89;
    int y = 24;

    // text

    int textWidth = r.w - 89 - 18;
    if (_text) {
        id text = [bitmap fitBitmapString:_text width:textWidth];
        int textHeight = [bitmap bitmapHeightForText:text];
        [bitmap setColorIntR:0 g:0 b:0 a:255];
        [bitmap drawBitmapText:text x:x y:y];
        y += textHeight + 16;
    }

    if (_fileText) {
        id text = [bitmap fitBitmapString:_fileText width:textWidth];
        [bitmap drawBitmapText:text x:x y:y];
        int textHeight = [bitmap bitmapHeightForText:text];
        y += textHeight;
    }


    // ok button

    if (_okText) {
        _okRect = [Definitions rectWithX:r.w-88 y:r.h-21-28 w:70 h:28];
        Int4 innerRect = _okRect;
        innerRect.y += 1;
        if ((_buttonDown == 'o') && (_buttonHover == 'o')) {
            char *palette = ". #000000\nb #000000\nw #ffffff\n";
            [Definitions drawDefaultButtonInBitmap:bitmap rect:_okRect palette:palette];
            [bitmap setColorIntR:255 g:255 b:255 a:255];
            [bitmap drawBitmapText:@"OK" centeredInRect:innerRect];
        } else {
            char *palette = ". #ffffff\nb #000000\nw #ffffff\n";
            [Definitions drawDefaultButtonInBitmap:bitmap rect:_okRect palette:palette];
            [bitmap setColorIntR:0 g:0 b:0 a:255];
            [bitmap drawBitmapText:@"OK" centeredInRect:innerRect];
        }
    } else {
        _okRect.x = 0;
        _okRect.y = 0;
        _okRect.w = 0;
        _okRect.h = 0;
    }

    // cancel button

    if (_cancelText) {
        _cancelRect = [Definitions rectWithX:_okRect.x-70-35 y:r.h-21-28 w:70 h:28];
        if ((_buttonDown == 'c') && (_buttonHover == 'c')) {
            char *palette = ". #000000\nb #000000\nw #ffffff\n";
            [Definitions drawButtonInBitmap:bitmap rect:_cancelRect palette:palette];
            [bitmap setColorIntR:255 g:255 b:255 a:255];
            [bitmap drawBitmapText:_cancelText centeredInRect:_cancelRect];
        } else {
            char *palette = ". #ffffff\nb #000000\nw #ffffff\n";
            [Definitions drawButtonInBitmap:bitmap rect:_cancelRect palette:palette];
            [bitmap setColorIntR:0 g:0 b:0 a:255];
            [bitmap drawBitmapText:_cancelText centeredInRect:_cancelRect];
        }
    } else {
        _cancelRect.x = 0;
        _cancelRect.y = 0;
        _cancelRect.w = 0;
        _cancelRect.h = 0;
    }



}
- (void)handleMouseDown:(id)event
{
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    if (_okText && [Definitions isX:mouseX y:mouseY insideRect:_okRect]) {
        _buttonDown = 'o';
        _buttonHover = 'o';
    } else if (_cancelText && [Definitions isX:mouseX y:mouseY insideRect:_cancelRect]) {
        _buttonDown = 'c';
        _buttonHover = 'c';
    } else {
        _buttonDown = 0;
        _buttonHover = 0;
    }
}
- (void)handleMouseMoved:(id)event
{
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    if (_okText && [Definitions isX:mouseX y:mouseY insideRect:_okRect]) {
        _buttonHover = 'o';
    } else if (_cancelText && [Definitions isX:mouseX y:mouseY insideRect:_cancelRect]) {
        _buttonHover = 'c';
    } else {
        _buttonHover = 0;
    }
}
- (void)handleMouseUp:(id)event
{
    if (_buttonDown == _buttonHover) {
        if (_buttonDown == 'o') {
            if (_dialogMode) {
                exit(0);
            }
            id x11dict = [event valueForKey:@"x11dict"];
            [x11dict setValue:@"1" forKey:@"shouldCloseWindow"];
        } else if (_buttonDown == 'c') {
            if (_dialogMode) {
                exit(1);
            }
            id x11dict = [event valueForKey:@"x11dict"];
            [x11dict setValue:@"1" forKey:@"shouldCloseWindow"];
        }
    }
    _buttonDown = 0;
    _buttonHover = 0;
}
@end

