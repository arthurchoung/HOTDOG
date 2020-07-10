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

@implementation NSNull(object)
- (id)strWithContext:(id)context
{
    return @"(null)";
}

- (int)compare:(id)obj
{
//    NSLog(@"NSNull compare:%@", obj);
    if (!obj || (obj == nsnull())) {
        return 0;
    }
    return -1;
}

- (id)stringFromFile
{
    return nil;
}

- (BOOL)isTrue
{
    return NO;
}

- (BOOL)isFalse
{
    return YES;
}

- (unsigned int)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id [])buffer count:(unsigned int)len
{
    return 0;
}

- (int)length
{
    return 0;
}

- (int)count
{
    return 0;
}

- (id)array
{
    return nsarr();
}

- (id)description
{
    return @"nil";
}

- (BOOL)isEqual:(id)obj
{
    return ((self == obj) || (obj == 0)) ? 1 : 0;
}

- (char *)UTF8String
{
    return "nil";
}

- (BOOL)boolValue
{
    return NO;
}
- (int)intValue
{ return 0; }
- (unsigned int)unsignedIntValue
{ return 0; }
- (unsigned long)unsignedLongValue
{ return 0; }
- (unsigned long long)unsignedLongLongValue
{ return 0; }
- (long)longValue
{ return 0; }
- (long long)longLongValue
{ return 0; }
- (double)doubleValue
{ return 0.0; }

@end

