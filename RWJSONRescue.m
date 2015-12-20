//
//  RWJSONRescue.m
//  RWJSONRescue
//
//  Created by deput on 12/19/15.
//  Copyright © 2015 deput. All rights reserved.
//

#import "RWJSONRescue.h"

static NSString*        rwString;
static NSNumber*        rwNumber;
static NSArray*         rwArray;
static NSDictionary*    rwDictionary;

static NSArray*         rwJSONDataObjects;
static id               RWJSONRescueForwardingTargetForSelector(id self, SEL cmd, SEL aSelector);

static RWJSONRescueHandler rwHandler;


#define RWJSONRECUEMACRO \
- (id) forwardingTargetForSelector:(SEL)aSelector\
{\
    if ([self respondsToSelector:aSelector]) {\
        return [super forwardingTargetForSelector:aSelector];\
    }else{\
        id object = RWJSONRescueForwardingTargetForSelector(self, _cmd, aSelector);\
        if (object) {\
            if (rwHandler) rwHandler(self,aSelector);\
            return object;\
        }\
    }\
    return [super forwardingTargetForSelector:aSelector];\
}

@implementation NSNull (RWJSONRescue)
RWJSONRECUEMACRO
@end

@implementation NSArray (RWJSONRescue)
RWJSONRECUEMACRO
@end

@implementation NSString (RWJSONRescue)
RWJSONRECUEMACRO
@end

@implementation NSDictionary (RWJSONRescue)
RWJSONRECUEMACRO
@end

@implementation NSNumber (RWJSONRescue)
RWJSONRECUEMACRO
@end

@implementation RWJSONRescue
+ (void) setHandler:(RWJSONRescueHandler)handler
{
    rwHandler = handler;
}
@end

#pragma mark - Interal Methods
id RWJSONRescueForwardingTargetForSelector(id self, SEL cmd, SEL aSelector)
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

