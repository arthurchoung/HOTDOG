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

@implementation Definitions(fjewmfnkdslnfsdjffdsjkflsdmkmklfdsjfjdskfjk)
+ (id)MacRadio
{
    id lines = [Definitions linesFromStandardInput];
    id obj = [@"MacRadio" asInstance];
    [obj setValue:@"jfkdlsjflkdsjfkljdsklf" forKey:@"text"];
    [obj setValue:lines forKey:@"array"];
    [obj setValue:@"OK" forKey:@"okText"];
    [obj setValue:@"Cancel" forKey:@"cancelText"];
    [obj setValue:@"1" forKey:@"dialogMode"];
    return obj;
}
@end

@interface MacRadio : IvarObject
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
@implementation MacRadio
- (int)preferredWidth
{
    return 640;
}
- (int)preferredHeight
{
    id bitmap = [Definitions bitmapWithWidth:1 height:1];
    int lineHeight = [bitmap bitmapHeightForText:@"X"];
    int radioWidth = [Definitions widthForCString:radio_pixels];
    int h = 24;
    int w = 640-89-18;
    {
        id text = [bitmap fitBitmapString:_text width:w];
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
    h += 21 + 28 + 21;
    return h;
}
- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    [Definitions drawAlertBorderInBitmap:bitmap rect:r];
    char *palette = "b #000000\n. #ffffff\n";
    [bitmap drawCString:[Definitions cStringForBitmapMessageIcon] palette:palette x:28 y:28];

    int x = 89;
    int y = 24;

    int lineHeight = [bitmap bitmapHeightForText:@"X"];

    // text

    {
        int textWidth = r.w - x - 18;
        id text = [bitmap fitBitmapString:_text width:textWidth];
        int textHeight = [bitmap bitmapHeightForText:text];
        [bitmap setColorIntR:0 g:0 b:0 a:255];
        [bitmap drawBitmapText:text x:x y:y];
        y += textHeight + lineHeight;
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
        [bitmap drawCString:str x:x y:y c:'b' r:0 g:0 b:0 a:255];
        if (_selectedIndex == i) {
            [bitmap drawCString:radio_selected_pixels x:x y:y c:'b' r:0 g:0 b:0 a:255];
        }
        [bitmap drawBitmapText:text x:x+radioWidth+10 y:y+1];
        y += textHeight + lineHeight;
    }
    // ok button

    if (_okText) {
        _okRect = [Definitions rectWithX:r.w-88 y:r.h-21-28 w:70 h:28];
        Int4 innerRect = _okRect;
        innerRect.y += 1;
        if ((_down == 'o') && (_hover == 'o')) {
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
        if ((_down == 'c') && (_hover == 'c')) {
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
                FILE *fp = (_dialogMode == 1) ? stdout : stderr;
                id elt = [_array nth:_selectedIndex];
                id tag = [elt valueForKey:@"tag"];
                fprintf(fp, "%@", (tag) ? tag : elt);
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
            FILE *fp = (_dialogMode == 1) ? stdout : stderr;
            id elt = [_array nth:_selectedIndex];
            id tag = [elt valueForKey:@"tag"];
            fprintf(fp, "%@", (tag) ? tag : elt);
            exit(0);
        }
    }
}
@end

