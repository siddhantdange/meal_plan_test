//
//  TNOrder.m
//  TineTest
//
//  Created by Siddhant Dange on 11/17/15.
//  Copyright © 2015 Siddhant Dange. All rights reserved.
//

#import "TNOrder.h"

@implementation TNOrder


- (instancetype)init {
    self = [super init];
    if (self) {
        self.orderOwner = @"not set yet";
        self.additionalDetails = @"";
        self.details = @[].mutableCopy;
    }
    
    return self;
}


- (void)clearOrder {
    self.details = @[].mutableCopy;
}


- (void)clearLastDetail {
    if ([self.details count]) {
        [self.details removeLastObject];
    }
}


- (void)sendOrder {
    NSDictionary *orderDict = [self constructFinalDict];
    
}


- (NSString *)description {
    
    return [NSString stringWithFormat:@"%@\n\n", [self constructFinalDict]];
}

- (NSDictionary *)constructFinalDict {
    return @{
             @"owner" : self.orderOwner,
             @"order" : self.details,
             @"additional_details" : self.additionalDetails
             };
}

@end
