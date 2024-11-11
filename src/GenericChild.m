//
//  GenericChild.m
//  BenchmarkAppObjC
//

#import <Foundation/Foundation.h>
#import "GenericChild.h"
#import "TaintObject.h"

@implementation GenericChild

- (instancetype) initWithGenericObject:(GenericObject *)object {
    self = [super init];
    
    if(self) {
        self.intNumber = object.intNumber;
        
        self.numberField = object.numberField;
        self.numberField2 = object.numberField2;
        self.numberField3 = object.numberField3;
        self.numberField4 = object.numberField4;
        self.numberField5 = object.numberField5;
    }
    
    return self;
}

- (void) dynamicDispatchTaint {
    self.numberField = [TaintObject source];
}

- (void) dynamicDispatchNoTaint {
    self.numberField = @0;
}

@end
