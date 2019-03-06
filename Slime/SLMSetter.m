//
//  SLMSetter.m
//  Slime
//
//  Created by HarrisonXi on 2018/5/17.
//  Copyright © 2019 harrisonxi.com. All rights reserved.
//
//  https://developer.apple.com/documentation/objectivec/objective_c_runtime?language=objc
//  https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html
//  http://blog.harrisonxi.com/2018/05/ObjC%E4%B8%AD%E7%9A%84TypeEncodings.html
//

#import "SLMSetter.h"
#import <objc/runtime.h>
#import "SLMMethodSetter.h"
#import "SLMIvarSetter.h"

@implementation NSObject (SLMSetter)

+ (BOOL)slm_accessIvarDirectly
{
    return [self accessInstanceVariablesDirectly];
}

@end

// ################################################################
#pragma mark -

@interface SLMSetter ()

@property (nonatomic, strong, readwrite) Class targetClass;
@property (nonatomic, strong, readwrite) NSString *targetKey;

@end

@implementation SLMSetter

- (instancetype)initWithValueType:(SLMType)valueType valueStruct:(NSString *)valueStruct valueClass:(__unsafe_unretained Class)valueClass
{
    if (self = [super init]) {
        _valueType = valueType;
        _valueStruct = valueStruct;
        _valueClass = valueClass;
    }
    return self;
}

+ (SLMSetter *)setterWithClass:(Class)class key:(NSString *)key
{
#ifdef SLIME_DEBUG
    NSParameterAssert(class != NULL);
    NSParameterAssert(key.length > 0);
#else
    if (class == NULL || key.length == 0) {
        return nil;
    }
#endif
    
    SLMSetter *setter = nil;
    SLMType valueType = SLMTypeUnsupported;
    NSString *valueStruct = nil;
    Class valueClass = NULL;
    
    const char *keyCStr = [key UTF8String];
    size_t keySize = strlen(keyCStr) + 1;
    char *propertyCStr = NULL;
    char *methodCStr = NULL;
    char *ivarCStr = NULL;

    // try to get property slm_<key> at first
    propertyCStr = (char *)malloc(keySize + 4);
    sprintf(propertyCStr, "slm_%s", keyCStr);
    objc_property_t property = class_getProperty(class, propertyCStr);
    if (!property) {
        // then try to get property <key>
        strcpy(propertyCStr, keyCStr);
        property = class_getProperty(class, propertyCStr);
    }
    if (property) {
        // found the property, try to use the setter method or ivar of this property
        unsigned int attributeCount = 0;
        objc_property_attribute_t *attributeList = property_copyAttributeList(property, &attributeCount);
        for (unsigned int i = 0; i < attributeCount; i++) {
            objc_property_attribute_t attribute = attributeList[i];
            switch (attribute.name[0]) {
                case 'T':
                    valueType = [SLMSetter analyzeTypeEncoding:attribute.value valueStruct:&valueStruct valueClass:&valueClass];
                    break;
                case 'S':
                    methodCStr = (char *)malloc(strlen(attribute.value) + 1);
                    strcpy(methodCStr, attribute.value);
                    break;
                case 'V':
                    ivarCStr = (char *)malloc(strlen(attribute.value) + 1);
                    strcpy(ivarCStr, attribute.value);
                    break;
                default:
                    break;
            }
        }
        free(attributeList);
#ifdef SLIME_SETTER_ANALYZING_LOG
        const char *encodingCStr = property_getAttributes(property);
        NSLog(@"SLMSetter: %@ => property -> %s -> %s", key, propertyCStr, encodingCStr);
#endif
    }
    
    Method method = NULL;
    if (methodCStr) {
        // try to get custom setter method
        method = class_getInstanceMethod(class, sel_registerName(methodCStr));
    }
    if (!method || method_getNumberOfArguments(method) != 3) {
        // try to get method slm_set<Key>:
        free(methodCStr);
        methodCStr = (char *)malloc(keySize + 8);
        sprintf(methodCStr, "slm_set%c%s:", toupper(*keyCStr), keyCStr + 1);
        method = class_getInstanceMethod(class, sel_registerName(methodCStr));
    }
    if (!method || method_getNumberOfArguments(method) != 3) {
        // try to get method set<Key>:
        sprintf(methodCStr, "set%c%s:", toupper(*keyCStr), keyCStr + 1);
        method = class_getInstanceMethod(class, sel_registerName(methodCStr));
    }
    if (method && method_getNumberOfArguments(method) == 3) {
        // found the method, use this method as setter method
#ifndef SLIME_SETTER_ANALYZING_LOG
        if (!valueType) {
            char *typeEncoding = method_copyArgumentType(method, 2);
            valueType = [SLMSetter analyzeTypeEncoding:typeEncoding valueStruct:&valueStruct valueClass:&valueClass];
            free(typeEncoding);
        }
#else
        char *typeEncoding = method_copyArgumentType(method, 2);
        NSLog(@"SLMSetter: %@ => method -> %s -> %s", key, methodCStr, typeEncoding);
        if (!valueType) {
            valueType = [SLMSetter analyzeTypeEncoding:typeEncoding valueStruct:&valueStruct valueClass:&valueClass];
        }
        free(typeEncoding);
#endif
        if ([SLMSetter validateValueType:valueType valueStruct:valueStruct valueClass:valueClass]) {
            setter = [[SLMMethodSetter alloc] initWithValueType:valueType valueStruct:valueStruct valueClass:valueClass method:method];
        }
    }
    
#ifndef SLIME_SETTER_ANALYZING_LOG
    if (!setter && [class slm_accessIvarDirectly]) {
#else
    if ([class slm_accessIvarDirectly]) {
#endif
        Ivar ivar = NULL;
        if (ivarCStr) {
            ivar = class_getInstanceVariable(class, ivarCStr);
        }
        if (!ivar) {
            // try to get ivar _<key>
            free(ivarCStr);
            ivarCStr = (char *)malloc(keySize + 1);
            sprintf(ivarCStr, "_%s", keyCStr);
            ivar = class_getInstanceVariable(class, ivarCStr);
        }
        if (!ivar) {
            // try to find iavr <key>
            strcpy(ivarCStr, keyCStr);
            ivar = class_getInstanceVariable(class, ivarCStr);
        }
        if (ivar) {
            // found the ivar, use this ivar to set value directly
#ifndef SLIME_SETTER_ANALYZING_LOG
            if (!valueType) {
                const char *typeEncoding = ivar_getTypeEncoding(ivar);
                valueType = [SLMSetter analyzeTypeEncoding:typeEncoding valueStruct:&valueStruct valueClass:&valueClass];
            }
#else
            const char *typeEncoding = ivar_getTypeEncoding(ivar);
            NSLog(@"SLMSetter: %@ => ivar -> %s -> %s", key, ivarCStr, typeEncoding);
            if (!valueType) {
                valueType = [SLMSetter analyzeTypeEncoding:typeEncoding valueStruct:&valueStruct valueClass:&valueClass];
            }
#endif
            if (!setter && [SLMSetter validateValueType:valueType valueStruct:valueStruct valueClass:valueClass]) {
                setter = [[SLMIvarSetter alloc] initWithValueType:valueType valueStruct:valueStruct valueClass:valueClass ivar:ivar];
            }
        }
    }
    
    free(propertyCStr);
    free(methodCStr);
    free(ivarCStr);
    
    if (setter) {
        setter.targetClass = class;
        setter.targetKey = key;
    }
    return setter;
}

+ (SLMType)analyzeTypeEncoding:(const char *)typeEncoding valueStruct:(NSString **)valueStruct valueClass:(Class *)valueClass
{
    SLMType result;
    switch (typeEncoding[0]) {
        case 'c':
            result = SLMTypeChar;
            break;
        case 'i':
            result = SLMTypeInt;
            break;
        case 's':
            result = SLMTypeShort;
            break;
        case 'l':
            result = SLMTypeLong;
            break;
        case 'q':
            result = SLMTypeLongLong;
            break;
        case 'C':
            result = SLMTypeUnsignedChar;
            break;
        case 'I':
            result = SLMTypeUnsignedInt;
            break;
        case 'S':
            result = SLMTypeUnsignedShort;
            break;
        case 'L':
            result = SLMTypeUnsignedLong;
            break;
        case 'Q':
            result = SLMTypeUnsignedLongLong;
            break;
        case 'f':
            result = SLMTypeFloat;
            break;
        case 'd':
            result = SLMTypeDouble;
            break;
        case 'B':
            result = SLMTypeBool;
            break;
        case '{':
            result = SLMTypeStruct;
            break;
        case '@':
            result = SLMTypeObject;
            break;
        case '#':
            result = SLMTypeClass;
            break;
        case ':':
            result = SLMTypeSelector;
            break;
        default:
            result = SLMTypeUnsupported;
    }
    if (result == SLMTypeStruct) {
        if (strncmp(typeEncoding, "{CGPoint=", 9) == 0) {
            result = SLMTypePoint;
        } else if (strncmp(typeEncoding, "{CGVector=", 10) == 0) {
            result = SLMTypeVector;
        } else if (strncmp(typeEncoding, "{CGSize=", 8) == 0) {
            result = SLMTypeSize;
        } else if (strncmp(typeEncoding, "{CGRect=", 8) == 0) {
            result = SLMTypeRect;
        } else if (strncmp(typeEncoding, "{CGAffineTransform=", 19) == 0) {
            result = SLMTypeAffineTransform;
        } else if (strncmp(typeEncoding, "{UIEdgeInsets=", 14) == 0) {
            result = SLMTypeEdgeInsets;
        } else if (strncmp(typeEncoding, "{UIOffset=", 10) == 0) {
            result = SLMTypeOffset;
        } else if (strncmp(typeEncoding, "{NSRange=", 9) == 0) {
            result = SLMTypeRange;
        } else {
            char *location = strchr(typeEncoding + 1, '=');
            if (location) {
                *location = '\0';
                *valueStruct = [NSString stringWithUTF8String:typeEncoding + 1];
                *location = '=';
            }
        }
    } else if (result == SLMTypeObject && typeEncoding[1] == '\"') {
        if (strncmp(typeEncoding, "@\"NSString\"", 11) == 0) {
            result = SLMTypeString;
        } else if (strncmp(typeEncoding, "@\"NSNumber\"", 11) == 0) {
            result = SLMTypeNumber;
        } else if (strncmp(typeEncoding, "@\"NSArray\"", 10) == 0) {
            result = SLMTypeArray;
        } else if (strncmp(typeEncoding, "@\"NSDictionary\"", 15) == 0) {
            result = SLMTypeDictionary;
        } else {
            char *location = strpbrk(typeEncoding + 2, "\"<");
            if (location && location > typeEncoding + 2) {
                char temp = *location;
                *location = '\0';
                NSString *className = [NSString stringWithUTF8String:typeEncoding + 2];
                *valueClass = NSClassFromString(className);
                *location = temp;
            }
        }
    }
    return result;
}

+ (BOOL)validateValueType:(SLMType)valueType valueStruct:(NSString *)valueStruct valueClass:(Class)valueClass
{
    if (valueType == SLMTypeUnsupported) {
        return NO;
    }
    if (valueType == SLMTypeStruct && valueStruct == nil) {
        return NO;
    }
    if (valueType == SLMTypeObject && valueClass == NULL) {
        return NO;
    }
    return YES;
}

- (void)setValue:(id)value forTarget:(id)target
{
#ifdef SLIME_DEBUG
    NSParameterAssert(value);
    NSParameterAssert(target);
    NSParameterAssert([target class] == _targetClass);
#else
    if (!value || !target || [target class] != _targetClass) {
        return;
    }
#endif
    
    if ([value isKindOfClass:[NSString class]]) {
        [self setString:value forTarget:target];
    } else if ([value isKindOfClass:[NSNumber class]]) {
        [self setNumber:value forTarget:target];
    } else if ([value isKindOfClass:[NSDictionary class]]) {
        [self setDict:value forTarget:target];
    } else if ([value isKindOfClass:[NSArray class]]) {
        [self setArray:value forTarget:target];
    }
    return;
}

- (void)setString:(NSString *)value forTarget:(id)target
{
    // override me
}

- (void)setNumber:(NSNumber *)value forTarget:(id)target
{
    // override me
}

- (void)setDict:(NSDictionary *)value forTarget:(id)target
{
    // override me
}

- (void)setArray:(NSArray *)value forTarget:(id)target
{
    // override me
}

@end
