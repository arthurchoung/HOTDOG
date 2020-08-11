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

@implementation NSDictionary(jfdkslfjklsdjfkldsjfklsdjfkls)

- (id)asString
{
    id arr = [[self allKeys] mapBlock:^(id obj) {
        return nsfmt(@"%@ %@", obj, [self valueForKey:obj]);
    }];
    return [arr join:@"\n"];
}

- (void)toNSLog
{
    NSLog(@"toNSLog: %@", [self allKeysAndValues]);
}


- (id)allKeysAndValues
{
    id arr = nsarr();
    id keys = [self allKeys];
    id values = [self allValues];
    int keysCount = [keys count];
    int valuesCount = [values count];
    int count = (keysCount > valuesCount) ? keysCount : valuesCount;
    for (int i=0; i<count; i++) {
        [arr addObject:[keys nth:i]];
        [arr addObject:[values nth:i]];
    }
    return arr;
}


- (id)asKeyValueArray
{
    id results = nsarr();
    for (id key in [[self allKeys] sort]) {
        id dict = nsdict();
        [dict setValue:key forKey:@"key"];
        [dict setValue:[self valueForKey:key] forKey:@"value"];
        [dict setValue:@"#{key}: #{value}" forKey:@"stringFormat"];
        [results addObject:dict];
    }
    return results;
}


- (id)mapEachKeyValue:(id (^)(id obj1, id obj2))block
{
    return [self mapEachKeyValue:block nullValue:@"(null)"];
}
- (id)mapEachKeyValue:(id (^)(id obj1, id obj2))block nullValue:(id)nullValue
{
    id results = nsarr();
    for (id key in [self allKeys]) {
        id obj = block(key, [self valueForKey:key]);
        if (!obj) {
            obj = nullValue;
        }
        [results addObject:obj];
    }
    return results;
}

- (void)forEachKeyValue:(void (^)(id obj1, id obj2))block
{
    for (id key in [self allKeys]) {
        block(key, [self valueForKey:key]);
    }
}

- (int)length
{
    return [self count];
}






@end
