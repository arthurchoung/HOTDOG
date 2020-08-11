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

#include "jsmn.h"

static id parseObject(jsmntok_t *token, char *JSON_STRING, id nullValue);
static id parseArray(jsmntok_t *token, char *JSON_STRING, id nullValue);

static id parseToken(jsmntok_t *token, char *JSON_STRING, id nullValue)
{
    if (token->type == 1) {
        return parseObject(token, JSON_STRING, nullValue);
    } else if (token->type == 2) {
        return parseArray(token, JSON_STRING, nullValue);
    } else if (token->type == 3) {
        return nscstrn(JSON_STRING+token->start, token->end-token->start);
    } else if (token->type == 4) {
        id str = nscstrn(JSON_STRING+token->start, token->end-token->start);
        if ([str isEqual:@"null"]) {
            return nullValue;
        }
        return str;
    } else {
        return @"none";
    }
}

static int numberOfTokens(jsmntok_t *token)
{
    int count = 1;
    for (int i=0; i<token->size; i++) {
        count += numberOfTokens(&token[count]);
    }
    return count;
}
static id parseObject(jsmntok_t *token, char *JSON_STRING, id nullValue)
{
    id dict = nsdict();
    int index = 1;
    for (int i=0; i<token->size; i++) {
NSLog(@"parseObject i %d type %d token->size %d", i, token->type, token->size);
        jsmntok_t *keytoken = &token[index];
NSLog(@"parseObject keytoken type %d size %d '%@'", keytoken->type, keytoken->size, nscstrn(JSON_STRING+keytoken->start, keytoken->end-keytoken->start));
        if (keytoken->type == 3) {
            if (keytoken->size == 1) {
                jsmntok_t *valtoken = &token[index+1];
NSLog(@"parseObject valtoken type %d size %d '%@'", valtoken->type, valtoken->size, nscstrn(JSON_STRING+valtoken->start, valtoken->end-valtoken->start));
                id key = nscstrn(JSON_STRING+keytoken->start, keytoken->end-keytoken->start);
                id val = parseToken(valtoken, JSON_STRING, nullValue);
                [dict setValue:val forKey:key];
                index += numberOfTokens(keytoken);
            } else {
NSLog(@"parseObject keytoken->size != 1");
                return nil;
            }
        } else {
NSLog(@"parseObject keytoken->type != 3");
            return nil;
        }
    }
    return dict;
}

static id parseArray(jsmntok_t *token, char *JSON_STRING, id nullValue)
{
    id arr = nsarr();
    int index = 1;
    for (int i=0; i<token->size; i++) {
        jsmntok_t *child = &token[index];
NSLog(@"parseArray i %d type %d token->size %d", i, child->type, child->size);
        id elt = parseToken(child, JSON_STRING, nullValue);
        if (elt) {
            [arr addObject:elt];
        } else {
NSLog(@"parseArray unable to parse token");
            return nil;
        }
        index += numberOfTokens(child);
    }
    return arr;
}

@implementation NSString(fjdkslfjklsdjf)
- (id)decodeJSON
{
    return [super decodeJSON];
}
@end

@implementation NSObject(jfkldsjfjsdjf)
- (id)decodeJSON
{
    return [self decodeJSONWithValueAsNull:@"null"];
}
- (id)decodeJSONWithValueAsNull:(id)nullValue
{
NSLog(@"decodeJSON");
    char *JSON_STRING = _contents;
    int i;
    int r;
    jsmn_parser p;
    int ntokens = 500000; //FIXME
    jsmntok_t *t; /* We expect no more than 128 tokens */
    t = [[[[NSMutableData alloc] initWithCapacity:sizeof(jsmntok_t)*ntokens] autorelease] bytes];
//    t = malloc(sizeof(jsmntok_t)*ntokens);
    if (!t) {
        NSLog(@"out of memory!");
        exit(0);
    }

    jsmn_init(&p);
    r = jsmn_parse(&p, JSON_STRING, _length, t, ntokens);
    if (r < 0) {
        printf("Failed to parse JSON: %d\n", r);
        return nil;
    }

    if (r > 0) {
/*
for (int i=0; i<r; i++) {
NSLog(@"stupid i %d type %d size %d numberOfTokens %d '%.*s'", i, t[i].type, t[i].size, numberOfTokens(&t[i]), t[i].end-t[i].start, JSON_STRING+t[i].start);
}
*/
        return parseToken(t, JSON_STRING, nullValue);
    }
    return nil;
}
@end

@implementation NSString(fjdkslfjkldsjfklsdjf)

- (id)readFromFileAsJSON
{
NSLog(@"readFromFileAsJSON");
    id jsonString = [self stringFromFile];
    return [jsonString decodeJSON];
}

@end

@implementation NSString(iwojfosdfjksdjfksdjf)
- (id)encodeJSON
{
    id str = self;
    str = [str find:@"\\" replace:@"\\\\"];
    str = [str find:@"\"" replace:@"\\\""];
    return nsfmt(@"\"%@\"", str);
}
@end

@implementation NSArray(JFkdlsjfklsdlkfjsd)
- (id)encodeJSON
{
    id results = nsarr();
    for (id elt in self) {
        [results addObject:[elt encodeJSON]];
    }
    return nsfmt(@"[%@]", [results join:@",\n"]);
}
@end
@implementation NSDictionary(fjkdslfjklsdjf)
- (id)encodeJSON
{
    id results = nsarr();
    for (id key in [self allKeys]) {
        id val = [self valueForKey:key];
        [results addObject:nsfmt(@"%@: %@", [key encodeJSON], [val encodeJSON])];
    }
    return nsfmt(@"{%@}", [results join:@",\n"]);
}
@end

