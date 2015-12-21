# RWJSONAid
## Description
RWJSONAid is a simple set of Objective-C Categories to avoid crash when sending messages to incompatible object instances from a JSON dicticonary in iOS. 

## Background

Given following situation:
```objc
NSString* someId = jsonDictionary[@"id"];
NSString* completeString = [someid stringByAppendingString:@"-SomeOtherThing"]; //get crash when jsonDictionary[@"id"] is not NSString.
```
Program crashes when object type is not as assummed! 

```objc
NSString* someId = jsonDictionary[@"id"];
if ([someId isKindOfClass:[NSString class]]){
  NSString* completeString = [someid stringByAppendingString:@"-SomeOtherThing"];
} 
```
We always perform defenvise coding to get rid of crashing. But such kind of code snippet could be annoying. Here we have a neat sulution：RWJSONAid.

## How it works

`forwardingTargetForSelector` is override as following to forward message to a correct coresponding object instance.

```objc
- (id) forwardingTargetForSelector:(SEL)aSelector{
    if ([self respondsToSelector:aSelector]) {
        return [super forwardingTargetForSelector:aSelector];
    }else{
        if ([someOtherObjectInstance respondsToSelector:aSelector]){
            return someOtherObjectInstance;
        }else if ...{
        }
    }
    return [super forwardingTargetForSelector:aSelector];
}
```
