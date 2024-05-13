/*

 HOTDOG

 Copyright (c) 2020 Arthur Choung. All rights reserved.

 Email: arthur -at- hotdogpucko.com

 This file is part of HOTDOG.

 HOTDOG is free software: you can redistribute it and/or modify
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

static unsigned char *bitmapButtonLeftPixels =
"   b\n"
" bb.\n"
" b..\n"
"b...\n"
"b...\n"
"b...\n"
"b...\n"
"b...\n"
"b...\n"
"b...\n"
"b...\n"
"b...\n"
"b...\n"
"b...\n"
"b...\n"
"b...\n"
"b...\n"
" b..\n"
" bb.\n"
"   b\n"
;
static unsigned char *bitmapButtonMiddlePixels =
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
".\n"
".\n"
"b\n"
;
static unsigned char *bitmapButtonRightPixels =
"b   \n"
".bb \n"
"..b \n"
"...b\n"
"...b\n"
"...b\n"
"...b\n"
"...b\n"
"...b\n"
"...b\n"
"...b\n"
"...b\n"
"...b\n"
"...b\n"
"...b\n"
"...b\n"
"...b\n"
"..b \n"
".bb \n"
"b   \n"
;

static void drawButtonInBitmap_rect_palette_(id bitmap, Int4 r, unsigned char *palette)
{
    unsigned char *left = bitmapButtonLeftPixels;
    unsigned char *middle = bitmapButtonMiddlePixels;
    unsigned char *right = bitmapButtonRightPixels;

    [Definitions drawInBitmap:bitmap left:left middle:middle right:right centeredInRect:r palette:palette];
}


static unsigned char *bitmapDefaultButtonLeftPixels =
"     bbb\n"
"   bbbbb\n"
"  bbbbbb\n"
" bbbbwww\n"
" bbbwwwb\n"
"bbbwwbb.\n"
"bbbwwb..\n"
"bbbwb...\n"
"bbbwb...\n"
"bbbwb...\n"
"bbbwb...\n"
"bbbwb...\n"
"bbbwb...\n"
"bbbwb...\n"
"bbbwb...\n"
"bbbwb...\n"
"bbbwb...\n"
"bbbwb...\n"
"bbbwb...\n"
"bbbwb...\n"
"bbbwb...\n"
"bbbwb...\n"
"bbbwwb..\n"
"bbbwwbb.\n"
" bbbwwwb\n"
" bbbbwww\n"
"  bbbbbb\n"
"   bbbbb\n"
"     bbb\n"
;
static unsigned char *bitmapDefaultButtonMiddlePixels =
"b\n"
"b\n"
"b\n"
"w\n"
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
".\n"
".\n"
".\n"
"b\n"
"w\n"
"b\n"
"b\n"
"b\n"
;
static unsigned char *bitmapDefaultButtonRightPixels =
"bbb     \n"
"bbbbb   \n"
"bbbbbb  \n"
"wwwbbbb \n"
"bwwwbbb \n"
".bbwwbbb\n"
"..bwwbbb\n"
"...bwbbb\n"
"...bwbbb\n"
"...bwbbb\n"
"...bwbbb\n"
"...bwbbb\n"
"...bwbbb\n"
"...bwbbb\n"
"...bwbbb\n"
"...bwbbb\n"
"...bwbbb\n"
"...bwbbb\n"
"...bwbbb\n"
"...bwbbb\n"
"...bwbbb\n"
"...bwbbb\n"
"..bwwbbb\n"
".bbwwbbb\n"
"bwwwbbb \n"
"wwwbbbb \n"
"bbbbbb  \n"
"bbbbb   \n"
"bbb     \n"
;
static void drawDefaultButtonInBitmap_rect_palette_(id bitmap, Int4 r, unsigned char *palette)
{
    unsigned char *left = bitmapDefaultButtonLeftPixels;
    unsigned char *middle = bitmapDefaultButtonMiddlePixels;
    unsigned char *right = bitmapDefaultButtonRightPixels;

    [Definitions drawInBitmap:bitmap left:left middle:middle right:right centeredInRect:r palette:palette];
}



static void drawAlertBorderInBitmap_rect_(id bitmap, Int4 r)
{
    [bitmap setColor:@"white"];
    [bitmap fillRect:r];
    unsigned char *pixels = [bitmap pixelBytes];
    if (!pixels) {
        return;
    }
    int bitmapWidth = [bitmap bitmapWidth];
    int bitmapHeight = [bitmap bitmapHeight];
    int bitmapStride = [bitmap bitmapStride];
    for (int i=0; i<bitmapWidth; i++) {
        unsigned char *p = pixels + i*4;
        p[0] = 0; p[1] = 0; p[2] = 0; p[3] = 0;
    }
    for (int i=3; i<bitmapWidth-3; i++) {
        unsigned char *p = pixels + bitmapStride*3 + i*4;
        p[0] = 0; p[1] = 0; p[2] = 0; p[3] = 0;
    }
    for (int i=4; i<bitmapWidth-4; i++) {
        unsigned char *p = pixels + bitmapStride*4 + i*4;
        p[0] = 0; p[1] = 0; p[2] = 0; p[3] = 0;
    }

    for (int i=0; i<bitmapWidth; i++) {
        unsigned char *p = pixels + bitmapStride*(bitmapHeight-1) + i*4;
        p[0] = 0; p[1] = 0; p[2] = 0; p[3] = 0;
    }
    for (int i=3; i<bitmapWidth-3; i++) {
        unsigned char *p = pixels + bitmapStride*(bitmapHeight-1-3) + i*4;
        p[0] = 0; p[1] = 0; p[2] = 0; p[3] = 0;
    }
    for (int i=4; i<bitmapWidth-4; i++) {
        unsigned char *p = pixels + bitmapStride*(bitmapHeight-1-4) + i*4;
        p[0] = 0; p[1] = 0; p[2] = 0; p[3] = 0;
    }

    for (int i=1; i<bitmapHeight-1; i++) {
        unsigned char *p = pixels + bitmapStride*i + 0;
        p[0] = 0; p[1] = 0; p[2] = 0; p[3] = 0;
    }
    for (int i=1; i<bitmapHeight-1; i++) {
        unsigned char *p = pixels + bitmapStride*i + (bitmapWidth-1)*4;
        p[0] = 0; p[1] = 0; p[2] = 0; p[3] = 0;
    }
    for (int i=4; i<bitmapHeight-4; i++) {
        unsigned char *p = pixels + bitmapStride*i + 3*4;
        p[0] = 0; p[1] = 0; p[2] = 0; p[3] = 0;
    }
    for (int i=4; i<bitmapHeight-4; i++) {
        unsigned char *p = pixels + bitmapStride*i + (bitmapWidth-1-3)*4;
        p[0] = 0; p[1] = 0; p[2] = 0; p[3] = 0;
    }
    for (int i=5; i<bitmapHeight-5; i++) {
        unsigned char *p = pixels + bitmapStride*i + 4*4;
        p[0] = 0; p[1] = 0; p[2] = 0; p[3] = 0;
    }
    for (int i=5; i<bitmapHeight-5; i++) {
        unsigned char *p = pixels + bitmapStride*i + (bitmapWidth-1-4)*4;
        p[0] = 0; p[1] = 0; p[2] = 0; p[3] = 0;
    }

}


#if defined(BUILD_FOR_LINUX) || defined(BUILD_FOR_FREEBSD)
@implementation Definitions(fjdklsjflkdsjlkfdsljkfkjsdmvcxki)
+ (id)inputNumberWithAlert:(id)text
{
    return [self inputTextWithAlert:text];
}

+ (id)inputTextWithAlert:(id)text
{
    return [Definitions inputTextWithAlert:text hidden:NO];
}
+ (id)inputTextWithAlert:(id)text hidden:(BOOL)hidden
{
    text = [text keepAlphanumericCharactersAndSpacesAndPunctuationAndNewlines];
    id quotedTitle = nil;
    id quotedText = nil;
    id lines = [text split:@"\n"];
    if ([lines count] > 1) {
        quotedTitle = [[lines nth:0] asQuotedString];
        quotedText = [[[lines subarrayFromIndex:1] join:@"\n"] asQuotedString];
    } else {
        quotedTitle = [text asQuotedString];
        quotedText = quotedTitle;
    }
    id message = nsfmt(@"TextInputDialog:%@ field:%@%@|showInXWindowWithWidth:%d height:%d|exit:0", quotedTitle, quotedText, (hidden) ? @" hidden:1" : @"", 600, 400);
    id cmd = nsarr();
    [cmd addObject:@"hotdog"];
    [cmd addObject:message];
    id outputData = [cmd runCommandAndReturnOutput];
    if (!outputData) {
        return nil;
    }
    id output = [outputData asString];
    if ([output length]) {
        return output;
    }
    return nil;
}
@end
@implementation NSObject(jfkldslkfjkdslfj)
- (void)inputNumberWithAlert:(id)text title:(id)title key:(id)key continuation:(id)continuation
{
    [self inputTextWithAlert:text title:title key:key continuation:continuation];
}
- (void)inputTextWithAlert:(id)text title:(id)title key:(id)key continuation:(id)continuation
{
    id quotedText = [[[self str:text] keepAlphanumericCharactersAndSpacesAndPunctuationAndNewlines] asQuotedString];
    id quotedTitle = [[[self str:title] keepAlphanumericCharactersAndSpacesAndPunctuationAndNewlines] asQuotedString];
    id message = nsfmt(@"TextInputDialog:%@ field:%@|showInXWindowWithWidth:%d height:%d|exit:0", quotedTitle, quotedText, 600, 400);
    id cmd = nsarr();
    [cmd addObject:@"hotdog"];
    [cmd addObject:message];
    id outputData = [cmd runCommandAndReturnOutput];
    if (!outputData) {
        return;
    }
    id output = [outputData asString];
    if ([output length]) {
        [[Definitions interfaceObject] setValue:output forKey:key];
        [self evaluateMessage:continuation];
    }
}


@end
#endif

@implementation Definitions(jfldslkfjdslkjfzkvjbvie)
+ (id)TextInputDialog:(id)text field:(id)field hidden:(BOOL)hidden
{
    id obj = [Definitions TextInputDialog:text field:field];
    [obj setValue:@"1" forKey:@"hideText"];
    return obj;
}
+ (id)TextInputDialog:(id)text field:(id)field
{
    id obj = [@"TextInputDialog" asInstance];
    [obj setValue:text forKey:@"text"];
    id fields = nsarr();
    [fields addObject:field];
    [obj setValue:fields forKey:@"fields"];
    return obj;
}
+ (int)preferredHeightForTextInputDialog:(id)text width:(int)width
{
    int textWidth = width - 89 - 18;
    id fittedText = [Definitions fitBitmapString:text width:textWidth];

    int minAlertHeight = 28 + 32 + 23 + 28 + 21;
    int textHeight = [Definitions bitmapHeightForText:fittedText];
    int alertHeight = 24 + textHeight + 20 + 28 + 21;
    if (alertHeight < minAlertHeight) {
        alertHeight = minAlertHeight;
    }
    return alertHeight;
}
@end

@interface TextInputDialog: IvarObject
{
    id _text;
    int _numberOfRects;
    Int4 _rects[2];
    int _buttonDown;
    int _buttonHover;
    id _fields;
    id _buffers;
    int _cursorBlink;
    int _cursorPos;
    int _currentField;
    int _returnKey;
    BOOL _hideText;
}
@end
@implementation TextInputDialog
- (void)handleBackgroundUpdate:(id)event
{
    _cursorBlink--;
    if (_cursorBlink < 0) {
        _cursorBlink = 1;
    }
}
- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    drawAlertBorderInBitmap_rect_(bitmap, r);

    int textHeight = [bitmap bitmapHeightForText:@"A"];

    int fieldWidth = 0;
    for (int i=0; i<[_fields count]; i++) {
        int w = [bitmap bitmapWidthForText:[_fields nth:i]];
        if (w > fieldWidth) {
            fieldWidth = w;
        }
    }

    int y = 20;

    int textWidth = (int)r.w - 20 - fieldWidth - 18;
    id text = [bitmap fitBitmapString:_text width:textWidth];
NSLog(@"text '%@'", text);
    [bitmap setColorIntR:0 g:0 b:0 a:255];
    [bitmap drawBitmapText:text x:10+fieldWidth+10+4 y:y];

    y += [Definitions bitmapHeightForText:text];
    y += 15;

    {
        int x = 5;
        for (int i=0; i<[_fields count]; i++) {
            id field = [_fields nth:i];
            [bitmap setColorIntR:0 g:0 b:0 a:255];
            [bitmap drawBitmapText:field x:10+fieldWidth-[bitmap bitmapWidthForText:field] y:y+6];

            int x = 10 + fieldWidth + 10;
            [bitmap setColor:@"black"];
            [bitmap fillRectangleAtX:x y:y w:r.w-x-10 h:22];
            [bitmap setColor:@"white"];
            [bitmap fillRectangleAtX:x+1 y:y+1 w:r.w-x-10-2 h:22-2];

            id str = [_buffers nth:i];
            if (_hideText) {
                if ([str length]) {
                    id hideStr = @"*******************************";
                    int maxHideLen = [hideStr length];
                    int hideLen = [str length];
                    if (hideLen > maxHideLen) {
                        hideLen = maxHideLen;
                    }
                    str = [hideStr substringToIndex:hideLen];
                }
            }
            if (!str) {
                str = @"";
            }
            id left = [str stringToIndex:_cursorPos];
            id right = [str stringFromIndex:_cursorPos];

            if ([left length]) {
                [bitmap setColorIntR:0 g:0 b:0 a:255];
                [bitmap drawBitmapText:left x:x+4 y:y+6];
                x += [bitmap bitmapWidthForText:left]+2;
            }
            if (_currentField == i) {
                if (_cursorBlink) {
                    [bitmap setColor:@"black"];
                    [bitmap drawVerticalLineAtX:x-1+4 y:y+3 y:y+12+6];
                }
            }
            if ([right length]) {
                [bitmap setColorIntR:0 g:0 b:0 a:255];
                [bitmap drawBitmapText:right x:x+4 y:y+6];
            }

            y -= 27;
        }
    }

    ////

    Int4 okButtonRect = [Definitions rectWithX:r.w-88 y:r.y+r.h-21-28 w:70 h:28];
    _rects[0] = okButtonRect;
    BOOL okButtonDown = NO;
    if ((_buttonDown == 1) && (_buttonDown == _buttonHover)) {
        okButtonDown = YES;
    } else if (_returnKey) {
        okButtonDown = YES;
    }
    if (okButtonDown) {
        char *palette = ". #000000\nb #000000\nw #ffffff\n";
        drawDefaultButtonInBitmap_rect_palette_(bitmap, okButtonRect, palette);
        [bitmap setColorIntR:255 g:255 b:255 a:255];
        [bitmap drawBitmapText:@"OK" centeredInRect:okButtonRect];
    } else {
        char *palette = ". #ffffff\nb #000000\nw #ffffff\n";
        drawDefaultButtonInBitmap_rect_palette_(bitmap, okButtonRect, palette);
        [bitmap setColorIntR:0 g:0 b:0 a:255];
        [bitmap drawBitmapText:@"OK" centeredInRect:okButtonRect];
    }
    Int4 cancelButtonRect = [Definitions rectWithX:r.w-88-70-35 y:r.y+r.h-21-28 w:70 h:28];
    _rects[1] = cancelButtonRect;
    _numberOfRects = 2;
    if ((_buttonDown == 2) && (_buttonDown == _buttonHover)) {
        char *palette = ". #000000\nb #000000\nw #ffffff\n";
        drawButtonInBitmap_rect_palette_(bitmap, cancelButtonRect, palette);
        [bitmap setColorIntR:255 g:255 b:255 a:255];
        [bitmap drawBitmapText:@"Cancel" centeredInRect:cancelButtonRect];
    } else {
        char *palette = ". #ffffff\nb #000000\nw #ffffff\n";
        drawButtonInBitmap_rect_palette_(bitmap, cancelButtonRect, palette);
        [bitmap setColorIntR:0 g:0 b:0 a:255];
        [bitmap drawBitmapText:@"Cancel" centeredInRect:cancelButtonRect];
    }
}
- (void)handleKeyDown:(id)event
{
    if (!_buffers) {
        id arr = nsarr();
        for (int i=0; i<[_fields count]; i++) {
            id elt = [_fields nth:i];
            [arr addObject:@""];
        }
        [self setValue:arr forKey:@"buffers"];
    }
    id buf = [_buffers nth:_currentField];
    id str = [event valueForKey:@"keyString"];
    if ([str isEqual:@"space"]) {
        str = @" ";
    }
    if ([str length] == 1) {
        if (![buf length]) {
            [_buffers replaceObjectAtIndex:_currentField withObject:str];
            _cursorPos = 1;
            _cursorBlink = 1;
        } else {
            id left = [buf stringToIndex:_cursorPos];
            id right = [buf stringFromIndex:_cursorPos];
            id newBuf = nsfmt(@"%@%@%@", left, str, right);
            [_buffers replaceObjectAtIndex:_currentField withObject:newBuf];
            _cursorPos++;
            _cursorBlink = 1;
        }
    } else if ([str hasPrefix:@"shift-"] && ([str length] == 7)) {
        if (![buf length]) {
            [_buffers replaceObjectAtIndex:_currentField withObject:[[str stringFromIndex:6] uppercaseString]];
            _cursorPos = 1;
            _cursorBlink = 1;
        } else {
            id left = [buf stringToIndex:_cursorPos];
            id right = [buf stringFromIndex:_cursorPos];
            id newBuf = nsfmt(@"%@%@%@", left, [[str stringFromIndex:6] uppercaseString], right);
            [_buffers replaceObjectAtIndex:_currentField withObject:newBuf];
            _cursorPos++;
            _cursorBlink = 1;
        }
    } else if ([str isEqual:@"left"]) {
        if (_cursorPos - 1 >= 0) {
            _cursorPos--;
        }
        _cursorBlink = 1;
    } else if ([str isEqual:@"right"]) {
        if (_cursorPos + 1 <= [buf length]) {
            _cursorPos++;
        }
        _cursorBlink = 1;
    } else if ([str isEqual:@"backspace"]) {
        if (_cursorPos >= 1) {
            id left = (_cursorPos > 1) ? [buf stringToIndex:_cursorPos-1] : @"";
            id right = [buf stringFromIndex:_cursorPos];
            id newBuf = nsfmt(@"%@%@", left, right);
            [_buffers replaceObjectAtIndex:_currentField withObject:newBuf];
            _cursorPos--;
        }
        _cursorBlink = 1;
    } else if ([str isEqual:@"return"]) {
        _returnKey = 1;
    } else if ([str isEqual:@"tab"]) {
        if ([_fields count] > 1) {
            _currentField++;
            if (_currentField >= [_fields count]) {
                _currentField = 0;
            }
            _cursorPos = [[_buffers nth:_currentField] length];
            _cursorBlink = 2;
        }
    } else if ([str isEqual:@"shift-tab"]) {
        if ([_fields count] > 1) {
            _currentField--;
            if (_currentField < 0) {
                _currentField = [_fields count]-1;
            }
            _cursorPos = [[_buffers nth:_currentField] length];
            _cursorBlink = 2;
        }
    }
}
- (void)handleKeyUp:(id)event
{
    id str = [event valueForKey:@"keyString"];
    if ([str isEqual:@"return"]) {
        if (_returnKey) {
            [self handleOKButton:event];
            _returnKey = 0;
        }
    }
}
- (void)handleMouseDown:(id)event
{
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    _buttonDown = 0;
    for (int i=0; i<_numberOfRects; i++) {
        if ([Definitions isX:mouseX y:mouseY insideRect:_rects[i]]) {
            _buttonDown = i+1;
        }
    }
}
- (void)handleMouseMoved:(id)event
{
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    _buttonHover = 0;
    for (int i=0; i<_numberOfRects; i++) {
        if ([Definitions isX:mouseX y:mouseY insideRect:_rects[i]]) {
            _buttonHover = i+1;
        }
    }
}
- (void)handleMouseUp:(id)event
{
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    int buttonUp = 0;
    for (int i=0; i<_numberOfRects; i++) {
        if ([Definitions isX:mouseX y:mouseY insideRect:_rects[i]]) {
            if (i+1 == _buttonDown) {
                buttonUp = _buttonDown;
            }
        }
    }
    _buttonDown = 0;
    if (buttonUp == 1) {
        [self handleOKButton:event];
    } else if (buttonUp == 2) {
        [self handleCancelButton:event];
    }
}
- (void)handleOKButton:(id)event
{
    id x11dict = [event valueForKey:@"x11dict"];
    [x11dict setValue:@"1" forKey:@"shouldCloseWindow"];
    [[_buffers nth:0] writeToStandardOutput];
}
- (void)handleCancelButton:(id)event
{
    id x11dict = [event valueForKey:@"x11dict"];
    [x11dict setValue:@"1" forKey:@"shouldCloseWindow"];
}
@end

