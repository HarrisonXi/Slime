//
//  SlimeTests.m
//  SlimeTests
//
//  Created by HarrisonXi on 2018/6/8.
//  Copyright © 2019 harrisonxi.com. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Slime.h"

@interface TestObjectA : NSObject {
    char _customIvar;
    double _testDouble;
    CGVector _testVector;
    CGRect _testRect3;
}

@property (nonatomic, assign) char testChar;
@property (nonatomic, assign, setter=customSetter:) int testInt;
@property (nonatomic, assign, readonly) short testShort;
@property (nonatomic, assign) long testLong;
@property (nonatomic, assign) CGPoint testPoint;
@property (nonatomic, assign) CGRect testRect1;
@property (nonatomic, strong) NSNumber *testNumber;
@property (nonatomic, strong) NSString *testString;
@property (nonatomic, strong) NSArray<NSString *> *testArray;
@property (nonatomic, strong) NSDictionary<NSNumber *, NSString *> *testDict;
@property (nonatomic, strong) TestObjectA *testObject;
@property (nonatomic, strong) id<NSCoding> testProtocol1;
@property (nonatomic, strong) NSObject<NSCoding> *testProtocol2;
@property (nonatomic, copy) void(^testBlock)(void);
@property (nonatomic, assign) Class testClass;
@property (nonatomic, assign) SEL testSelector;

@end

@implementation TestObjectA

@synthesize testChar = _customIvar;
@dynamic testLong;

- (void)setTestFloat:(float)value { }
- (void)setTestSize:(CGSize)value { }
- (void)setTestRect2:(CGRect)value { }

@end

@interface SetterTests : XCTestCase

@end

@implementation SetterTests

- (void)testSetter {    
    // char, custom ivar
    [SLMSetter setterWithClass:[TestObjectA class] key:@"testChar"];
    // int, custom setter
    [SLMSetter setterWithClass:[TestObjectA class] key:@"testInt"];
    // short, readonly
    [SLMSetter setterWithClass:[TestObjectA class] key:@"testShort"];
    // long, dynamic
    [SLMSetter setterWithClass:[TestObjectA class] key:@"testLong"];
    // float, no property, only method
    [SLMSetter setterWithClass:[TestObjectA class] key:@"testFloat"];
    // double, no property, no method, only ivar
    [SLMSetter setterWithClass:[TestObjectA class] key:@"testDouble"];
    // struct
    [SLMSetter setterWithClass:[TestObjectA class] key:@"testPoint"];
    // struct, no property, only method
    [SLMSetter setterWithClass:[TestObjectA class] key:@"testSize"];
    // struct, no property, no method, only ivar
    [SLMSetter setterWithClass:[TestObjectA class] key:@"testVector"];
    // nested struct
    [SLMSetter setterWithClass:[TestObjectA class] key:@"testRect1"];
    [SLMSetter setterWithClass:[TestObjectA class] key:@"testRect2"];
    [SLMSetter setterWithClass:[TestObjectA class] key:@"testRect3"];
    // object
    [SLMSetter setterWithClass:[TestObjectA class] key:@"testNumber"];
    [SLMSetter setterWithClass:[TestObjectA class] key:@"testString"];
    [SLMSetter setterWithClass:[TestObjectA class] key:@"testArray"];
    [SLMSetter setterWithClass:[TestObjectA class] key:@"testDict"];
    [SLMSetter setterWithClass:[TestObjectA class] key:@"testObject"];
    // protocol
    [SLMSetter setterWithClass:[TestObjectA class] key:@"testProtocol1"];
    [SLMSetter setterWithClass:[TestObjectA class] key:@"testProtocol2"];
    // block
    [SLMSetter setterWithClass:[TestObjectA class] key:@"testBlock"];
    // class
    [SLMSetter setterWithClass:[TestObjectA class] key:@"testClass"];
    // selector
    [SLMSetter setterWithClass:[TestObjectA class] key:@"testSelector"];
    /*
     result:
     
     testChar => property -> testChar -> Tc,N,V_customIvar
     testChar => method -> setTestChar: -> c
     testChar => ivar -> _customIvar -> c
     testInt => property -> testInt -> Ti,N,ScustomSetter:,V_testInt
     testInt => method -> customSetter: -> i
     testInt => ivar -> _testInt -> i
     testShort => property -> testShort -> Ts,R,N,V_testShort
     testShort => ivar -> _testShort -> s
     testLong => property -> testLong -> Tq,D,N
     testFloat => method -> setTestFloat: -> f
     testDouble => ivar -> _testDouble -> d
     testPoint => property -> testPoint -> T{CGPoint=dd},N,V_testPoint
     testPoint => method -> setTestPoint: -> {CGPoint=dd}
     testPoint => ivar -> _testPoint -> {CGPoint="x"d"y"d}
     testSize => method -> setTestSize: -> {CGSize=dd}
     testVector => ivar -> _testVector -> {CGVector="dx"d"dy"d}
     testRect1 => property -> testRect1 -> T{CGRect={CGPoint=dd}{CGSize=dd}},N,V_testRect1
     testRect1 => method -> setTestRect1: -> {CGRect={CGPoint=dd}{CGSize=dd}}
     testRect1 => ivar -> _testRect1 -> {CGRect="origin"{CGPoint="x"d"y"d}"size"{CGSize="width"d"height"d}}
     testRect2 => method -> setTestRect2: -> {CGRect={CGPoint=dd}{CGSize=dd}}
     testRect3 => ivar -> _testRect3 -> {CGRect="origin"{CGPoint="x"d"y"d}"size"{CGSize="width"d"height"d}}
     testNumber => property -> testNumber -> T@"NSNumber",&,N,V_testNumber
     testNumber => method -> setTestNumber: -> @
     testNumber => ivar -> _testNumber -> @"NSNumber"
     testString => property -> testString -> T@"NSString",&,N,V_testString
     testString => method -> setTestString: -> @
     testString => ivar -> _testString -> @"NSString"
     testArray => property -> testArray -> T@"NSArray",&,N,V_testArray
     testArray => method -> setTestArray: -> @
     testArray => ivar -> _testArray -> @"NSArray"
     testDict => property -> testDict -> T@"NSDictionary",&,N,V_testDict
     testDict => method -> setTestDict: -> @
     testDict => ivar -> _testDict -> @"NSDictionary"
     testObject => property -> testObject -> T@"TestObjectA",&,N,V_testObject
     testObject => method -> setTestObject: -> @
     testObject => ivar -> _testObject -> @"TestObjectA"
     testProtocol1 => property -> testProtocol1 -> T@"<NSCoding>",&,N,V_testProtocol1
     testProtocol1 => method -> setTestProtocol1: -> @
     testProtocol1 => ivar -> _testProtocol1 -> @"<NSCoding>"
     testProtocol2 => property -> testProtocol2 -> T@"NSObject<NSCoding>",&,N,V_testProtocol2
     testProtocol2 => method -> setTestProtocol2: -> @
     testProtocol2 => ivar -> _testProtocol2 -> @"NSObject<NSCoding>"
     testBlock => property -> testBlock -> T@?,C,N,V_testBlock
     testBlock => method -> setTestBlock: -> @?
     testBlock => ivar -> _testBlock -> @?
     testClass => property -> testClass -> T#,N,V_testClass
     testClass => method -> setTestClass: -> #
     testClass => ivar -> _testClass -> #
     testSelector => property -> testSelector -> T:,N,V_testSelector
     testSelector => method -> setTestSelector: -> :
     testSelector => ivar -> _testSelector -> :
     */
}

@end
