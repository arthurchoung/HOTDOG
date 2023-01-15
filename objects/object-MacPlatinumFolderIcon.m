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

static char *folderPalette =
". #202040\n"
"X #282850\n"
"o #303060\n"
"O #303068\n"
"+ #383870\n"
"@ #383878\n"
"# #505050\n"
"$ #585858\n"
"% #606060\n"
"& #686868\n"
"* #707070\n"
"= #787878\n"
"- #404080\n"
"; #404088\n"
": #484888\n"
"> #484890\n"
", #484898\n"
"< #505098\n"
"1 #5050A0\n"
"2 #5850A0\n"
"3 #5858A0\n"
"4 #5858A8\n"
"5 #5858B0\n"
"6 #6058B0\n"
"7 #6060B0\n"
"8 #6060B8\n"
"9 #6868B8\n"
"0 #6060C0\n"
"q #6868C0\n"
"w #6060C8\n"
"e #7878D8\n"
"r #7878E0\n"
"t #8078E0\n"
"y #808080\n"
"u #888888\n"
"i #909090\n"
"p #989898\n"
"a #A0A0A0\n"
"s #b8b8b8\n"
"d #8080E0\n"
"f #8080E8\n"
"g #8888E8\n"
"h #8888F0\n"
"j #9090F0\n"
"k #9898F0\n"
"l #9090F8\n"
"z #9898F8\n"
"x #A0A0F0\n"
"c #A8A0F0\n"
"v #A0A8F0\n"
"b #A8A8F0\n"
"n #A8A8F8\n"
"m #B0A8F0\n"
"M #A8B0F0\n"
"N #B0B0F0\n"
"B #B0B0F8\n"
"V #B8B0F8\n"
"C #B8B8F8\n"
"Z #C0B8F8\n"
"A #C8C8C8\n"
"S #C8C8D0\n"
"D #C8C8D8\n"
"F #D0D0D0\n"
"G #D8D8D8\n"
"H #C0C0F8\n"
"J #C8C0F8\n"
"K #C8C8F8\n"
"L #D0C8F8\n"
"P #D0D0F8\n"
"I #D8D8F8\n"
"U #e0e0e0\n"
"Y #e8e8e8\n"
"T #E0E0F8\n"
"R #F8F8F8\n"
;
static char *folderPixels =
"  41XD                          \n"
"  1zq1oD                        \n"
"84+fzzq1oD                      \n"
"7Td,+fllq1oD                    \n"
"7KKTd,@fllq1oD oooD             \n"
"6LKKKId,@flhq1oqhq1oD           \n"
"4KKKKKKId,@rhhqhfdhq1oD         \n"
"4KKKKKJHHId,@rhgfddtf5o         \n"
"4KKKKHHHHHHId,@qfddtre1D        \n"
"3KKKHHHHHHHCCId,@qdtreqoD       \n"
"2KKHHHHHHHCCCCCId,@qrre1o       \n"
"1KHHHHHHHCCCCCCCBId,@qeq.       \n"
"<HHHHHHHZCCCCCVBBBBId@q9.       \n"
"<HHHHHZCCCCCCVBBBBBBNPo0.       \n"
"<HHHHZZCCCCCVBBBBNBmbeo5.       \n"
">HHHHCCCCCCVBBBBBBmbbeo5.       \n"
">HHHZCCCCCVBBBBBBNbbbeo1.       \n"
">HHCCCCCCCBBBBNNNnbbbeo,.       \n"
":HZCCCCCCBBBBBNMbbbbbeo,.       \n"
":ZCCCCCVBBBBBNNnbbbbbeo,.       \n"
";ezCCCVBBBBBNNbbbbbbceo,.sFU    \n"
"SO-ezCBBBBBNmbbbbbbvxeo,.*isFU  \n"
"  SO-ezBBBBmbbbbbbxxxeo,.$&*isFY\n"
"    SO-ezBBnbbbbbxxxxeo,.#$%*uaF\n"
"      SO-ezbbbbbxxxxxeo,.##$%*yA\n"
"        SO-ezbbbxxxxxeo,.##$&=pA\n"
"          SO-ejxxxxxxeo,.#$%*ysU\n"
"            SO-ejxxxkeo,.$%*ysG \n"
"              SO-ejkkeo,.&*ysG  \n"
"                SO-qeeo,.*ysG   \n"
"                  SO-wo,.ysG    \n"
"                    So..*sU     \n"
;
static char *selectedFolderPalette = 
". #101020\n"
"X #101028\n"
"o #181830\n"
"O #181838\n"
"+ #202040\n"
"@ #202048\n"
"# #282848\n"
"$ #282850\n"
"% #282858\n"
"& #302858\n"
"* #303058\n"
"= #303060\n"
"- #383868\n"
"; #383870\n"
": #403870\n"
"> #484848\n"
", #505050\n"
"< #585858\n"
"1 #404070\n"
"2 #404078\n"
"3 #484878\n"
"4 #505078\n"
"5 #585078\n"
"6 #505878\n"
"7 #585878\n"
"8 #605878\n"
"9 #606060\n"
"0 #686868\n"
"q #606078\n"
"w #686078\n"
"e #686878\n"
"r #707070\n"
"t #707078\n"
"y #787878\n"
"u #808080\n"
"i #888888\n"
"p #909090\n"
"a #A0A0A0\n"
"s #b0b0b0\n"
"d #C0C0C0\n"
"f #C0C0C8\n"
"g #C8C8C8\n"
"h #D0D0D0\n"
"j #D8D8D8\n"
"k #e0e0e0\n"
"l #e8e8e8\n"
"z #F8F8F8\n"
;
static char *selectedFolderPixels =
"  $$Xf                          \n"
"  $3=$of                        \n"
"*$O133=$of                      \n"
"*t1@O133=$of                    \n"
"*qqt1@O133=$of ooof             \n"
"&wqqqe1@O132=$o=2=$of           \n"
"$qqqqqqe1@O;22=2112=$of         \n"
"$qqqqqqqqe1@O;21111:1%o         \n"
"$qqqqqqqqqqe1@O=111:;-$f        \n"
"$qqqqqqqqqq77e1@O=1:;-=of       \n"
"$qqqqqqqqq77777e1@O=;;-$o       \n"
"$qqqqqqqq77777777e1@O=-=.       \n"
"#qqqqqqq87777777777e1O=*.       \n"
"#qqqqq877777777777777eo=.       \n"
"#qqqq8877777777777754-o%.       \n"
"@qqqq7777777777777544-o%.       \n"
"@qqq87777777777777444-o$.       \n"
"@qq777777777777774444-o@.       \n"
"+q8777777777777644444-o@.       \n"
"+87777777777777444444-o@.       \n"
"+-3777777777774444444-o@.shk    \n"
"fo+-37777777544444444-o@.0ishk  \n"
"  fo+-377775444444444-o@.,<0ishl\n"
"    fo+-3774444444444-o@.>,<9uah\n"
"      fo+-34444444444-o@.>>,<9yd\n"
"        fo+-344444444-o@.>>,<rpg\n"
"          fo+-3444444-o@.>,<9ysk\n"
"            fo+-34443-o@.,<0ysj \n"
"              fo+-333-o@.<0ysj  \n"
"                fo+=--o@.0ysj   \n"
"                  fo+=o@.ysj    \n"
"                    fo..0sk     \n"
;



@interface MacPlatinumFolderIcon : IvarObject
{
    id _path;
    id _buttonDown;
    int _buttonDownX;
    int _buttonDownY;
    id _buttonDownTimestamp;
}
@end
@implementation MacPlatinumFolderIcon
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
        [bitmap drawCString:selectedFolderPixels palette:selectedFolderPalette x:r.x+(r.w-w)/2 y:r.y];
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

    struct timeval tv;
    gettimeofday(&tv, NULL);
    id timestamp = nsfmt(@"%ld.%06ld", tv.tv_sec, tv.tv_usec);
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

