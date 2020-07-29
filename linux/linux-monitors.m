/*

 PEEOS

 Copyright (c) 2020 Arthur Choung. All rights reserved.

 Email: arthur -at- peeos.org

 This file is part of PEEOS.

 PEEOS is free software: you can redistribute it and/or modify it
 under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <https://www.gnu.org/licenses/>.

 */

#import "PEEOS.h"

@implementation Definitions(fjkdlsjfklsdjklfjsdf)
+ (id)monitorName
{
    int x = [[@"windowManager" valueForKey] intValueForKey:@"mouseX"];
    id result = [Definitions monitorForX:x y:0];
    return [result valueForKey:@"output"];
}
+ (id)monitorTitle
{
    int x = [[@"windowManager" valueForKey] intValueForKey:@"mouseX"];
    id result = [Definitions monitorIndexNameForX:x y:0];
    return result;
}
+ (void)rotateCurrentMonitor:(id)orientation
{
    id windowManager = [@"windowManager" valueForKey];
    int mouseX = [windowManager intValueForKey:@"mouseX"];
    int mouseY = [windowManager intValueForKey:@"mouseY"];
    id monitor = [Definitions monitorForX:mouseX y:mouseY];
    id name = [monitor valueForKey:@"output"];
    id path = [Definitions execDir:@"Config/monitors.csv"];
    id monitors = [path parseCSVFromFile];
    id elt = [monitors objectWithValue:name forKey:@"output"];
    if (!elt) {
        elt = nsdict();
        [elt setValue:name forKey:@"output"];
        if (!monitors) {
            monitors = nsarr();
        }
        [monitors addObject:elt];
    }
    [elt setValue:orientation forKey:@"rotate"];
    [monitors writeCSVToFile:path];
    [Definitions setupMonitors];
}
+ (void)showAlert:(id)text monitor:(int)monitor
{
    if (!monitor) {
        return;
    }

    id windowManager = [@"windowManager" valueForKey];

    int x = 0;
    int y = 0;
    int w = 400;
    int h = [Definitions preferredHeightForBitmapMessageAlert:text width:400];

    int monitorX = [monitor intValueForKey:@"x"];
    int monitorY = [monitor intValueForKey:@"y"];
    int monitorWidth = [monitor intValueForKey:@"width"];
    int monitorHeight = [monitor intValueForKey:@"height"];

    Int4 r = [Definitions centerRectX:0 y:0 w:w h:h inW:monitorWidth h:monitorHeight];
    x = monitorX + r.x;
    y = monitorY + r.y;

//    id obj = [text asBitmapMessageAlert];
    id obj = [Definitions testChat:text];
    [windowManager openWindowForObject:obj x:x y:y w:w h:h];
}
+ (void)identifyMonitors
{
    id windowManager = [@"windowManager" valueForKey];

    id monitors = [Definitions monitorConfig];
    int index = 1;
    for (id monitor in monitors) {
        [Definitions showAlert:nsfmt(@"Monitor %d of %d (%@)", index, [monitors count], [monitor valueForKey:@"output"]) monitor:monitor];
        index++;
    }
}
+ (id)detectMonitors
{
    id str = [@"xrandrOutput" valueForKey];
    if (!str) {
        str = [[@[ @"xrandr" ] runCommandAndReturnOutput] asString];
        [str setAsValueForKey:@"xrandrOutput"];
    }
    if (!str) {
        id dict = nsdict();
        [dict setValue:@"default" forKey:@"output"];
        [dict setValue:@"1024" forKey:@"width"];
        [dict setValue:@"768" forKey:@"height"];
        id arr = nsarr();
        [arr addObject:dict];
        return arr;
    }
    id lines = [str split:@"\n"];
    id path = [Definitions execDir:@"Config/monitors.csv"];
    id monitors = [path parseCSVFromFile];
    id results = nsarr();
    for (id line in lines) {
        if (![line containsString:@" connected "]) {
            continue;
        }
        id a = [line split:@" connected "];
        id output = [a nth:0];
        id aa = [[a nth:1] find:@"primary " replace:@""];
        id b = [aa split:@"x"];
        id width = [b nth:0];
        id c = [[b nth:1] split:@"+"];
        id height = [c nth:0];
        if (![output length]) {
            continue;
        }
        id dict = [monitors objectWithValue:output forKey:@"output"];
        if (!dict) {
            dict = nsdict();
            [dict setValue:output forKey:@"output"];
        }
        [dict setValue:width forKey:@"width"];
        [dict setValue:height forKey:@"height"];
        [results addObject:dict];
    }
    id sortedResults = nsarr();
    for (id elt in monitors) {
        id dict = [results objectWithValue:[elt valueForKey:@"output"] forKey:@"output"];
        if (!dict) {
            continue;
        }
        [sortedResults addObject:dict];
        [results removeObject:dict];
    }
    [sortedResults addObjectsFromArray:results];
    return sortedResults;
}
+ (void)setupMonitors
{
    id monitors = [Definitions monitorConfig];
    for (id elt in monitors) {
        id output = [elt valueForKey:@"output"];
        id rightOf = [elt valueForKey:@"rightOf"];
        id rotate = [elt valueForKey:@"rotate"];
        if (!output) {
            continue;
        }
        id cmd = nsarr();
        [cmd addObject:@"xrandr"];
        [cmd addObject:@"--output"];
        [cmd addObject:output];
        [cmd addObject:@"--auto"];
        if (rightOf) {
            [cmd addObject:@"--right-of"];
            [cmd addObject:rightOf];
        }
        if (rotate) {
            [cmd addObject:@"--rotate"];    
            [cmd addObject:rotate];
        }
NSLog(@"setupMonitors cmd %@", cmd);
        [cmd runCommandAndReturnOutput];
    }
    [@"xrandrOutput" setNilValueForKey];
}
+ (id)monitorIndexNameForX:(int)x y:(int)y
{
    id monitors = [Definitions monitorConfig];
    for (int index=0; index<[monitors count]; index++) {
        id elt = [monitors nth:index];
        int monitorX = [elt intValueForKey:@"x"];
        int monitorWidth = [elt intValueForKey:@"width"];
        if (!monitorWidth) {
            continue;
        }
        if ((x >= monitorX) && (x < (monitorX+monitorWidth))) {
            return nsfmt(@"%d/%d", index+1, [monitors count]);;
        }
    }
    return nsfmt(@"%d/%d", 1, [monitors count]);
}
+ (int)monitorIndexForX:(int)x y:(int)y
{
    id monitors = [Definitions monitorConfig];
    for (int index=0; index<[monitors count]; index++) {
        id elt = [monitors nth:index];
        int monitorX = [elt intValueForKey:@"x"];
        int monitorWidth = [elt intValueForKey:@"width"];
        if (!monitorWidth) {
            continue;
        }
        if ((x >= monitorX) && (x < (monitorX+monitorWidth))) {
            return index;
        }
    }
    return 0;
}
+ (id)monitorForX:(int)x y:(int)y
{
    id monitors = [Definitions monitorConfig];
    for (id elt in monitors) {
        int monitorX = [elt intValueForKey:@"x"];
        int monitorWidth = [elt intValueForKey:@"width"];
        if (!monitorWidth) {
            continue;
        }
        if ((x >= monitorX) && (x < (monitorX+monitorWidth))) {
            return elt;
        }
    }
    return [monitors nth:0];
}
+ (id)monitorConfig
{
    id arr = [Definitions detectMonitors];
    int x = 0;
    id prevElt = nil;
    for (id elt in arr) {
        id rotate = [elt valueForKey:@"rotate"];
/*
        if ([rotate isEqual:@"left"] || [rotate isEqual:@"right"]) {
            id temp = [elt valueForKey:@"width"];
            [elt setValue:[elt valueForKey:@"height"] forKey:@"width"];
            [elt setValue:temp forKey:@"height"];
        }
*/
        [elt setValue:nsfmt(@"%d", x) forKey:@"x"];
        x += [elt intValueForKey:@"width"];
        int h = [elt intValueForKey:@"height"];
        [elt setValue:[prevElt valueForKey:@"output"] forKey:@"rightOf"];
        prevElt = elt;
    }
    return arr;
}
@end






