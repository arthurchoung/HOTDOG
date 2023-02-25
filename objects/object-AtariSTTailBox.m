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

static char *borderPalette =
"b #000000\n"
". #ffffff\n"
;

static char *topBorderLeftPixels = 
"bbb\n"
"b..\n"
"b..\n"
"b..\n"
;
static char *topBorderMiddlePixels = 
"b\n"
".\n"
".\n"
"b\n"
;
static char *topBorderRightPixels = 
"bbb\n"
"..b\n"
"..b\n"
"..b\n"
;
static char *leftBorderPixels = 
"b..b\n"
;
static char *rightBorderPixels = 
"b..b\n"
;
static char *bottomBorderLeftPixels = 
"b..\n"
"b..\n"
"b..\n"
"bbb\n"
;
static char *bottomBorderMiddlePixels = 
"b\n"
".\n"
".\n"
"b\n"
;
static char *bottomBorderRightPixels = 
"..b\n"
"..b\n"
"..b\n"
"bbb\n"
;

static char *buttonPalette =
"b #000000\n"
". #ffffff\n"
;


static char *defaultButtonLeftPixels =
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
;
static char *defaultButtonMiddlePixels =
"b\n"
"b\n"
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
".\n"
".\n"
"b\n"
"b\n"
"b\n"
;
static char *defaultButtonDownMiddlePixels =
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
;
static char *defaultButtonRightPixels =
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
;

static char *buttonLeftPixels =
"   \n"
" bb\n"
" bb\n"
" bb\n"
" bb\n"
" bb\n"
" bb\n"
" bb\n"
" bb\n"
" bb\n"
" bb\n"
" bb\n"
" bb\n"
" bb\n"
" bb\n"
" bb\n"
" bb\n"
" bb\n"
" bb\n"
" bb\n"
" bb\n"
"   \n"
;
static char *buttonMiddlePixels =
" \n"
"b\n"
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
".\n"
".\n"
"b\n"
"b\n"
" \n"
;
static char *buttonDownMiddlePixels =
" \n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
" \n"
;
static char *buttonRightPixels =
"   \n"
"bb \n"
"bb \n"
"bb \n"
"bb \n"
"bb \n"
"bb \n"
"bb \n"
"bb \n"
"bb \n"
"bb \n"
"bb \n"
"bb \n"
"bb \n"
"bb \n"
"bb \n"
"bb \n"
"bb \n"
"bb \n"
"bb \n"
"bb \n"
"   \n"
;

@implementation Definitions(fjejfksdljfklsdjfkkwlfmkldsmfkldsjflkfjdskfjksdfjdksfjksd)
+ (id)testAtariSTTailBox:(id)filePath
{
    id obj = [@"AtariSTTailBox" asInstance];
    [obj setValue:@"TITLE" forKey:@"text"];
    [obj setValue:filePath forKey:@"path"];
    [obj setValue:@"OK" forKey:@"okText"];
    return obj;
}
@end
@interface AtariSTTailBox : IvarObject
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
    int _HOTDOGNOFRAME;
    int _buttonDownX;
    int _buttonDownY;
}
@end
@implementation AtariSTTailBox
- (id)init
{
    self = [super init];
    if (self) {
        _HOTDOGNOFRAME = 1;
    }
    return self;
}
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
    [bitmap useAtariSTFont];
    id text1 = [bitmap fitBitmapString:_text width:480-18-18];
    int textHeight1 = [bitmap bitmapHeightForText:text1];
    id text2 = [bitmap fitBitmapString:_fileText width:480-18-18];
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
    [bitmap useAtariSTFont];

    [bitmap setColor:@"white"];
    [bitmap fillRect:r];
    [Definitions drawInBitmap:bitmap left:topBorderLeftPixels middle:topBorderMiddlePixels right:topBorderRightPixels x:r.x y:r.y w:r.w palette:borderPalette];
    [Definitions drawInBitmap:bitmap top:leftBorderPixels palette:borderPalette middle:leftBorderPixels palette:borderPalette bottom:leftBorderPixels palette:borderPalette x:r.x y:r.y+4 h:r.h-8];
    [Definitions drawInBitmap:bitmap top:rightBorderPixels palette:borderPalette middle:rightBorderPixels palette:borderPalette bottom:rightBorderPixels palette:borderPalette x:r.x+r.w-4 y:r.y+4 h:r.h-8];
    [Definitions drawInBitmap:bitmap left:bottomBorderLeftPixels middle:bottomBorderMiddlePixels right:bottomBorderRightPixels x:r.x y:r.y+r.h-4 w:r.w palette:borderPalette];

    int x = 18;
    int y = 24;

    // text

    int textWidth = r.w - 18 - 18;
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


    // metrics

    int okTextWidth = (_okText) ? [bitmap bitmapWidthForText:_okText] : 0;
    int okTextHeight = (_okText) ? [bitmap bitmapHeightForText:_okText] : 0;
    int okButtonWidth = 70;
    int okButtonHeight = 22;
    if (okTextWidth+14 > 70) {
        okButtonWidth = okTextWidth+14;
    }
    _okRect.w = okButtonWidth;
    _okRect.h = okButtonHeight;
NSLog(@"okButtonWidth %d okTextWidth %d", okButtonWidth, okTextWidth);

    int cancelTextWidth = [bitmap bitmapWidthForText:_cancelText];
    int cancelTextHeight = [bitmap bitmapHeightForText:_cancelText];
    int cancelButtonWidth = 70;
    int cancelButtonHeight = 22;
    if (cancelTextWidth+14 > 70) {
        cancelButtonWidth = cancelTextWidth+14;
    }
    _cancelRect.w = cancelButtonWidth;
    _cancelRect.h = cancelButtonHeight;
NSLog(@"cancelButtonWidth %d cancelTextWidth %d", cancelButtonWidth, cancelTextWidth);

    if (_okText && _cancelText) {
        if (_okRect.w > _cancelRect.w) {
            _cancelRect.w = _okRect.w;
        } else if (_okRect.w < _cancelRect.w) {
            _okRect.w = _cancelRect.w;
        }
        _okRect.x = r.x+(r.w-_okRect.w-_cancelRect.w-18)/2;
        _okRect.y = r.y+r.h-okButtonHeight-16;
        _cancelRect.x = _okRect.x + _okRect.w + 18;
        _cancelRect.y = _okRect.y;
    } else if (_okText) {
        _okRect.x = r.x+(r.w-okButtonWidth)/2;
        _okRect.y = r.y+r.h-okButtonHeight-16;
    } else if (_cancelText) {
        _cancelRect.x = r.x+(r.w-cancelButtonWidth)/2;
        _cancelRect.y = r.y+r.h-cancelButtonHeight-16;
    }

    // ok button

    if (_okText) {
        BOOL okButtonDown = NO;        
        if ((_buttonDown == 'o') && (_buttonHover == 'o')) {
            okButtonDown = YES;
        }
        if (okButtonDown) {
            int okTextX = _okRect.x+(_okRect.w-okTextWidth)/2;
            int okTextY = _okRect.y+(_okRect.h-okTextHeight)/2;
[Definitions drawInBitmap:bitmap left:defaultButtonLeftPixels middle:defaultButtonDownMiddlePixels right:defaultButtonRightPixels x:_okRect.x y:_okRect.y w:_okRect.w palette:buttonPalette];

            [bitmap setColor:@"white"];
            [bitmap drawBitmapText:_okText x:okTextX y:okTextY];
        } else {
            int okTextX = _okRect.x+(_okRect.w-okTextWidth)/2-1;
            int okTextY = _okRect.y+(_okRect.h-okTextHeight)/2;
[Definitions drawInBitmap:bitmap left:defaultButtonLeftPixels middle:defaultButtonMiddlePixels right:defaultButtonRightPixels x:_okRect.x y:_okRect.y w:_okRect.w palette:buttonPalette];

            [bitmap setColor:@"black"];
            [bitmap drawBitmapText:_okText x:okTextX y:okTextY];
        }
    } else {
        _okRect.x = 0;
        _okRect.y = 0;
        _okRect.w = 0;
        _okRect.h = 0;
    }

    // cancel button

    if (_cancelText) {
        BOOL cancelButtonDown = NO;
        if ((_buttonDown == 'c') && (_buttonHover == 'c')) {
            cancelButtonDown = YES;
        }
        if (cancelButtonDown) {
            int cancelTextX = _cancelRect.x+(_cancelRect.w-cancelTextWidth)/2;
            int cancelTextY = _cancelRect.y+(_cancelRect.h-cancelTextHeight)/2;
[Definitions drawInBitmap:bitmap left:buttonLeftPixels middle:buttonDownMiddlePixels right:buttonRightPixels x:_cancelRect.x y:_cancelRect.y w:_cancelRect.w palette:buttonPalette];

            [bitmap setColor:@"white"];
            [bitmap drawBitmapText:_cancelText x:cancelTextX y:cancelTextY];
        } else {
            int cancelTextX = _cancelRect.x+(_cancelRect.w-cancelTextWidth)/2-1;
            int cancelTextY = _cancelRect.y+(_cancelRect.h-cancelTextHeight)/2;
[Definitions drawInBitmap:bitmap left:buttonLeftPixels middle:buttonMiddlePixels right:buttonRightPixels x:_cancelRect.x y:_cancelRect.y w:_cancelRect.w palette:buttonPalette];

            [bitmap setColor:@"black"];
            [bitmap drawBitmapText:_cancelText x:cancelTextX y:cancelTextY];
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
    {
        id x11dict = [event valueForKey:@"x11dict"];
        unsigned long win = [[x11dict valueForKey:@"window"] unsignedLongValue];
        id windowManager = [@"windowManager" valueForKey];
        [windowManager XRaiseWindow:win];
    }

    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    if (_okText && [Definitions isX:mouseX y:mouseY insideRect:_okRect]) {
        _buttonDown = 'o';
        _buttonHover = 'o';
    } else if (_cancelText && [Definitions isX:mouseX y:mouseY insideRect:_cancelRect]) {
        _buttonDown = 'c';
        _buttonHover = 'c';
    } else {
        _buttonDown = 'b';
        _buttonHover = 0;
        _buttonDownX = mouseX;
        _buttonDownY = mouseY;
    }
}
- (void)handleMouseMoved:(id)event
{
    if (_buttonDown == 'b') {
        int mouseRootX = [event intValueForKey:@"mouseRootX"];
        int mouseRootY = [event intValueForKey:@"mouseRootY"];

        id dict = [event valueForKey:@"x11dict"];

        int newX = mouseRootX - _buttonDownX;
        int newY = mouseRootY - _buttonDownY;

        [dict setValue:nsfmt(@"%d", newX) forKey:@"x"];
        [dict setValue:nsfmt(@"%d", newY) forKey:@"y"];

        [dict setValue:nsfmt(@"%d %d", newX, newY) forKey:@"moveWindow"];
        return;
    }

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
- (void)handleKeyDown:(id)event
{
    id str = [event valueForKey:@"keyString"];
    if ([str isEqual:@"return"] || [str isEqual:@"shift-return"]) {
        if (_dialogMode) {
            exit(0);
        }
        id x11dict = [event valueForKey:@"x11dict"];
        [x11dict setValue:@"1" forKey:@"shouldCloseWindow"];
    }
}
@end

