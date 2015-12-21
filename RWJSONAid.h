//
//  RWJSONAid.h
//  RWJSONAid
//
//  Created by deput on 12/19/15.
//  Copyright © 2015 deput. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^RWJSONAidHandler)(id originalObject,SEL aSelector);

@interface RWJSONAid: NSObject
+ (void) setHandler:(RWJSONAidHandler)handler;
@end

