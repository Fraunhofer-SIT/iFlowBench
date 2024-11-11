//
//  TaintObject.m
//  BenchmarkAppObjC
//

#import <Foundation/Foundation.h>
#import "TaintObject.h"

@implementation TaintObject

+ (NSNumber *) source {
    return @1729;
}

+ (void) sink :(NSNumber *) information {
    NSLog(@"%@", information);
}

+ (int) sourceCstyle {
    return 1729;
}

+ (void) sinkCstyle :(int)information {
    NSLog(@"%d", information);
}

+ (void) taintStaticPropertyOfGenericObject {
    GenericObject *Generic = [[GenericObject alloc] init];
    
    [Generic setStaticNumber:[TaintObject source]];
}

+ (void) taintDynamicDispatch:(GenericObject *)object {
    [object dynamicDispatchTaint];
}

+ (void) taintNotDynamicDispatch:(GenericObject *)object {
    [object dynamicDispatchNoTaint];
}

+ (void) taintNSNumberNoEffect:(NSNumber *)number {
    // local variable number is a local copy of the reference ID pointer to the original object
    // this creates a new NSNumber object and updates only the local reference
    // it has no effect on the original NSNumber object
    number = [TaintObject source];
}

+ (void) taintNSNumberField:(GenericObject *)object {
    // local variable object is a local copy of the reference ID pointer to the original object
    // this updates the actual NSNumber reference in the numberField field of the original object
    object.numberField = [TaintObject source];
}

+ (void) taintMultipleNumberFields:(GenericObject *)object {
    object.numberField = [TaintObject source];
    object.numberField2 = [TaintObject source];
    object.numberField3 = [TaintObject source];
}

+ (void) taintMultipleNumberFieldsOfTwoObjects:(GenericObject *)object1 :(GenericObject *)object2 {
    object1.numberField = [TaintObject source];
    object1.numberField2 = [TaintObject source];
    
    object2.numberField = [TaintObject source];
    object2.numberField2 = [TaintObject source];
}

+ (void) leakNumberFieldOfSecondObject:(GenericObject *)firstObject :(GenericObject *)secondObject {
    [TaintObject sink:secondObject.numberField];
}

@end
