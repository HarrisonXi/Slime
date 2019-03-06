//
//  SLMIvarSetter.h
//  Slime
//
//  Created by HarrisonXi on 2018/9/6.
//  Copyright © 2019 harrisonxi.com. All rights reserved.
//

#import <objc/runtime.h>
#import "SLMSetter+Private.h"

@interface SLMIvarSetter : SLMSetter

/**
 DO NOT use this method directly.
 
 @param valueType    Type of value
 @param valueStruct  Struct of value if value is an struct
 @param valueClass   Class of value if value is an object
 @param ivar         Setter ivar
 @return             Instance of SLMSetter
 */
- (instancetype)initWithValueType:(SLMType)valueType valueStruct:(NSString *)valueStruct valueClass:(Class)valueClass ivar:(Ivar)ivar;

@end
