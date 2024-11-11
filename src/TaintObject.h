//
//  TaintObject.h
//  BenchmarkAppObjC
//

#ifndef TaintObject_h
#define TaintObject_h

#import<Foundation/Foundation.h>
#import "GenericObject.h"

@interface TaintObject : NSObject

+ (NSNumber *) source;
+ (void) sink :(NSNumber *) information;

+ (int) sourceCstyle;
+ (void) sinkCstyle :(int)information;

+ (void) taintStaticPropertyOfGenericObject;

+ (void) taintDynamicDispatch :(GenericObject *)object;
+ (void) taintNotDynamicDispatch :(GenericObject *)object;

+ (void) taintNSNumberNoEffect :(NSNumber *) number;
+ (void) taintNSNumberField :(GenericObject *)object;

+ (void) taintMultipleNumberFields :(GenericObject *)object;
+ (void) taintMultipleNumberFieldsOfTwoObjects :(GenericObject *)object1 :(GenericObject *)object2;

+ (void) leakNumberFieldOfSecondObject:(GenericObject *)firstObject :(GenericObject *)secondObject;

@end

#endif /* TaintObject_h */
