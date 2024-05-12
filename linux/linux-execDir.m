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

#ifdef BUILD_FOR_FREEBSD
#include <sys/sysctl.h>
#endif

@implementation Definitions(jfkldsjklfjdsklfjlksdklfj)

+ (id)execDir:(id)str
{
    return nsfmt(@"%@/%@", [Definitions execDir], str);
}
#ifdef BUILD_FOR_LINUX
+ (id)execDir
{
    static id execDir = nil;
    if (execDir) {
        return execDir;
    }
    char buf[1024];
    int result = readlink("/proc/self/exe", buf, 1023);
    if ((result > 0) && (result < 1024)) {
        execDir = [[[NSString alloc] initWithBytes:buf length:result] autorelease];
        execDir = [[execDir stringByDeletingLastPathComponent] retain];
    }
    return execDir;
}
#endif

#ifdef BUILD_FOR_FREEBSD
+ (id)execDir
{
    static char *path = 0;

    if (!path) {
        int mib[4];
        mib[0] = CTL_KERN;
        mib[1] = KERN_PROC;
        mib[2] = KERN_PROC_PATHNAME;
        mib[3] = -1;

        size_t len = 0;
        sysctl(mib, 4, 0, &len, 0, 0);
        path = malloc(len);
        if (!path) {
NSLog(@"out of memory!");
            exit(1);
        }
        sysctl(mib, 4, path, &len, 0, 0);
    }

	return [nsfmt(@"%s", path) stringByDeletingLastPathComponent];
}
#endif

@end

