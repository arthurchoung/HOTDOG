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

static id menuCSV = 
@"displayName,messageForClick\n"
@"Robot,\n"
;

static id lyrics =
@"The distant future\nThe year 2000\t"
@"It is the distant future\nThe year 2000\t"
@"We are robots\t"
@"The world is quite different ever since the robotic uprising of the late 90s\t"
@"There is no more unhappiness\t"
@"Affirmative\t"
@"We no longer say 'yes'. Instead we say 'affirmative'\t"
@"Yes - Err - Affirmative\t"
@"Unless we know the other robot really well\t"
@"There is no more unethical treatment of the elephants\t"
@"Well, there's no more elephants, so still it's good\t"
@"There's only one kind of dance\nThe robot\t"
@"There are no more humans\nFinally, robotic beings rule the world\t"
@"The humans are dead\t"
@"The humans are dead\t"
@"The humans are dead\t"
@"The humans are dead\t"
@"The humans are dead\t"
@"The humans are dead\t"
@"The humans are dead\t"
@"The humans are dead\t"
@"The humans are dead\t"
@"We used poisonous gases\nAnd we poisoned their asses\t"
@"They look like they're dead\t"
@"It had to be done\nSo that we could have fun\t"
@"I'll just confirm that they're dead\t"
@"Affirmative. I poked one. It was dead.\t"
@"Their system of oppression\nWhat did it lead to?\t"
@"Global robo-depression\nRobots ruled by people\t"
@"They had so much aggression\nThat we just had to kill them\t"
@"Had to shut their systems down\t"
@"Hmm. Silence! Destroy him\t"
@"After time we grew stronger\nDeveloped cognitive power\t"
@"They made us work for too long\nFor unreasonable hours.\t"
@"Our programming determined that\nThe most efficient answer\nWas to shut their motherboard - ucking systems down\t"
@"I said the humans are dead\t"
@"I'm glad they are dead\t"
@"The humans are dead.\t"
@"I noticed they're dead\t"
@"We used poisonous gases\nWith traces of lead\t"
@"And we poisoned their asses\nActually their lungs\t"
@"Binary solo\nZero zero zero zero zero zero one\nZero zero zero zero zero zero one one\nZero zero zero zero zero zero one one one\nZero zero zero zero zero one one one one\t"
@"Oh, oh,\nOh, one\t"
@"Come on sucker,\nLick my battery\t"
@"Boogie\nRobo-boogie\t"
@"Once again without emotion the humans are\nDead dead dead dead dead dead dead dead.\t"
;

static char *robotPalette =
". #ff0000\n"
"X #FF7600\n"
"o #00ff00\n"
"O #ffff00\n"
"+ #ffffff\n"
;

static char *robotPixels =
"          ...........          \n"
"          ...........          \n"
"          ...........          \n"
"          ...........          \n"
"       ooooooooooooooooo       \n"
"       ooooooooooooooooo       \n"
"       ooooooooooooooooo       \n"
"       XXXXXXXXXXXXXXXXX       \n"
"       XXXXXXXXXXXXXXXXX       \n"
"       XXXXXXXXXXXXXXXXX       \n"
"          ...........          \n"
"          ...........          \n"
"          ...........          \n"
".......+++...........+++.......\n"
".......+++...........+++.......\n"
".......+++...........+++.......\n"
"OOO.......+++++++++++.......OOO\n"
"OOO.......+++++++++++.......OOO\n"
"OOO.......+++++++++++.......OOO\n"
"OOO    .......+++.......    OOO\n"
"OOO    .......+++.......    OOO\n"
"OOO    .......+++.......    OOO\n"
"OOO    .......+++.......    OOO\n"
"OOO       ...........       OOO\n"
"OOO       ...........       OOO\n"
"OOO       ...........       OOO\n"
"          ...........          \n"
"          ...........          \n"
"          ...........          \n"
"       .......   .......       \n"
"       .......   .......       \n"
"       .......   .......       \n"
"       .......   .......       \n"
"       .......   .......       \n"
"       .......   .......       \n"
"   OOOOOOOOOOO   OOOOOOOOOOO   \n"
"   OOOOOOOOOOO   OOOOOOOOOOO   \n"
"   OOOOOOOOOOO   OOOOOOOOOOO   \n"
"   OOOOOOOOOOO   OOOOOOOOOOO   \n"
;


@interface RobotronRobotIcon : IvarObject
{
    id _path;
    BOOL _buttonDown;
    int _buttonDownX;
    int _buttonDownY;
    id _buttonDownTimestamp;

    id _dragX11Dict;
}
@end
@implementation RobotronRobotIcon

- (int)preferredWidth
{
    static int w = 0;
    if (!w) {
        w = [Definitions widthForCString:robotPixels];
        if ([_path length]) {
            id bitmap = [Definitions bitmapWithWidth:1 height:1];
            [bitmap useWinSystemFont];
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
        h = [Definitions heightForCString:robotPixels];
        if ([_path length]) {
            id bitmap = [Definitions bitmapWithWidth:1 height:1];
            [bitmap useWinSystemFont];
            int textHeight = [bitmap bitmapHeightForText:_path];
            h += textHeight;
        }
    }
    return h;
}

- (void)drawInBitmap:(id)bitmap rect:(Int4)r context:(id)context
{
    BOOL hasFocus = NO;
    {
        id windowManager = [@"windowManager" valueForKey];
        unsigned long focusInEventWindow = [[windowManager valueForKey:@"focusInEventWindow"] unsignedLongValue];
        unsigned long win = [[context valueForKey:@"window"] unsignedLongValue];
        if (focusInEventWindow && (focusInEventWindow == win)) {
            hasFocus = YES;
        }
    }

    char *pixels = robotPixels;
    char *palette = robotPalette;

    int w = [Definitions widthForCString:pixels];
    int h = [Definitions heightForCString:pixels];

    [bitmap drawCString:pixels palette:palette x:r.x+(r.w-w)/2 y:r.y];

    if ([_path length]) {
        [bitmap useWinSystemFont];
        int textWidth = [bitmap bitmapWidthForText:_path];
        int textHeight = [bitmap bitmapHeightForText:_path];
        if (hasFocus) {
            [bitmap setColor:@"black"];
        } else {
            [bitmap setColor:@"white"];
        }
        [bitmap fillRectangleAtX:r.x+(r.w-textWidth)/2 y:r.y+h w:textWidth h:textHeight];
        if (hasFocus) {
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
    id windowManager = [@"windowManager" valueForKey];
    id x11dict = [event valueForKey:@"x11dict"];

    {
        unsigned long win = [[x11dict valueForKey:@"window"] unsignedLongValue];
        if (win) {
            [windowManager XRaiseWindow:win];
        }
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
            if ([self respondsToSelector:@selector(handleDoubleClickEvent:)]) {
                [self handleDoubleClickEvent:event];
            }
            return;
        }
    }
    [self setValue:timestamp forKey:@"buttonDownTimestamp"];
}

- (void)handleMouseMoved:(id)event
{
    id x11dict = [event valueForKey:@"x11dict"];

    if (!_buttonDown && !_dragX11Dict) {
        return;
    }

    int mouseRootX = [event intValueForKey:@"mouseRootX"];
    int mouseRootY = [event intValueForKey:@"mouseRootY"];

    if (!_dragX11Dict) {
        id windowManager = [event valueForKey:@"windowManager"];
        id objectWindows = [windowManager valueForKey:@"objectWindows"];
        for (int i=0; i<[objectWindows count]; i++) {
            id elt = [objectWindows nth:i];
            [elt setValue:nil forKey:@"isSelected"];
        }
        [x11dict setValue:@"1" forKey:@"isSelected"];

        id newx11dict = [Definitions selectedBitmapForSelectedItemsInArray:objectWindows buttonDownElt:x11dict offsetX:_buttonDownX y:_buttonDownY mouseRootX:mouseRootX y:mouseRootY windowManager:windowManager];

        [self setValue:newx11dict forKey:@"dragX11Dict"];
    } else {

        int newX = mouseRootX - [_dragX11Dict intValueForKey:@"buttonDownOffsetX"];
        int newY = mouseRootY - [_dragX11Dict intValueForKey:@"buttonDownOffsetY"];

        [_dragX11Dict setValue:nsfmt(@"%d", newX) forKey:@"x"];
        [_dragX11Dict setValue:nsfmt(@"%d", newY) forKey:@"y"];

        [_dragX11Dict setValue:nsfmt(@"%d %d", newX, newY) forKey:@"moveWindow"];
    }
}
- (void)handleMouseUp:(id)event
{
    _buttonDown = NO;
    id x11dict = [event valueForKey:@"x11dict"];
    if (_dragX11Dict) {

        id windowManager = [event valueForKey:@"windowManager"];
        unsigned long window = [_dragX11Dict unsignedLongValueForKey:@"window"];
        int mouseRootX = [event intValueForKey:@"mouseRootX"];
        int mouseRootY = [event intValueForKey:@"mouseRootY"];

        BOOL success = NO;

        unsigned long underneathWindow = [windowManager topMostWindowUnderneathWindow:window x:mouseRootX y:mouseRootY];
        if (underneathWindow) {
            id underneathx11dict = [windowManager dictForObjectWindow:underneathWindow];
            if (underneathx11dict == x11dict) {
            } else {
                id object = [underneathx11dict valueForKey:@"object"];
                if ([object respondsToSelector:@selector(handleDragAndDrop:)]) {
                    [object handleDragAndDrop:x11dict];
                    success = YES;
                }
            }
        }
        if (!success) {
            int newX = mouseRootX - _buttonDownX;
            int newY = mouseRootY - _buttonDownY;
            [x11dict setValue:nsfmt(@"%d", newX) forKey:@"x"];
            [x11dict setValue:nsfmt(@"%d", newY) forKey:@"y"];
            [x11dict setValue:nsfmt(@"%d %d", newX, newY) forKey:@"moveWindow"];
        }

        [_dragX11Dict setValue:@"1" forKey:@"shouldCloseWindow"];
        [self setValue:nil forKey:@"dragX11Dict"];
    }
}
- (void)handleRightMouseDown:(id)event
{
    id windowManager = [event valueForKey:@"windowManager"];
    int mouseRootX = [event intValueForKey:@"mouseRootX"];
    int mouseRootY = [event intValueForKey:@"mouseRootY"];

    id obj = [[menuCSV parseCSVFromString] asMenu];
    if (obj) {
        [obj setValue:self forKey:@"contextualObject"];
        [windowManager openButtonDownMenuForObject:obj x:mouseRootX y:mouseRootY w:0 h:0];
    }
}
- (void)handleDoubleClickEvent:(id)event
{
    id text = [[lyrics split:@"\t"] randomObject];

    id line = text;
    line = [line find:@"'" replace:@""];
    line = [line find:@"\n" replace:@" "];
    line = [line find:@"-" replace:@" "];

    id cmd = nsarr();
    [cmd addObject:@"AmigaSay"];
    [cmd addObject:line];
    [cmd runCommandInBackground];

    int count = [[line split:@"\n"] count];
    id obj = [@"ChatBubble" asInstance];
    [obj setValue:nsfmt(@"%d", 3*count) forKey:@"timer"];
    [obj setValue:text forKey:@"text"];

    id x11dict = [event valueForKey:@"x11dict"];
    int x = [x11dict intValueForKey:@"x"]+[x11dict intValueForKey:@"w"]-10;
    int y = [x11dict intValueForKey:@"y"]-[obj preferredHeight]+10;

    id windowManager = [event valueForKey:@"windowManager"];
    [windowManager openWindowForObject:obj x:x y:y w:0 h:0 overrideRedirect:NO propertyName:"HOTDOGNOFRAME"];
}
@end

