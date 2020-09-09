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

int main(int argc, char **argv)
{
    extern void HOTDOG_initialize(void);
    HOTDOG_initialize();


	@autoreleasepool {

#ifdef BUILD_FOR_ANDROID
#else
        id execDir = [Definitions execDir];
        if (setenv("HOTDOG_HOME", [execDir UTF8String], 1) != 0) {
NSLog(@"Unable to setenv HOTDOG_HOME=%@", execDir);
        }
        if (argc == 1) {
            id object = [Definitions mainInterface];
            [object pushObject:[Definitions mainMenuInterface]];
            [Definitions runWindowManagerForObject:object];
            [[Definitions mainInterface] setValue:nil forKey:@"context"];
        } else if ((argc > 1) && !strcmp(argv[1], "open")) {
            id arr = nsarr();
            for (int i=2; i<argc; i++) {
                id filePath = nscstr(argv[i]);
                id displayName = filePath;
                id dict = nsdict();
                if ([filePath isDirectory]) {
                    displayName = [displayName cat:@"/"];
                    [dict setValue:@"directory" forKey:@"fileType"];
                }
                if ([filePath isFile]) {
                    [dict setValue:@"file" forKey:@"fileType"];
                }
                [dict setValue:@"#{displayName}" forKey:@"stringFormat"];
                [dict setValue:displayName forKey:@"displayName"];
                [dict setValue:filePath forKey:@"filePath"];
                [dict setValue:[filePath fileModificationDate] forKey:@"fileModificationDate"];
                [dict setValue:nsfmt(@"%lu", [filePath fileSize]) forKey:@"fileSize"];
                [arr addObject:dict];
            }
            id rootObject = [Definitions mainInterface];
            if ([arr count]) {
                [rootObject pushObject:[arr asListInterface]];
            } else {
                id object = [[[@"." contentsOfDirectory] asFileArray] asListInterface];
                [object setValue:@"#{displayName}" forKey:@"stringFormat"];
                [rootObject pushObject:object];
            }
            [Definitions runWindowManagerForObject:rootObject];
            [[Definitions mainInterface] setValue:nil forKey:@"context"];
        } else if ((argc > 1) && !strcmp(argv[1], "show")) {
            id args = nsarr();
            for (int i=2; i<argc; i++) {
                id str = nscstr(argv[i]);
                [args addObject:str];
            }
            id message = [args join:@" "];
//NSLog(@"message %@", message);
            id object = [@{} evaluateMessage:message];
            if (object) {
                [Definitions runWindowManagerForObject:object];
                [[Definitions mainInterface] setValue:nil forKey:@"context"];
            }
        } else {
            id args = nsarr();
            for (int i=1; i<argc; i++) {
                if (!strcmp(argv[i], "evaluateFile:")) {
                    [args addObject:@"evaluateFile:"];
                    i++;
                    if (i < argc) {
                        [args addObject:[nscstr(argv[i]) asQuotedString]];
                    }
                    break;
                } else {
                    id str = nscstr(argv[i]);
                    [args addObject:str];
                }
            }
            id message = [args join:@" "];
//NSLog(@"message %@", message);
            id object = [@{} evaluateMessage:message];
            if (object) {
                [nsfmt(@"%@", object) writeToStandardOutput];
            }
        }
#endif

/*
#ifdef BUILD_FOR_ANDROID
#else
        if (object == [object class]) {
            object = [object asInstance];
        }
        if (isnsarr(object)) {
            object = [object asListInterface];
            id mainInterface = [Definitions mainInterface];
            [mainInterface pushObject:object];
            object = mainInterface;
        } else if (isnsdict(object)) {
            object = [object asKeyValueArray];
            object = [object asListInterface];
            id mainInterface = [Definitions mainInterface];
            [mainInterface pushObject:object];
            object = mainInterface;
        }
        [Definitions runWindowManagerForObject:object];
#endif
*/

	}
    return 0;
}
