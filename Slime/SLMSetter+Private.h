//
//  SLMSetter+Private.h
//  SlimeDemo
//
//  Created by HarrisonXi on 2019/3/4.
//  Copyright © 2019 harrisonxi.com. All rights reserved.
//

#import "SLMSetter.h"

@interface SLMSetter (Private)

/**
 DO NOT use this method directly. It is used for overriding.
 
 @param valueType    Type of value
 @param valueStruct  Struct of value if value is an struct
 @param valueClass   Class of value if value is an object
 @return             Instance of SLMSetter
 */
- (instancetype)initWithValueType:(SLMType)valueType valueStruct:(NSString *)valueStruct valueClass:(Class)valueClass;

@end
