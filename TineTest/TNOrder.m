//
//  TNOrder.m
//  TineTest
//
//  Created by Siddhant Dange on 11/17/15.
//  Copyright © 2015 Siddhant Dange. All rights reserved.
//

#import "TNOrder.h"
#import "TNParseManager.h"

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
    [[TNParseManager sharedInstance] sendOrder:self];
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


#pragma mark - NSCoding


- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        self.orderOwner = [decoder decodeObjectForKey:@"order_owner"];
        self.additionalDetails = [decoder decodeObjectForKey:@"additional_details"];
        self.details = [decoder decodeObjectForKey:@"details"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.orderOwner forKey:@"order_owner"];
    [aCoder encodeObject:self.additionalDetails forKey:@"additional_details"];
    [aCoder encodeObject:self.details forKey:@"details"];
}


@end
