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

@implementation NSObject(jiweofjksdjf)
- (id)stringForCSVFile
{
    return nsfmt(@"\"<%@>\"", [self class]);
}

@end

@implementation NSNull(jfklsdjfklsdjkf)
- (id)stringForCSVFile
{
    return @"";
}
@end

@implementation NSArray(ieojfksdjfjsdf)
- (id)asCSVWithKeys:(id)header
{
    id arr = self;
    arr = [arr mapBlock:^(id a) {
        id dict = nsdict();
        for (int i=0; i<[header count]; i++) {
            id key = [header nth:i];
            if (key) {
                id val = [a nth:i];
                if (val && (val != nsnull())) {
                    [dict setValue:val forKey:key];
                }
            }
        }
        return dict;
    }];
    return arr;
}

- (id)asCSVUsingHeader
{
    id header = [self firstObject];
    if (!header) {
        return nil;
    }
    id arr = [self subarrayFromIndex:1];
    if (![arr count]) {
        return nil;
    }
    return [arr asCSVWithKeys:header];
}

- (BOOL)writeToFileAsCSV:(id)path usingKeys:(id)keys
{
    id results = nsarr();
    id temp = nsarr();
    {
        id obj = [keys joinAsCSV];
        if (!obj) {
            obj = nsnull();
        }
        [results addObject:obj];
    }
    for (id elt in self) {
        for (id key in keys) {
            id val = [elt valueForKey:key];
            if (!val) {
                val = nsnull();
            }
            [temp addObject:val];
        }
        {
            id obj = [temp joinAsCSV];
            if (!obj) {
                obj = nsnull();
            }
            [results addObject:obj];
        }
        [temp removeAllObjects];
    }
    [results addObject:@""];
    return [[results join:@"\n"] writeToFile:path];
}

- (BOOL)writeAsCSVToFile:(id)path usingKeys:(id)keys
{
    return [self writeAsCSVToFile:path usingKeys:keys];
}

- (BOOL)writeToFileAsCSV:(id)path
{
    id elt = [self firstObject];
    id keys = [[self allKeys] sort];
    return [self writeToFileAsCSV:path usingKeys:keys];
}

- (BOOL)writeAsCSVToFile:(id)path
{
    return [self writeToFileAsCSV:path];
}

- (id)joinAsCSV
{
    id arr = nsarr();
    for (id elt in self) {
        id obj = [elt stringForCSVFile];
        if (!obj) {
            obj = nsnull();
        }
        [arr addObject:obj];
    }
    return [arr join:@","];
}

@end

@interface CSVParser : IvarObject
{
    id _rows;
    id _cells;
    id _current;
    BOOL _stringIsQuoted;
    char *_p;
}
@end
@implementation CSVParser
- (id)convertCStringToObject:(char *)cstring
{
    if (_stringIsQuoted) {
        _stringIsQuoted = NO;
        return nscstr(cstring);
    }
    if (!*cstring) {
        return nsnull();
    }
    
    return nscstr(cstring);
}
- (void)parseQuote:(char)quote_char
{
    _stringIsQuoted = YES;
    _p++;
    while (*_p) {
        if (*_p == quote_char) {
            _p++;
            break;
        } else if (*_p == '\\') {
            _p++;
            if (*_p) {
                [_current addObject:nsfmt(@"%c", *_p)];
                _p++;
                continue;
            } else {
                /* parse error */
                break;
            }
        }
        if (isprint(*_p)) {
            [_current addObject:nsfmt(@"%c", *_p)];
        }
        _p++;
    }
}
- (void)parseComma
{
    [_cells addObject:[self convertCStringToObject:[[_current join:@""] UTF8String]]];
    [_current removeAllObjects];
    _p++;
}
- (void)flush
{
    if ([_current count]) {
        [_cells addObject:[self convertCStringToObject:[[_current join:@""] UTF8String]]];
        [_current removeAllObjects];
    }
    if ([_cells count]) {
        [_rows addObject:[[_cells mutableCopy] autorelease]];
        [_cells removeAllObjects];
    }
}
- (void)parseLF
{
    [self flush];
    _p++;
}
- (void)parseChar
{
    if (isprint(*_p)) {
        [_current addObject:nsfmt(@"%c", *_p)];
    }
    _p++;
}
- (id)processString:(id)input
{
    [self setValue:nsarr() forKey:@"rows"];
    [self setValue:nsarr() forKey:@"cells"];
    [self setValue:nsarr() forKey:@"current"];
    _stringIsQuoted = NO;
    _p = [input UTF8String];
    while (*_p) {
        if (*_p == '"') {
            [self parseQuote:'"'];
            continue;
//        } else if (*p == '\'') {
//            parse_csv_file_quote('\'');
//            continue;
        } else if (*_p == ',') {
            [self parseComma];
            continue;
        } else if (*_p == '\r') {
            [self parseLF];
            continue;
        } else if (*_p == '\n') {
            [self parseLF];
            continue;
        } else if ((*_p == '#') && ![_current count]) {
            _p++;
            while (*_p) {
                if (*_p == '\n') {
                    _p++;
                    break;
                } else if (*_p == '\r') {
                    _p++;
                    break;
                }
                _p++;
            }
            continue;
        }
        [self parseChar];
    }
    [self flush];
    
    return _rows;
}
@end

@implementation NSString(jfklsdjfksdjf)
- (id)stringForCSVFile
{
    id result = self;
    result = [result stringByRemovingNonASCIICharacters];
    result = [result find:@"\"" replace:@""];
    result = [result find:@"\\" replace:@""];
    return nsfmt(@"\"%@\"", result);
}

- (id)parseCSV
{
    id parser = [[[CSVParser alloc] init] autorelease];
    return [parser processString:self];
}

- (id)parseFileAsCSV
{
    return [[[self stringFromFile] parseCSV] asCSVUsingHeader];
}


@end


