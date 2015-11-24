//
//  TNOrderViewController.h
//  TineTest
//
//  Created by Siddhant Dange on 11/17/15.
//  Copyright © 2015 Siddhant Dange. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TNOrder.h"

@interface TNOrderViewController : UIViewController

@property (nonatomic, strong) NSArray *nextViewControllers;
@property (nonatomic, strong) TNOrder *currentOrder;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil order:(TNOrder *)order;

@end
