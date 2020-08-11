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

@implementation NSString(jfksldjflksdjkfljskf)
- (id)currentDateTimeForTimeZoneWithFormat:(id)format
{
    id results = nsarr(); 

    char *oldTZ = getenv("TZ");
    if (oldTZ) {
        oldTZ = strdup(oldTZ);
        setenv("TZ", [self UTF8String], 1);
    } else {
        setenv("TZ", [self UTF8String], 0);
    }
    
    time_t timestamp = time(NULL);
    struct tm *tmptr;
    tmptr = localtime(&timestamp);
    if (tmptr) {
        char buf[256];
        if (strftime(buf, 255, [format UTF8String], tmptr)) {
            [results addObject:nscstr(buf)];
        }
    }

    if (oldTZ) {
        setenv("TZ", oldTZ, 1);
        free(oldTZ);
    } else {
        unsetenv("TZ");
    }
    return [results join:@"\n"];
}
@end


@implementation NSArray(jfkldsjlkfjsf)
- (id)asArrayWithLeftStringFormat:(id)leftStringFormat rightStringFormat:(id)rightStringFormat messageForClick:(id)messageForClick
{
    id results = nsarr();
    for (id elt in self) {
        id dict = [[elt mutableCopy] autorelease];
        [dict setValue:leftStringFormat forKey:@"leftStringFormat"];
        [dict setValue:rightStringFormat forKey:@"rightStringFormat"];
        if ([messageForClick length]) {
            [dict setValue:@"1" forKey:@"drawChevron"];
            [dict setValue:messageForClick forKey:@"messageForClick"];
        }
        [results addObject:dict];
    }
    return results;
}
- (id)asArrayWithStringFormat:(id)stringFormat messageForClick:(id)messageForClick
{
    id results = nsarr();
    for (id elt in self) {
        id dict = [[elt mutableCopy] autorelease];
        [dict setValue:stringFormat forKey:@"stringFormat"];
        if ([messageForClick length]) {
            [dict setValue:@"1" forKey:@"drawChevron"];
            [dict setValue:messageForClick forKey:@"messageForClick"];
        }
        [results addObject:dict];
    }
    return results;
}
@end


@implementation Definitions(fjkdsjlkfjdslkfj)
+ (id)timezoneTable
{
    id path = @"/usr/share/zoneinfo/zone1970.tab";
    id str = [path stringFromFile];
    id result = [str parseTimezoneTableFile];
    if (!result) {
        [nsfmt(@"File '%@' not found", path) showAlert];
    }
    return result;
}
@end
@implementation NSString(fjlkdsfjkldsjkfls)
- (id)parseTimezoneTableFile
{
    id str = self;
    id lines = [str split:@"\n"];
    id results = nsarr();
    for (id line in lines) {
        if ([line hasPrefix:@"#"]) {
            continue;
        }
        id fields = [line split:@"\t"];
        id tz = [fields nth:2];
        id tokens = [tz split:@"/"];
        id tz1 = tz;
        id tz2 = nil;
        if ([tokens count] > 1) {
            tz1 = [tokens nth:0];
            tz2 = [[tokens subarrayFromIndex:1] join:@"/"];
        }
        id dict = nsdict();
        [dict setValue:[fields nth:0] forKey:@"codes"];
        [dict setValue:[fields nth:1] forKey:@"coordinates"];
        [dict setValue:tz forKey:@"TZ"];
        [dict setValue:[fields nth:3] forKey:@"comments"];
        [dict setValue:tz1 forKey:@"TZ1"];
        [dict setValue:tz2 forKey:@"TZ2"];
        [results addObject:dict];
    }
    return results;
}
@end


@implementation Definitions(fjdsklfjklsdjf)
+ (id)testWorldClock
{
    id str = @"timezoneTable|asArraySortedWithKey:'TZ'|asArrayWithLeftStringFormat:'#{TZ2}' rightStringFormat:'#{TZ|currentDateTimeForTimeZoneWithFormat:\"%I:%M:%S %p\"}' messageForClick:''|asDictionaryGroupByKey:'TZ1'|asKeyValueArray|asArrayWithStringFormat:'#{key}' messageForClick:'selectedObject|value'";
    return [@{} evaluateMessage:str];
}

@end

