//
//  RWJSONAid.m
//  RWJSONAid
//
//  Created by deput on 12/19/15.
//  Copyright © 2015 deput. All rights reserved.
//

#import "RWJSONAid.h"

static NSString*        rwString;
static NSNumber*        rwNumber;
static NSArray*         rwArray;
static NSDictionary*    rwDictionary;

static NSArray*         rwJSONDataObjects;
static id               RWJSONAidForwardingTargetForSelector(id self, SEL cmd, SEL aSelector);

static RWJSONAidHandler rwHandler;


#define RWJSONRECUEMACRO \
- (id) forwardingTargetForSelector:(SEL)aSelector\
{\
    if ([self respondsToSelector:aSelector]) {\
        return [super forwardingTargetForSelector:aSelector];\
    }else{\
        id object = RWJSONAidForwardingTargetForSelector(self, _cmd, aSelector);\
        if (object) {\
            if (rwHandler) rwHandler(self,aSelector);\
            return object;\
        }\
    }\
    return [super forwardingTargetForSelector:aSelector];\
}

@implementation NSNull (RWJSONAid)
RWJSONRECUEMACRO
@end

@implementation NSArray (RWJSONAid)
RWJSONRECUEMACRO
@end

@implementation NSString (RWJSONAid)
RWJSONRECUEMACRO
@end

@implementation NSDictionary (RWJSONAid)
RWJSONRECUEMACRO
@end

@implementation NSNumber (RWJSONAid)
RWJSONRECUEMACRO
@end

@implementation RWJSONAid
+ (void) setHandler:(RWJSONAidHandler)handler
{
    rwHandler = handler;
}
@end

#pragma mark - Interal Methods
id RWJSONAidForwardingTargetForSelector(id self, SEL cmd, SEL aSelector)
{
    __block id retObject = nil;
    [rwJSONDataObjects enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj respondsToSelector:aSelector]) {
            retObject = obj;
            *stop = YES;
        }
    }];
    return retObject;
}

__attribute__((constructor)) static void InitJSONObjects(void)
{
    rwString = [NSString stringWithFormat:@""];
    rwNumber = @(0);
    rwArray = @[].copy;
    rwDictionary = @{}.copy;
    rwJSONDataObjects = @[rwString,rwArray,rwDictionary,rwNumber];
}

