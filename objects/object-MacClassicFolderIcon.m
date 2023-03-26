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

static char *folderPalette =
"b #000000\n"
". #ffffff\n"
;
static char *selectedFolderPalette = 
". #000000\n"
"b #ffffff\n"
;
static char *folderPixels =
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



@interface MacClassicFolderIcon : IvarObject
{
    id _path;
    id _buttonDown;
    int _buttonDownX;
    int _buttonDownY;
    id _buttonDownTimestamp;
}
@end
@implementation MacClassicFolderIcon
- (int)preferredWidth
{
    static int w = 0;
    if (!w) {
        w = [Definitions widthForCString:folderPixels];
        if ([_path length]) {
            id bitmap = [Definitions bitmapWithWidth:1 height:1];
            [bitmap useMonacoFont];
            int textWidth = [bitmap bitmapWidthForText:_path];
            if (textWidth > w) {
                w = textWidth;
            }
        }
    }
    return w;
}
- (int)preferredHeight
{
    static int h = 0;
    if (!h) {
        h = [Definitions heightForCString:folderPixels];
        if ([_path length]) {
            id bitmap = [Definitions bitmapWithWidth:1 height:1];
            [bitmap useMonacoFont];
            int textHeight = [bitmap bitmapHeightForText:_path];
            h += textHeight;
        }
    }
    return h;
}

- (void)drawInBitmap:(id)bitmap rect:(Int4)r context:(id)context
{
    int isSelected = [context intValueForKey:@"isSelected"];

    BOOL hasFocus = NO;
    {
        id windowManager = [@"windowManager" valueForKey];
        unsigned long focusInEventWindow = [[windowManager valueForKey:@"focusInEventWindow"] unsignedLongValue];
        unsigned long win = [[context valueForKey:@"window"] unsignedLongValue];
        if (focusInEventWindow && (focusInEventWindow == win)) {
            hasFocus = YES;
        }
    }

    int w = [Definitions widthForCString:folderPixels];
    int h = [Definitions heightForCString:folderPixels];

    if (hasFocus || isSelected) {
        [bitmap drawCString:folderPixels palette:selectedFolderPalette x:r.x+(r.w-w)/2 y:r.y];
    } else {
        [bitmap drawCString:folderPixels palette:folderPalette x:r.x+(r.w-w)/2 y:r.y];
    }
    if ([_path length]) {
        [bitmap useMonacoFont];
        int textWidth = [bitmap bitmapWidthForText:_path];
        int textHeight = [bitmap bitmapHeightForText:_path];
        if (hasFocus || isSelected) {
            [bitmap setColor:@"black"];
        } else {
            [bitmap setColor:@"white"];
        }
        [bitmap fillRectangleAtX:r.x+(r.w-textWidth)/2 y:r.y+h w:textWidth h:textHeight];
        if (hasFocus || isSelected) {
            [bitmap setColor:@"white"];
        } else {
            [bitmap setColor:@"black"];
        }
        [bitmap drawBitmapText:_path x:r.x+(r.w-textWidth)/2 y:r.y+h];
    }

    id windowManager = [@"windowManager" valueForKey];
    unsigned long win = [[context valueForKey:@"window"] unsignedLongValue];
    if (win) {
        [windowManager addMaskToWindow:win bitmap:bitmap];
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
    _buttonDown = YES;
    _buttonDownX = mouseX;
    _buttonDownY = mouseY;

    id timestamp = [Definitions gettimeofday];
    if (_buttonDownTimestamp) {
        if ([timestamp doubleValue]-[_buttonDownTimestamp doubleValue] <= 0.3) {
            [self setValue:nil forKey:@"buttonDownTimestamp"];
            if ([self respondsToSelector:@selector(handleDoubleClick)]) {
                [self handleDoubleClick];
            }
            return;
        }
    }
    [self setValue:timestamp forKey:@"buttonDownTimestamp"];
}

- (void)handleMouseMoved:(id)event
{
    id x11dict = [event valueForKey:@"x11dict"];
    id dragx11dict = [x11dict valueForKey:@"dragx11dict"];

    if (!_buttonDown && !dragx11dict) {
        return;
    }

    if (!dragx11dict) {
        int x = [x11dict intValueForKey:@"x"];
        int y = [x11dict intValueForKey:@"y"];
        int w = [x11dict intValueForKey:@"w"];
        int h = [x11dict intValueForKey:@"h"];
        id windowManager = [event valueForKey:@"windowManager"];
        id newx11dict = [windowManager openWindowForObject:self x:x y:y w:w h:h overrideRedirect:NO propertyName:"HOTDOGNOFRAME"];
        [windowManager setValue:newx11dict forKey:@"buttonDownDict"];
        [windowManager setValue:newx11dict forKey:@"menuDict"];
        [newx11dict setValue:x11dict forKey:@"dragx11dict"];
        x11dict = newx11dict;
    }

    int mouseRootX = [event intValueForKey:@"mouseRootX"];
    int mouseRootY = [event intValueForKey:@"mouseRootY"];

    int newX = mouseRootX - _buttonDownX;
    int newY = mouseRootY - _buttonDownY;

    [x11dict setValue:nsfmt(@"%d", newX) forKey:@"x"];
    [x11dict setValue:nsfmt(@"%d", newY) forKey:@"y"];

    [x11dict setValue:nsfmt(@"%d %d", newX, newY) forKey:@"moveWindow"];
}
- (void)handleMouseUp:(id)event
{
    _buttonDown = NO;
    id x11dict = [event valueForKey:@"x11dict"];
    id dragx11dict = [x11dict valueForKey:@"dragx11dict"];
    if (dragx11dict) {
        [x11dict setValue:nil forKey:@"dragx11dict"];

        id windowManager = [event valueForKey:@"windowManager"];
        unsigned long window = [x11dict unsignedLongValueForKey:@"window"];
        int mouseRootX = [event intValueForKey:@"mouseRootX"];
        int mouseRootY = [event intValueForKey:@"mouseRootY"];

        unsigned long underneathWindow = [windowManager topMostWindowUnderneathWindow:window x:mouseRootX y:mouseRootY];
        if (underneathWindow) {
            id underneathx11dict = [windowManager dictForObjectWindow:underneathWindow];
            if (underneathx11dict == dragx11dict) {
                [dragx11dict setValue:@"1" forKey:@"shouldCloseWindow"];
                return;
            }

            id object = [underneathx11dict valueForKey:@"object"];
            if ([object respondsToSelector:@selector(handleDragAndDrop:)]) {
                [x11dict setValue:@"1" forKey:@"shouldCloseWindow"];
                [object handleDragAndDrop:dragx11dict];
                return;
            }
        }

        [dragx11dict setValue:@"1" forKey:@"shouldCloseWindow"];
    }
}
- (void)handleRightMouseDown:(id)event
{
    id windowManager = [event valueForKey:@"windowManager"];
    int mouseRootX = [event intValueForKey:@"mouseRootX"];
    int mouseRootY = [event intValueForKey:@"mouseRootY"];

    id obj = nil;//[[menuCSV parseCSVFromString] asMenu];
    if (obj) {
        [obj setValue:self forKey:@"contextualObject"];
        [windowManager openButtonDownMenuForObject:obj x:mouseRootX y:mouseRootY w:0 h:0];
    }
}
- (void)handleDoubleClick
{
    [self handleOpen];
}
- (void)handleOpen
{
    if ([_path length]) {
        id cmd = nsarr();
        [cmd addObject:@"hotdog"];
        [cmd addObject:@"macclassicdir"];
        [cmd addObject:_path];
        [cmd runCommandInBackground];
    }
}
- (void)handleDragAndDrop:(id)obj
{
    [nsfmt(@"%@ dropped onto %@", obj, self) showAlert];
}
@end

