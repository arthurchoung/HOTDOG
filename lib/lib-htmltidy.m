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

#include <tidy.h>
#include <tidybuffio.h>
#include <stdio.h>
#include <errno.h>

@implementation NSString(jfkdlsjfkldsjkf)
- (id)parseAsHTMLTidyDocument
{
    id document = [@"HTMLTidyDocument" asInstance];
    TidyDoc tdoc = tidyCreate();
    [document setPointerValue:tdoc forKey:@"tdoc"];
    if (tidyParseString(tdoc, [self UTF8String]) < 0) {
        return nil;
    }
    return document;
}
@end

@interface HTMLTidyDocument : IvarObject
{
    TidyDoc _tdoc;
    id _rootNode;
}
@end
@implementation HTMLTidyDocument
- (void)dealloc
{
    if (_tdoc) {
        tidyRelease(_tdoc);
    }
    [super dealloc];
}
- (id)rootNode
{
    if (_rootNode) {
        return _rootNode;
    }
    if (!_tdoc) {
        return nil;
    }
    TidyNode rootNode = tidyGetRoot(_tdoc);
    if (!rootNode) {
        return nil;
    }
    id obj = [@"HTMLTidyNode" asInstance];
    [obj setValue:self forKey:@"document"];
    [obj setPointerValue:rootNode forKey:@"tnod"];
    [self setValue:obj forKey:@"rootNode"];
    return obj;
}
- (id)allNodes
{
    id obj = [[self rootNode] allChildren];
    [self setValue:obj forKey:@"allNodes"];
    return obj;
}
- (id)allNodesWithName:(id)matchName
{
    return [[self rootNode] allChildrenWithName:matchName];
}
@end

@interface HTMLTidyNode : IvarObject
{
    id _document;
    TidyNode _tnod;
    id _name;
    id _allChildren;
    id _text;
    id _allAttributes;
}
@end
@implementation HTMLTidyNode
- (id)name
{
    if (_name) {
        return _name;
    }
    if (!_tnod) {
        return nil;
    }
    switch (tidyNodeGetType(_tnod)) {
        case TidyNode_Root: return @"Root";
        case TidyNode_DocType: return @"DOCTYPE";
        case TidyNode_Comment: return @"Comment";
        case TidyNode_ProcIns: return @"Processing Instruction";
        case TidyNode_Text: return @"Text";
        case TidyNode_CDATA: return @"CDATA";
        case TidyNode_Section: return @"XML Section";
        case TidyNode_Asp: return @"ASP";
        case TidyNode_Jste: return @"JSTE";
        case TidyNode_Php: return @"PHP";
        case TidyNode_XmlDecl: return @"XML Declaration";
//        case TidyNode_Start:
//        case TidyNode_End:
//        case TidyNode_StartEnd:
    }
    id obj = nsfmt(@"%s", tidyNodeGetName(_tnod));
    [self setValue:obj forKey:@"name"];
    return obj;
}
- (id)allChildren
{
    if (_allChildren) {
        return _allChildren;
    }
    id results = nsarr();
    for (TidyNode child=tidyGetChild(_tnod); child; child=tidyGetNext(child)) {
        id node = [@"HTMLTidyNode" asInstance];
        [node setValue:_document forKey:@"document"];
        [node setPointerValue:child forKey:@"tnod"];
        [results addObject:node];
        id children = [node allChildren];
        if (children) { 
            [results addObjectsFromArray:children];
        }
    }
    [self setValue:results forKey:@"allChildren"];
    return results;
}
- (id)allChildrenWithName:(id)matchName
{
    id allChildren = [self allChildren];
    id results = nsarr();
    for (id node in allChildren) {
        if ([[node name] isEqual:matchName]) {
            [results addObject:node];
        }
    }
    return results;
}
- (id)findFirstNode:(id)matchName
{
    for (id node in [self allChildren]) {
        id name = [node name];
        if ([name isEqual:matchName]) {
            return node;
        }
    }
    return nil;
}
- (id)findFirstNodeWithClass:(id)classValue
{
    for (id node in [self allChildren]) {
        for (id attr in [node allAttributes]) {
            if ([[attr name] isEqual:@"class"]) {
                if ([[attr value] isEqual:classValue]) {
                    return node;
                }
            }
        }
    }
    return nil;
}
- (id)findAllNodesWithClass:(id)classValue
{
    id results = nsarr();
    for (id node in [self allChildren]) {
        for (id attr in [node allAttributes]) {
            if ([[attr name] isEqual:@"class"]) {
                if ([[attr value] isEqual:classValue]) {
                    [results addObject:node];
                }
            }
        }
    }
    if (![results count]) {
        return nil;
    }
    return results;
}
- (id)text
{
    if (_text) {
        return _text;
    }
    if (!_tnod) {
        return nil;
    }
    if (!tidyNodeIsText(_tnod)) {
        return nil;
    }
    TidyBuffer buf;
    tidyBufInit(&buf);
    tidyNodeGetText([_document pointerValueForKey:@"tdoc"], _tnod, &buf);
    id text = nsfmt(@"%*.*s", buf.size, buf.size, buf.bp);
    tidyBufFree(&buf);
    [self setValue:text forKey:@"text"];
    return text;
}
- (id)childText
{
    for (id node in [self allChildren]) {
        id text = [node text];
        if (text) {
            return text;
        }
    }
    return nil;
}
- (id)allAttributes
{
    if (_allAttributes) {
        return _allAttributes;
    }
    id results = nsarr();
    for (TidyAttr attr=tidyAttrFirst(_tnod); attr; attr=tidyAttrNext(attr)) {
        id obj = [@"HTMLTidyAttribute" asInstance];
        [obj setPointerValue:attr forKey:@"attr"];
        [results addObject:obj];
    }
    [self setValue:results forKey:@"allAttributes"];
    return results;
}
- (id)attributeValueForName:(id)name
{
    for (id attr in [self allAttributes]) {
        if ([[attr name] isEqual:name]) {
            return [attr value];
        }
    }
    return nil;
}
- (BOOL)hasAttributeWithName:(id)name value:(id)value
{
    for (id attr in [self allAttributes]) {
        if ([[attr name] isEqual:name]) {
            if ([[attr value] isEqual:value]) {
                return YES;
            }
        }
    }
    return NO;
}
@end

@interface HTMLTidyAttribute : IvarObject
{
    TidyAttr _attr;
    id _name;
    id _value;
}
@end
@implementation HTMLTidyAttribute
- (id)name
{
    if (_name) {
        return _name;
    }
    if (!_attr) {
        return nil;
    }
    ctmbstr cstr = tidyAttrName(_attr);
    if (!cstr) {
        return nil;
    }
    id obj = nsfmt(@"%s", cstr);
    [self setValue:obj forKey:@"name"];
    return obj;
}
- (id)value
{
    if (_value) {
        return _value;
    }
    if (!_attr) {
        return nil;
    }
    ctmbstr cstr = tidyAttrValue(_attr);
    if (!cstr) {
        return nil;
    }
    id obj = nsfmt(@"%s", cstr);
    [self setValue:obj forKey:@"value"];
    return obj;
}
@end


