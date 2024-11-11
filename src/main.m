//
//  main.m
//  STATIC-BenchmarkAppObjC
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "TaintObject.h"
#import "GenericObject.h"
#import "GenericChild.h"
#import "ObjectHolder.h"

/*
 BENCHMARK FUNCTIONS
 DECLARATION
 */


// GENERAL OBJECTIVE-C
void Bench_p_SourceToSink(void);
void Bench_n_SourceToSinkNoLeak(void);

// GLOBAL VARIABLES
void Bench_p_SetStaticPropertyInSecondProcedureLeak(void);
void Bench_n_SetStaticPropertyInSecondProcedureNoLeak(void);
void Bench_p_StaticPropertyLeakOverDifferentObjects(void);
void Bench_p_FieldToStaticPropertyToFieldLeak(void);
void Bench_p_WriteThenReadGlobalVariableIntraproceduralLeak(void);

void Bench_n_WriteThenReadGlobalVariableIntraproceduralNoLeak(void);

// FIELD AND OBJECT SENSITIVITY - FIELD ACCESS
void Bench_n_SinkUninitializedField(void);
void Bench_p_SourceToSinkOverField(void);
void Bench_p_SourceToSinkOverTwoFieldsOfSameObject(void);
void Bench_p_SourceToSinkOverMultipleFieldsOfSameObject(void);
void Bench_p_SourceToSinkOverTwoFieldsOfDifferentObjects(void);

void Bench_p_SourceToSinkOverMultipleFieldsOfDifferentObjects(void);
void Bench_n_SourceToSinkTaintMultipleFieldsLeakNone(void);
void Bench_p_SourceToSinkTaintMultipleFieldsOnlyLeakOne(void);
void Bench_p_SourceToSinkTaintMultipleFieldsLeakAll(void);
void Bench_n_SourceToSinkTaintMultipleFieldsOfDifferentObjectsLeakNone(void);

void Bench_p_SourceToSinkTaintMultipleFieldsOfDifferentObjectsOnlyLeakOne(void);
void Bench_p_SourceToSinkTaintMultipleFieldsOfDifferentObjectsLeakAll(void);
void Bench_p_SourceToSinkOverFieldNoInternalSetter(void);
void Bench_p_SourceToSinkOverTwoFieldsOfSameObjectNoInternalSetter(void);
void Bench_n_LeakUntaintedField(void);

void Bench_p_LeakTaintedField(void);
void Bench_p_LeakTaintedAndUntaintedField(void);
void Bench_n_TaintFieldThenOverwrite(void);
void Bench_p_TaintAndSanitizeFieldRepeatedly(void);
void Bench_p_SourceToSinkLeakInSecondProcedure(void);

void Bench_n_SourceToSinkNoLeakInSecondProcedure(void);
void Bench_p_SourceToSinkLeakInSecondProcedurePassingObject(void);
void Bench_n_SourceToSinkNoLeakInSecondProcedurePassingObject(void);
void Bench_p_SourceToSinkLeakInSecondProcedureOverLocalVariable(void);
void Bench_n_SourceToSinkNoLeakInSecondProcedureOverLocalVariable(void);

void Bench_p_SourceToSinkLeakAfterOneRecursion(void);
void Bench_n_NoLeakAfterPassingNSNumberObjectReference(void);
void Bench_p_LeakAfterPassingGenericObjectReference(void);
void Bench_p_LeakAfterTaintInInitialization(void);
void Bench_p_LeakAfterInheritanceConstructor(void);

void Bench_p_LeakAfterTaintingMultipleFieldsOfSameObjectInSecondProcedure(void);
void Bench_n_NoLeakAfterTaintingMultipleFieldsOfSameObjectInSecondProcedure(void);
void Bench_p_LeakAfterPassingTwoObjectsToSecondProcedureAndTaintingMultipleFields(void);
void Bench_n_NoLeakAfterPassingTwoObjectsToSecondProcedureAndTaintingMultipleFields(void);
void Bench_p_LeakAfterSwappingFieldsOfSameObject(void);

void Bench_n_NoLeakAfterSwappingFieldsOfSameObject(void);
void Bench_p_LeakAfterSwappingFieldsOfDifferentObjects(void);
void Bench_n_NoLeakAfterSwappingFieldsOfDifferentObjects(void);

// FIELD AND OBJECT SENSITIVITY - FIELD DEPTH
void Bench_p_SourceToSinkOverFieldObjectDepth1(void);
void Bench_p_SourceToSinkOverFieldObjectDepth2(void);
void Bench_p_SourceToSinkOverTwoFieldsOfSameObjectInDepth1(void);
void Bench_p_SourceToSinkOverTwoFieldsOfSameObjectInMixedDepthJumpDistance1(void);
void Bench_p_SourceToSinkOverMultipleFieldsOfDifferentObjectsInMixedDepthMixedJumpDistance(void);

void Bench_n_NoLeakAfterResetObjectDepth1(void);

// DYNAMIC DISPATCH
void Bench_p_DynamicDispatchLeakChild(void);
void Bench_n_DynamicDispatchNoLeakChild(void);
void Bench_n_DynamicDispatchNoLeakParent(void);

// ALIASING - INTRA-PROCEDURAL
void Bench_p_SetObjectToAnotherLeak(void);
void Bench_n_SetObjectToAnotherNoLeak(void);
void Bench_p_AliasingIfElseLeak(int a);
void Bench_p_AliasingIfElseLeakNoOpt(int a);
void Bench_n_AliasingIfElseNoLeak(int a);

// ALIASING - INTER-PROCEDURAL
void Bench_p_AliasInSecondProcedureLeakAfterReturn(void);
void Bench_n_AliasInSecondProcedureNoLeakAfterReturn(void);
void Bench_p_AliasBeforeCallLeakInSecondProcedure(void);
void Bench_n_AliasBeforeCallNoLeakInSecondProcedure(void);

// CONTROL FLOW
void Bench_p_IfElseLeak(int a);
void Bench_n_IfElseNoLeak(int a);
void Bench_p_IfElseIfLeak(int a);
void Bench_n_IfElseIfNoLeak(int a);
void Bench_p_IfElseIfLeakDifferentFields(int a);

void Bench_n_IfElseIfNoLeakDifferentFields(int a);
void Bench_p_SwitchLeak(int a);
void Bench_n_SwitchNoLeak(int a);
void Bench_p_WhileLeak(int a);
void Bench_n_WhileNoLeak(int a);

void Bench_p_ForLeak(int a);
void Bench_n_ForNoLeak(int a);
void Bench_p_GotoLeak(int a);
void Bench_n_GotoNoLeak(int a);

// C-INTEROPERABILITY
void Bench_p_SourceToSinkCstyle(void);
void Bench_p_SourceToSinkCstyleOverVariable(void);
void Bench_p_SourceToSinkCstyleArithmeticAdd(void);
void Bench_p_SourceToSinkCstyleArithmeticMultiply(void);
void Bench_p_LeakOverGlobalCstyleStruct(void);

void Bench_n_NoLeakOverGlobalCstyleStruct(void);
void Bench_p_LeakOverGlobalCstyleStructFunction(void);
void Bench_n_NoLeakOverGlobalCstyleStructFunction(void);
void Bench_p_LeakOverLocalCstyleStruct(void);
void Bench_n_NoLeakOverLocalCstyleStruct(void);

void Bench_p_SourceToSinkCastIntToNSNumber(void);
void Bench_p_SourceToSinkCastNSNumberToInt(void);
void Bench_p_SourceToSinkCastNSNumberToStringToInt(void);



/*
 GLOBAL ENTETIES FOR MEMORY MODELLING
 */

typedef struct {
    __unsafe_unretained volatile GenericObject *first;
    __unsafe_unretained volatile GenericObject *second;
} NSNumberPairStruct;

void leakNSNumberPairStructSecondObject(NSNumberPairStruct pair) {
    [TaintObject sink:pair.second.numberField];
}

/*
 BENCHMARK FUNCTIONS
 IMPLEMENTATION
 */

/*
 Bench_p_SourceToSink
 
 simple direct source to sink data flow
 */
void Bench_p_SourceToSink(void) {
    NSNumber *information = [TaintObject source];
    [TaintObject sink:information];
}

/*
 Bench_n_SourceToSinkNoLeak
 
 source to sink without leak as the data is sinked before it was tainted
 */
void Bench_n_SourceToSinkNoLeak(void) {
    NSNumber *information = @0;
    [TaintObject sink:information];
    information = [TaintObject source];
}

/*
 Bench_n_SinkUninitializedField
 
 an uninitialized field is passed to the sink
 */
void Bench_n_SinkUninitializedField(void) {
    GenericObject *Generic = [[GenericObject alloc] init];
    
    [TaintObject sink:Generic.numberField];
}

/*
 Bench_p_SourceToSinkOverField
 
 simple direct source to sink data flow,
 where the data is stored in an object field
 */
void Bench_p_SourceToSinkOverField(void) {
    GenericObject *Generic = [[GenericObject alloc] init];
    
    Generic.numberField = [TaintObject source];
    [TaintObject sink:Generic.numberField];
}

/*
 Bench_p_SourceToSinkOverTwoFieldsOfSameObject
 
 simple direct source to sink data flow,
 where the data flow involves two object fields of the same object
 */
void Bench_p_SourceToSinkOverTwoFieldsOfSameObject(void) {
    GenericObject *Generic = [[GenericObject alloc] init];
    
    Generic.numberField = [TaintObject source];
    Generic.numberField2 = Generic.numberField;
    Generic.numberField = @0;
    [TaintObject sink:Generic.numberField2];
}

/*
 Bench_p_SourceToSinkOverMultipleFieldsOfSameObject
 
 simple direct source to sink data flow,
 where the data flow involves multiple object fields of the same object
 */
void Bench_p_SourceToSinkOverMultipleFieldsOfSameObject(void) {
    GenericObject *Generic = [[GenericObject alloc] init];
    
    Generic.numberField = [TaintObject source];
    Generic.numberField2 = Generic.numberField;
    Generic.numberField = @0;
    Generic.numberField3 = Generic.numberField2;
    Generic.numberField2 = @0;
    Generic.numberField4 = Generic.numberField3;
    Generic.numberField3 = @0;
    Generic.numberField5 = Generic.numberField4;
    Generic.numberField4 = @0;
    [TaintObject sink:Generic.numberField5];
}

/*
 Bench_p_SourceToSinkOverTwoFieldsOfDifferentObjects
 
 simple direct source to sink data flow,
 where the data flow involves two object fields of different objects
 */
void Bench_p_SourceToSinkOverTwoFieldsOfDifferentObjects(void) {
    GenericObject *Generic1 = [[GenericObject alloc] init];
    GenericObject *Generic2 = [[GenericObject alloc] init];
    
    Generic1.numberField = [TaintObject source];
    Generic2.numberField = Generic1.numberField;
    Generic1.numberField = @0;
    [TaintObject sink:Generic2.numberField];
}

/*
 Bench_p_SourceToSinkOverMultipleFieldsOfDifferentObjects
 
 simple direct source to sink data flow,
 where the data flow involves multiple object fields of different objects
 */
void Bench_p_SourceToSinkOverMultipleFieldsOfDifferentObjects(void) {
    GenericObject *Generic1 = [[GenericObject alloc] init];
    GenericObject *Generic2 = [[GenericObject alloc] init];
    GenericObject *Generic3 = [[GenericObject alloc] init];
    
    Generic1.numberField = [TaintObject source];
    Generic2.numberField2 = Generic1.numberField;
    Generic1.numberField = @0;
    Generic3.numberField3 = Generic2.numberField2;
    Generic2.numberField2 = @0;
    [TaintObject sink:Generic3.numberField3];
}

/*
 Bench_n_SourceToSinkTaintMultipleFieldsLeakNone
 
 taint multiple fields of the same object and leak no tainted field
 */
void Bench_n_SourceToSinkTaintMultipleFieldsLeakNone(void) {
    GenericObject *Generic = [[GenericObject alloc] init];
    
    Generic.numberField = [TaintObject source];
    Generic.numberField2 = [TaintObject source];
    Generic.numberField3 = [TaintObject source];
    
    [TaintObject sink:Generic.numberField4];
    [TaintObject sink:Generic.numberField5];
}

/*
 Bench_p_SourceToSinkTaintMultipleFieldsOnlyLeakOne
 
 taint multiple fields of the same object and leak only one tainted field
 */
void Bench_p_SourceToSinkTaintMultipleFieldsOnlyLeakOne(void) {
    GenericObject *Generic = [[GenericObject alloc] init];
    
    Generic.numberField = [TaintObject source];
    Generic.numberField2 = [TaintObject source];
    Generic.numberField3 = [TaintObject source];
    
    [TaintObject sink:Generic.numberField3];
    [TaintObject sink:Generic.numberField4];
    [TaintObject sink:Generic.numberField5];
}

/*
 Bench_p_SourceToSinkTaintMultipleFieldsLeakAll
 
 taint multiple fields of the same object and leak all tainted fields
 */
void Bench_p_SourceToSinkTaintMultipleFieldsLeakAll(void) {
    GenericObject *Generic = [[GenericObject alloc] init];
    
    Generic.numberField = [TaintObject source];
    Generic.numberField2 = [TaintObject source];
    Generic.numberField3 = [TaintObject source];
    
    [TaintObject sink:Generic.numberField];
    [TaintObject sink:Generic.numberField2];
    [TaintObject sink:Generic.numberField3];
    [TaintObject sink:Generic.numberField4];
    [TaintObject sink:Generic.numberField5];
}

/*
 Bench_n_SourceToSinkTaintMultipleFieldsLeakNone
 
 taint multiple fields of the different objects and leak no tainted field
 */
void Bench_n_SourceToSinkTaintMultipleFieldsOfDifferentObjectsLeakNone(void) {
    GenericObject *Generic1 = [[GenericObject alloc] init];
    GenericObject *Generic2 = [[GenericObject alloc] init];
    
    Generic1.numberField = [TaintObject source];
    Generic1.numberField2 = [TaintObject source];
    Generic1.numberField3 = [TaintObject source];
    
    Generic2.numberField = @0;
    Generic2.numberField2 = @0;
    Generic2.numberField3 = @0;
    
    [TaintObject sink:Generic2.numberField];
    [TaintObject sink:Generic2.numberField2];
    [TaintObject sink:Generic2.numberField3];
}

/*
 Bench_p_SourceToSinkTaintMultipleFieldsOfDifferentObjectsOnlyLeakOne
 
 taint multiple fields of the same object and leak only one tainted field
 */
void Bench_p_SourceToSinkTaintMultipleFieldsOfDifferentObjectsOnlyLeakOne(void) {
    GenericObject *Generic1 = [[GenericObject alloc] init];
    GenericObject *Generic2 = [[GenericObject alloc] init];
    
    Generic1.numberField = [TaintObject source];
    Generic1.numberField2 = [TaintObject source];
    Generic1.numberField3 = [TaintObject source];
    
    Generic2.numberField = @0;
    Generic2.numberField2 = @0;
    Generic2.numberField3 = @0;
    
    [TaintObject sink:Generic1.numberField];
    [TaintObject sink:Generic2.numberField2];
    [TaintObject sink:Generic2.numberField3];
}

/*
 Bench_p_SourceToSinkTaintMultipleFieldsOfDifferentObjectsLeakAll
 
 taint multiple fields of the different objects and leak all tainted fields
 */
void Bench_p_SourceToSinkTaintMultipleFieldsOfDifferentObjectsLeakAll(void) {
    GenericObject *Generic1 = [[GenericObject alloc] init];
    GenericObject *Generic2 = [[GenericObject alloc] init];
    
    Generic1.numberField = [TaintObject source];
    Generic1.numberField2 = [TaintObject source];
    Generic1.numberField3 = @0;
    
    Generic2.numberField = @0;
    Generic2.numberField2 = @0;
    Generic2.numberField3 = [TaintObject source];
    
    [TaintObject sink:Generic1.numberField];
    [TaintObject sink:Generic1.numberField2];
    [TaintObject sink:Generic2.numberField3];
}

/*
 Bench_p_SourceToSinkOverFieldObjectDepth1
 
 access the field of an object stored as property of another object,
 taint the field and pass it to the sink
 */
void Bench_p_SourceToSinkOverFieldObjectDepth1(void) {
    ObjectHolder *Holder = [[ObjectHolder alloc] init];
    
    Holder.object1 = [[GenericObject alloc] init];
    
    Holder.object1.numberField = [TaintObject source];
    [TaintObject sink:Holder.object1.numberField];
}

/*
 Bench_p_SourceToSinkOverFieldObjectDepth2
 
 access the field of an object stored as property of another object,
 stored as property of another object, taint the field and pass it to the sink
 */
void Bench_p_SourceToSinkOverFieldObjectDepth2(void) {
    ObjectHolder *Holder = [[ObjectHolder alloc] init];
    Holder.recursionHolder = [[ObjectHolder alloc] init];
    
    Holder.recursionHolder.object1 = [[GenericObject alloc] init];
    
    Holder.recursionHolder.object1.numberField = [TaintObject source];
    [TaintObject sink:Holder.recursionHolder.object1.numberField];
}

/*
 Bench_p_SourceToSinkOverTwoFieldsOfSameObjectInDepth1
 
 the taint flow involves two object fields of objects, stored as property of another object
 */
void Bench_p_SourceToSinkOverTwoFieldsOfSameObjectInDepth1(void) {
    ObjectHolder *Holder = [[ObjectHolder alloc] init];
    Holder.object1 = [[GenericObject alloc] init];
    Holder.object2 = [[GenericObject alloc] init];
    
    Holder.object1.numberField = [TaintObject source];
    Holder.object2.numberField = Holder.object1.numberField;
    Holder.object1.numberField = @0;
    
    [TaintObject sink:Holder.object2.numberField];
}

/*
 Bench_p_SourceToSinkOverTwoFieldsOfSameObjectInMixedDepthJumpDistance1
 
 the taint flow involves object fields of object properties in mixed depth, where
 the taint flow only differs by 1 in depth
 */
void Bench_p_SourceToSinkOverTwoFieldsOfSameObjectInMixedDepthJumpDistance1(void) {
    ObjectHolder *Holder = [[ObjectHolder alloc] init];
    
    Holder.recursionHolder = [[ObjectHolder alloc] init];
    Holder.recursionHolder.recursionHolder = [[ObjectHolder alloc] init];
    
    // way down
    Holder.object1 = [[GenericObject alloc] init];
    Holder.recursionHolder.object1 = [[GenericObject alloc] init];
    Holder.recursionHolder.recursionHolder.object1 = [[GenericObject alloc] init];
    
    // way up
    Holder.object2 = [[GenericObject alloc] init];
    Holder.recursionHolder.object2 = [[GenericObject alloc] init];
    Holder.recursionHolder.recursionHolder.object2 = [[GenericObject alloc] init];
    
    // taint flow
    Holder.object1.numberField = [TaintObject source];
    
    Holder.recursionHolder.object1.numberField = Holder.object1.numberField;
    Holder.object1.numberField = @0;
    Holder.recursionHolder.recursionHolder.object1.numberField = Holder.recursionHolder.object1.numberField;
    Holder.recursionHolder.object1.numberField = @0;
    
    Holder.recursionHolder.recursionHolder.object2.numberField = Holder.recursionHolder.recursionHolder.object1.numberField;
    Holder.recursionHolder.recursionHolder.object1.numberField = @0;
    
    Holder.recursionHolder.object2.numberField = Holder.recursionHolder.recursionHolder.object2.numberField;
    Holder.recursionHolder.recursionHolder.object2.numberField = @0;
    Holder.object2.numberField = Holder.recursionHolder.object2.numberField;
    Holder.recursionHolder.object2.numberField = @0;
    
    [TaintObject sink:Holder.object2.numberField];
}

/*
 Bench_p_SourceToSinkOverTwoFieldsOfSameObjectInMixedDepthMixedJumpDistance
 
 the taint flow involves object fields of object properties in mixed depth
 */
void Bench_p_SourceToSinkOverMultipleFieldsOfDifferentObjectsInMixedDepthMixedJumpDistance(void) {
    ObjectHolder *Holder = [[ObjectHolder alloc] init];
    
    Holder.recursionHolder = [[ObjectHolder alloc] init];
    Holder.recursionHolder.recursionHolder = [[ObjectHolder alloc] init];
    
    Holder.object1 = [[GenericObject alloc] init];
    Holder.recursionHolder.object1 = [[GenericObject alloc] init];
    Holder.recursionHolder.recursionHolder.object1 = [[GenericObject alloc] init];
    Holder.object2 = [[GenericObject alloc] init];
    Holder.recursionHolder.object2 = [[GenericObject alloc] init];
    Holder.recursionHolder.recursionHolder.object2 = [[GenericObject alloc] init];
    
    // taint flow
    Holder.recursionHolder.recursionHolder.object2.numberField = [TaintObject source];
    
    Holder.object1.numberField = Holder.recursionHolder.recursionHolder.object2.numberField;
    Holder.recursionHolder.recursionHolder.object2.numberField = @0;
    Holder.recursionHolder.object1.numberField = Holder.object1.numberField;
    Holder.object1.numberField = @0;
    Holder.recursionHolder.recursionHolder.object1.numberField = Holder.recursionHolder.object1.numberField;
    Holder.recursionHolder.object1.numberField = @0;
    
    [TaintObject sink:Holder.recursionHolder.recursionHolder.object1.numberField];
}

/*
 Bench_p_SourceToSinkOverFieldNoInternalSetter
 
 simple direct source to sink data flow,
 where the data is stored in an object field
 and the internal setter methods are avoided
 */
void Bench_p_SourceToSinkOverFieldNoInternalSetter(void) {
    GenericObject *Generic = [[GenericObject alloc] init];
    [Generic SourceToSinkOverFieldNoInternalSetter];
}

/*
 Bench_p_SourceToSinkOverTwoFieldsOfSameObjectNoInternalSetter
 
 simple direct source to sink data flow,
 where the data flow involves two object fields of the same object
 and the internal setter methods are avoided
 */
void Bench_p_SourceToSinkOverTwoFieldsOfSameObjectNoInternalSetter(void) {
    GenericObject *Generic = [[GenericObject alloc] init];
    [Generic SourceToSinkOverTwoFieldsOfSameObjectNoInternalSetter];
}

/*
 Bench_p_SourceToSinkCstyle
 
 simple direct source to sink data flow of an integer
 */
void Bench_p_SourceToSinkCstyle(void) {
    int x = [TaintObject sourceCstyle];
    [TaintObject sinkCstyle:x];
}

/*
 Bench_p_SourceToSinkCstyleOverVariable
 
 simple direct source to sink data flow by assignments of integers
 */
void Bench_p_SourceToSinkCstyleOverVariable(void) {
    int x = [TaintObject sourceCstyle];
    int y = x;
    x = 0;
    [TaintObject sinkCstyle:y];
}

/*
 Bench_p_SourceToSinkCstyleArithmeticAdd
 
 simple direct source to sink data where a number is added to the passed integer
 */
void Bench_p_SourceToSinkCstyleArithmeticAdd(void) {
    int x = [TaintObject sourceCstyle];
    x++;
    [TaintObject sinkCstyle:x];
}

/*
 Bench_p_SourceToSinkCstyleArithmeticMultiply
 
 simple direct source to sink data where the passed integer is multiplied by some number
 */
void Bench_p_SourceToSinkCstyleArithmeticMultiply(void) {
    int x = [TaintObject sourceCstyle];
    x = x*7;
    [TaintObject sinkCstyle:x];
}

/*
 Bench_n_LeakUntaintedField
 
 leak of an untainted object field
 */
void Bench_n_LeakUntaintedField(void) {
    GenericObject *Generic = [[GenericObject alloc] init];
    
    Generic.numberField = [TaintObject source];
    Generic.numberField2 = @0;
    [TaintObject sink:Generic.numberField2];
}

/*
 Bench_p_LeakTaintedField
 
 leak of a tainted object field
 */
void Bench_p_LeakTaintedField(void) {
    GenericObject *Generic = [[GenericObject alloc] init];
    
    Generic.numberField = [TaintObject source];
    Generic.numberField2 = @0;
    [TaintObject sink:Generic.numberField];
}

/*
 Bench_p_LeakTaintedAndUntaintedFields
 
 leak of tainted and untainted object fields
 first the tainted field is leaked, then the untainted
 */
void Bench_p_LeakTaintedAndUntaintedField(void) {
    GenericObject *Generic = [[GenericObject alloc] init];
    
    Generic.numberField = [TaintObject source];
    Generic.numberField2 = @0;
    [TaintObject sink:Generic.numberField];
    [TaintObject sink:Generic.numberField2];
}

/*
 Bench_n_TaintFieldThenOverwrite
 
 taint a field, overwrite it with untainted data, then leak
 */
void Bench_n_TaintFieldThenOverwrite(void) {
    GenericObject *Generic = [[GenericObject alloc] init];
    
    Generic.numberField = [TaintObject source];
    Generic.numberField = @0;
    [TaintObject sink:Generic.numberField];
}

/*
 Bench_p_TaintAndSanitizeFieldRepeatedly
 
 repeatedly taint a field, leak, overwrite it with untainted data, leak
 */
void Bench_p_TaintAndSanitizeFieldRepeatedly(void) {
    GenericObject *Generic = [[GenericObject alloc] init];
    
    Generic.numberField = [TaintObject source];
    [TaintObject sink:Generic.numberField];
    Generic.numberField = @0;
    [TaintObject sink:Generic.numberField];
    Generic.numberField = [TaintObject source];
    [TaintObject sink:Generic.numberField];
    Generic.numberField = @0;
    [TaintObject sink:Generic.numberField];
}

/*
 Bench_p_StaticPropertyLeakOverDifferentObjects
 
 taint the static property with the set method using one object
 then leak the static property with the get method using another object
 */
void Bench_p_StaticPropertyLeakOverDifferentObjects(void) {
    GenericObject *Generic1 = [[GenericObject alloc] init];
    GenericObject *Generic2 = [[GenericObject alloc] init];
    
    [Generic1 setStaticNumber:[TaintObject source]];
    [TaintObject sink:[Generic2 getStaticNumber]];
}

/*
 Bench_p_FieldToStaticPropertyToFieldLeak
 
 taint the field of an object, then set the static property to a field value,
 set the field value of another object to the tainted static property, then leak
 */
void Bench_p_FieldToStaticPropertyToFieldLeak(void) {
    GenericObject *Generic1 = [[GenericObject alloc] init];
    GenericObject *Generic2 = [[GenericObject alloc] init];
    
    Generic1.numberField = [TaintObject source];
    [Generic1 setStaticNumber:Generic1.numberField];
    Generic2.numberField = [Generic2 getStaticNumber];
    
    [TaintObject sink:Generic2.numberField];
}

/*
 Bench_p_SetObjectToAnotherLeak
 
 create two instances of GenericObject, taint a field of the first one,
 then set both objects equal, i.e. the ID pointer of the second object points to the first one
 meaning that now accessing a field of the second object is effectively simply accessing the
 corresponding field of the first object
 */
void Bench_p_SetObjectToAnotherLeak(void) {
    GenericObject *Generic1 = [[GenericObject alloc] init];
    GenericObject *Generic2 = [[GenericObject alloc] init];
    
    Generic1.numberField = [TaintObject source];
    
    Generic2 = Generic1;
    
    [TaintObject sink:Generic2.numberField];
}

/*
 Bench_n_SetObjectToAnotherNoLeak
 
 create two instances of GenericObject, taint a field of the first one,
 then set both objects equal such that the ID pointer of the first object points to the second one
 meaning that now accessing a field of the first object is effectively simply accessing the
 corresponding field of the second object and hence, this results in no leak
 */
void Bench_n_SetObjectToAnotherNoLeak(void) {
    GenericObject *Generic1 = [[GenericObject alloc] init];
    GenericObject *Generic2 = [[GenericObject alloc] init];
    
    Generic1.numberField = [TaintObject source];
    Generic2.numberField = @0;
    
    Generic1 = Generic2;
    
    [TaintObject sink:Generic1.numberField];
}

/*
 Bench_p_LeakOverGlobalCstyleStruct
 
 a field of an object is tainted, the ID pointer is stored in a C style struct
 then the tainted field is accessed via the stored pointer and leaked
 */
void Bench_p_LeakOverGlobalCstyleStruct(void) {
    GenericObject *object1 = [[GenericObject alloc] init];
    GenericObject *object2 = [[GenericObject alloc] init];
    
    object1.numberField = @0;
    object2.numberField = [TaintObject source];
    
    NSNumberPairStruct pair;
    pair.first = object1;
    pair.second = object2;
    
    [TaintObject sink:pair.second.numberField];
}

/*
 Bench_n_NoLeakOverGlobalCstyleStruct
 
 a field of an object is tainted, the ID pointer is stored in a C style struct
 then the untainted field is accessed via the stored pointer and leaked
 */
void Bench_n_NoLeakOverGlobalCstyleStruct(void) {
    GenericObject *object1 = [[GenericObject alloc] init];
    GenericObject *object2 = [[GenericObject alloc] init];
    
    object1.numberField = @0;
    object2.numberField = [TaintObject source];
    
    NSNumberPairStruct pair;
    pair.first = object2;
    pair.second = object1;
    
    [TaintObject sink:pair.second.numberField];
}


/*
 Bench_p_LeakOverGlobalCstyleStructFunction
 
 a field of an object is tainted, the ID pointer is stored in a C style struct
 then the tainted field is accessed in another function via the stored pointer and leaked
 */
void Bench_p_LeakOverGlobalCstyleStructFunction(void) {
    GenericObject *object1 = [[GenericObject alloc] init];
    GenericObject *object2 = [[GenericObject alloc] init];
    
    object1.numberField = @0;
    object2.numberField = [TaintObject source];
    
    NSNumberPairStruct pair;
    pair.first = object1;
    pair.second = object2;
    
    leakNSNumberPairStructSecondObject(pair);
}

/*
 Bench_n_NoLeakOverGlobalCstyleStructFunction
 
 a field of an object is tainted, the ID pointer is stored in a C style struct
 then the untainted field is accessed in another function via the stored pointer and leaked
 */
void Bench_n_NoLeakOverGlobalCstyleStructFunction(void) {
    GenericObject *object1 = [[GenericObject alloc] init];
    GenericObject *object2 = [[GenericObject alloc] init];
    
    object1.numberField = @0;
    object2.numberField = [TaintObject source];
    
    NSNumberPairStruct pair;
    pair.first = object2;
    pair.second = object1;
    
    leakNSNumberPairStructSecondObject(pair);
}

/*
 Bench_p_LeakOverLocalCstyleStruct
 
 this case is analogous to the global case, now the struct is only in the local
 function scope and can not be accessed elsewhere
 */
void Bench_p_LeakOverLocalCstyleStruct(void) {
    
    // use volatile to avoid optimization interference
    typedef struct {
        __unsafe_unretained volatile GenericObject *first;
        __unsafe_unretained volatile GenericObject *second;
    } NSNumberPairLocalStruct;
    
    GenericObject *object1 = [[GenericObject alloc] init];
    GenericObject *object2 = [[GenericObject alloc] init];
    
    object1.numberField = @0;
    object2.numberField = [TaintObject source];
    
    NSNumberPairLocalStruct pair;
    pair.first = object1;
    pair.second = object2;
    
    [TaintObject sink:pair.second.numberField];
}

/*
 Bench_n_NoLeakOverLocalCstyleStruct
 
 this case is analogous to the global case, now the struct is only in the local
 function scope and can not be accessed elsewhere
 */
void Bench_n_NoLeakOverLocalCstyleStruct(void) {
    
    // use volatile to avoid optimization interference
    typedef struct {
        __unsafe_unretained volatile GenericObject *first;
        __unsafe_unretained volatile GenericObject *second;
    } NSNumberPairLocalStruct;
    
    GenericObject *object1 = [[GenericObject alloc] init];
    GenericObject *object2 = [[GenericObject alloc] init];
    
    object1.numberField = @0;
    object2.numberField = [TaintObject source];
    
    NSNumberPairLocalStruct pair;
    pair.first = object2;
    pair.second = object1;
    
    [TaintObject sink:pair.second.numberField];
}

/*
 Bench_p_DynamicDispatchLeakChild
 
 creates an instance of GenericObject via GenericChild constructor, then
 calls the dynamicDispatchTaint function that dispatches to the GenericChild
 implementation during runtime
 */
void Bench_p_DynamicDispatchLeakChild(void) {
    GenericObject *Generic = [[GenericChild alloc] init];
    
    [TaintObject taintDynamicDispatch:Generic];
    [TaintObject sink:Generic.numberField];
}

/*
 Bench_n_DynamicDispatchNoLeakChild
 
 creates an instance of GenericObject via GenericChild constructor, then
 calls the dynamicDispatchNoTaint function that dispatches to the GenericChild
 implementation during runtime
 */
void Bench_n_DynamicDispatchNoLeakChild(void) {
    GenericObject *Generic = [[GenericChild alloc] init];
    
    [TaintObject taintNotDynamicDispatch:Generic];
    [TaintObject sink:Generic.numberField];
}

/*
 Bench_n_DynamicDispatchNoLeakParent
 
 simply calls the parent function without an actual dispatch for comparison of the cases
 */
void Bench_n_DynamicDispatchNoLeakParent(void) {
    GenericObject *Generic = [[GenericObject alloc] init];
    
    [TaintObject taintDynamicDispatch:Generic];
    [TaintObject sink:Generic.numberField];
}

/*
 Bench_p_SourceToSinkCastIntToNSNumber
 
 here the source function is sourceCtype and the sink is the usual sink
 function, taking a NSNumber object
 
 the dataflow involves a cast
 */
void Bench_p_SourceToSinkCastIntToNSNumber(void) {
    int x = [TaintObject sourceCstyle];
    [TaintObject sink:@(x)];
}

/*
 Bench_p_SourceToSinkCastNSNumberToInt
 
 here the source function is the usual source and the sink is the sinkCstyle
 function, taking an integer
 
 the dataflow involves a cast
 */
void Bench_p_SourceToSinkCastNSNumberToInt(void) {
    NSNumber *number = [TaintObject source];
    [TaintObject sinkCstyle:[number intValue]];
}

/*
 Bench_p_SourceToSinkCastNSNumberToStringToInt
 
 here the source function is the usual source and the sink is the sinkCstyle
 function, taking an integer
 
 the dataflow involves a cast to a NSString, which is then casted to an integer
 */
void Bench_p_SourceToSinkCastNSNumberToStringToInt(void) {
    int x = [TaintObject sourceCstyle];
    NSString *numberString = [NSString stringWithFormat:@"%d", x];
    [TaintObject sink:@([numberString intValue])];
}

/*
 Bench_p_SourceToSinkLeakInSecondProcedure
 
 data from the source is obtained and stored in an object field,
 then the field is passed to a class function
 in which the passed field is leaked
 */
void Bench_p_SourceToSinkLeakInSecondProcedure(void) {
    GenericObject *Generic = [[GenericObject alloc] init];
    
    Generic.numberField = [TaintObject source];
    [GenericObject leakFunction:Generic.numberField];
}

/*
 Bench_n_SourceToSinkNoLeakInSecondProcedure
 
 data from the source is obtained and stored in an object field,
 then the field is passed to a class function
 in which the passed field is not leaked
 */
void Bench_n_SourceToSinkNoLeakInSecondProcedure(void) {
    GenericObject *Generic = [[GenericObject alloc] init];
    
    Generic.numberField = [TaintObject source];
    [GenericObject noLeakFunction:Generic.numberField];
}

/*
 Bench_p_SourceToSinkLeakInSecondProcedurePassingObject
 
 data from the source is obtained and stored in an object field,
 then the object is passed to a class function
 in which the number field is leaked
 */
void Bench_p_SourceToSinkLeakInSecondProcedurePassingObject(void) {
    GenericObject *Generic = [[GenericObject alloc] init];
    
    Generic.numberField = [TaintObject source];
    [GenericObject leakFunctionObject:Generic];
}

/*
 Bench_n_SourceToSinkNoLeakInSecondProcedurePassingObject
 
 data from the source is obtained and stored in an object field,
 then the object is passed to a class function
 in which the number field is not leaked
 */
void Bench_n_SourceToSinkNoLeakInSecondProcedurePassingObject(void) {
    GenericObject *Generic = [[GenericObject alloc] init];
    
    Generic.numberField = [TaintObject source];
    [GenericObject noLeakFunctionObject:Generic];
}

/*
 Bench_p_SourceToSinkLeakInSecondProcedureOverLocalVariable
 
 data from the source is obtained and stored in an object field,
 then the object is passed to a class function
 in which the number field is leaked where the dataflow involves
 an additional local variable
 */
void Bench_p_SourceToSinkLeakInSecondProcedureOverLocalVariable(void) {
    GenericObject *Generic = [[GenericObject alloc] init];
    
    Generic.numberField = [TaintObject source];
    [GenericObject leakFunctionObjectOverLocalVariable:Generic];
}

/*
 Bench_n_SourceToSinkNoLeakInSecondProcedureOverLocalVariable
 
 data from the source is obtained and stored in an object field,
 then the object is passed to a class function
 in which the number field is not leaked where the dataflow involves
 an additional local variable
 */
void Bench_n_SourceToSinkNoLeakInSecondProcedureOverLocalVariable(void) {
    GenericObject *Generic = [[GenericObject alloc] init];
    
    Generic.numberField = [TaintObject source];
    [GenericObject noLeakFunctionObjectOverLocalVariable:Generic];
}

/*
 Bench_p_SourceToSinkLeakAfterOneRecursion
 
 data from source is obtained and stored in an object field,
 then the field is passed to a recursive class function, calling
 itself just once
 then, the field is leaked
 */
void Bench_p_SourceToSinkLeakAfterOneRecursion(void) {
    GenericObject *Generic = [[GenericObject alloc] init];
    
    Generic.numberField = [TaintObject source];
    
    [GenericObject recursiveFunction:0 :Generic.numberField];
}


/*
 Bench_p_IfElseLeak
 
 a simple if-else structure, an object field is tainted in one branch and then leaked
 */
void Bench_p_IfElseLeak(int a) {
    GenericObject *Generic = [[GenericObject alloc] init];
    
    if(a==1) {
        Generic.numberField = @0;
    }
    else {
        Generic.numberField = [TaintObject source];
    }
    
    [TaintObject sink:Generic.numberField];
}

/*
 Bench_n_IfElseNoLeak
 
 a simple if-else structure, an object field is tainted and then sanitized in every branch
 */
void Bench_n_IfElseNoLeak(int a) {
    GenericObject *Generic = [[GenericObject alloc] init];
    Generic.numberField = [TaintObject source];
    
    if(a==0) {
        Generic.numberField = @0;
    }
    else {
        Generic.numberField = @1;
    }
    
    [TaintObject sink:Generic.numberField];
}

/*
 Bench_p_IfElseIfLeak
 
 a simple if-else_if structure, an object field is tainted in one branch and then leaked
 */
void Bench_p_IfElseIfLeak(int a) {
    GenericObject *Generic = [[GenericObject alloc] init];
    
    if(a==1) {
        Generic.numberField = @1;
    }
    else if(a==2) {
        Generic.numberField = @2;
    }
    else if(a==0) {
        Generic.numberField = [TaintObject source];
    }
    else {
        Generic.numberField = @0;
    }
    
    [TaintObject sink:Generic.numberField];
}


/*
 Bench_n_IfElseIfNoLeak
 
 a simple if-else_if structure, an object field is tainted and then sanitized in every branch
 */
void Bench_n_IfElseIfNoLeak(int a) {
    GenericObject *Generic = [[GenericObject alloc] init];
    Generic.numberField = [TaintObject source];
    
    if(a==1) {
        Generic.numberField = @1;
    }
    else if(a==2) {
        Generic.numberField = @2;
    }
    else if(a==0) {
        Generic.numberField = @0;
    }
    else {
        Generic.numberField = @-1;
    }
    
    [TaintObject sink:Generic.numberField];
}

/*
 Bench_p_IfElseIfLeakDifferentFields
 
 a simple if-else_if structure, different object fields are tainted, one among them that is leaked afterwards
 */
void Bench_p_IfElseIfLeakDifferentFields(int a) {
    GenericObject *Generic = [[GenericObject alloc] init];
    
    if(a==0) {
        Generic.numberField = [TaintObject source];
    }
    else if(a==2) {
        Generic.numberField2 = [TaintObject source];
    }
    else if(a==3) {
        Generic.numberField3 = [TaintObject source];
    }
    else if(a==4) {
        Generic.numberField4 = [TaintObject source];
    }
    else {
        Generic.numberField5 = [TaintObject source];
    }
    
    [TaintObject sink:Generic.numberField];
}

/*
 Bench_n_IfElseIfNoLeakDifferentFields
 
 a simple if-else_if structure, some object fields are tainted, then different object fields are tainted/sanitized in the branches,
 the leaked object field however was never tainted, resulting in no leak
 */
void Bench_n_IfElseIfNoLeakDifferentFields(int a) {
    GenericObject *Generic = [[GenericObject alloc] init];
    Generic.numberField = @0;
    Generic.numberField2 = [TaintObject source];
    Generic.numberField3 = [TaintObject source];
    
    if(a==2) {
        Generic.numberField2 = @0;
    }
    else if(a==3) {
        Generic.numberField3 = @0;
    }
    else {
        Generic.numberField4 = [TaintObject source];
    }
    
    [TaintObject sink:Generic.numberField];
}

/*
 Bench_p_SwitchLeak
 
 a simple switch structure, in one branch the object field that is leaked afterwards is tainted
 */
void Bench_p_SwitchLeak(int a) {
    GenericObject *Generic = [[GenericObject alloc] init];
    
    switch(a) {
        case 1: {
            Generic.numberField = @1;
            break;
        }
        case 2: {
            Generic.numberField = @2;
            break;
        }
        case 0: {
            Generic.numberField = [TaintObject source];
            break;
        }
        default: {
            Generic.numberField = @0;
            break;
        }
    }
    [TaintObject sink:Generic.numberField];
}


/*
 Bench_n_SwitchNoLeak
 
 a simple switch structure, an object field is tainted and then sanitized in every branch
 */
void Bench_n_SwitchNoLeak(int a) {
    GenericObject *Generic = [[GenericObject alloc] init];
    Generic.numberField = [TaintObject source];
    
    switch(a) {
        case 1: {
            Generic.numberField = @1;
            break;
        }
        case 2: {
            Generic.numberField = @2;
            break;
        }
        case 0: {
            Generic.numberField = @0;
            break;
        }
        default: {
            Generic.numberField = @-1;
            break;
        }
    }
    [TaintObject sink:Generic.numberField];
}

/*
 Bench_p_WhileLeak
 
 a simple while loop, where an object field is tainted in the body and leaked afterwards
 */
void Bench_p_WhileLeak(int a) {
    GenericObject *Generic = [[GenericObject alloc] init];
    Generic.numberField = @0;
    
    while(a<1) {
        Generic.numberField = [TaintObject source];
        a++;
    }
    
    [TaintObject sink:Generic.numberField];
}


/*
 Bench_n_WhileNoLeak
 
 a simple while loop, where the leaked field is not tainted
 */
void Bench_n_WhileNoLeak(int a) {
    GenericObject *Generic = [[GenericObject alloc] init];
    Generic.numberField = @0;
    Generic.numberField2 = @0;
    
    while(a<1) {
        Generic.numberField = [TaintObject source];
        a++;
    }
    
    Generic.numberField = Generic.numberField2;
    
    [TaintObject sink:Generic.numberField];
}


/*
 Bench_p_ForLeak
 
 a simple for loop, where an object field is tainted in the body and leaked afterwards
 */
void Bench_p_ForLeak(int a) {
    GenericObject *Generic = [[GenericObject alloc] init];
    Generic.numberField = @0;
    
    for(a = 0; a<1; a++) {
        Generic.numberField = [TaintObject source];
    }
    
    [TaintObject sink:Generic.numberField];
}


/*
 Bench_n_ForNoLeak
 
 a simple for loop, where the leaked field is not tainted
 */
void Bench_n_ForNoLeak(int a) {
    GenericObject *Generic = [[GenericObject alloc] init];
    Generic.numberField = @0;
    Generic.numberField2 = @0;
    
    for(a = 0; a<1; a++) {
        Generic.numberField = [TaintObject source];
    }
    
    Generic.numberField = Generic.numberField2;
    
    [TaintObject sink:Generic.numberField];
}

/*
 Bench_p_GotoLeak
 
 a simple goto loop structure resulting in the leak of a tainted object field
 */
void Bench_p_GotoLeak(int a) {
    GenericObject *Generic = [[GenericObject alloc] init];
    
start:
    if(a<1) {
        Generic.numberField = [TaintObject source];
        a++;
        goto start;
    }
    goto end;
    
end:
    [TaintObject sink:Generic.numberField];
}

/*
 Bench_n_GotoNoLeak
 
 a simple goto loop structure where the leaked field is not tainted
 */
void Bench_n_GotoNoLeak(int a) {
    GenericObject *Generic = [[GenericObject alloc] init];
    Generic.numberField = @0;
    Generic.numberField2 = @0;
    
start:
    if(a<1) {
        Generic.numberField = [TaintObject source];
        a++;
        goto start;
    }
    goto end;
    
end:
    Generic.numberField = Generic.numberField2;
    [TaintObject sink:Generic.numberField];
}

/*
 Bench_n_NoLeakAfterPassingNSNumberObjectReference
 
 a NSNumber object is passed to a function, i.e. actually a reference to the
 original object is passed and stored in a local variable, then the source function
 is called inside this function resulting in a change of the local variable holding
 now a reference to a tainted NSNumber object
 
 after returning from the function there is no change of the original NSNumber object
 */
void Bench_n_NoLeakAfterPassingNSNumberObjectReference(void) {
    NSNumber *information = @0;
    
    [TaintObject taintNSNumberNoEffect:information];
    [TaintObject sink:information];
}

/*
 Bench_p_LeakAfterPassingGenericObjectReference
 
 a GenericObject reference is passed to a function, i.e. the ID pointer is stored
 in a local variable allowing to access the number field of the original object
 this field is updated with a tainted NSNumber object, resulting in a leak after
 returning from the function
 */
void Bench_p_LeakAfterPassingGenericObjectReference(void) {
    GenericObject *Generic = [[GenericObject alloc] init];
    
    [TaintObject taintNSNumberField:Generic];
    [TaintObject sink:Generic.numberField];
}

/*
 Bench_p_SetStaticPropertyInSecondProcedureLeak
 
 the static property gets tainted in a second procedure
 and leaked afterwards
 */
void Bench_p_SetStaticPropertyInSecondProcedureLeak(void) {
    [TaintObject taintStaticPropertyOfGenericObject];
    
    GenericObject *Generic = [[GenericObject alloc] init];
    [TaintObject sink:[Generic getStaticNumber]];
}

/*
 Bench_n_SetStaticPropertyInSecondProcedureLeak
 
 the static property gets tainted in a second procedure,
 sanitized and then reaches the sink, resulting in no leak
 */
void Bench_n_SetStaticPropertyInSecondProcedureNoLeak(void) {
    [TaintObject taintStaticPropertyOfGenericObject];
    
    GenericObject *Generic = [[GenericObject alloc] init];
    [Generic setStaticNumber:@0];
    [TaintObject sink:[Generic getStaticNumber]];
}


/*
 Bench_p_LeakAfterTaintInInitialization
 
 the numerField field is tainted right in the initialization, to catch the taint
 it is necessary to correctly run through the initializing function, resulting in a leak
 */
void Bench_p_LeakAfterTaintInInitialization(void) {
    GenericObject *Generic = [[GenericObject alloc] initWithTaint];
    [TaintObject sink:Generic.numberField];
}

/*
 Bench_p_LeakAfterInheritanceConstructor
 
 taints a field of a GenericObject instance, constructs an instance of the child
 class and inherits all properties via the constructor, then leaks the tainted field
 */
void Bench_p_LeakAfterInheritanceConstructor(void) {
    GenericObject *Generic = [[GenericObject alloc] init];
    
    Generic.numberField = [TaintObject source];
    
    GenericChild *Child = [[GenericChild alloc] initWithGenericObject:Generic];
    
    [TaintObject sink:Child.numberField];
}

/*
 Bench_p_LeakAfterTaintingMultipleFieldsOfSameObjectInSecondProcedure
 
 taints multiple fields of a passed object and leaks tainted fields after returning from
 the function
 */
void Bench_p_LeakAfterTaintingMultipleFieldsOfSameObjectInSecondProcedure(void) {
    GenericObject *Generic = [[GenericObject alloc] init];
    
    [TaintObject taintMultipleNumberFields:Generic];
    
    [TaintObject sink:Generic.numberField];
    [TaintObject sink:Generic.numberField2];
    [TaintObject sink:Generic.numberField3];
}


/*
 Bench_n_NoLeakAfterTaintingMultipleFieldsOfSameObjectInSecondProcedure
 
 taints multiple fields of a passed object and leaks untainted fields after returning from
 the function
 */
void Bench_n_NoLeakAfterTaintingMultipleFieldsOfSameObjectInSecondProcedure(void) {
    GenericObject *Generic = [[GenericObject alloc] init];
    
    [TaintObject taintMultipleNumberFields:Generic];
    
    [TaintObject sink:Generic.numberField4];
    [TaintObject sink:Generic.numberField5];
}

/*
 Bench_p_LeakAfterPassingTwoObjectsToSecondProcedureAndTaintingMultipleFields
 
 taints multiple fields of two passed objects and leaks tainted fields after returning from
 the function
 */
void Bench_p_LeakAfterPassingTwoObjectsToSecondProcedureAndTaintingMultipleFields(void) {
    GenericObject *Generic1 = [[GenericObject alloc] init];
    GenericObject *Generic2 = [[GenericObject alloc] init];
    
    [TaintObject taintMultipleNumberFieldsOfTwoObjects:Generic1 :Generic2];
    
    [TaintObject sink:Generic1.numberField];
    [TaintObject sink:Generic1.numberField2];
    
    [TaintObject sink:Generic2.numberField];
    [TaintObject sink:Generic2.numberField2];
}

/*
 Bench_n_LeakAfterPassingTwoObjectsToSecondProcedureAndTaintingMultipleFields
 
 taints multiple fields of two passed objects and leaks untainted fields after returning from
 the function
 */
void Bench_n_NoLeakAfterPassingTwoObjectsToSecondProcedureAndTaintingMultipleFields(void) {
    GenericObject *Generic1 = [[GenericObject alloc] init];
    GenericObject *Generic2 = [[GenericObject alloc] init];
    
    [TaintObject taintMultipleNumberFieldsOfTwoObjects:Generic1 :Generic2];
    
    [TaintObject sink:Generic1.numberField4];
    [TaintObject sink:Generic1.numberField5];
    
    [TaintObject sink:Generic2.numberField4];
    [TaintObject sink:Generic2.numberField5];
}

/*
 Bench_p_LeakAfterSwappingFieldsOfSameObject
 
 taints number field 2, swaps number field 2 and 3 in called function, then
 leaks number field 3, resulting in a leak
 */
void Bench_p_LeakAfterSwappingFieldsOfSameObject(void) {
    GenericObject *Generic = [[GenericObject alloc] init];
    
    Generic.numberField2 = [TaintObject source];
    Generic.numberField3 = @0;
    [Generic SwapNumberField2and3];
    [TaintObject sink:Generic.numberField3];
}

/*
 Bench_n_NoLeakAfterSwappingFieldsOfSameObject
 
 taints number field 2, swaps number field 2 and 3 in called function, then
 leaks number field 2, resulting in no leak
 */
void Bench_n_NoLeakAfterSwappingFieldsOfSameObject(void) {
    GenericObject *Generic = [[GenericObject alloc] init];
    
    Generic.numberField2 = [TaintObject source];
    Generic.numberField3 = @0;
    [Generic SwapNumberField2and3];
    [TaintObject sink:Generic.numberField2];
}

/*
 Bench_p_LeakAfterSwappingFieldsOfDifferentObjects
 
 taints numberField of first, swaps the numberField fields of first and second object,
 then leaks the numberField of second object resulting in a leak
 */
void Bench_p_LeakAfterSwappingFieldsOfDifferentObjects(void) {
    GenericObject *Generic1 = [[GenericObject alloc] init];
    GenericObject *Generic2 = [[GenericObject alloc] init];
    
    Generic1.numberField = [TaintObject source];
    Generic2.numberField = @0;
    
    [GenericObject SwapNumberFieldObject1WithNumberFieldObject2:Generic1 :Generic2];
    
    [TaintObject sink:Generic2.numberField];
}

/*
 Bench_n_NoLeakAfterSwappingFieldsOfDifferentObjects
 
 taints numberField of first, swaps the numberField fields of first and second object,
 then leaks the numberField of the first object resulting in no leak
 */
void Bench_n_NoLeakAfterSwappingFieldsOfDifferentObjects(void) {
    GenericObject *Generic1 = [[GenericObject alloc] init];
    GenericObject *Generic2 = [[GenericObject alloc] init];
    
    Generic1.numberField = [TaintObject source];
    Generic2.numberField = @0;
    
    [GenericObject SwapNumberFieldObject1WithNumberFieldObject2:Generic1 :Generic2];
    
    [TaintObject sink:Generic1.numberField];
}

/*
 Bench_n_NoLeakAfterResetObjectDepth1
 
 resets all fields of an object, that is stored as a property by external access
 */
void Bench_n_NoLeakAfterResetObjectDepth1(void) {
    ObjectHolder *Holder = [[ObjectHolder alloc] init];
    
    Holder.object1 = [[GenericObject alloc] init];
    Holder.object1.numberField = [TaintObject source];
    
    [Holder resetObject1];
    [TaintObject sink:Holder.object1.numberField];
}

/*
 Bench_p_WriteThenReadGlobalVariableIntraproceduralLeak
 
 taints a static property and leaks it immediately
 */
void Bench_p_WriteThenReadGlobalVariableIntraproceduralLeak(void) {
    GenericObject *Generic = [[GenericObject alloc] init];
    
    [Generic setStaticNumber:[TaintObject source]];
    [TaintObject sink:[Generic getStaticNumber]];
}

/*
 Bench_n_WriteThenReadGlobalVariableIntraproceduralNoLeak
 
 taints a static property, sanitizes and leaks it, resulting in no leak
 */
void Bench_n_WriteThenReadGlobalVariableIntraproceduralNoLeak(void) {
    GenericObject *Generic = [[GenericObject alloc] init];
    
    [Generic setStaticNumber:[TaintObject source]];
    [Generic setStaticNumber:@0];
    [TaintObject sink:[Generic getStaticNumber]];
}

/*
 Bench_p_AliasingIfElseLeak
 
 combination of aliasing with if else control structure
 */
void Bench_p_AliasingIfElseLeak(int a) {
    GenericObject *Generic1 = [[GenericObject alloc] init];
    GenericObject *Generic2 = [[GenericObject alloc] init];
    
    Generic1.numberField = [TaintObject source];
    Generic2.numberField = @0;
    
    if(a==0) {
        Generic2 = Generic1;
    }
    else {
        Generic1 = Generic2;
    }
    
    [TaintObject sink:Generic2.numberField];
}

/*
 Bench_p_AliasingIfElseLeakNoOpt
 
 combination of aliasing with if else control structure and additional Generic1 object access to avoid
 compiler / decompiler optimizations that may interfer
 */
void Bench_p_AliasingIfElseLeakNoOpt(int a) {
    GenericObject *Generic1 = [[GenericObject alloc] init];
    GenericObject *Generic2 = [[GenericObject alloc] init];
    
    Generic1.numberField = [TaintObject source];
    Generic2.numberField = @0;
    
    if(a==0) {
        Generic2 = Generic1;
    }
    else {
        Generic1 = Generic2;
    }
    
    Generic1.numberField2 = @0;
    
    [TaintObject sink:Generic2.numberField];
}

/*
 Bench_p_AliasingIfElseLeak
 
 combination of aliasing with if else control structure resulting in no leak
 */
void Bench_n_AliasingIfElseNoLeak(int a) {
    GenericObject *Generic1 = [[GenericObject alloc] init];
    GenericObject *Generic2 = [[GenericObject alloc] init];
    
    Generic1.numberField = [TaintObject source];
    
    if(a==0) {
        Generic2.numberField = @0;
    }
    else {
        Generic1 = Generic2;
    }
    
    [TaintObject sink:Generic2.numberField];
}

/*
 Bench_p_AliasInSecondProcedureLeakAfterReturn
 
 we obtain an ObjectHolder holding the objects object1 and object2 of type GenericObject,
 where the alias object2 = object1 is located in the returnAliasedObjects function, adding inter-procedural character
 we taint the numberField of object1 and leak the numberField of object2, resulting in a leak
 */
void Bench_p_AliasInSecondProcedureLeakAfterReturn(void) {
    ObjectHolder *aliasedHolder = [ObjectHolder returnAliasedObjects];
    
    aliasedHolder.object1.numberField = [TaintObject source];
    
    [TaintObject sink:aliasedHolder.object2.numberField];
}

/*
 Bench_p_AliasInSecondProcedureNoLeakAfterReturn
 
 we obtain an ObjectHolder holding the objects object1 and object2 of type GenericObject,
 where the alias object2 = object1 is located in the returnAliasedObjects function, adding inter-procedural character
 we taint the numberField of object1, sanitize the numberField of object2 and then leak the numberField of object1,
 resulting in no leak
 */
void Bench_n_AliasInSecondProcedureNoLeakAfterReturn(void) {
    ObjectHolder *aliasedHolder = [ObjectHolder returnAliasedObjects];
    
    aliasedHolder.object1.numberField = [TaintObject source];
    
    aliasedHolder.object2.numberField = @0;
    
    [TaintObject sink:aliasedHolder.object1.numberField];
}

/*
 Bench_p_AliasBeforeCallLeakInSecondProcedure
 
 two GenericObject instances are aliased and passed to another function that leaks numberField of the secondObject,
 resulting in a leak
 */
void Bench_p_AliasBeforeCallLeakInSecondProcedure(void) {
    GenericObject *firstObject = [[GenericObject alloc] init];
    GenericObject *secondObject = [[GenericObject alloc] init];
    
    firstObject.numberField = [TaintObject source];
    secondObject = firstObject;
    
    [TaintObject leakNumberFieldOfSecondObject:firstObject :secondObject];
}

/*
 Bench_p_AliasBeforeCallNoLeakInSecondProcedure
 
 two GenericObject instances are aliased and passed to another function that leaks numberField of the secondObject,
 resulting in no leak
 */
void Bench_n_AliasBeforeCallNoLeakInSecondProcedure(void) {
    GenericObject *firstObject = [[GenericObject alloc] init];
    GenericObject *secondObject = [[GenericObject alloc] init];
    
    secondObject.numberField = [TaintObject source];
    secondObject = firstObject;
    
    [TaintObject leakNumberFieldOfSecondObject:firstObject :secondObject];
}

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
        
        Bench_p_SourceToSink();
        Bench_n_SourceToSinkNoLeak();
        Bench_n_SinkUninitializedField();
        Bench_p_SourceToSinkOverField();
        Bench_p_SourceToSinkOverTwoFieldsOfSameObject();
        Bench_p_SourceToSinkOverMultipleFieldsOfSameObject();

        Bench_p_SourceToSinkOverTwoFieldsOfDifferentObjects();
        Bench_p_SourceToSinkOverMultipleFieldsOfDifferentObjects();

        Bench_n_SourceToSinkTaintMultipleFieldsLeakNone();
        Bench_p_SourceToSinkTaintMultipleFieldsOnlyLeakOne();
        Bench_p_SourceToSinkTaintMultipleFieldsLeakAll();

        Bench_n_SourceToSinkTaintMultipleFieldsOfDifferentObjectsLeakNone();
        Bench_p_SourceToSinkTaintMultipleFieldsOfDifferentObjectsOnlyLeakOne();
        Bench_p_SourceToSinkTaintMultipleFieldsOfDifferentObjectsLeakAll();

        Bench_p_SourceToSinkOverFieldObjectDepth1();
        Bench_p_SourceToSinkOverFieldObjectDepth2();

        Bench_p_SourceToSinkOverTwoFieldsOfSameObjectInDepth1();
        Bench_p_SourceToSinkOverTwoFieldsOfSameObjectInMixedDepthJumpDistance1();
        Bench_p_SourceToSinkOverMultipleFieldsOfDifferentObjectsInMixedDepthMixedJumpDistance();
        
        Bench_p_SourceToSinkOverFieldNoInternalSetter();
        Bench_p_SourceToSinkOverTwoFieldsOfSameObjectNoInternalSetter();

        Bench_p_SourceToSinkCstyle();
        Bench_p_SourceToSinkCstyleOverVariable();
        Bench_p_SourceToSinkCstyleArithmeticAdd();
        Bench_p_SourceToSinkCstyleArithmeticMultiply();

        Bench_n_LeakUntaintedField();
        Bench_p_LeakTaintedField();
        Bench_p_LeakTaintedAndUntaintedField();
        Bench_n_TaintFieldThenOverwrite();
        Bench_p_TaintAndSanitizeFieldRepeatedly();

        Bench_p_StaticPropertyLeakOverDifferentObjects();
        Bench_p_FieldToStaticPropertyToFieldLeak();
        Bench_p_SetObjectToAnotherLeak();
        Bench_n_SetObjectToAnotherNoLeak();
        
        Bench_p_LeakOverGlobalCstyleStruct();
        Bench_n_NoLeakOverGlobalCstyleStruct();
        
        Bench_p_LeakOverGlobalCstyleStructFunction();
        Bench_n_NoLeakOverGlobalCstyleStructFunction();
        
        Bench_p_LeakOverLocalCstyleStruct();
        Bench_n_NoLeakOverLocalCstyleStruct();
        
        Bench_p_DynamicDispatchLeakChild();
        Bench_n_DynamicDispatchNoLeakChild();
        Bench_n_DynamicDispatchNoLeakParent();
        
        Bench_p_SourceToSinkCastIntToNSNumber();
        Bench_p_SourceToSinkCastNSNumberToInt();
        Bench_p_SourceToSinkCastNSNumberToStringToInt();

        Bench_p_SourceToSinkLeakInSecondProcedure();
        Bench_n_SourceToSinkNoLeakInSecondProcedure();
        Bench_p_SourceToSinkLeakInSecondProcedurePassingObject();
        Bench_n_SourceToSinkNoLeakInSecondProcedurePassingObject();

        Bench_p_SourceToSinkLeakInSecondProcedureOverLocalVariable();
        Bench_n_SourceToSinkNoLeakInSecondProcedureOverLocalVariable();

        Bench_p_SourceToSinkLeakAfterOneRecursion();

        Bench_n_NoLeakAfterPassingNSNumberObjectReference();
        Bench_p_LeakAfterPassingGenericObjectReference();
        
        Bench_p_SetStaticPropertyInSecondProcedureLeak();
        Bench_n_SetStaticPropertyInSecondProcedureNoLeak();

        Bench_p_LeakAfterTaintInInitialization();
        Bench_p_LeakAfterInheritanceConstructor();

        Bench_p_LeakAfterTaintingMultipleFieldsOfSameObjectInSecondProcedure();
        Bench_n_NoLeakAfterTaintingMultipleFieldsOfSameObjectInSecondProcedure();

        Bench_p_LeakAfterPassingTwoObjectsToSecondProcedureAndTaintingMultipleFields();
        Bench_n_NoLeakAfterPassingTwoObjectsToSecondProcedureAndTaintingMultipleFields();

        Bench_p_LeakAfterSwappingFieldsOfSameObject();
        Bench_n_NoLeakAfterSwappingFieldsOfSameObject();

        Bench_p_LeakAfterSwappingFieldsOfDifferentObjects();
        Bench_n_NoLeakAfterSwappingFieldsOfDifferentObjects();

        Bench_n_NoLeakAfterResetObjectDepth1();

        Bench_p_IfElseLeak(0);
        Bench_n_IfElseNoLeak(0);
        Bench_p_IfElseIfLeak(0);
        Bench_n_IfElseIfNoLeak(0);
        Bench_p_IfElseIfLeakDifferentFields(0);
        Bench_n_IfElseIfNoLeakDifferentFields(0);
        Bench_p_SwitchLeak(0);
        Bench_n_SwitchNoLeak(0);
        Bench_p_WhileLeak(0);
        Bench_n_WhileNoLeak(0);
        Bench_p_ForLeak(0);
        Bench_n_ForNoLeak(0);
        Bench_p_GotoLeak(0);
        Bench_n_GotoNoLeak(0);

        Bench_p_WriteThenReadGlobalVariableIntraproceduralLeak();
        Bench_n_WriteThenReadGlobalVariableIntraproceduralNoLeak();

        Bench_p_AliasingIfElseLeak(0);
        Bench_p_AliasingIfElseLeakNoOpt(0);
        Bench_n_AliasingIfElseNoLeak(0);
        
        Bench_p_AliasInSecondProcedureLeakAfterReturn();
        Bench_n_AliasInSecondProcedureNoLeakAfterReturn();
        Bench_p_AliasBeforeCallLeakInSecondProcedure();
        Bench_n_AliasBeforeCallNoLeakInSecondProcedure();
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
