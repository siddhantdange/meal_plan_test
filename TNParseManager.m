//
//  TNParseManager.m
//  TineTest
//
//  Created by Siddhant Dange on 11/24/15.
//  Copyright © 2015 Siddhant Dange. All rights reserved.
//

#import "TNParseManager.h"

#import <Parse/Parse.h>

#import "TNSession.h"

@interface TNParseManager ()

@property (nonatomic, strong) TNSession *currentSession;

@end

@implementation TNParseManager

- (void)sendOrder:(TNOrder *)order {
    [self.currentSession.orders addObject:order];
    
    NSDictionary *orderDict = [self constructOrderDict:order];
    [PFCloud callFunctionInBackground:@"yourCloudFunctionName"
                       withParameters:@{@"parameterKey": @"parameterValue"}
                                block:^(NSArray *results, NSError *error) {
                                    if (!error) {
                                        // this is where you handle the results and change the UI.
                                        
                                        
                                    }
                                }];
}


- (void)startSession {
    self.currentSession = [[TNSession alloc] init];
}


- (void)endSession {
    
}


- (void)sendSession {
    [PFCloud callFunctionInBackground:@"yourCloudFunctionName"
                       withParameters:@{@"parameterKey": @"parameterValue"}
                                block:^(NSArray *results, NSError *error) {
                                    if (!error) {
                                        // this is where you handle the results and change the UI.
                                        
                                        
                                    }
                                }];
}


- (NSDictionary *)constructOrderDict:(TNOrder *)order {
    return @{
             @"owner" : order.orderOwner,
             @"order" : order.details,
             @"additional_details" : order.additionalDetails
             };
}

static TNParseManager *gInstance;
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gInstance = [[TNParseManager alloc] init];
        
        
    });
            
    return gInstance;
}


@end
