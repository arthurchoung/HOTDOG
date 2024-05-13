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

static char *radio_pixels =
"    bbbb    \n"
"  bb    bb  \n"
" b        b \n"
" b        b \n"
"b          b\n"
"b          b\n"
"b          b\n"
"b          b\n"
" b        b \n"
" b        b \n"
"  bb    bb  \n"
"    bbbb    \n"
;
static char *radio_selected_pixels =
"            \n"
"            \n"
"            \n"
"    bbbb    \n"
"   bbbbbb   \n"
"   bbbbbb   \n"
"   bbbbbb   \n"
"   bbbbbb   \n"
"    bbbb    \n"
"            \n"
"            \n"
"            \n"
;
static char *radio_down_pixels =
"    bbbb    \n"
"  bbbbbbbb  \n"
" bbb    bbb \n"
" bb      bb \n"
"bb        bb\n"
"bb        bb\n"
"bb        bb\n"
"bb        bb\n"
" bb      bb \n"
" bbb    bbb \n"
"  bbbbbbbb  \n"
"    bbbbb   \n"
;

#define MAX_RADIO 20

@implementation Definitions(fjewmfnkdslnfsdjffdsjkflsdmkmklk)
+ (id)AmigaRadio
{
    id lines = [Definitions linesFromStandardInput];
    id obj = [@"AmigaRadio" asInstance];
    [obj setValue:lines forKey:@"array"];
    return obj;
}
@end

@interface AmigaRadio : IvarObject
{
    int _dialogMode;
    id _text;
    id _array;
    int _selectedIndex;
    Int4 _rect[MAX_RADIO];
    char _down;
    char _hover;
    Int4 _okRect;
    Int4 _cancelRect;
    id _okText;
    id _cancelText;
}
@end
@implementation AmigaRadio
- (int)preferredWidth
{
    return 640;
}
- (int)preferredHeight
{
    id bitmap = [Definitions bitmapWithWidth:1 height:1];
    [bitmap useTopazFont];
    int lineHeight = [bitmap bitmapHeightForText:@"X"];
    int radioWidth = [Definitions widthForCString:radio_pixels];
    int h = 16;
    int w = 640;
    {
        id text = [bitmap fitBitmapString:_text width:w-16*2];
        h += [bitmap bitmapHeightForText:text] + lineHeight;
    }
    for (int i=0; i<[_array count]; i++) {
        id elt = [_array nth:i];
        id text = [elt valueForKey:@"text"];
        if (!text) {
            text = elt;
        }
        text = [bitmap fitBitmapString:text width:w-radioWidth-10-lineHeight];
        h += [bitmap bitmapHeightForText:text] + lineHeight;
    }
    h += 50;
    return h;
}
- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    [bitmap useTopazFont];
    [bitmap setColor:@"white"];
    [bitmap fillRect:r];
    [bitmap setColor:@"#0055aa"];
    int rightBorder = 14;
    [bitmap fillRectangleAtX:r.x+r.w-rightBorder y:r.y w:rightBorder h:r.h];
    [bitmap setColor:@"#0055aa"];

    // border

    [bitmap drawRectangleAtX:r.x y:r.y x:r.x+r.w-1-rightBorder y:r.y+r.h-1];
    [bitmap drawRectangleAtX:r.x+1 y:r.y+1 x:r.x+r.w-2-rightBorder y:r.y+r.h-2];

    [bitmap drawRectangleAtX:r.x+3 y:r.y+4 x:r.x+r.w-4-rightBorder y:r.y+r.h-5];
    [bitmap drawRectangleAtX:r.x+4 y:r.y+5 x:r.x+r.w-5-rightBorder y:r.y+r.h-6];

    // text

    int lineHeight = [bitmap bitmapHeightForText:@"X"];
    int x = r.x+lineHeight;
    int y = r.y + 16;
    {
        id text = [bitmap fitBitmapString:_text width:r.w-16*2];
        [bitmap drawBitmapText:text x:r.x+16 y:y];
        int textHeight = [bitmap bitmapHeightForText:text];
        y += textHeight;
        y += lineHeight;
    }

    // buttons

    int radioWidth = [Definitions widthForCString:radio_pixels];
    int radioHeight = [Definitions heightForCString:radio_pixels];
    for (int i=0; i<[_array count]; i++) {
        id elt = [_array nth:i];
        id text = [elt valueForKey:@"text"];
        if (!text) {
            text = elt;
        }
        _rect[i].x = x;
        _rect[i].y = y;
        text = [bitmap fitBitmapString:text width:r.w-radioWidth-10-(r.x-x)];
        int textWidth = [bitmap bitmapWidthForText:text];
        int textHeight = [bitmap bitmapHeightForText:text];
        _rect[i].w = radioWidth+10+textWidth;
        _rect[i].h = textHeight;
        char *str = radio_pixels;
        if ((_down==i+1) && (_hover==i+1)) {
            str = radio_down_pixels;
        }
        [bitmap drawCString:str x:x y:y+1 c:'b' r:0x00 g:0x55 b:0xaa a:255];
        if (_selectedIndex == i) {
            [bitmap drawCString:radio_selected_pixels x:x y:y+1 c:'b' r:0x00 g:0x55 b:0xaa a:255];
        }
        [bitmap drawBitmapText:text x:x+radioWidth+10 y:y];
        y += textHeight + lineHeight;
    }

    // ok button

    if (_okText) {
        int textWidth = [bitmap bitmapWidthForText:_okText];
        int innerWidth = 50;
        if (textWidth > innerWidth) {
            innerWidth = textWidth;
        }
        _okRect.x = r.x+r.w-rightBorder-10-(innerWidth+16);
        _okRect.y = r.y+r.h-40;
        _okRect.w = innerWidth+16;
        _okRect.h = 30;
        if ((_down == 'o') && (_hover == 'o')) {
            [bitmap setColor:@"black"];
            [bitmap fillRect:_okRect];
        }
        [bitmap setColor:@"#ff8800"];
        [bitmap drawRectangle:_okRect];
        [bitmap setColor:@"#0055aa"];
        Int4 r1 = _okRect;
        r1.x += 1;
        r1.w -= 2;
        r1.y += 4;
        r1.h -= 8;
        [bitmap drawRectangle:r1];
        [bitmap drawBitmapText:_okText x:_okRect.x+(_okRect.w-textWidth)/2 y:_okRect.y+8];
    } else {
        _okRect.x = 0;
        _okRect.y = 0;
        _okRect.w = 0;
        _okRect.h = 0;
    }

    // cancel button

    if (_cancelText) {
        int textWidth = [bitmap bitmapWidthForText:_cancelText];
        int innerWidth = 50;
        if (textWidth > innerWidth) {
            innerWidth = textWidth;
        }
        _cancelRect.x = r.x+10;
        _cancelRect.y = r.y+r.h-40;
        _cancelRect.w = innerWidth+16;
        _cancelRect.h = 30;
        if ((_down == 'c') && (_hover == 'c')) {
            [bitmap setColor:@"black"];
            [bitmap fillRect:_cancelRect];
        }
        [bitmap setColor:@"#ff8800"];
        [bitmap drawRectangle:_cancelRect];
        [bitmap setColor:@"#0055aa"];
        Int4 r1 = _cancelRect;
        r1.x += 1;
        r1.w -= 2;
        r1.y += 4;
        r1.h -= 8;
        [bitmap drawRectangle:r1];
        [bitmap drawBitmapText:_cancelText x:_cancelRect.x+(_cancelRect.w-textWidth)/2 y:_cancelRect.y+8];
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
        _down = 'o';
        _hover = 'o';
        return;
    }
    if (_cancelText && [Definitions isX:mouseX y:mouseY insideRect:_cancelRect]) {
        _down = 'c';
        _hover = 'c';
        return;
    }
    for (int i=0; i<[_array count]; i++) {
        if ([Definitions isX:mouseX y:mouseY insideRect:_rect[i]]) {
            _down = i+1;
            _hover = i+1;
            return;
        }
    }
    _down = 0;
    _hover = 0;
}
- (void)handleMouseMoved:(id)event
{
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    if (_okText && [Definitions isX:mouseX y:mouseY insideRect:_okRect]) {
        _hover = 'o';
        return;
    }
    if (_cancelText && [Definitions isX:mouseX y:mouseY insideRect:_cancelRect]) {
        _hover = 'c';
        return;
    }
    for (int i=0; i<[_array count]; i++) {
        if ([Definitions isX:mouseX y:mouseY insideRect:_rect[i]]) {
            _hover = i+1;
            return;
        }
    }
    _hover = 0;
}
- (void)handleMouseUp:(id)event
{
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    if (_down && (_down == _hover)) {
        if (_down == 'o') {
            if (_dialogMode) {
                id elt = [_array nth:_selectedIndex];
                id tag = [elt valueForKey:@"tag"];
                if (_dialogMode == 1) {
                    NSOut(@"%@", (tag) ? tag : elt);
                } else {
                    NSErr(@"%@", (tag) ? tag : elt);
                }
                exit(0);
            }
        } else if (_down == 'c') {
            if (_dialogMode) {
                exit(1);
            }
        } else {
            _selectedIndex = _down-1;
        }
    }
    _down = 0;
}
- (void)handleKeyDown:(id)event
{
    id keyString = [event valueForKey:@"keyString"];
    if ([keyString isEqual:@"return"]) {
        if (_dialogMode) {
            id elt = [_array nth:_selectedIndex];
            id tag = [elt valueForKey:@"tag"];
            if (_dialogMode == 1) {
                NSOut(@"%@", (tag) ? tag : elt);
            } else {
                NSErr(@"%@", (tag) ? tag : elt);
            }
            exit(0);
        }
    }
}
@end

