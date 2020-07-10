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


@implementation NSString(jfksdljfklsdjfsdfjksdjfkdsjfksdjfkiji)

- (BOOL)hasAnySuffix:(id)suffixes
{
    for (id suffix in suffixes) {
        if ([self hasSuffix:suffix]) {
            return YES;
        }
    }
    return NO;
}

- (id)capitalizeFirstLetter
{
    int len = [self length];
    if (!len) {
        return self;
    }
    if (len == 1) {
        return [self uppercaseString];
    }
    id first = [self stringToIndex:1];
    id last = [self stringFromIndex:1];
    return nsfmt(@"%@%@", [first uppercaseString], last);
}

- (unsigned char)unsignedCharValue
{
    unsigned char val = [self intValue];
    return val;
}
- (unsigned long)unsignedLongValue
{
    return strtoul([self UTF8String], NULL, 10);
}
- (long)longValue
{
    return strtol([self UTF8String], NULL, 10);
}

- (id)keepAlphanumericCharacters
{
    return [self keepCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ01234567890"];
}
- (id)keepAlphanumericCharactersAndSpaces
{
    return [self keepCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ01234567890 "];
}
- (id)keepAlphanumericCharactersAndSpacesAndPunctuation
{
    return [self keepCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ01234567890 !@#$%^&*()-_=+[];:'\",<.>/?|"];
}
- (id)keepAlphanumericCharactersAndSpacesAndPunctuationAndNewlines
{
    return [self keepCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ01234567890 !@#$%^&*()-_=+[];:'\",<.>/?|\n"];
}
- (id)replaceNonAlphanumericCharactersWithSpaces
{
    id str = [[self mutableCopy] autorelease];
    return [str destructiveReplaceCharactersNotInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ01234567890" withChar:' '];
}

- (id)parseAsSimpleDictionary
{
    id results = nsdict();
    id pairs = [self split:@" "];
    for (id elt in pairs) {
        if (![elt containsString:@"="]) {
            continue;
        }
        id tokens = [elt split:@"="];
        id key = [tokens nth:0];
        id val = [tokens nth:1];
        if (![key length] || ![val length]) {
            continue;
        }
        [results setValue:val forKey:key];
    }
    return results;
}

- (id)split:(id)sep
{
    return [[self componentsSeparatedByString:sep] filterEmptyStrings];
}
- (id)cat:(id)str
{
    return (str) ? [self stringByAppendingString:str] : self;
}

- (id)asCapitalizedString
{
    return [[[self stringToIndex:1] uppercaseString] cat:[self stringFromIndex:1]];
}


- (id)keepCharactersInString:(id)keepString
{
    char *selfChars = [self UTF8String];
    char *keepChars = [keepString UTF8String];
    id results = nsarr();
    char *p = selfChars;
    while (*p) {
        if (strchr(keepChars, *p)) {
            [results addObject:nsfmt(@"%c", *p)];
        }
        p++;
    }
    return [results join:@""];
}

- (id)splitMaxLength:(int)maxLength
{
    id results = nsarr();
    id str = self;
    for(;;) {
        if ([str length] > maxLength) {
            [results addObject:[str substringToIndex:maxLength]];
            str = [str substringFromIndex:maxLength];
            continue;
        }
        [results addObject:str];
        break;
    }
    return results;
}
- (int)nthChar:(int)index
{
    NSLog(@"nthChar:%d", index);
    int len = [self length];
    if (index < 0) {
        return 0;
    }
    if (index >= len) {
        return 0;
    }
    return [self characterAtIndex:index];
}


- (id)strip:(id)str
{
    return [self stringByReplacingOccurrencesOfString:str withString:@""];
}
- (id)stripTabs
{
    return [self strip:@"\t"];
}
- (id)stripNewlines
{
    return [self strip:@"\n"];
}


- (id)splitCharacters
{
    int length = [self length];
    id arr = nsarr();
    for (int i=0; i<length; i++) {
        [arr addObject:nsfmt(@"%c", [self characterAtIndex:i])];
    }
    return arr;
}

- (id)strWithContext:(id)context
{
    id string = self;
    id components = [string componentsSeparatedByString:@"#{"];
    if ([components count] == 0) {
        return @"";
    }
    if ([components count] == 1) {
        return string;
    }

    id results = nsarr();
    [results addObject:[components objectAtIndex:0]];

    for (int i=1; i<[components count]; i++) {
        id parts = [[components objectAtIndex:i] componentsSeparatedByString:@"}"];
        id expression = [parts objectAtIndex:0];
        if (expression) {
            id stringValue = nil;
            stringValue = [context valueForKey:expression];
            if (!stringValue) {
                 stringValue = [context evaluateMessage:expression];
            }
            if (stringValue) {
                [results addObject:[stringValue description]];
            } else {
            }
        }
        [results addObject:[parts objectAtIndex:1]];
        for (int j=2; j<[parts count]; j++) {
            [results addObject:@"}"];
            [results addObject:[parts objectAtIndex:j]];
        }
    }
    return [results join:@""];
}

- (BOOL)isInt
{
    char *cstring = [self UTF8String];
    if (!cstring || !*cstring) {
        return NO;
    }
    char *endptr;
    long long lvalue = strtoll(cstring, &endptr, 10);
    if (*endptr == 0) {
        return YES;
    }
    return NO;
}

- (BOOL)isDouble
{
    char *cstring = [self UTF8String];
    if (!cstring || !*cstring) {
        return NO;
    }
    char *endptr;
    double dvalue = strtod(cstring, &endptr);
    if (*endptr == 0) {
        return YES;
    }
    return NO;
}

- (id)stringFromIndex:(int)index
{
    int len = [self length];
    if (len == 0) {
        return self;
    }
    if (index < 0) {
        index += len;
        if (index < 0) {
            return self;
        }
    }
    if (index == 0) {
        return self;
    }
    if (index >= len) {
        return @"";
    }
    return [self substringFromIndex:index];
}

- (id)stringToIndex:(int)index
{
    int len = [self length];
    if (len == 0) {
        return self;
    }
    if (index < 0) {
        index += len;
        if (index <= 0) {
            return @"";
        }
    }
    if (index == 0) {
        return @"";
    }
    if (index >= len) {
        return self;
    }
    return [self substringToIndex:index];
}

- (id)prepend:(id)str
{
    return (str) ? [str cat:self] : self;
}

- (id)cat:(id)str1 cat:(id)str2
{
    return [[self cat:str1] cat:str2];
}

- (id)cat:(id)str1 cat:(id)str2 cat:(id)str3
{
    return [[[self cat:str1] cat:str2] cat:str3];
}

- (id)cat:(id)str1 cat:(id)str2 cat:(id)str3 cat:(id)str4
{
    return [[[[self cat:str1] cat:str2] cat:str3] cat:str4];
}

- (id)cat:(id)str1 cat:(id)str2 cat:(id)str3 cat:(id)str4 cat:(id)str5
{
    return [[[[[self cat:str1] cat:str2] cat:str3] cat:str4] cat:str5];
}

- (id)cat:(id)str1 :(id)str2
{
    return [[self cat:str1] cat:str2];
}

- (id)cat:(id)str1 :(id)str2 :(id)str3
{
    return [[[self cat:str1] cat:str2] cat:str3];
}

- (id)cat:(id)str1 :(id)str2 :(id)str3 :(id)str4
{
    return [[[[self cat:str1] cat:str2] cat:str3] cat:str4];
}

- (id)cat:(id)str1 :(id)str2 :(id)str3 :(id)str4 :(id)str5
{
    return [[[[[self cat:str1] cat:str2] cat:str3] cat:str4] cat:str5];
}

- (BOOL)isString
{
    return isnsstr(self);
}



- (id)asQuotedString
{
    return [self asEscapedString];
}



- (id)asEscapedString
{
    id results = nsarr();
    [results addObject:@"\""];
    int length = [self length];
    for (int i=0; i<length; i++) {
        int c = [self characterAtIndex:i];
        if (c < 32) {
            switch (c) {
                case 0x07: [results addObject:@"\\a"]; break;
                case 0x08: [results addObject:@"\\b"]; break;
                case 0x09: [results addObject:@"\\t"]; break;
                case 0x0a: [results addObject:@"\\n"]; break;
                case 0x0c: [results addObject:@"\\f"]; break;
                case 0x0d: [results addObject:@"\\r"]; break;
                case 0x1b: [results addObject:@"\\e"]; break;
                default:
                    [results addObject:nsfmt(@"\\x%02x", c)];
            }
        }
        else if (c == '"') {
            [results addObject:@"\\\""];
        }
        else if (c == '\\') {
            [results addObject:@"\\\\"];
        }
        else if (c < 127) {
            [results addObject:nsfmt(@"%C", c)];
        }
        else if (c < 256) {
            [results addObject:nsfmt(@"\\x%02x", c)];
        }
        else {
            [results addObject:nsfmt(@"\\u%04x", c)];
        }
    }
    [results addObject:@"\""];
    return [results join:@""];
}






- (id) lines
{
    id a = [self componentsSeparatedByString:@"\n"];
    if ([[a lastObject] isEqual:@""]) {
        return [a subarrayFromLocation:0 length:[a count]-1];
    }
    else {
        return a;
    }
}

- (id)urlDecode
{
    return [self stringByRemovingPercentEncoding];
}

- (id)urlEncode
{
    return [self stringByAddingPercentEscapes];
}



- (id)dataValue
{
    return [NSData dataWithBytes:[self UTF8String] length:strlen([self UTF8String])];
}
- (id)asData
{
    return [NSData dataWithBytes:[self UTF8String] length:strlen([self UTF8String])];
}




@end
