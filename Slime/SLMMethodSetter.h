//
//  SLMMethodSetter.h
//  Slime
//
//  Created by HarrisonXi on 2018/6/12.
//  Copyright © 2019 harrisonxi.com. All rights reserved.
//

#import <objc/runtime.h>
#import "SLMSetter+Private.h"

@interface SLMMethodSetter : SLMSetter

/**
 DO NOT use this method directly.
 
 @param valueType    Type of value
 @param valueStruct  Struct of value if value is an struct
 @param valueClass   Class of value if value is an object
 @param method       Setter method
 @return             Instance of SLMSetter
 */
- (instancetype)initWithValueType:(SLMType)valueType valueStruct:(NSString *)valueStruct valueClass:(Class)valueClass method:(Method)method;

@end
