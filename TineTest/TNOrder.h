//
//  TNOrder.h
//  TineTest
//
//  Created by Siddhant Dange on 11/17/15.
//  Copyright © 2015 Siddhant Dange. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TNOrder : NSObject <NSCoding>

@property (nonatomic, strong) NSString *orderOwner;
@property (nonatomic, strong) NSString *additionalDetails;
@property (nonatomic, strong) NSMutableArray *details;

- (void)clearOrder;

- (void)clearLastDetail;

- (void)sendOrder;

@end
