//
//  SLMIvarSetter.m
//  Slime
//
//  Created by HarrisonXi on 2018/9/6.
//  Copyright © 2019 harrisonxi.com. All rights reserved.
//

#import "SLMIvarSetter.h"
#import <objc/message.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

static void(*char_object_setIvar)(id, Ivar, char) = (void(*)(id, Ivar, char))object_setIvar;
static void(*int_object_setIvar)(id, Ivar, int) = (void(*)(id, Ivar, int))object_setIvar;
static void(*short_object_setIvar)(id, Ivar, short) = (void(*)(id, Ivar, short))object_setIvar;
static void(*long_object_setIvar)(id, Ivar, long) = (void(*)(id, Ivar, long))object_setIvar;
static void(*long_long_object_setIvar)(id, Ivar, long long) = (void(*)(id, Ivar, long long))object_setIvar;
static void(*unsigned_char_object_setIvar)(id, Ivar, unsigned char) = (void(*)(id, Ivar, unsigned char))object_setIvar;
static void(*unsigned_int_object_setIvar)(id, Ivar, unsigned int) = (void(*)(id, Ivar, unsigned int))object_setIvar;
static void(*unsigned_short_object_setIvar)(id, Ivar, unsigned short) = (void(*)(id, Ivar, unsigned short))object_setIvar;
static void(*unsigned_long_object_setIvar)(id, Ivar, unsigned long) = (void(*)(id, Ivar, unsigned long))object_setIvar;
static void(*unsigned_long_long_object_setIvar)(id, Ivar, unsigned long long) = (void(*)(id, Ivar, unsigned long long))object_setIvar;
static void(*float_object_setIvar)(id, Ivar, float) = (void(*)(id, Ivar, float))object_setIvar;
static void(*double_object_setIvar)(id, Ivar, double) = (void(*)(id, Ivar, double))object_setIvar;
static void(*bool_object_setIvar)(id, Ivar, bool) = (void(*)(id, Ivar, bool))object_setIvar;

static void(*point_object_setIvar)(id, Ivar, CGPoint) = (void(*)(id, Ivar, CGPoint))object_setIvar;
static void(*vector_object_setIvar)(id, Ivar, CGVector) = (void(*)(id, Ivar, CGVector))object_setIvar;
static void(*size_object_setIvar)(id, Ivar, CGSize) = (void(*)(id, Ivar, CGSize))object_setIvar;
static void(*rect_object_setIvar)(id, Ivar, CGRect) = (void(*)(id, Ivar, CGRect))object_setIvar;
static void(*transform_object_setIvar)(id, Ivar, CGAffineTransform) = (void(*)(id, Ivar, CGAffineTransform))object_setIvar;
static void(*insets_object_setIvar)(id, Ivar, UIEdgeInsets) = (void(*)(id, Ivar, UIEdgeInsets))object_setIvar;
static void(*offset_object_setIvar)(id, Ivar, UIOffset) = (void(*)(id, Ivar, UIOffset))object_setIvar;
static void(*range_object_setIvar)(id, Ivar, NSRange) = (void(*)(id, Ivar, NSRange))object_setIvar;

static void(*object_object_setIvar)(id, Ivar, id) = (void(*)(id, Ivar, id))object_setIvar;
static void(*class_object_setIvar)(id, Ivar, Class) = (void(*)(id, Ivar, Class))object_setIvar;
static void(*selector_object_setIvar)(id, Ivar, SEL) = (void(*)(id, Ivar, SEL))object_setIvar;

@interface SLMIvarSetter () {
    Ivar _ivar;
}

@end

@implementation SLMIvarSetter

- (instancetype)initWithValueType:(SLMType)valueType valueStruct:(NSString *)valueStruct valueClass:(__unsafe_unretained Class)valueClass ivar:(Ivar)ivar
{
    if (self = [super initWithValueType:valueType valueStruct:valueStruct valueClass:valueClass]) {
        _ivar = ivar;
    }
    return self;
}

- (void)setNumber:(NSNumber *)value forTarget:(id)target
{
    switch (self.valueType) {
        case SLMTypeChar:
            char_object_setIvar(target, _ivar, [value charValue]);
            break;
        case SLMTypeInt:
            int_object_setIvar(target, _ivar, [value intValue]);
            break;
        case SLMTypeShort:
            short_object_setIvar(target, _ivar, [value shortValue]);
            break;
        case SLMTypeLong:
            long_object_setIvar(target, _ivar, [value longValue]);
            break;
        case SLMTypeLongLong:
            long_long_object_setIvar(target, _ivar, [value longLongValue]);
            break;
        case SLMTypeUnsignedChar:
            unsigned_char_object_setIvar(target, _ivar, [value unsignedCharValue]);
            break;
        case SLMTypeUnsignedInt:
            unsigned_int_object_setIvar(target, _ivar, [value unsignedIntValue]);
            break;
        case SLMTypeUnsignedShort:
            unsigned_short_object_setIvar(target, _ivar, [value unsignedShortValue]);
            break;
        case SLMTypeUnsignedLong:
            unsigned_long_object_setIvar(target, _ivar, [value unsignedLongValue]);
            break;
        case SLMTypeUnsignedLongLong:
            unsigned_long_long_object_setIvar(target, _ivar, [value unsignedLongLongValue]);
            break;
        case SLMTypeFloat:
            float_object_setIvar(target, _ivar, [value floatValue]);
            break;
        case SLMTypeDouble:
            double_object_setIvar(target, _ivar, [value doubleValue]);
            break;
        case SLMTypeBool:
            bool_object_setIvar(target, _ivar, [value boolValue]);
            break;
        case SLMTypeNumber:
            object_object_setIvar(target, _ivar, value);
            break;
        case SLMTypeString:
            object_object_setIvar(target, _ivar, [value stringValue]);
            break;
        default:
            break;
    }
}

- (void)setString:(NSString *)value forTarget:(id)target
{
    switch (self.valueType) {
        case SLMTypeChar:
            char_object_setIvar(target, _ivar, [value intValue]);
            break;
        case SLMTypeInt:
            int_object_setIvar(target, _ivar, [value intValue]);
            break;
        case SLMTypeShort:
            short_object_setIvar(target, _ivar, [value intValue]);
            break;
        case SLMTypeLong:
            long_object_setIvar(target, _ivar, [value longLongValue]);
            break;
        case SLMTypeLongLong:
            long_long_object_setIvar(target, _ivar, [value longLongValue]);
            break;
        case SLMTypeUnsignedChar:
            unsigned_char_object_setIvar(target, _ivar, [value intValue]);
            break;
        case SLMTypeUnsignedInt:
            unsigned_int_object_setIvar(target, _ivar, [value intValue]);
            break;
        case SLMTypeUnsignedShort:
            unsigned_short_object_setIvar(target, _ivar, [value intValue]);
            break;
        case SLMTypeUnsignedLong:
            unsigned_long_object_setIvar(target, _ivar, [value longLongValue]);
            break;
        case SLMTypeUnsignedLongLong:
            unsigned_long_long_object_setIvar(target, _ivar, [value longLongValue]);
            break;
        case SLMTypeFloat:
            float_object_setIvar(target, _ivar, [value floatValue]);
            break;
        case SLMTypeDouble:
            double_object_setIvar(target, _ivar, [value doubleValue]);
            break;
        case SLMTypeBool:
            bool_object_setIvar(target, _ivar, [value boolValue]);
            break;
        case SLMTypePoint:
            point_object_setIvar(target, _ivar, CGPointFromString(value));
            break;
        case SLMTypeVector:
            vector_object_setIvar(target, _ivar, CGVectorFromString(value));
            break;
        case SLMTypeSize:
            size_object_setIvar(target, _ivar, CGSizeFromString(value));
            break;
        case SLMTypeRect:
            rect_object_setIvar(target, _ivar, CGRectFromString(value));
            break;
        case SLMTypeAffineTransform:
            transform_object_setIvar(target, _ivar, CGAffineTransformFromString(value));
            break;
        case SLMTypeEdgeInsets:
            insets_object_setIvar(target, _ivar, UIEdgeInsetsFromString(value));
            break;
        case SLMTypeOffset:
            offset_object_setIvar(target, _ivar, UIOffsetFromString(value));
            break;
        case SLMTypeRange:
            range_object_setIvar(target, _ivar, NSRangeFromString(value));
            break;
        case SLMTypeString:
            object_object_setIvar(target, _ivar, value);
            break;
        case SLMTypeClass:
            class_object_setIvar(target, _ivar, NSClassFromString(value));
            break;
        case SLMTypeSelector:
            selector_object_setIvar(target, _ivar, NSSelectorFromString(value));
            break;
        default:
            break;
    }
}

@end
