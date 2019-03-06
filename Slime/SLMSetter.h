//
//  SLMSetter.h
//  Slime
//
//  Created by HarrisonXi on 2018/5/17.
//  Copyright © 2019 harrisonxi.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SLMDefine.h"

@interface NSObject (SLMSetter)

/**
 Return YES if setValue:forTarget: of SLMSetter may directly manipulate instance variables.

 @return Return [NSObject accessInstanceVariablesDirectly] by default.
 */
+ (BOOL)slm_accessIvarDirectly;

@end

// ################################################################
#pragma mark -

@interface SLMSetter : NSObject

@property (nonatomic, strong, readonly) Class targetClass;
@property (nonatomic, strong, readonly) NSString *targetKey;
@property (nonatomic, assign, readonly) SLMType valueType;
@property (nonatomic, assign, readonly) NSString *valueStruct;
@property (nonatomic, assign, readonly) Class valueClass;

/**
 Create a SLMSetter with class and key. Does not support key path. Searching order:
 1. property 'slm_<key>'
 2. property '<key>'
 3. method 'slm_set<Key>', must be able to get a fixed encoding type
 3. method 'set<Key>:', must be able to get a fixed encoding type
 4. ivar '_<key>'
 4. ivar '<key>'

 @param class  Target class
 @param key    Target key
 @return       SLMSetter for sepcified class and key. Will retrun nil if does not find a suitable property/method/ivar.
 */
+ (SLMSetter *)setterWithClass:(Class)class key:(NSString *)key;

/**
 Set a value for specified target.

 @param value   The value.
 @param target  Target instance.
 */
- (void)setValue:(id)value forTarget:(id)target;
- (void)setNumber:(NSNumber *)value forTarget:(id)target;
- (void)setString:(NSString *)value forTarget:(id)target;
- (void)setDict:(NSDictionary *)value forTarget:(id)target;
- (void)setArray:(NSArray *)value forTarget:(id)target;

@end
