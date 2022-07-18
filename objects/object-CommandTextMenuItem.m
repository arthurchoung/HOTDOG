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

// FIXME: Couple of hacks, fix later
@implementation Definitions(fmekwlfeiosmfklxdvmosjdfiosdf)
+ (id)PercentString:(id)val
{
    return nsfmt(@"%@%%", val);
}
+ (id)MuteString
{
    return @"Mute";
}
@end

// for compatibility
// CommandOutputText has been renamed to CommandTextMenuItem
@implementation Definitions(fjkdlsfjjfdksjfklksdejwklfmksldmfklsdmfklsdjkf)
+ (id)CommandOutputText:(id)cmd
{
    id process = [cmd runCommandAndReturnProcess];
    id obj = [@"CommandTextMenuItem" asInstance];
    [obj setValue:cmd forKey:@"command"];
    [obj setValue:process forKey:@"fileDescriptor"];
    return obj;
}
+ (id)CommandOutputText:(id)cmd lineMessage:(id)lineMessage
{
    id obj = [Definitions CommandTextMenuItem:cmd];
    [obj setValue:lineMessage forKey:@"lineMessage"];
    return obj;
}
+ (id)CommandOutputText:(id)cmd stringFormat:(id)stringFormat
{
    id obj = [Definitions CommandTextMenuItem:cmd];
    [obj setValue:stringFormat forKey:@"stringFormat"];
    return obj;
}
+ (id)CommandOutputText:(id)cmd lineMessage:(id)lineMessage stringFormat:(id)stringFormat
{
    id obj = [Definitions CommandTextMenuItem:cmd];
    [obj setValue:lineMessage forKey:@"lineMessage"];
    [obj setValue:stringFormat forKey:@"stringFormat"];
    return obj;
}
@end

@implementation Definitions(fjkdlsfjlksdejwklfmksldmfklsdmfklsdjkf)
+ (id)CommandTextMenuItem:(id)cmd
{
    id process = [cmd runCommandAndReturnProcess];
    id obj = [@"CommandTextMenuItem" asInstance];
    [obj setValue:cmd forKey:@"command"];
    [obj setValue:process forKey:@"fileDescriptor"];
    return obj;
}
+ (id)CommandTextMenuItem:(id)cmd lineMessage:(id)lineMessage
{
    id obj = [Definitions CommandTextMenuItem:cmd];
    [obj setValue:lineMessage forKey:@"lineMessage"];
    return obj;
}
+ (id)CommandTextMenuItem:(id)cmd stringFormat:(id)stringFormat
{
    id obj = [Definitions CommandTextMenuItem:cmd];
    [obj setValue:stringFormat forKey:@"stringFormat"];
    return obj;
}
+ (id)CommandTextMenuItem:(id)cmd lineMessage:(id)lineMessage stringFormat:(id)stringFormat
{
    id obj = [Definitions CommandTextMenuItem:cmd];
    [obj setValue:lineMessage forKey:@"lineMessage"];
    [obj setValue:stringFormat forKey:@"stringFormat"];
    return obj;
}
@end

@interface CommandTextMenuItem : IvarObject
{
    id _command;
    id _fileDescriptor;
    id _lastLine;
    int _maxWidth;
    id _lineMessage;
    id _stringFormat;
}
@end
@implementation CommandTextMenuItem
    
- (int)fileDescriptor
{
    if (_fileDescriptor) {
        return [_fileDescriptor fileDescriptor];
    }
    return -1;
}
- (void)handleFileDescriptor
{
    if (_fileDescriptor) {
        [_fileDescriptor handleFileDescriptor];
        for(;;) {
            id line = [[_fileDescriptor valueForKey:@"data"] readLine];
            if (!line) {
                break;
            }
NSLog(@"CommandOutputText command '%@' readLine '%@'", _command, line);
            [self setValue:line forKey:@"lastLine"];
            if (_lineMessage) {
                [line evaluateMessage:_lineMessage];
            }
        }
    }
}
- (id)text
{
    id str = @"No output";
    if (_stringFormat) {
        if (_lastLine) {
            str = [_lastLine str:_stringFormat];
        } else {
            str = [@"" str:_stringFormat];
        }
    } else if (_lastLine) {
        str = _lastLine;
    }
    return str;
}

@end
