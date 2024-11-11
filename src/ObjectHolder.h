//
//  ObjectHolder.h
//  BenchmarkAppObjC
//

#ifndef ObjectHolder_h
#define ObjectHolder_h

#import "GenericObject.h"

@interface ObjectHolder : NSObject

@property GenericObject *object1;
@property GenericObject *object2;

// if we initialize this in a constructor, we run into an infinite loop of initializations
@property ObjectHolder *recursionHolder;

- (instancetype) initWithRecursion;

- (void) resetObject1;
- (void) resetObject2;

+ (ObjectHolder *) returnAliasedObjects;

@end

#endif /* ObjectHolder_h */
