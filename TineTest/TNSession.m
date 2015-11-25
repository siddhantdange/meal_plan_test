//
//  TNSession.m
//  TineTest
//
//  Created by Siddhant Dange on 11/24/15.
//  Copyright © 2015 Siddhant Dange. All rights reserved.
//

#import "TNSession.h"

@implementation TNSession

- (instancetype)init {
    self = [super init];
    if (self) {
        self.orders = @[].mutableCopy;
    }
    
    return self;
}

@end
