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

static char *documentPalette =
"b #000000\n"
". #080000\n"
"X #080808\n"
"o #080810\n"
"O #101010\n"
"+ #181818\n"
"@ #182020\n"
"# #202020\n"
"$ #202820\n"
"% #202028\n"
"& #282828\n"
"* #302828\n"
"= #283028\n"
"- #303030\n"
"; #383838\n"
": #404040\n"
"> #404048\n"
", #404848\n"
"< #484848\n"
"1 #485050\n"
"2 #505050\n"
"3 #505058\n"
"4 #585858\n"
"5 #606060\n"
"6 #706868\n"
"7 #707070\n"
"8 #787878\n"
"9 #787880\n"
"0 #808080\n"
"q #888888\n"
"w #909090\n"
"e #989898\n"
"r #A0A0A0\n"
"t #a8a8a8\n"
"y #b0b0b0\n"
"u #b8b8b8\n"
"i #C0C0C0\n"
"p #D0D0D0\n"
"a #D8D8D8\n"
"s #e0e0e0\n"
"d #e8e8e8\n"
"f #f0f0f0\n"
"g #F8F8F8\n"
;
static char *documentPixels =
"54444222<<<<:::;;;;s            \n"
"4ggggggfffffddddds:2s           \n"
"4ggggggfffffddddds>i4s          \n"
"4ggggggfffffddddds<fu5s         \n"
"4ggggggfffffddddds2gsy4s        \n"
"4ggggggfffffddddds2ggat2s       \n"
"3ggggggfffffddddds2<<:;-*       \n"
"2ggggggfffffdddddsp09876&       \n"
"2ggggggfffffdddddssuytte&       \n"
"2ggggggfffffdddddsssssae&       \n"
"2ggggggfffffdddddsssssae%       \n"
"1ggggggfffffdddddsssssae#       \n"
"<ggggggfffffdddddsssssae#       \n"
"<ggggggfffffdddddsssssar#       \n"
"<ggggggfffffdddddsssssar#       \n"
"<ggggggfffffdddddsssssar+       \n"
",ggggggfffffdddddsssssar+       \n"
":ggggggfffffdddddsssssar+       \n"
":ggggggfffffdddddsssssat+       \n"
":ggggggfffffdddddsssssatO       \n"
":ggggggfffffdddddsssssatO       \n"
":ggggggfffffdddddsssssatO       \n"
";ggggggfffffdddddsssssatO       \n"
";ggggggfffffdddddsssssato       \n"
";ggggggfffffdddddsssssayX       \n"
";ggggggfffffdddddsssssayX       \n"
";ggggggfffffdddddsssssayXad     \n"
"-ggggggfffffdddddsssssay.ruad   \n"
"-ggggggfffffdddddsssssaybqruiad \n"
"-ggggggfffffdddddsssssaub8qrtusf\n"
"-ggggggfffffdddddsssssaub88wris \n"
"-=&&&$###@++++OOOOXXXXXbb80euaf \n"
;
static char *selectedDocumentPalette =
"b #000000\n"
". #000008\n"
"X #080808\n"
"o #081010\n"
"O #101010\n"
"+ #181010\n"
"@ #101810\n"
"# #181818\n"
"$ #202020\n"
"% #202828\n"
"& #282828\n"
"* #303030\n"
"= #383030\n"
"- #383838\n"
"; #383840\n"
": #404040\n"
"> #484848\n"
", #505050\n"
"< #585858\n"
"1 #606060\n"
"2 #686868\n"
"3 #707070\n"
"4 #787878\n"
"5 #888888\n"
"6 #909090\n"
"7 #989898\n"
"8 #A0A0A0\n"
"9 #b0b0b0\n"
"0 #b8b8b8\n"
"q #D0D0D0\n"
"w #D8D8D8\n"
"e #e0e0e0\n"
"r #e8e8e8\n"
"t #f0f0f0\n"
"y #F8F8F8\n"
;
static char *selectedDocumentPixels =
"*&&&&&&&$$$$$$$####e            \n"
"&44444444444333333$&e           \n"
"&44444444444333333$1&e          \n"
"&44444444444333333$4<*e         \n"
"&44444444444333333&43<&e        \n"
"&44444444444333333&442,&e       \n"
"&44444444444333333&$$$##+       \n"
"&444444444443333332:;--=O       \n"
"&444444444443333333<<,,>O       \n"
"&4444444444433333333332>O       \n"
"&4444444444433333333332>O       \n"
"%4444444444433333333332>O       \n"
"$4444444444433333333332>O       \n"
"$4444444444433333333332,O       \n"
"$4444444444433333333332,O       \n"
"$4444444444433333333332,X       \n"
"$4444444444433333333332,X       \n"
"$4444444444433333333332,X       \n"
"$4444444444433333333332,X       \n"
"$4444444444433333333332,X       \n"
"$4444444444433333333332,X       \n"
"$4444444444433333333332,X       \n"
"#4444444444433333333332,X       \n"
"#4444444444433333333332,.       \n"
"#4444444444433333333332<b       \n"
"#4444444444433333333332<b       \n"
"#4444444444433333333332<bqr     \n"
"#4444444444433333333332<b69qr   \n"
"#4444444444433333333332<b3690qr \n"
"#4444444444433333333332<b23689wt\n"
"#4444444444433333333332<b11470e \n"
"#@OOOOOOOoXXXXXXXXbbbbbbb1359qt \n"
;


@interface MacPlatinumDocumentIcon : IvarObject
{
    id _path;
    BOOL _buttonDown;
    int _buttonDownX;
    int _buttonDownY;
    id _buttonDownTimestamp;
}
@end
@implementation MacPlatinumDocumentIcon
- (int)preferredWidth
{
    static int w = 0;
    if (!w) {
        w = [Definitions widthForCString:documentPixels];
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
        h = [Definitions heightForCString:documentPixels];
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

    int w = [Definitions widthForCString:documentPixels];
    int h = [Definitions heightForCString:documentPixels];

    if (hasFocus || isSelected) {
        [bitmap drawCString:selectedDocumentPixels palette:selectedDocumentPalette x:r.x+(r.w-w)/2 y:r.y];
    } else {
        [bitmap drawCString:documentPixels palette:documentPalette x:r.x+(r.w-w)/2 y:r.y];
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
        [cmd addObject:@"maccolordir"];
        [cmd addObject:_path];
        [cmd runCommandInBackground];
    }
}
- (void)handleDragAndDrop:(id)obj
{
    [nsfmt(@"%@ dropped onto %@", obj, self) showAlert];
}
@end

