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

static void signal_handler(int num)
{
NSLog(@"signal_handler %d", num);
}

int main(int argc, char **argv)
{
    if (signal(SIGPIPE, signal_handler) == SIG_ERR) {
NSLog(@"unable to set signal handler for SIGPIPE");
    }

#ifndef BUILD_FOR_OSX
    extern void HOTDOG_initialize(void);
    HOTDOG_initialize();
#endif


    id pool = [[NSAutoreleasePool alloc] init];

#ifdef BUILD_FOR_ANDROID
#else
        id execDir = [Definitions execDir];

        /* If argv[0] contains a slash, then add the directory that the
           executable resides in to the PATH */
        if ((argc > 0) && strchr(argv[0], '/')) {
            char *pathcstr = getenv("PATH");
            id path = nil;
            if (pathcstr && strlen(pathcstr)) {
                path = nsfmt(@"%@:%s", execDir, pathcstr);
            } else {
                path = execDir;
            }
            if (setenv("PATH", [path UTF8String], 1) != 0) {
NSLog(@"Unable to set PATH");
            }
        }

        if (setenv("SUDO_ASKPASS", [[Definitions execDir:@"hotdog-getPassword.pl"] UTF8String], 1) != 0) {
NSLog(@"Unable to setenv SUDO_ASKPASS");
        }

        if (argc == 1) {
            id object = [Definitions mainInterface];
            [[Definitions configDir:@"MainMenu"] changeDirectory];
            [object pushObject:[Definitions ObjectInterface]];
            [Definitions runWindowManagerForObject:object];
            [[Definitions mainInterface] setValue:nil forKey:@"context"];
        } else if ((argc > 1) && !strcmp(argv[1], "open")) {
            if (argc > 2) {
                id filePath = nscstr(argv[2]);
                if ([filePath isDirectory]) {
                    chdir(argv[2]);
                }
            }
            id obj = [Definitions ObjectInterface];
            if ([obj isKindOfClass:[@"ListInterface" asClass]]) {
                id nav = [Definitions mainInterface];
                [nav pushObject:obj];
                [Definitions runWindowManagerForObject:nav];
            } else {
                [Definitions runWindowManagerForObject:obj];
            }
            [[Definitions mainInterface] setValue:nil forKey:@"context"];
        } else if ((argc > 1) && !strcmp(argv[1], "ls")) {
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
                id object = [Definitions ObjectInterface];
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
            id object = [nsdict() evaluateMessage:message];
            if (object) {
                [Definitions runWindowManagerForObject:object];
                [[Definitions mainInterface] setValue:nil forKey:@"context"];
            }
        } else if ((argc == 2) && !strcmp(argv[1], ".")) {
            id obj = [Definitions ObjectInterface];
            if ([obj isKindOfClass:[@"ListInterface" asClass]]) {
                id nav = [Definitions mainInterface];
                [nav pushObject:obj];
                [Definitions runWindowManagerForObject:nav];
            } else {
                [Definitions runWindowManagerForObject:obj];
            }
            [[Definitions mainInterface] setValue:nil forKey:@"context"];
        } else if ((argc > 1) && !strcmp(argv[1], "lines")) {
            id lines = nil;
            if (argc > 2) {
                lines = [nscstr(argv[2]) linesFromFile];
                if (!lines) {
NSLog(@"unable to read file '%s'", argv[2]);
exit(1);
                }
            } else {
                lines = [Definitions linesFromStandardInput];
NSLog(@"lines %@", lines);
            }
            if (lines) {
                id nav = [Definitions mainInterface];
                id obj = [lines asListInterface];
                [nav pushObject:obj];
                [Definitions runWindowManagerForObject:nav];
            }
        } else if ((argc > 1) && !strcmp(argv[1], "linesfmt")) {
            id stringFormat = nil;
            if (argc > 2) {
                stringFormat = nscstr(argv[2]);
            }
            id lines = [Definitions linesFromStandardInput];
            if (lines) {
                id nav = [Definitions mainInterface];
                id obj = [lines asListInterface];
                [obj setValue:stringFormat forKey:@"defaultStringFormat"];
                [nav pushObject:obj];
                [Definitions runWindowManagerForObject:nav];
            }
        } else if ((argc > 1) && !strcmp(argv[1], "table")) {
            id lines = nil;
            if (argc > 2) {
                lines = [nscstr(argv[2]) linesFromFile];
                if (!lines) {
NSLog(@"unable to read file '%s'", argv[2]);
exit(1);
                }
            } else {
                lines = [Definitions linesFromStandardInput];
NSLog(@"lines %@", lines);
            }
            if (lines) {
                id nav = [Definitions mainInterface];
                id obj = [lines asTableInterface];
                [nav pushObject:obj];
                [Definitions runWindowManagerForObject:nav];
            }
        } else if ((argc > 1) && !strcmp(argv[1], "json")) {
            id json = nil;
            if (argc > 2) {
                json = [nscstr(argv[2]) readFromFileAsJSON];
                if (!json) {
NSLog(@"unable to read file '%s'", argv[2]);
exit(1);
                }
            } else {
                id data = [Definitions dataFromStandardInput];
                json = [[data asString] decodeJSON];
            }
            if (json) {
                id nav = [Definitions mainInterface];
                id obj = [json asListInterface];
                [nav pushObject:obj];
                [Definitions runWindowManagerForObject:nav];
            }
        } else if ((argc > 1) && !strcmp(argv[1], "ipod")) {
            id ipod = [@"IpodInterface" asInstance];
            [ipod setAsValueForKey:@"IpodInterface"];
            id home = [@"HomeScreen" asInstance];
            [ipod setValue:home forKey:@"object"];
            [ipod goToLockScreen];
            [Definitions runWindowManagerForObject:ipod];
        } else if ((argc > 1) && !strcmp(argv[1], "nav")) {
            id args = nsarr();
            for (int i=2; i<argc; i++) {
                id str = nscstr(argv[i]);
                [args addObject:str];
            }
            id message = [args join:@" "];
            id object = [nsdict() evaluateMessage:message];
            if (object) {
                id nav = [Definitions mainInterface];
                [nav pushObject:object];
                [Definitions runWindowManagerForObject:nav];
                [[Definitions mainInterface] setValue:nil forKey:@"context"];
            }
        } else if ((argc > 1) && !strcmp(argv[1], "alert")) {
            id data = [Definitions dataFromStandardInput];
            id str = [data asString];
            if ([str length]) {
                int x = 0;
                int y = 0;
                int w = 400;
                int h = [Definitions preferredHeightForBitmapMessageAlert:str width:400];
                id monitor = [Definitions monitorForX:0 y:0];
                if (monitor) {
                    int monitorX = [monitor intValueForKey:@"x"];
                    int monitorY = [monitor intValueForKey:@"y"];
                    int monitorWidth = [monitor intValueForKey:@"width"];
                    int monitorHeight = [monitor intValueForKey:@"height"];
NSLog(@"*** monitor %d %d %d %d", monitorX, monitorY, monitorWidth, monitorHeight);
                    Int4 r = [Definitions centerRectX:0 y:0 w:w h:h inW:monitorWidth h:monitorHeight];
                    x = monitorX + r.x;
                    y = monitorY + r.y;
                }
                id obj = [str asBitmapMessageAlert];
                [Definitions runWindowManagerForObject:obj x:x y:y w:w h:h];
            }
        } else if ((argc > 1) && !strcmp(argv[1], "confirm")) {
            id data = [Definitions dataFromStandardInput];
            id text = [data asString];
            if ([text length]) {
                id obj = [@"ConfirmationDialog" asInstance];
                [obj setValue:text forKey:@"text"];
                if (argc > 2) {
                    [obj setValue:nsfmt(@"%s", argv[2]) forKey:@"okText"];
                } else {
                    [obj setValue:@"OK" forKey:@"okText"];
                }
                if (argc > 3) {
                    [obj setValue:nsfmt(@"%s", argv[3]) forKey:@"cancelText"];
                } else {
                    [obj setValue:@"Cancel" forKey:@"cancelText"];
                }
                [Definitions runWindowManagerForObject:obj];
            }
        } else if ((argc > 1) && !strcmp(argv[1], "choose")) {
            id stringFormat = nil;
            if (argc > 2) {
                stringFormat = nsfmt(@"%s", argv[2]);
            }
            id title = nil;
            if (argc > 3) {
                title = nsfmt(@"%s", argv[3]);
            }
            id text = nil;
            if (argc > 4) {
                text = nsfmt(@"%s", argv[4]);
            }
            id lines = [Definitions linesFromStandardInput];
            if (lines) {
                id obj = [@"ListInterface" asInstance];
                [obj setValue:text forKey:@"marginText"];
                [obj setValue:lines forKey:@"array"];
                [obj setValue:@"20" forKey:@"cellHeight"];
//                id obj = [lines asListInterface];
                [obj setValue:@"selectedObject|writeToStandardOutput;'\n'|writeToStandardOutput;exit:0" forKey:@"defaultMessageForClick"];
                [obj setValue:stringFormat forKey:@"defaultStringFormat"];
                [obj setValue:@"0" forKey:@"defaultDrawChevron"];

                id nav = [Definitions mainInterface];
                [nav pushObject:obj];
                [nav setValue:title forKey:@"defaultTitle"];
                [Definitions runWindowManagerForObject:nav];
            }
        } else if ((argc > 1) && !strcmp(argv[1], "chooseCommandObserver")) {
            id command = nil;
            if (argc > 2) {
                command = nsfmt(@"%s", argv[2]);
            }
            id observer = nil;
            if (argc > 3) {
                observer = nsfmt(@"%s", argv[3]);
            }
            id stringFormat = nil;
            if (argc > 4) {
                stringFormat = nsfmt(@"%s", argv[4]);
            }
            id title = nil;
            if (argc > 5) {
                title = nsfmt(@"%s", argv[5]);
            }
            id text = nil;
            if (argc > 6) {
                text = nsfmt(@"%s", argv[6]);
            }
            id observerCommand = nsarr();
            [observerCommand addObject:observer];
            id observerProcess = [observerCommand runCommandAndReturnProcess];
            id obj = [@"ListInterface" asInstance];
            [obj setValue:nsfmt(@"['%@']|runCommandAndReturnOutput|asString|lines", command) forKey:@"message"];
            [obj setValue:observerProcess forKey:@"observer"];
            [obj updateArray];
            [obj setValue:text forKey:@"marginText"];
            [obj setValue:@"20" forKey:@"cellHeight"];
            [obj setValue:@"selectedObject|writeToStandardOutput;'\n'|writeToStandardOutput;exit:0" forKey:@"defaultMessageForClick"];
            [obj setValue:stringFormat forKey:@"defaultStringFormat"];
            [obj setValue:@"0" forKey:@"defaultDrawChevron"];

            id nav = [Definitions mainInterface];
            [nav pushObject:obj];
            [nav setValue:title forKey:@"defaultTitle"];
            [Definitions runWindowManagerForObject:nav];
        } else if ((argc > 1) && !strcmp(argv[1], "chooseFromBlocks")) {
            id stringFormat = nil;
            if (argc > 2) {
                stringFormat = nsfmt(@"%s", argv[2]);
            }
            id lines = [Definitions blocksFromStandardInput];
            if (lines) {
                id obj = [lines asListInterface];
                [obj setValue:@"selectedObject|writeToStandardOutput;'\n'|writeToStandardOutput;exit:0" forKey:@"defaultMessageForClick"];
                [obj setValue:stringFormat forKey:@"defaultStringFormat"];
                [obj setValue:@"0" forKey:@"defaultDrawChevron"];
                [Definitions runWindowManagerForObject:obj];
            }
        } else if ((argc > 1) && !strcmp(argv[1], "progress")) {
            id obj = [@"Progress" asInstance];
            [Definitions runWindowManagerForObject:obj];
        } else if ((argc > 1) && !strcmp(argv[1], "amigadrives")) {
            id obj = [Definitions AmigaDrives];
            [Definitions runWindowManagerForObject:obj];
        } else if ((argc > 1) && !strcmp(argv[1], "amigadir")) {
            if (argc > 2) {
                id filePath = nscstr(argv[2]);
                if ([filePath isDirectory]) {
                    chdir(argv[2]);
                }
            }

            id obj = [Definitions AmigaDir];
            [Definitions runWindowManagerForObject:obj];
        } else if ((argc > 1) && !strcmp(argv[1], "amigagurumeditation")) {
            id obj = [Definitions AmigaGuruMeditation];
            [Definitions runWindowManagerForObject:obj];
        } else if ((argc > 1) && !strcmp(argv[1], "amigabuiltindir")) {
            if (argc > 2) {
                id name = nscstr(argv[2]);
                id obj = [Definitions AmigaBuiltInDir:name];
                [Definitions runWindowManagerForObject:obj];
            } else {
                id obj = [Definitions AmigaBuiltInDir:nil];
                [Definitions runWindowManagerForObject:obj];
            }
        } else if ((argc > 1) && !strcmp(argv[1], "macclassicdrives")) {
            id obj = [Definitions MacClassicDrives];
            [Definitions runWindowManagerForObject:obj];
        } else if ((argc > 1) && !strcmp(argv[1], "macclassicdir")) {
            if (argc > 2) {
                id filePath = nscstr(argv[2]);
                if ([filePath isDirectory]) {
                    chdir(argv[2]);
                }
            }

            id obj = [Definitions MacClassicDir];
            [Definitions runWindowManagerForObject:obj];
        } else if ((argc > 1) && !strcmp(argv[1], "macclassictrash")) {
            id obj = [Definitions MacClassicTrash];
            [Definitions runWindowManagerForObject:obj];
        } else if ((argc > 1) && !strcmp(argv[1], "maccolordrives")) {
            id obj = [Definitions MacColorDrives];
            [Definitions runWindowManagerForObject:obj];
        } else if ((argc > 1) && !strcmp(argv[1], "maccolordir")) {
            if (argc > 2) {
                id filePath = nscstr(argv[2]);
                if ([filePath isDirectory]) {
                    chdir(argv[2]);
                }
            }

            id obj = [Definitions MacColorDir];
            [Definitions runWindowManagerForObject:obj];
        } else if ((argc > 1) && !strcmp(argv[1], "maccolortrash")) {
            id obj = [Definitions MacColorTrash];
            [Definitions runWindowManagerForObject:obj];
        } else if ((argc > 1) && !strcmp(argv[1], "macplatinumtrash")) {
            id obj = [Definitions MacPlatinumTrash];
            [Definitions runWindowManagerForObject:obj];
        } else if ((argc > 1) && !strcmp(argv[1], "ataristdrives")) {
            id obj = [Definitions AtariSTDrives];
            [Definitions runWindowManagerForObject:obj];
        } else if ((argc > 1) && !strcmp(argv[1], "ataristtrash")) {
            id obj = [Definitions AtariSTTrash];
            [Definitions runWindowManagerForObject:obj];
        } else if ((argc > 1) && !strcmp(argv[1], "hotdogstandprograms")) {
            id obj = [Definitions HotDogStandPrograms];
            [Definitions runWindowManagerForObject:obj];
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
            id object = [nsdict() evaluateMessage:message];
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

	[pool drain];

    return 0;
}
