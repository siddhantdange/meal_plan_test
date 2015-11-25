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
@property (nonatomic, strong) TNOrder *specialOrder;
@property (nonatomic, strong) UIImage *specialImage;
@property (nonatomic, strong) NSNumber *specialPrice;

@end

@implementation TNParseManager

- (void)sendOrder:(TNOrder *)order {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:order];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"last_order"];
    
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


- (void)getSpecialDetails:(void (^)(NSNumber *, NSNumber *, UIImage *, TNOrder *))completion {
    
    completion(@(YES), @(8.99f), [UIImage imageNamed:@"burrito.jpg"], self.specialOrder);
    return;
    
    if (self.specialPrice) {
        completion(@(YES), self.specialPrice, self.specialImage, self.specialOrder);
    }
    
    [PFCloud callFunctionInBackground:@"yourCloudFunctionName"
                       withParameters:@{@"parameterKey": @"parameterValue"}
                                block:^(NSArray *results, NSError *error) {
                                    if (!error) {
                                        self.specialPrice = nil;
                                        self.specialOrder = nil;
                                        self.specialImage = nil;
                                        completion(@(YES), self.specialPrice, self.specialImage, self.specialOrder);
                                    }
                                }];
}

@end
