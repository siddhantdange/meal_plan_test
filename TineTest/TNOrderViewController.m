//
//  TNOrderViewController.m
//  TineTest
//
//  Created by Siddhant Dange on 11/17/15.
//  Copyright © 2015 Siddhant Dange. All rights reserved.
//

#import "TNOrderViewController.h"

@interface TNOrderViewController ()

@end

@implementation TNOrderViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil order:(TNOrder *)order {
    self.currentOrder = order;
    return [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        
        [self.currentOrder clearLastDetail];
    }
    [super viewWillDisappear:animated];
}

@end
