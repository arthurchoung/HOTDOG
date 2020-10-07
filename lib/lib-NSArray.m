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

@implementation Definitions(fjieowfjkldsjflksdjkfl)
+ (id)NSArray
{
    return nsarr();
}
@end




@implementation NSArray(sdsadff)
- (void)addToArray:(id)arr
{
    [arr addObjectsFromArray:self];
}
- (id)asDictionaryGroupByKey:(id)groupKey
{
    id results = nsdict();
    for (id elt in self) {
        id eltKey = [elt valueForKey:groupKey];
        if (eltKey) {
            [results addObject:elt intoArrayForKey:eltKey];
        }
    }
    return results;
}




- (id)strWithContext:(id)context
{
    return nsfmt(@"NSArray strWithContext %@", [self description]);
}


- (BOOL)writeToFile:(id)path
{
    return [self writeLinesToFile:path];
}

- (id)filter:(BOOL (^)(id obj))block
{
    id results = nsarr();
    for (id elt in self) {
        if (block(elt)) {
            [results addObject:elt];
        }
    }
    return results;
}
- (id)nth:(int)n
{
    if (n < 0) {
        return nil;
    }
    if (n >= self.count) {
        return nil;
    }
    return [self objectAtIndex:n];
}
- (id)subarrayFromIndex:(int)index
{
    if (index < 0) {
        int loc = [self count] + index;
        if (loc < 0) {
            loc = 0;
        }
        int len = [self count] - loc;
        return [self subarrayFromLocation:loc length:len];
    }
    if (index >= [self count]) {
        return nil;
    }
    int location = index;
    int length = [self count] - index;
    if (!length) {
        return nil;
    }
    return [self subarrayFromLocation:location length:length];
}
- (id)filterEmptyStrings
{
    return [self filter:^(id obj) {
        if ([obj length]) {
            return YES;
        } else {
            return NO;
        }
    }];
}
- (id)join:(id)obj
{
    return [self componentsJoinedByString:obj];
}





- (void)setAllValues:(id)val forKey:(id)key
{
    for (id elt in self) {
        [elt setValue:val forKey:key];
    }
}


- (id)lowest
{
    id lowest = nil;
    for (id elt in self) {
        if (!lowest) {
            lowest = elt;
        } else if ([elt compare:lowest] < 0) {
            lowest = elt;
        }
    }
    return lowest;
}

- (id)highest
{
    id highest = nil;
    for (id elt in self) {
        if (!highest) {
            highest = elt;
        } else if ([elt compare:highest] > 0) {
            highest = elt;
        }
    }
    return highest;
}

- (id)removeIfContainsString:(id)string
{
    return [self filter:^(id obj) {
        return (BOOL)(([obj containsString:string]) ? NO : YES);
    }];
}

- (id)keepIfKey:(id)key startsWith:(id)string
{
    return [self filter:^(id obj) {
        id val = [obj valueForKey:key];
        if (!val) {
            return NO;
        }
        if ([val startsWith:string]) {
            return YES;
        } else {
            return NO;
        }
    }];
}
- (id)keepIfKey:(id)key equals:(id)string
{
    return [self filter:^(id obj) {
        id val = [obj valueForKey:key];
        if (!val) {
            return NO;
        }
        if ([val isEqual:string]) {
            return YES;
        } else {
            return NO;
        }
    }];
}

- (id)keepIfContainsString:(id)string
{
    return [self filter:^(id obj) {
        return [obj containsString:string];
    }];
}

- (id)keepPrefix:(id)prefix
{
    return [self filter:^(id obj) {
        return [obj hasPrefix:prefix];
    }];
}
- (id)keepSuffix:(id)suffix
{
    return [self filter:^(id obj) {
        return [obj hasSuffix:suffix];
    }];
}

- (id)asArraySortedWithKey:(id)key
{
    return [self asArraySortedWithBlock:^(id a, id b) {
        return (int)[a compare:b key:key];
    }];
}

- (id)asArrayReverseSortedWithKey:(id)key
{
    return [self asArraySortedWithBlock:^(id a, id b) {
        return (int)[a reverseCompare:b key:key];
    }];
}
- (id)asArrayReverseSortedWithKeys:(id)keys
{
    return [self asArraySortedWithBlock:^(id a, id b) {
        for (id key in keys) {
            int cmp = [a reverseCompare:b key:key];
            if (cmp != 0) {
                return cmp;
            }
        }
        return 0;
    }];
}

- (id)asDictionary
{
    id dict = nsdict();
    id key = nil;
    for (id elt in self) {
        if (!key) {
            key = elt;
            continue;
        }
        [dict setValue:elt forKey:key];
        key = nil;
    }
    return dict;
}

- (id)keepObjectsEqualTo:(id)objectToKeep
{
    return [self filter:^(id obj) {
        return (BOOL)(([obj isEqual:objectToKeep]) ? YES : NO);
    }];
}

- (id)asStringForKeys:(id)keys titleKeys:(id)titleKeys
{
    int minLength = 4;
    id results = nsarr();
    
    id titleArr = [titleKeys mapBlock:^(id obj) {
        return [[[self valueForKey:obj] uniq] join:@""];
    }];
    id title = [titleArr join:@"  "];
    if (title) {
        [results addObject:title];
        [results addObject:@""];
    }
    
    id header = [[keys mapBlock:^(id key) {
        int len = [key length];
        if (len < minLength) {
            len = minLength;
        }
        return nsfmt(@"%-*s", len, [key UTF8String]);
    }] join:@"  "];
    
    id arr = [self mapBlock:^(id obj) {
        return [[keys mapBlock:^(id key) {
            int len = [key length];
            if (len < minLength) {
                len = minLength;
            }
            id val = [obj valueForKey:key];
            if ([val isKindOfClass:[@"NSNumber" asClass]]) {
                return nsfmt(@"%-*d", len, [[obj valueForKey:key] intValue]);
            } else {
                return nsfmt(@"%-*.*@", len, len, val);
            }
        }] join:@"  "];
    }];
    [results addObject:header];
    [results addObjectsFromArray:arr];
    return [results join:@"\n"];
}

- (id)uniq
{
    id results = nsarr();
    id prev = nil;
    for (id elt in self) {
        if ([prev isEqual:elt]) {
            continue;
        }
        [results addObject:elt];
        prev = elt;
    }
    return results;
}

- (id)asString
{
    return [self asStringForKeys:[[self allKeys] sort] titleKeys:nil];
}

- (id)asStringWithHeaderMessage:(id)message
{
    id header = (message) ? [self evaluateMessage:message] : nil;
    header = (header) ? [header cat:@"\n\n"] : @"";
    id str = [self asStringForKeys:[[self allKeys] sort] titleKeys:nil];
    return [header cat:str];
}


- (id)asDictionaryCount
{
    id results = nsdict();
    for (id elt in self) {
        [results incrementKey:elt];
    }
    return results;
}

- (id)asMergedDictionary
{
    id results = nsdict();
    for (id elt in self) {
        [results addEntriesFromDictionary:elt];
    }
    return results;
}

- (id)objectWithValue:(id)value forMessage:(id)message
{
    if (!value) {
        return nil;
    }
    for (id elt in self) {
        if ([[elt evaluateMessage:message] isEqual:value]) {
            return elt;
        }
    }
    return nil;
}

- (id)objectWithValue:(id)value forKey:(id)key
{
    if (!value) {
        return nil;
    }
    for (id elt in self) {
        if ([[elt valueForKey:key] isEqual:value]) {
            return elt;
        }
    }
    return nil;
}

- (id)objectWithValueContainingString:(id)str forKey:(id)key
{
    if (!str) {
        return nil;
    }
    for (id elt in self) {
        if ([[elt valueForKey:key] containsString:str]) {
            return elt;
        }
    }
    return nil;
}

- (id)sliceFrom:(int)fromIndex to:(int)toIndex
{
    return [self subarrayFromLocation:fromIndex length:toIndex-fromIndex];
}
- (id)sliceTo:(int)index
{
    return [self subarrayToIndex:index];
}
- (id)sliceFrom:(int)index
{
    return [self subarrayFromIndex:index];
}
- (double)minDouble
{
    BOOL first = YES;
    double lowest = 0.0;
    for (id elt in self) {
        double val = [elt doubleValue];
        if (first) {
            lowest = val;
            first = NO;
        } else if (val < lowest) {
            lowest = val;
        }
    }
    return lowest;
}
- (id)min
{
    id arr = [self asSortedArray];
    return [arr nth:0];
}

- (double)maxDouble
{
    BOOL first = YES;
    double highest = 0.0;
    for (id elt in self) {
        double val = [elt doubleValue];
        if (first) {
            highest = val;
            first = NO;
        } else if (val > highest) {
            highest = val;
        }
    }
    return highest;
}

- (id)max
{
    id arr = [self asSortedArray];
    int count = [arr count];
    if (!count) {
        return nil;
    }
    return [arr nth:count-1];
}
- (id)median
{
    int count = [self count];
    if (count == 0) {
        return nil;
    } else if (count % 2 == 1) {
        return [self nth:count/2];
    } else {
        double a = [[self nth:count/2-1] doubleValue];
        double b = [[self nth:count/2] doubleValue];
        return nsfmt(@"%f", (a+b)/2.0);
    }
}

- (id)average
{
    int count = [self count];
    if (!count) {
        return @"0";
    }
    id sum = [self sum];
    return [sum dividedBy:nsfmt(@"%d", count)];
}
- (double)averageDouble
{
    int count = [self count];
    if (!count) {
        return 0.0;
    }
    double sum = [self sumDouble];
    return sum / (double)count;
}

- (double)sumDouble
{
    double result = 0.0;
    for (id elt in self) {
        result += [elt doubleValue];
    }
    return result;
}
- (int)sumIntegers
{
    int result = 0;
    for (id elt in self) {
        result += [elt intValue];
    }
    return result;
}
- (id)sum
{
    id result = @"0";
    for (id elt in self) {
        result = [result plus:elt];
    }
    return result;
}

- (id)asReverseArray
{
    id arr = nsarr();
    for (int i=[self count]-1; i>=0; i--) {
        id elt = [self nth:i];
        if (elt) {
            [arr addObject:elt];
        }
    }
    return arr;
}
- (id)reverse
{
    id arr = nsarr();
    for (int i=[self count]-1; i>=0; i--) {
        id elt = [self nth:i];
        if (elt) {
            [arr addObject:elt];
        }
    }
    return arr;
}

- (id)randomObject
{
    int count = [self count];
    if (!count) {
        return nil;
    }
    int index = [Definitions randomInt:count];
    return [self nth:index];
}

- (id)tail:(int)n
{
    int count = [self count];
    int index = count - n;
    if (index >= count) {
        return nil;
    }
    if (index <= 0) {
        return self;
    }
    return [self subarrayFromIndex:index];
}





- (id)chompEmptyLine
{
    id lastObject = [self lastObject];
    if ([lastObject isEqual:@""]) {
        return [self subarrayToIndex:[self count]-1];
    }
    return self;
}

- (id)cat:(id)arr
{
    return [self arrayByAddingObjectsFromArray:arr];
}

- (id)keepIfTrue:(id)message
{
    return [self filter:^(id obj) {
        return [[obj evaluateMessage:message] boolValue];
    }];
}





- (id)asReverseSortedArray
{
    return [self asArraySortedWithBlock:^(id a, id b) {
        return (int)[a reverseCompare:b];
    }];
}

- (id)asSortedArray
{
    return [self asArraySortedWithBlock:^(id a, id b) {
        return (int)[a compare:b];
    }];
}


- (id) sort
{
    return [self asArraySortedWithBlock:^(id a, id b) {
        return (int)[a compare:b];
    }];
}

- (id)numericSortForKey:(id)key
{
    return [self asArraySortedWithBlock:^(id a, id b) {
        double aa = [[a valueForKey:key] doubleValue];
        double bb = [[b valueForKey:key] doubleValue];
        if (aa < bb) {
            return -1;
        }
        if (aa > bb) {
            return 1;
        }
        return 0;
    }];
}
- (id)reverseNumericSortForKey:(id)key
{
    id results = [self asArraySortedWithBlock:^(id a, id b) {
        double aa = [[a valueForKey:key] doubleValue];
        double bb = [[b valueForKey:key] doubleValue];
        if (aa > bb) {
            return -1;
        }
        if (aa < bb) {
            return 1;
        }
        return 0;
    }];
    results = [[results mutableCopy] autorelease];
    return results;
}
- (id)numericKeySort
{
    return [self numericSortForKey:@"key"];
}
- (id)numericValueSort
{
    return [self numericSortForKey:@"value"];
}
- (id)reverseNumericValueSort
{
    return [self reverseNumericSortForKey:@"value"];
}

- (id)reverseSort
{
    return [self asArraySortedWithBlock:^(id a, id b) {
        int val = [a compare:b];
        if (val < 0) {
            return 1;
        }
        if (val > 0) {
            return -1;
        }
        return 0;
    }];
}

- (id)numericSort
{
    return [self asArraySortedWithBlock:^(id a, id b) {
        double aa = [a doubleValue];
        double bb = [b doubleValue];
        if (aa < bb) {
            return -1;
        } else if (aa > bb) {
            return 1;
        } else {
            return 0;
        }
    }];
}
- (id)reverseNumericSort
{
    return [self asArraySortedWithBlock:^(id a, id b) {
        double aa = [a doubleValue];
        double bb = [b doubleValue];
        if (aa > bb) {
            return -1;
        } else if (aa < bb) {
            return 1;
        } else {
            return 0;
        }
    }];
}

- (id)sort:(int (^)(id a, id b))block
{
    return [self asArraySortedWithBlock:block];
}


- (int)length
{
    return [self count];
}

- (int)depth
{
    return [self count];
}

- (id)top
{
    return [self lastObject];
}

- (id)mapArray:(id (^)(id arr))block
{
    return [self mapArray:block nullValue:@"(null)"];
}
- (id)mapArray:(id (^)(id arr))block nullValue:(id)nullValue
{
    if (![self count]) {
        return nil;
    }
    id results = nsarr();
    int i = 0;
    for(;;) {
        id args = nsarr();
        for (id arr in self) {
            id elt = [arr nth:i];
            if (!elt) {
                return results;
            }
            [args addObject:elt];
        }
        id obj = block(args);
        if (!obj) {
            obj = nullValue;
        }
        [results addObject:obj];
        i++;
    }
}

- (id)mapBlock:(id (^)(id obj))block
{
    return [self mapBlock:block nullValue:@"(null)"];
}
- (id)mapBlock:(id (^)(id obj))block nullValue:(id)nullValue
{
    id results = nsarr();
    for (id elt in self) {
        id obj = block(elt);
        if (!obj) {
            obj = nullValue;
        }
        [results addObject:obj];
    }
    return results;
}

- (id)keepBlock:(BOOL (^)(id obj))block
{
    id results = nsarr();
    for (id elt in self) {
        if (block(elt)) {
            [results addObject:elt];
        }
    }
    return results;
}

- (id)map:(id (^)(id obj))block
{
    return [self map:block nullValue:@"(null)"];
}
- (id)map:(id (^)(id obj))block nullValue:(id)nullValue
{
    id results = nsarr();
    for (id elt in self) {
        id obj = block(elt);
        if (!obj) {
            obj = nullValue;
        }
        [results addObject:obj];
    }
    return results;
}

- (id)mapPairs:(id (^)(id obj1, id obj2))block
{
    return [self mapPairs:block nullValue:@"(null)"];
}
- (id)mapPairs:(id (^)(id obj1, id obj2))block nullValue:(id)nullValue
{
    id results = nsarr();
    id first = nil;
    for (id obj in self) {
        if (!first) {
            first = obj;
            continue;
        }
        id val = block(first, obj);
        if (!val) {
            val = nullValue;
        }
        [results addObject:val];
        first = nil;
    }
    return results;
}
- (id)mapIndex:(id (^)(int i, id obj))block
{
    return [self mapIndex:block nullValue:@"(null)"];
}
- (id)mapIndex:(id (^)(int i, id obj))block nullValue:(id)nullValue
{
    id results = nsarr();
    int i = 0;
    for (id obj in self) {
        id val = block(i, obj);
        if (!val) {
            val = nullValue;
        }
        [results addObject:val];
        i++;
    }
    return results;
}
- (id)keep:(id)message
{
    id results = nsarr();
    for (id elt in self) {
        if ([[elt evaluateMessage:message] intValue]) {
            [results addObject:elt];
        }
    }
    return results;
}
- (id)mapMessage:(id)message
{
    return [self mapMessage:message nullValue:@"(null)"];
}
- (id)mapMessage:(id)message nullValue:(id)nullValue
{
    id results = nsarr();
    for (id elt in self) {
        id obj = [elt evaluateMessage:message];
        [results addObject:(obj) ? obj : nullValue];
    }
    return results;
}
- (void)forEachMessage:(id)message
{
    for (id elt in self) {
        @autoreleasepool {
            [elt evaluateMessage:message];
        }
    }
}

- (void)loopIndex:(void (^)(int i, id obj))block
{
    int i = 0;
    for (id obj in self) {
        block(i, obj);
        i++;
    }
}
- (void)reverseLoopIndex:(int (^)(int i, id obj))block
{
    int count = [self count];
    for (int i=count-1; i>=0; i--) {
        id elt = [self objectAtIndex:i];
        if (elt) {
            if (!block(i, elt)) {
                break;
            }
        }
    }
}

- (void)loopPairs:(void (^)(id obj1, id obj2))block
{
    id first = nil;
    for (id obj in self) {
        if (!first) {
            first = obj;
            continue;
        }
        block(first, obj);
        first = nil;
    }
}



- (id)allKeys
{
    id results = nsdict();
    for (id elt in self) {
        for (id key in [elt allKeys]) {
            if ([key hasPrefix:@"_"] && ![key containsString:@"."]) {
                continue;
            }
            [results setValue:@"1" forKey:key];
        }
    }
    return [results allKeys];
}




- (id)reverseSortedWithKey:(id)key
{
    return [self asArraySortedWithBlock:^(id a, id b) {
        id aa = [a valueForKey:key];
        if (!aa) {
            return 1;
        }
        id bb = [b valueForKey:key];
        if (!bb) {
            return -1;
        }
        return (int)[bb compare:aa];
    }];
}

- (id)sortedWithKey:(id)key
{
    return [self asArraySortedWithBlock:^(id a, id b) {
        id aa = [a valueForKey:key];
        if (!aa) {
            return -1;
        }
        id bb = [b valueForKey:key];
        if (!bb) {
            return 1;
        }
        return (int)[aa compare:bb];
    }];
}


- (id)subarrayToIndex:(int)index
{
    if (index == 0) {
        return self;
    }
    if (index < 0) {
        return [self subarrayToIndex:[self count]+index];
    }
    return [self subarrayFromLocation:0 length:index];
}

- (id)subarrayBetweenIndex:(int)index1 and:(int)index2
{
    if (index1 < 0) {
        return nil;
    }
    if (index2 < 0) {
        return nil;
    }
    int start, end;
    if (index1 < index2) {
        start = index1;
        end = index2;
    } else {
        start = index2;
        end = index1;
    }
    return [self subarrayFromLocation:start length:end-start+1];
}


- (int)indexForHighestKeyValue:(id)key
{
    id highest = nil;
    int index = 0;
    int highestIndex = 0;
    for (id elt in self) {
        if (!highest) {
            highest = elt;
        } else {
            if ([[elt valueForKey:key] compare:[highest valueForKey:key]] > 0) {
                highest = elt;
                highestIndex = index;
            }
        }
        index++;
    }
    return highestIndex;
}

- (int)indexForLowestKeyValue:(id)key
{
    id lowest = nil;
    int index = 0;
    int lowestIndex = 0;
    for (id elt in self) {
        if (!lowest) {
            lowest = elt;
        } else {
            if ([[elt valueForKey:key] compare:[lowest valueForKey:key]] < 0) {
                lowest = elt;
                lowestIndex = index;
            }
        }
        index++;
    }
    return lowestIndex;
}



- (id)asShuffledArray
{
    id src = [[self mutableCopy] autorelease];
    id dst = nsarr();
    for (;;) {
        int count = [src count];
        if (count == 0) {
            break;
        }
        int index = [Definitions randomInt:count];
        id elt = [src nth:index];
        [dst addObject:elt];
        [src removeObjectAtIndex:index];
    }
    return dst;
}

@end

