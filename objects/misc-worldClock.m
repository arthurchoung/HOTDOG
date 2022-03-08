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

