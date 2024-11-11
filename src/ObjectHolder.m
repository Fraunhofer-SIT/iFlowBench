//
//  ObjectHolder.m
//  BenchmarkAppObjC
//

#import <Foundation/Foundation.h>
#import "ObjectHolder.h"

@implementation ObjectHolder : NSObject

- (instancetype) initWithRecursion {
    self = [super init];
    
    if(self) {
        // loop
        _recursionHolder = [[ObjectHolder alloc] initWithRecursion];
    }
    
    return self;
}

- (void)resetObject1 {
    self.object1.numberField = @0;
    self.object1.numberField2 = @0;
    self.object1.numberField3 = @0;
    self.object1.numberField4 = @0;
    self.object1.numberField5 = @0;
    
    self.object1.intNumber = 0;
}

- (void)resetObject2 {
    self.object2.numberField = @0;
    self.object2.numberField2 = @0;
    self.object2.numberField3 = @0;
    self.object2.numberField4 = @0;
    self.object2.numberField5 = @0;
    
    self.object2.intNumber = 0;
}

+ (ObjectHolder *) returnAliasedObjects {
    ObjectHolder *aliasedHolder = [[ObjectHolder alloc] init];
    aliasedHolder.object1 = [[GenericObject alloc] init];
    aliasedHolder.object2 = aliasedHolder.object1;
    
    return aliasedHolder;
}

@end
