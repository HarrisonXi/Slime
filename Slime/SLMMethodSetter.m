//
//  SLMMethodSetter.m
//  SlimeDemo
//
//  Created by HarrisonXi on 2018/6/12.
//  Copyright © 2019 harrisonxi.com. All rights reserved.
//

#import "SLMMethodSetter.h"
#import <objc/message.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

static void(*char_method_invoke)(id, Method, char) = (void(*)(id, Method, char))method_invoke;
static void(*int_method_invoke)(id, Method, int) = (void(*)(id, Method, int))method_invoke;
static void(*short_method_invoke)(id, Method, short) = (void(*)(id, Method, short))method_invoke;
static void(*long_method_invoke)(id, Method, long) = (void(*)(id, Method, long))method_invoke;
static void(*long_long_method_invoke)(id, Method, long long) = (void(*)(id, Method, long long))method_invoke;
static void(*unsigned_char_method_invoke)(id, Method, unsigned char) = (void(*)(id, Method, unsigned char))method_invoke;
static void(*unsigned_int_method_invoke)(id, Method, unsigned int) = (void(*)(id, Method, unsigned int))method_invoke;
static void(*unsigned_short_method_invoke)(id, Method, unsigned short) = (void(*)(id, Method, unsigned short))method_invoke;
static void(*unsigned_long_method_invoke)(id, Method, unsigned long) = (void(*)(id, Method, unsigned long))method_invoke;
static void(*unsigned_long_long_method_invoke)(id, Method, unsigned long long) = (void(*)(id, Method, unsigned long long))method_invoke;
static void(*float_method_invoke)(id, Method, float) = (void(*)(id, Method, float))method_invoke;
static void(*double_method_invoke)(id, Method, double) = (void(*)(id, Method, double))method_invoke;
static void(*bool_method_invoke)(id, Method, bool) = (void(*)(id, Method, bool))method_invoke;

static void(*point_method_invoke)(id, Method, CGPoint) = (void(*)(id, Method, CGPoint))method_invoke;
static void(*vector_method_invoke)(id, Method, CGVector) = (void(*)(id, Method, CGVector))method_invoke;
static void(*size_method_invoke)(id, Method, CGSize) = (void(*)(id, Method, CGSize))method_invoke;
static void(*rect_method_invoke)(id, Method, CGRect) = (void(*)(id, Method, CGRect))method_invoke;
static void(*transform_method_invoke)(id, Method, CGAffineTransform) = (void(*)(id, Method, CGAffineTransform))method_invoke;
static void(*insets_method_invoke)(id, Method, UIEdgeInsets) = (void(*)(id, Method, UIEdgeInsets))method_invoke;
static void(*offset_method_invoke)(id, Method, UIOffset) = (void(*)(id, Method, UIOffset))method_invoke;
static void(*range_method_invoke)(id, Method, NSRange) = (void(*)(id, Method, NSRange))method_invoke;

static void(*object_method_invoke)(id, Method, id) = (void(*)(id, Method, id))method_invoke;
static void(*class_method_invoke)(id, Method, Class) = (void(*)(id, Method, Class))method_invoke;
static void(*selector_method_invoke)(id, Method, SEL) = (void(*)(id, Method, SEL))method_invoke;

@interface SLMMethodSetter () {
    Method _method;
}

@end

@implementation SLMMethodSetter

- (instancetype)initWithValueType:(SLMType)valueType valueStruct:(NSString *)valueStruct valueClass:(__unsafe_unretained Class)valueClass method:(Method)method
{
    if (self = [super initWithValueType:valueType valueStruct:valueStruct valueClass:valueClass]) {
        _method = method;
    }
    return self;
}

- (void)setNumber:(NSNumber *)value forTarget:(id)target
{
    switch (self.valueType) {
        case SLMTypeChar:
            char_method_invoke(target, _method, [value charValue]);
            break;
        case SLMTypeInt:
            int_method_invoke(target, _method, [value intValue]);
            break;
        case SLMTypeShort:
            short_method_invoke(target, _method, [value shortValue]);
            break;
        case SLMTypeLong:
            long_method_invoke(target, _method, [value longValue]);
            break;
        case SLMTypeLongLong:
            long_long_method_invoke(target, _method, [value longLongValue]);
            break;
        case SLMTypeUnsignedChar:
            unsigned_char_method_invoke(target, _method, [value unsignedCharValue]);
            break;
        case SLMTypeUnsignedInt:
            unsigned_int_method_invoke(target, _method, [value unsignedIntValue]);
            break;
        case SLMTypeUnsignedShort:
            unsigned_short_method_invoke(target, _method, [value unsignedShortValue]);
            break;
        case SLMTypeUnsignedLong:
            unsigned_long_method_invoke(target, _method, [value unsignedLongValue]);
            break;
        case SLMTypeUnsignedLongLong:
            unsigned_long_long_method_invoke(target, _method, [value unsignedLongLongValue]);
            break;
        case SLMTypeFloat:
            float_method_invoke(target, _method, [value floatValue]);
            break;
        case SLMTypeDouble:
            double_method_invoke(target, _method, [value doubleValue]);
            break;
        case SLMTypeBool:
            bool_method_invoke(target, _method, [value boolValue]);
            break;
        case SLMTypeNumber:
            object_method_invoke(target, _method, value);
            break;
        case SLMTypeString:
            object_method_invoke(target, _method, [value stringValue]);
            break;
        default:
            break;
    }
}

- (void)setString:(NSString *)value forTarget:(id)target
{
    switch (self.valueType) {
        case SLMTypeChar:
            char_method_invoke(target, _method, [value intValue]);
            break;
        case SLMTypeInt:
            int_method_invoke(target, _method, [value intValue]);
            break;
        case SLMTypeShort:
            short_method_invoke(target, _method, [value intValue]);
            break;
        case SLMTypeLong:
            long_method_invoke(target, _method, [value longLongValue]);
            break;
        case SLMTypeLongLong:
            long_long_method_invoke(target, _method, [value longLongValue]);
            break;
        case SLMTypeUnsignedChar:
            unsigned_char_method_invoke(target, _method, [value intValue]);
            break;
        case SLMTypeUnsignedInt:
            unsigned_int_method_invoke(target, _method, [value intValue]);
            break;
        case SLMTypeUnsignedShort:
            unsigned_short_method_invoke(target, _method, [value intValue]);
            break;
        case SLMTypeUnsignedLong:
            unsigned_long_method_invoke(target, _method, [value longLongValue]);
            break;
        case SLMTypeUnsignedLongLong:
            unsigned_long_long_method_invoke(target, _method, [value longLongValue]);
            break;
        case SLMTypeFloat:
            float_method_invoke(target, _method, [value floatValue]);
            break;
        case SLMTypeDouble:
            double_method_invoke(target, _method, [value doubleValue]);
            break;
        case SLMTypeBool:
            bool_method_invoke(target, _method, [value boolValue]);
            break;
        case SLMTypePoint:
            point_method_invoke(target, _method, CGPointFromString(value));
            break;
        case SLMTypeVector:
            vector_method_invoke(target, _method, CGVectorFromString(value));
            break;
        case SLMTypeSize:
            size_method_invoke(target, _method, CGSizeFromString(value));
            break;
        case SLMTypeRect:
            rect_method_invoke(target, _method, CGRectFromString(value));
            break;
        case SLMTypeAffineTransform:
            transform_method_invoke(target, _method, CGAffineTransformFromString(value));
            break;
        case SLMTypeEdgeInsets:
            insets_method_invoke(target, _method, UIEdgeInsetsFromString(value));
            break;
        case SLMTypeOffset:
            offset_method_invoke(target, _method, UIOffsetFromString(value));
            break;
        case SLMTypeRange:
            range_method_invoke(target, _method, NSRangeFromString(value));
            break;
        case SLMTypeString:
            object_method_invoke(target, _method, value);
            break;
        case SLMTypeClass:
            class_method_invoke(target, _method, NSClassFromString(value));
            break;
        case SLMTypeSelector:
            selector_method_invoke(target, _method, NSSelectorFromString(value));
            break;
        default:
            break;
    }
}

@end
