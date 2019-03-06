//
//  SLMDefine.h
//  Slime
//
//  Created by HarrisonXi on 2018/6/7.
//  Copyright © 2019 harrisonxi.com. All rights reserved.
//

#ifndef SLMDefine_h
#define SLMDefine_h

// Macros to enable specified features
#ifdef DEBUG
#  define SLIME_ENABLE_DEBUG 1
#  define SLIME_ENABLE_SETTER_ANALYZING_LOG 0
#endif

// DO NOT modify these lines unless you know what are you doing
#if SLIME_ENABLE_DEBUG > 0
#  define SLIME_DEBUG
#  if SLIME_ENABLE_SETTER_ANALYZING_LOG > 0
#     define SLIME_SETTER_ANALYZING_LOG
#  endif
#endif

typedef enum : NSUInteger {
    SLMTypeUnsupported      = 0,
    SLMTypeChar             = 1,
    SLMTypeInt              = 2,
    SLMTypeShort            = 3,
    SLMTypeLong             = 4,
    SLMTypeLongLong         = 5,
    SLMTypeUnsignedChar     = 6,
    SLMTypeUnsignedInt      = 7,
    SLMTypeUnsignedShort    = 8,
    SLMTypeUnsignedLong     = 9,
    SLMTypeUnsignedLongLong = 10,
    SLMTypeFloat            = 11,
    SLMTypeDouble           = 12,
    SLMTypeBool             = 13,
    SLMTypeStruct           = 100,
    SLMTypePoint            = 101, // CGPoint
    SLMTypeVector           = 102, // CGVector
    SLMTypeSize             = 103, // CGSize
    SLMTypeRect             = 104, // CGRect
    SLMTypeAffineTransform  = 105, // CGAffineTransform
    SLMTypeEdgeInsets       = 106, // UIEdgeInsets
    SLMTypeOffset           = 107, // UIOffset
    SLMTypeRange            = 108, // NSRange
    SLMTypeObject           = 200,
    SLMTypeString           = 201, // NSString
    SLMTypeNumber           = 202, // NSNumber
    SLMTypeArray            = 203, // NSArray
    SLMTypeDictionary       = 204, // NSDictionary
    SLMTypeClass            = 300,
    SLMTypeSelector         = 400
} SLMType;

#endif /* SLMDefine_h */
