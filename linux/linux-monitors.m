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


@implementation Definitions(fjkdlsjfklsdjklfjsdf)
+ (void)rotateMonitor:(id)name orientation:(id)orientation
{
    id path = [Definitions execDir:@"Temp/monitors.csv"];
    id monitors = [path parseCSVFile];
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
    if (![monitors writeCSVToFile:path]) {
        [nsfmt(@"Unable to write to file '%@'", path) showAlert];
    }
    [Definitions setupMonitors];
}
+ (void)swapMonitors:(id)name1 :(id)name2
{
    id path = [Definitions execDir:@"Temp/monitors.csv"];
    id monitors = [path parseCSVFile];

    int index1 = -1;
    int index2 = -1;
    for (int i=0; i<[monitors count]; i++) {
        id elt = [monitors nth:i];
        if ([name1 isEqual:[elt valueForKey:@"output"]]) {
            index1 = i;
        } else if ([name2 isEqual:[elt valueForKey:@"output"]]) {
            index2 = i;
        }
    }
    if ((index1 == -1) || (index2 == -1)) {
        return;
    }

    id elt1 = [monitors nth:index1];
    id elt2 = [monitors nth:index2];

    [monitors replaceObjectAtIndex:index1 withObject:elt2];
    [monitors replaceObjectAtIndex:index2 withObject:elt1];
    
    if (![monitors writeCSVToFile:path]) {
        [nsfmt(@"Unable to write to file '%@'", path) showAlert];
    }

    [Definitions setupMonitors];
}
+ (id)previousMonitorName
{
    int x = [[@"windowManager" valueForKey] intValueForKey:@"mouseX"];
    int index = [Definitions monitorIndexForX:x y:0];
    if (index >= 1) {
        id monitors = [Definitions monitorConfig];
        id elt = [monitors nth:index-1];
        return [elt valueForKey:@"output"];
    }
    return nil;
}
+ (id)nextMonitorName
{
    int x = [[@"windowManager" valueForKey] intValueForKey:@"mouseX"];
    int index = [Definitions monitorIndexForX:x y:0];
    id monitors = [Definitions monitorConfig];
    id elt = [monitors nth:index+1];
    return [elt valueForKey:@"output"];
}
+ (id)currentMonitor
{
    int x = [[@"windowManager" valueForKey] intValueForKey:@"mouseX"];
    return [Definitions monitorForX:x y:0];
}
+ (id)currentMonitorName
{
    int x = [[@"windowManager" valueForKey] intValueForKey:@"mouseX"];
    id result = [Definitions monitorForX:x y:0];
    return [result valueForKey:@"output"];
}
+ (int)currentMonitorIndex
{
    int x = [[@"windowManager" valueForKey] intValueForKey:@"mouseX"];
    return [Definitions monitorIndexForX:x y:0];
}
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
    id path = [Definitions execDir:@"Temp/monitors.csv"];
    id monitors = [path parseCSVFile];
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
    if (![monitors writeCSVToFile:path]) {
        [nsfmt(@"Unable to write to file '%@'", path) showAlert];
    }
    [Definitions setupMonitors];
}
+ (void)setupMonitors
{
    id cmd = nsarr();
    [cmd addObject:@"hotdog-setupMonitors.pl"];
    [cmd runCommandAndReturnOutput];
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
    static time_t lastTimestamp = 0;
    static id lastMonitors = nil;
    
    id path = [Definitions execDir:@"Temp/listMonitors.csv"];    
    if ([path fileExists]) {
        time_t timestamp = [path fileModificationTimestamp];
        if (timestamp == lastTimestamp) {
            return lastMonitors;
        }
        id monitors = [path parseCSVFile];
        if (monitors) {
            lastTimestamp = timestamp; 
            [lastMonitors autorelease];
            lastMonitors = monitors;
            [lastMonitors retain];
            return lastMonitors;
        }
    }
    if (lastMonitors) {
        return lastMonitors;
    }
    id dict = nsdict();
    [dict setValue:@"default" forKey:@"output"];
    [dict setValue:@"1024" forKey:@"width"];
    [dict setValue:@"768" forKey:@"height"];
    id arr = nsarr();
    [arr addObject:dict];
    lastMonitors = arr;
    [lastMonitors retain];
    return lastMonitors;
}
@end






