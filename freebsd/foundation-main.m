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

static void signal_handler(int num)
{
NSLog(@"signal_handler %d", num);
}

int main(int argc, char **argv)
{
    if (signal(SIGPIPE, signal_handler) == SIG_ERR) {
NSLog(@"unable to set signal handler for SIGPIPE");
    }

#ifdef BUILD_FOR_ANDROID
    extern void HOTDOG_initialize_stdout(FILE *);
    extern void HOTDOG_initialize(FILE *);
    HOTDOG_initialize_stdout(stdout);
    HOTDOG_initialize(stderr);
#elif BUILD_FOR_OSX
#else
    extern void HOTDOG_initialize_stdout(FILE *);
    extern void HOTDOG_initialize(FILE *);
    HOTDOG_initialize_stdout(stdout);
    if ((argc >= 2) && !strcmp(argv[1], "dialog")) {
        FILE *fp = fopen("/dev/null", "w");
        if (!fp) {
            fprintf(stderr, "unable to open /dev/null\n");
            exit(1);
        }
        HOTDOG_initialize(fp);
    } else {
        HOTDOG_initialize(stderr);
    }
#endif



    id pool = [[NSAutoreleasePool alloc] init];

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
            id obj = [Definitions Dir];
            [Definitions runWindowManagerForObject:obj];
            [[Definitions navigationStack] setValue:nil forKey:@"context"];
        } else if ((argc > 1) && !strcmp(argv[1], "open")) {
            if (argc > 2) {
                id filePath = nscstr(argv[2]);
                if ([filePath isDirectory]) {
                    chdir(argv[2]);
                }
            }
            id obj = [Definitions Dir];
            [Definitions runWindowManagerForObject:obj];
            [[Definitions navigationStack] setValue:nil forKey:@"context"];
        } else if ((argc > 1) && !strcmp(argv[1], "stringFromFile")) {
            if (argc > 2) {
                id obj = [nsfmt(@"%s", argv[2]) stringFromFile];
//NSLog(@"message %@", message);
                if (obj) {
                    [Definitions runWindowManagerForObject:obj];
                }
            }
        } else if ((argc >= 3) && !strcmp(argv[1], "show")) {
            for (int i=3; i<argc; i++) {
                [nsfmt(@"%s", argv[i]) setAsValueForKey:nsfmt(@"arg%d", i-3)];
            }
            id message = nsfmt(@"%s", argv[2]);
//NSLog(@"message %@", message);
            id object = [[Definitions globalContext] evaluateMessage:message];
            if (object) {
                [Definitions runWindowManagerForObject:object];
            }
        } else if ((argc >= 3) && !strcmp(argv[1], "output")) {
            for (int i=3; i<argc; i++) {
                [nsfmt(@"%s", argv[i]) setAsValueForKey:nsfmt(@"arg%d", i-3)];
            }
            id message = nsfmt(@"%s", argv[2]);
//NSLog(@"message %@", message);
            [[Definitions globalContext] evaluateMessage:message];
            exit(0);
        } else if ((argc > 2) && !strcmp(argv[1], "windowproperty")) {
            char *propertyName = argv[2];
            id args = nsarr();
            for (int i=3; i<argc; i++) {
                id str = nscstr(argv[i]);
                [args addObject:str];
            }
            id message = [args join:@" "];
//NSLog(@"message %@", message);
            id object = [nsdict() evaluateMessage:message];
            if (object) {
                [Definitions runWindowManagerForObject:object propertyName:propertyName];
            }
        } else if ((argc > 1) && !strcmp(argv[1], "desktop")) {
            id args = nsarr();
            for (int i=2; i<argc; i++) {
                id str = nscstr(argv[i]);
                [args addObject:str];
            }
            id message = [args join:@" "];
//NSLog(@"message %@", message);
            id object = [nsdict() evaluateMessage:message];
            if (!object) {
                exit(0);
            }

            [object setAsValueForKey:@"desktopObject"];

            char *propertyName = "HOTDOGDESKTOP";


            id windowManager = [@"WindowManager" asInstance];
            [windowManager setAsValueForKey:@"windowManager"];
            if (![windowManager setupX11]) {
NSLog(@"unable to setup window manager");
exit(0);
            }


            unsigned long appMenuWindow = 0;
            if ([object respondsToSelector:@selector(appMenuArray)]) {
                id appMenuArray = [object appMenuArray];
                if (appMenuArray) {
                    appMenuWindow = [windowManager openAppMenuWindowsForArray:appMenuArray];
                }
            }

            id dict = [windowManager openUnmappedWindowForObject:object x:0 y:0 w:10 h:10 overrideRedirect:NO propertyName:propertyName];
NSLog(@"unmapped dict %@", dict);

            if (dict && appMenuWindow) {
                unsigned long win = [dict unsignedLongValueForKey:@"window"];
                id str = nsfmt(@"%lu", appMenuWindow);
                [str setAsValueForKey:@"HOTDOGAPPMENUHEAD"];
                [windowManager XChangeProperty:win name:"HOTDOGAPPMENUHEAD" str:str];
                [windowManager XRaiseWindow:win];
            }
                
            [windowManager runLoop];


            exit(0);

        } else if ((argc == 2) && !strcmp(argv[1], ".")) {
            id obj = [Definitions ObjectInterface];
            [Definitions runWindowManagerForObject:obj];
        } else if ((argc > 1) && !strcmp(argv[1], "keyval")) {
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
                id arr = nsarr();
                for (int i=0; i<[lines count]; i++) {
                    id line = [lines nth:i];
                    id dict = nsdict();
                    char *linecstr = [line UTF8String];
                    char *colon = strchr(linecstr, ':');
                    if (colon) {
                        [dict setValue:nscstrn(linecstr, colon-linecstr) forKey:@"key"];
                        [dict setValue:nsfmt(@"%s", colon+1) forKey:@"val"];
                    } else {
                        [dict setValue:@"" forKey:@"key"];
                        [dict setValue:line forKey:@"val"];
                    }
                    [arr addObject:dict];
                }
                id nav = [Definitions navigationStack];
                id obj = [arr asTableInterface];
                [nav pushObject:obj];
                [Definitions runWindowManagerForObject:nav];
            }
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
                id arr = nsarr();
                for (int i=0; i<[lines count]; i++) {
                    id line = [lines nth:i];
                    id dict = nsdict();
                    [dict setValue:line forKey:@"line"];
                    [arr addObject:dict];
                }
                id nav = [Definitions navigationStack];
                id obj = [arr asTableInterface];
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
                id nav = [Definitions navigationStack];
                id obj = [lines asTableInterface];
                [nav pushObject:obj];
                [Definitions runWindowManagerForObject:nav];
            }
        } else if ((argc > 1) && !strcmp(argv[1], "nav")) {
            if ((argc == 3) && !strcmp(argv[2], ".")) {
                id obj = [Definitions ObjectInterface];
                id nav = [Definitions navigationStack];
                [nav pushObject:obj];
                [Definitions runWindowManagerForObject:nav];
                [[Definitions navigationStack] setValue:nil forKey:@"context"];
            } else {
                id args = nsarr();
                for (int i=2; i<argc; i++) {
                    id str = nscstr(argv[i]);
                    [args addObject:str];
                }
                id message = [args join:@" "];
                id object = [nsdict() evaluateMessage:message];
                if (object) {
                    id nav = [Definitions navigationStack];
                    [nav pushObject:object];
                    [Definitions runWindowManagerForObject:nav];
                    [[Definitions navigationStack] setValue:nil forKey:@"context"];
                }
            }
        } else if ((argc > 1) && !strcmp(argv[1], "alert")) {
            id str = nil;
            if (argc > 2) {
                for (int i=2; i<argc; i++) {
                    if (!str) {
                        str = nsfmt(@"%s", argv[i]);
                    } else {
                        str = nsfmt(@"%@\n%s", str, argv[i]);
                    }
                }
            } else {
                id data = [Definitions dataFromStandardInput];
                str = [data asString];
            }
            if ([str length]) {
                id hotdogMode = [Definitions valueForEnvironmentVariable:@"HOTDOG_MODE"];
                id obj = nil;
                if ([hotdogMode isEqual:@"aqua"]) {
                    obj = [@"AquaAlert" asInstance];
                } else if ([hotdogMode isEqual:@"amiga"]) {
                    obj = [@"AmigaAlert" asInstance];
                } else if ([hotdogMode isEqual:@"atarist"]) {
                    obj = [@"AtariSTAlert" asInstance];
                } else if ([hotdogMode isEqual:@"macplatinum"]) {
                    obj = [@"MacPlatinumAlert" asInstance];
                } else if ([hotdogMode isEqual:@"hotdogstand"]) {
                    obj = [@"HotDogStandAlert" asInstance];
                } else if ([hotdogMode isEqual:@"winmac"]) {
                    obj = [@"ZeroWingAlert" asInstance];
//                    obj = [@"MacAlert" asInstance];
//                    [obj setValue:@"0" forKey:@"HOTDOGNOFRAME"];
                } else if ([hotdogMode isEqual:@"macwin"]) {
                    obj = [@"MacPlatinumAlert" asInstance];
                } else {
                    obj = [@"MacAlert" asInstance];
                }
                [obj setValue:str forKey:@"text"];
                [obj setValue:@"OK" forKey:@"okText"];
                [Definitions runWindowManagerForObject:obj];
            }
        } else if ((argc > 1) && !strcmp(argv[1], "confirm")) {
            id okText = @"OK";
            id cancelText = @"Cancel";
            if (argc > 2) {
                okText = nsfmt(@"%s", argv[2]);
            }
            if (argc > 3) {
                cancelText = nsfmt(@"%s", argv[3]);
            }
            id text = nil;
            if (argc > 4) {
                for (int i=4; i<argc; i++) {
                    if (!text) {
                        text = nsfmt(@"%s", argv[i]);
                    } else {
                        text = nsfmt(@"%@\n%s", text, argv[i]);
                    }
                }
            } else {
                id data = [Definitions dataFromStandardInput];
                text = [data asString];
            }
            if ([text length]) {
                id hotdogMode = [Definitions valueForEnvironmentVariable:@"HOTDOG_MODE"];
                id obj = nil;
                if ([hotdogMode isEqual:@"aqua"]) {
                    obj = [@"AquaAlert" asInstance];
                } else if ([hotdogMode isEqual:@"amiga"]) {
                    obj = [@"AmigaAlert" asInstance];
                } else if ([hotdogMode isEqual:@"atarist"]) {
                    obj = [@"AtariSTAlert" asInstance];
                } else if ([hotdogMode isEqual:@"macplatinum"]) {
                    obj = [@"MacPlatinumAlert" asInstance];
                } else if ([hotdogMode isEqual:@"hotdogstand"]) {
                    obj = [@"HotDogStandAlert" asInstance];
                } else if ([hotdogMode isEqual:@"winmac"]) {
                    obj = [@"ZeroWingAlert" asInstance];
                } else if ([hotdogMode isEqual:@"macwin"]) {
                    obj = [@"MacPlatinumAlert" asInstance];
                } else {
                    obj = [@"MacAlert" asInstance];
                }
                [obj setValue:text forKey:@"text"];
                [obj setValue:okText forKey:@"okText"];
                [obj setValue:cancelText forKey:@"cancelText"];
                [Definitions runWindowManagerForObject:obj];
            }
        } else if ((argc > 1) && !strcmp(argv[1], "checklist")) {
            id text = @"Checklist";
            id okText = @"OK";
            id cancelText = @"Cancel";
            if (argc > 2) {
                okText = (argv[2]) ? nsfmt(@"%s", argv[2]) : nil;
            }
            if (argc > 3) {
                cancelText = (argv[3]) ? nsfmt(@"%s", argv[3]) : nil;
            }
            if (argc > 4) {
                text = nsfmt(@"%s", argv[4]);
            }
            id arr = nsarr();
            if (argc > 5) {
                for (int i=5; i+2<argc; i+=3) {
                    id dict = nsdict();
                    [dict setValue:nsfmt(@"%s", argv[i]) forKey:@"tag"];
                    [dict setValue:nsfmt(@"%s", argv[i+1]) forKey:@"checked"];
                    [dict setValue:nsfmt(@"%s", argv[i+2]) forKey:@"text"];
                    [arr addObject:dict];
                }
            }
            id hotdogMode = [Definitions valueForEnvironmentVariable:@"HOTDOG_MODE"];
            id obj = nil;
            if ([hotdogMode isEqual:@"aqua"]) {
                obj = [@"AquaChecklist" asInstance];
            } else if ([hotdogMode isEqual:@"amiga"]) {
                obj = [@"AmigaChecklist" asInstance];
            } else if ([hotdogMode isEqual:@"atarist"]) {
                obj = [@"AtariSTChecklist" asInstance];
            } else if ([hotdogMode isEqual:@"macplatinum"]) {
                obj = [@"MacPlatinumChecklist" asInstance];
            } else if ([hotdogMode isEqual:@"hotdogstand"]) {
                obj = [@"HotDogStandChecklist" asInstance];
            } else if ([hotdogMode isEqual:@"winmac"]) {
                obj = [@"ZeroWingChecklist" asInstance];
            } else if ([hotdogMode isEqual:@"macwin"]) {
                obj = [@"MacPlatinumChecklist" asInstance];
            } else {
                obj = [@"MacChecklist" asInstance];
            }
            [obj setValue:@"1" forKey:@"dialogMode"];
            [obj setValue:text forKey:@"text"];
            [obj setValue:arr forKey:@"array"];
            [obj setValue:okText forKey:@"okText"];
            [obj setValue:cancelText forKey:@"cancelText"];
            for (int i=0; i<[arr count]; i++) {
                id elt = [arr nth:i];
                if ([elt intValueForKey:@"checked"]) {
                    [obj setChecked:YES forIndex:i];
                }
            }
            [Definitions runWindowManagerForObject:obj];
        } else if ((argc > 1) && !strcmp(argv[1], "radio")) {
            id text = @"Radio";
            id okText = @"OK";
            id cancelText = @"Cancel";
            if (argc > 2) {
                okText = (argv[2]) ? nsfmt(@"%s", argv[2]) : nil;
            }
            if (argc > 3) {
                cancelText = (argv[3]) ? nsfmt(@"%s", argv[3]) : nil;
            }
            if (argc > 4) {
                text = nsfmt(@"%s", argv[4]);
            }
            id arr = nsarr();
            if (argc > 5) {
                for (int i=5; i+2<argc; i+=3) {
                    id dict = nsdict();
                    [dict setValue:nsfmt(@"%s", argv[i]) forKey:@"tag"];
                    [dict setValue:nsfmt(@"%s", argv[i+1]) forKey:@"selected"];
                    [dict setValue:nsfmt(@"%s", argv[i+2]) forKey:@"text"];
                    [arr addObject:dict];
                }
            }
            id hotdogMode = [Definitions valueForEnvironmentVariable:@"HOTDOG_MODE"];
            id obj = nil;
            if ([hotdogMode isEqual:@"aqua"]) {
                obj = [@"AquaRadio" asInstance];
            } else if ([hotdogMode isEqual:@"amiga"]) {
                obj = [@"AmigaRadio" asInstance];
            } else if ([hotdogMode isEqual:@"atarist"]) {
                obj = [@"AtariSTRadio" asInstance];
            } else if ([hotdogMode isEqual:@"macplatinum"]) {
                obj = [@"MacPlatinumRadio" asInstance];
            } else if ([hotdogMode isEqual:@"hotdogstand"]) {
                obj = [@"HotDogStandRadio" asInstance];
            } else if ([hotdogMode isEqual:@"winmac"]) {
                obj = [@"ZeroWingRadio" asInstance];
            } else if ([hotdogMode isEqual:@"macwin"]) {
                obj = [@"MacPlatinumRadio" asInstance];
            } else {
                obj = [@"MacRadio" asInstance];
            }
            [obj setValue:@"1" forKey:@"dialogMode"];
            [obj setValue:text forKey:@"text"];
            [obj setValue:arr forKey:@"array"];
            [obj setValue:okText forKey:@"okText"];
            [obj setValue:cancelText forKey:@"cancelText"];
            for (int i=0; i<[arr count]; i++) {
                id elt = [arr nth:i];
                if ([elt intValueForKey:@"selected"]) {
                    [obj setValue:nsfmt(@"%d", i) forKey:@"selectedIndex"];
                    break;
                }
            }
            [Definitions runWindowManagerForObject:obj];
        } else if ((argc > 1) && !strcmp(argv[1], "input")) {
            id okText = @"OK";
            id cancelText = @"Cancel";
            id text = @"";
            id fieldText = @"";
            id initialText = nil;

            if (argc > 2) {
                okText = (argv[2]) ? nsfmt(@"%s", argv[2]) : nil;
            }
            if (argc > 3) {
                cancelText = (argv[3]) ? nsfmt(@"%s", argv[3]) : nil;
            }
            if (argc > 4) {
                text = nsfmt(@"%s", argv[4]);
            }
            if (argc > 5) {
                fieldText = nsfmt(@"%s", argv[5]);
            }
            if (argc > 6) {
                initialText = nsfmt(@"%s", argv[6]);
            }

            id hotdogMode = [Definitions valueForEnvironmentVariable:@"HOTDOG_MODE"];
            id obj = nil;
            if ([hotdogMode isEqual:@"aqua"]) {
                obj = [@"AquaTextFields" asInstance];
            } else if ([hotdogMode isEqual:@"amiga"]) {
                obj = [@"AmigaTextFields" asInstance];
            } else if ([hotdogMode isEqual:@"atarist"]) {
                obj = [@"AtariSTTextFields" asInstance];
            } else if ([hotdogMode isEqual:@"macplatinum"]) {
                obj = [@"MacPlatinumTextFields" asInstance];
            } else if ([hotdogMode isEqual:@"hotdogstand"]) {
                obj = [@"HotDogStandTextFields" asInstance];
            } else if ([hotdogMode isEqual:@"winmac"]) {
                obj = [@"ZeroWingTextFields" asInstance];
            } else if ([hotdogMode isEqual:@"macwin"]) {
                obj = [@"MacPlatinumTextFields" asInstance];
            } else {
                obj = [@"MacTextFields" asInstance];
            }
            [obj setValue:@"1" forKey:@"dialogMode"];

            [obj setValue:text forKey:@"text"];
            [obj setValue:okText forKey:@"okText"];
            [obj setValue:cancelText forKey:@"cancelText"];

            id fields = nsarr();
            [fields addObject:fieldText];
            [obj setValue:fields forKey:@"fields"];

            if (initialText) {
                id buffers = nsarr();
                [buffers addObject:initialText];
                [obj setValue:buffers forKey:@"buffers"];
            }

            [Definitions runWindowManagerForObject:obj];
        } else if ((argc > 1) && !strcmp(argv[1], "password")) {
            id okText = @"OK";
            id cancelText = @"Cancel";
            id text = @"";
            id fieldText = @"";

            if (argc > 2) {
                okText = (argv[2]) ? nsfmt(@"%s", argv[2]) : nil;
            }
            if (argc > 3) {
                cancelText = (argv[3]) ? nsfmt(@"%s", argv[3]) : nil;
            }
            if (argc > 4) {
                text = nsfmt(@"%s", argv[4]);
            }
            if (argc > 5) {
                fieldText = nsfmt(@"%s", argv[5]);
            }

            id hotdogMode = [Definitions valueForEnvironmentVariable:@"HOTDOG_MODE"];
            id obj = nil;
            if ([hotdogMode isEqual:@"aqua"]) {
                obj = [@"AquaTextFields" asInstance];
            } else if ([hotdogMode isEqual:@"amiga"]) {
                obj = [@"AmigaTextFields" asInstance];
            } else if ([hotdogMode isEqual:@"atarist"]) {
                obj = [@"AtariSTTextFields" asInstance];
            } else if ([hotdogMode isEqual:@"macplatinum"]) {
                obj = [@"MacPlatinumTextFields" asInstance];
            } else if ([hotdogMode isEqual:@"hotdogstand"]) {
                obj = [@"HotDogStandTextFields" asInstance];
            } else if ([hotdogMode isEqual:@"winmac"]) {
                obj = [@"ZeroWingTextFields" asInstance];
            } else if ([hotdogMode isEqual:@"macwin"]) {
                obj = [@"MacPlatinumTextFields" asInstance];
            } else {
                obj = [@"MacTextFields" asInstance];
            }
            [obj setValue:@"1" forKey:@"dialogMode"];

            [obj setValue:@"1" forKey:@"hidden"];
            [obj setValue:text forKey:@"text"];
            [obj setValue:okText forKey:@"okText"];
            [obj setValue:cancelText forKey:@"cancelText"];

            id fields = nsarr();
            [fields addObject:fieldText];
            [obj setValue:fields forKey:@"fields"];

            [Definitions runWindowManagerForObject:obj];
        } else if ((argc > 1) && !strcmp(argv[1], "prgbox")) {
            id cmd = nsarr();
            for (int i=2; i<argc; i++) {
                [cmd addObject:nsfmt(@"%s", argv[i])];
            }
            id process = [cmd runCommandAndReturnProcessWithError];
            if (!process) {
NSLog(@"unable to run command %@", cmd);
                exit(1);
            }
            id obj = [@"AmigaPrgBox" asInstance];
            [obj setValue:process forKey:@"process"];
            [obj setValue:nsfmt(@"%@", [cmd join:@" "]) forKey:@"text"];
            [obj setValue:@"OK" forKey:@"okText"];
            [Definitions runWindowManagerForObject:obj];
        } else if ((argc > 1) && !strcmp(argv[1], "drives")) {
            id hotdogMode = [Definitions valueForEnvironmentVariable:@"HOTDOG_MODE"];
            id obj = nil;
            if ([hotdogMode isEqual:@"aqua"]) {
                obj = [Definitions MacColorDrives];
            } else if ([hotdogMode isEqual:@"amiga"]) {
                obj = [Definitions AmigaDrives];
            } else if ([hotdogMode isEqual:@"macclassic"]) {
                obj = [Definitions MacClassicDrives];
            } else if ([hotdogMode isEqual:@"maccolor"]) {
                obj = [Definitions MacColorDrives];
            } else if ([hotdogMode isEqual:@"atarist"]) {
                obj = [Definitions AtariSTDrives];
            } else if ([hotdogMode isEqual:@"hotdogstand"]) {
                obj = [Definitions HotDogStandPrograms];
            } else {
                obj = [Definitions MacColorDrives];
            }
            [Definitions runWindowManagerForObject:obj];
        } else if ((argc > 2) && !strcmp(argv[1], "hotdogstandbuiltindir")) {
            id obj = [Definitions HotDogStandBuiltInDir:nsfmt(@"%s", argv[2])];
            [Definitions runWindowManagerForObject:obj];
        } else if ((argc > 1) && !strcmp(argv[1], "dir")) {
            if (argc > 2) {
                id filePath = nscstr(argv[2]);
                if ([filePath isDirectory]) {
                    chdir(argv[2]);
                }
            }

            id hotdogMode = [Definitions valueForEnvironmentVariable:@"HOTDOG_MODE"];
            id obj = nil;
            BOOL clearNavigationStack = NO;
            if ([hotdogMode isEqual:@"aqua"]) {
                obj = [Definitions ObjectInterface];
                if (obj) {
                    if ([obj isKindOfClass:[@"Panel" asClass]]) {
                        id nav = [Definitions navigationStack];
                        [nav pushObject:obj];
                        obj = nav;
                        clearNavigationStack = YES;
                    }
                }
            } else if ([hotdogMode isEqual:@"amiga"]) {
                obj = [Definitions AmigaDir:@"."];
            } else if ([hotdogMode isEqual:@"macclassic"]) {
                obj = [Definitions MacClassicDir:@"."];
            } else if ([hotdogMode isEqual:@"maccolor"]) {
                obj = [Definitions MacColorDir:@"."];
            } else {
                obj = [Definitions MacColorDir:@"."];
            }
            [Definitions runWindowManagerForObject:obj];
            if (clearNavigationStack) {
                [[Definitions navigationStack] setValue:nil forKey:@"context"];
            }
        } else if ((argc > 1) && !strcmp(argv[1], "dialog")) {
            if (argc > 3) {
                char *classPrefix = "Amiga";
                if (!strcmp(argv[2], "amiga")) {
                    classPrefix = "Amiga";
                } else if (!strcmp(argv[2], "mac")) {
                    classPrefix = "Mac";
                } else if (!strcmp(argv[2], "aqua")) {
                    classPrefix = "Aqua";
                } else if (!strcmp(argv[2], "macplatinum")) {
                    classPrefix = "MacPlatinum";
                } else if (!strcmp(argv[2], "hotdogstand")) {
                    classPrefix = "HotDogStand";
                } else if (!strcmp(argv[2], "atarist")) {
                    classPrefix = "AtariST";
                } else if (!strcmp(argv[2], "zerowing")) {
                    classPrefix = "ZeroWing";
                }
                [Definitions dialog:classPrefix :argc-3 :&argv[3]];
            }
            exit(-1);
        } else if ((argc > 1) && !strcmp(argv[1], "VCFPanel")) {
            if (argc > 2) {
                id obj = [Definitions VCFPanel:nsfmt(@"%s", argv[2])];
                [Definitions runWindowManagerForObject:obj];
                exit(0);
            }
            exit(1);
        } else if ((argc > 1) && !strcmp(argv[1], "oldman")) {
            id text = nil;
            if (argc > 2) {
                text = nsfmt(@"%s", argv[2]);
            } else {
                id data = [Definitions dataFromStandardInput];
                text = [data asString];
            }
            id obj = [Definitions OldMan];
            [obj setValue:text forKey:@"text"];
            [Definitions runWindowManagerForObject:obj];
            exit(0);
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

	[pool drain];

    return 0;
}
