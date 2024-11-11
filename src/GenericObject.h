//
//  GenericObject.h
//  BenchmarkAppObjC
//

#ifndef GenericObject_h
#define GenericObject_h

@interface GenericObject : NSObject

@property NSNumber *numberField;
@property NSNumber *numberField2;
@property NSNumber *numberField3;
@property NSNumber *numberField4;
@property NSNumber *numberField5;

@property int intNumber;

- (instancetype) initWithTaint;

- (void) setStaticNumber :(NSNumber *)number;
- (NSNumber *)getStaticNumber;

- (void) resetNumberFieldNoInternalSetter;
- (void) resetIntNumberFieldNoInternalSetter;

- (void) SourceToSinkOverFieldNoInternalSetter;
- (void) SourceToSinkOverTwoFieldsOfSameObjectNoInternalSetter;

- (void) SwapNumberField2and3;

- (void) dynamicDispatchTaint;
- (void) dynamicDispatchNoTaint;

+ (void) SwapNumberFieldObject1WithNumberFieldObject2 :(GenericObject *)object1 :(GenericObject *)object2;

+ (void) leakFunction :(NSNumber *)number;
+ (void) noLeakFunction :(NSNumber *)number;

+ (void) leakFunctionObject :(GenericObject *)object;
+ (void) noLeakFunctionObject :(GenericObject *)object;

+ (void) leakFunctionObjectOverLocalVariable:(GenericObject *)object;
+ (void) noLeakFunctionObjectOverLocalVariable:(GenericObject *)object;

+ (void) recursiveFunction :(int)counter :(NSNumber *)number;

@end

#endif /* GenericObject_h */
