//
//  GenericObject.m
//  BenchmarkAppObjC
//

#import <Foundation/Foundation.h>
#import "GenericObject.h"
#import "TaintObject.h"

@implementation GenericObject

static NSNumber *staticNumber = @0;

/*
 initWithTaint
 
 different initializer that taints numberField on initialization
 */
- (instancetype) initWithTaint {
    self = [super init];
    if(self) {
        self.numberField = [TaintObject source];
    }
    
    return self;
}

- (void) setStaticNumber:(NSNumber *)number {
    staticNumber = number;
}

- (NSNumber *) getStaticNumber {
    return staticNumber;
}

- (void) resetNumberFieldNoInternalSetter {
    _numberField = @0;
}

- (void) resetIntNumberFieldNoInternalSetter {
    _intNumber = 0;
}

- (void) SwapNumberField2and3 {
    NSNumber *local = self.numberField3;
    self.numberField3 = self.numberField2;
    self.numberField2 = local;
}

- (void) dynamicDispatchTaint {
    NSLog(@"dynamicDispatchTaint called: we are in the parent class, so nothing should happen here");
}

- (void) dynamicDispatchNoTaint {
    NSLog(@"dynamicDispatchNoTaint called: we are in the parent class, so nothing should happen here");
}

+ (void) SwapNumberFieldObject1WithNumberFieldObject2:(GenericObject *)object1 :(GenericObject *)object2 {
    NSNumber *local = object1.numberField;
    object1.numberField = object2.numberField;
    object2.numberField = local;
}

- (void) SourceToSinkOverFieldNoInternalSetter {
    _numberField = [TaintObject source];
    [TaintObject sink:_numberField];
}

- (void) SourceToSinkOverTwoFieldsOfSameObjectNoInternalSetter {
    _numberField = [TaintObject source];
    _numberField2 = _numberField;
    _numberField = @0;
    [TaintObject sink:_numberField2];
}

+ (void) leakFunction:(NSNumber *)number {
    [TaintObject sink:number];
}

+ (void) noLeakFunction:(NSNumber *)number {
    number = @0;
    [TaintObject sink:number];
}

+ (void) leakFunctionObject:(GenericObject *)object {
    [TaintObject sink:object.numberField];
}

+ (void) noLeakFunctionObject:(GenericObject *)object {
    object.numberField = @0;
    [TaintObject sink:object.numberField];
}

+ (void) leakFunctionObjectOverLocalVariable:(GenericObject *)object {
    NSNumber *local = object.numberField;
    [TaintObject sink:local];
}

+ (void) noLeakFunctionObjectOverLocalVariable:(GenericObject *)object {
    NSNumber *local = object.numberField;
    local = @0;
    [TaintObject sink:local];
}

+ (void) recursiveFunction:(int)counter :(NSNumber *)number {
    if(counter < 1) {
        return [self recursiveFunction:counter+1 :number];
    }
    else {
        [TaintObject sink:number];
    }
}

@end
