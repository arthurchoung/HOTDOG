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

@implementation Definitions(fjkdslfjklsdjf)

+ (id)namespace
{
    static NSMutableDictionary *dict = nil;
    if (!dict) {
        dict = [[NSMutableDictionary alloc] init];
    }
    return dict;
}

@end



@implementation NSObject(Jpewifjpeowfsd)

+ (id)globalContext
{
    return [Definitions namespace];
}

- (id)globalContext
{
    return [Definitions namespace];
}

@end


@implementation NSString(fjdklsfjlksdjflksdlkfj)
- (id)str
{
    return [self strWithContext:[Definitions namespace]];
}
- (void)setNilValueForKey
{
    [[Definitions namespace] setValue:nil forKeyPath:self];
}

- (id)valueForKey
{
    id val = [[Definitions namespace] valueForKeyPath:self];
    return val;
}

- (int)intValueForKey
{
    id val = [[Definitions namespace] valueForKeyPath:self];
    return [val intValue];
}

- (double)doubleValueForKey
{
    id val = [[Definitions namespace] valueForKeyPath:self];
    return [val doubleValue];
}

@end

@implementation NSObject(jfkldsjfklsdjkfljsdklfj)
- (void)setAsValueForKey:(id)key
{
    [[Definitions namespace] setValue:self forKeyPath:key];
}
@end
