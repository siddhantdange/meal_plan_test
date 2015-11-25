//
//  TNParseManager.h
//  TineTest
//
//  Created by Siddhant Dange on 11/24/15.
//  Copyright © 2015 Siddhant Dange. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

#import "TNOrder.h"

@interface TNParseManager : NSObject

+ (instancetype)sharedInstance;

- (void)sendOrder:(TNOrder *)order;

- (void)getSpecialDetails:(void(^)(NSNumber*, NSNumber *, UIImage *, TNOrder *))completion;

- (void)startSession;
- (void)endSession;

@end
