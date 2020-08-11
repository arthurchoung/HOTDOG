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

@implementation NSObject(jfkldsjflksdjf)
- (id)valuesForAllIvars
{
    id arr = [[self allIvars] split:@"\n"];
    id results = nsarr();
    for (id elt in arr) {
        id tokens = [elt split:@" "];
        id key = [tokens nth:1];
        id val = [self valueForKey:[key stringFromIndex:1]];
        id str = nsfmt(@"%@ %@", key, val);
        [results addObject:str];
    }
    return [results join:@"\n"];
}
@end

@implementation Definitions(fjdksljfklsdjf)
+ (id)selectorMenu
{
    id arr = [Definitions classMethods];
    arr = [arr asSortedArray];
    arr = [arr mapBlock:^(id obj) {
        id dict = nsdict();
        [dict setValue:@"#{selector}" forKey:@"stringFormat"];
        [dict setValue:obj forKey:@"selector"];
        [dict setValue:@"1" forKey:@"drawChevron"];
        [dict setValue:@"selector|asTextFieldsForSelector" forKey:@"messageForClick"];
        return dict;
    }];
    return arr;
}
+ (id)testTextFields
{
    id obj = [@"TextFields" asInstance];
    id fields = [@"field1:field2:field3:field4:field5:" splitTerminator:@":"];
    [obj setValue:fields forKey:@"fields"];
    return obj;
}
@end

@implementation NSString(fjdklsfjlksdjf)
- (id)asTextFieldsForSelector
{
    id obj = [@"TextFields" asInstance];
    id fields = [self splitTerminator:@":"];
    if (![fields count]) {
        return nil;
    }
    [obj setValue:fields forKey:@"fields"];
    return obj;
}
@end

@interface TextFields : IvarObject
{
    id _fields;
    id _buffers;
    int _cursorBlink;
    int _cursorPos;
    int _currentField;
    int _okButtonDown;
}
@end
@implementation TextFields

- (void)handleBackgroundUpdate:(id)event
{
    _cursorBlink--;
    if (_cursorBlink < 0) {
        _cursorBlink = 1;
    }
}
- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    [bitmap setColor:@"white"];
    [bitmap fillRect:r];

    int textHeight = [bitmap bitmapHeightForText:@"A"];

    int fieldWidth = 0;
    for (int i=0; i<[_fields count]; i++) {
        int w = [bitmap bitmapWidthForText:[_fields nth:i]];
        if (w > fieldWidth) {
            fieldWidth = w;
        }
    }

    int y = r.y+10;
    {
        int x = 5;
        for (int i=0; i<[_fields count]; i++) {
            id field = [_fields nth:i];
            [bitmap setColorIntR:0 g:0 b:0 a:255];
            [bitmap drawBitmapText:field x:10+fieldWidth-[bitmap bitmapWidthForText:field] y:y+6];

            int x = 10 + fieldWidth + 10;
            [bitmap setColor:@"black"];
            [bitmap fillRectX:x y:y w:r.w-x-10 h:22];
            [bitmap setColor:@"white"];
            [bitmap fillRectX:x+1 y:y+1 w:r.w-x-10-2 h:22-2];

            id str = [_buffers nth:i];
            if (!str) {
                str = @"";
            }
            id left = [str stringToIndex:_cursorPos];
            id right = [str stringFromIndex:_cursorPos];

            if ([left length]) {
                [bitmap setColorIntR:0 g:0 b:0 a:255];
                [bitmap drawBitmapText:left x:x+4 y:y+6];
                x += [bitmap bitmapWidthForText:left]+2;
            }
            if (_currentField == i) {
                if (_cursorBlink) {
                    [bitmap setColor:@"black"];
                    [bitmap drawVerticalLineX:x-1+4 y:y+3 y:y+18];
                }
            }
            if ([right length]) {
                [bitmap setColorIntR:0 g:0 b:0 a:255];
                [bitmap drawBitmapText:right x:x+4 y:y+6];
            }

            y += 27;
        }
    }

    y += 28 + 18;
    Int4 buttonRect = [Definitions rectWithX:r.w-88 y:y w:70 h:28];
    if (_okButtonDown) {
        char *palette = ". #000000\nb #000000\nw #ffffff\n";
        [Definitions drawDefaultButtonInBitmap:bitmap rect:buttonRect palette:palette];
        [bitmap setColorIntR:255 g:255 b:255 a:255];
        [bitmap drawBitmapText:@"OK" centeredInRect:buttonRect];
    } else {
        char *palette = ". #ffffff\nb #000000\nw #ffffff\n";
        [Definitions drawDefaultButtonInBitmap:bitmap rect:buttonRect palette:palette];
        [bitmap setColorIntR:0 g:0 b:0 a:255];
        [bitmap drawBitmapText:@"OK" centeredInRect:buttonRect];
    }
}

- (void)handleKeyDown:(id)event
{
    if (!_buffers) {
        id arr = [_fields mapBlock:^(id obj) {
            return @"";
        }];
        [self setValue:arr forKey:@"buffers"];
    }
    id buf = [_buffers nth:_currentField];
    id str = [event valueForKey:@"keyString"];
    if ([str length] == 1) {
        if (![buf length]) {
            [_buffers replaceObjectAtIndex:_currentField withObject:str];
            _cursorPos = 1;
            _cursorBlink = 1;
        } else {
            id left = [buf stringToIndex:_cursorPos];
            id right = [buf stringFromIndex:_cursorPos];
            id newBuf = nsfmt(@"%@%@%@", left, str, right);
            [_buffers replaceObjectAtIndex:_currentField withObject:newBuf];
            _cursorPos++;
            _cursorBlink = 1;
        }
    } else if ([str isEqual:@"left"]) {
        if (_cursorPos - 1 >= 0) {
            _cursorPos--;
        }
        _cursorBlink = 1;
    } else if ([str isEqual:@"right"]) {
        if (_cursorPos + 1 <= [buf length]) {
            _cursorPos++;
        }
        _cursorBlink = 1;
    } else if ([str isEqual:@"backspace"]) {
        if (_cursorPos >= 1) {
            id left = (_cursorPos > 1) ? [buf stringToIndex:_cursorPos-1] : @"";
            id right = [buf stringFromIndex:_cursorPos];
            id newBuf = nsfmt(@"%@%@", left, right);
            [_buffers replaceObjectAtIndex:_currentField withObject:newBuf];
            _cursorPos--;
        }
        _cursorBlink = 1;
    } else if ([str isEqual:@"return"]) {
        _okButtonDown = YES;
    } else if ([str isEqual:@"tab"]) {
        if ([_fields count] > 1) {
            _currentField++;
            if (_currentField >= [_fields count]) {
                _currentField = 0;
            }
            _cursorPos = [[_buffers nth:_currentField] length];
            _cursorBlink = 2;
        }
    } else if ([str isEqual:@"shifttab"]) {
        if ([_fields count] > 1) {
            _currentField--;
            if (_currentField < 0) {
                _currentField = [_fields count]-1;
            }
            _cursorPos = [[_buffers nth:_currentField] length];
            _cursorBlink = 2;
        }
    }
}
- (void)handleKeyUp:(id)event
{
    id str = [event valueForKey:@"keyString"];
    if ([str isEqual:@"return"]) {
        _okButtonDown = NO;
        id message = nsarr();
        for (int i=0; i<[_fields count]; i++) {
            id field = [_fields nth:i];
            id buf = [_buffers nth:i];
            [message addObject:nsfmt(@"%@'%@'", field, buf)];
        }
        message = [message join:@" "];
id result = [self evaluateMessage:message];
[result pushToMainInterface];
//        [self setValue:message forKey:@"returnValue"];
    }
}
@end

