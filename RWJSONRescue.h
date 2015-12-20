//
//  RWJSONRescue.h
//  RWJSONRescue
//
//  Created by deput on 12/19/15.
//  Copyright © 2015 deput. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^RWJSONRescueHandler)(id originalObject,SEL aSelector);

@interface RWJSONRescue: NSObject
+ (void) setHandler:(RWJSONRescueHandler)handler;
@end

