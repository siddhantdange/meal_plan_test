//
//  TNSession.h
//  TineTest
//
//  Created by Siddhant Dange on 11/24/15.
//  Copyright © 2015 Siddhant Dange. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TNSession : NSObject

@property (nonatomic, strong) NSDate *startTime;
@property (nonatomic, strong) NSDate *endTime;
@property (nonatomic, strong) NSMutableArray *orders;

@end
