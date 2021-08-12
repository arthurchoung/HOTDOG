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

@implementation Definitions(jfoiwejfklsdjfklsdjlkfjsdlkfj)
+ (void)enterMacColorMode
{
    id windowManager = [@"windowManager" valueForKey];
    [windowManager unparentAllWindows];
    char *backgroundCString =
"ab\n"
"ba\n"
;
    char *backgroundPalette =
"a #606060\n"
"b #a0a0a0\n"
;
    [windowManager setBackgroundForCString:backgroundCString palette:backgroundPalette];
    id rootWindowObject = [@"MacRootWindow" asInstance];
    [windowManager setValue:rootWindowObject forKey:@"rootWindowObject"];
    [windowManager reparentAllWindows:@"MacColorWindow"];
    [[windowManager valueForKey:@"menuBar"] setValue:@"1" forKey:@"shouldCloseWindow"];
    id menuBar = [windowManager openWindowForObject:[@"MacMenuBar" asInstance] x:0 y:0 w:[windowManager intValueForKey:@"rootWindowWidth"] h:[windowManager intValueForKey:@"menuBarHeight"]];
    [windowManager setValue:menuBar forKey:@"menuBar"];
    [windowManager setFocusDict:nil];
}
@end

@interface MacRootWindow : IvarObject
@end
@implementation MacRootWindow
- (BOOL)shouldPassthroughClickToFocus
{
    return YES;
}
- (void)handleMouseMoved:(id)event
{
    id windowManager = [event valueForKey:@"windowManager"];
    id menuBar = [windowManager valueForKey:@"menuBar"];
    [menuBar setValue:@"1" forKey:@"needsRedraw"];
}
- (void)handleMouseDown:(id)event
{
NSLog(@"MacRootWindow handleMouseDown");
    id windowManager = [event valueForKey:@"windowManager"];
    int mouseRootX = [event intValueForKey:@"mouseRootX"];
    int mouseRootY = [event intValueForKey:@"mouseRootY"];
    int viewWidth = [event intValueForKey:@"viewWidth"];
    int viewHeight = [event intValueForKey:@"viewHeight"];
    id buttonDownWhich = [event valueForKey:@"buttonDownWhich"];

    id object = [@"SelectionBox" asInstance];
    int w = 1;
    int h = 1;
    if ([object respondsToSelector:@selector(preferredWidth)]) {
        w = [object preferredWidth];
    }
    if ([object respondsToSelector:@selector(preferredHeight)]) {
        h = [object preferredHeight];
    }
    id dict = [windowManager openWindowForObject:object x:mouseRootX y:mouseRootY w:w h:h];
    id eventDict = [windowManager generateEventDictRootX:mouseRootX rootY:mouseRootY x:mouseRootX y:mouseRootY w:viewWidth h:viewHeight x11dict:dict];
    if ([object respondsToSelector:@selector(handleMouseDown:)]) {
        [object handleMouseDown:eventDict];
    }
    [windowManager setValue:dict forKey:@"buttonDownDict"];
    [windowManager setValue:buttonDownWhich forKey:@"buttonDownWhich"];
}
- (void)handleRightMouseDown:(id)event
{
    id windowManager = [event valueForKey:@"windowManager"];
    int mouseRootX = [event intValueForKey:@"mouseRootX"];
    int mouseRootY = [event intValueForKey:@"mouseRootY"];
    id buttonDownWhich = [event valueForKey:@"buttonDownWhich"];

    id obj = [[[Definitions configDir:@"Config/rootWindowMenu.csv"] parseCSVFile] asMenu];
    int w = [obj preferredWidth];
    int h = [obj preferredHeight];
    id dict = [windowManager openWindowForObject:obj x:mouseRootX y:mouseRootY w:w+3 h:h+3];
    [windowManager setValue:dict forKey:@"buttonDownDict"];
    [windowManager setValue:buttonDownWhich forKey:@"buttonDownWhich"];
}
@end

