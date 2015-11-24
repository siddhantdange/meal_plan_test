//
//  MonteguesSandwichSelectionViewController.m
//  TineTest
//
//  Created by Siddhant Dange on 11/17/15.
//  Copyright © 2015 Siddhant Dange. All rights reserved.
//

#import "MonteguesSandwichSelectionViewController.h"
#import "MonteguesCheeseViewController.h"
#import "MonteguesBreadViewController.h"
#import "MonteguesMeatViewController.h"

#import "TNOrder.h"

@interface MonteguesSandwichSelectionViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *sandwichTableView;
@property (nonatomic, strong) NSArray *sandwichTypes;

@end

@implementation MonteguesSandwichSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.sandwichTableView.delegate = self;
    self.sandwichTableView.dataSource = self;
    self.sandwichTypes = @[@"Custom Order", @"Rosemary Chicken Sandwich", @"Meatball Sandwich"];
}

#pragma -mark UITableViewDataSource Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    int numRows = (int)self.sandwichTypes.count;
    return numRows;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Identifier for retrieving reusable cells.
    static NSString *cellIdentifier = @"cellIdentifier";
    
    // Attempt to request the reusable cell.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // No cell available - create one.
    if(cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
    
    cell.textLabel.text = self.sandwichTypes[indexPath.row];
    
    return cell;
}

#pragma -mark UITableViewDelegate Methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *orderType = self.sandwichTypes[indexPath.row];
    
    [self.currentOrder.details addObject:orderType];
    
    if ([orderType isEqualToString:@"Custom Order"]) {
        MonteguesBreadViewController *vc = [[MonteguesBreadViewController alloc] initWithNibName:@"MonteguesBreadView" bundle:[NSBundle mainBundle] order:self.currentOrder];
        vc.nextViewControllers = @[[[MonteguesMeatViewController alloc] initWithNibName:@"MonteguesMeatView" bundle:[NSBundle mainBundle] order:self.currentOrder],[[MonteguesCheeseViewController alloc] initWithNibName:@"MonteguesCheeseView" bundle:[NSBundle mainBundle] order:self.currentOrder]];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([orderType isEqualToString:@"Rosemary Chicken Sandwich"]) {
        MonteguesBreadViewController *vc = [[MonteguesBreadViewController alloc] initWithNibName:@"MonteguesBreadView" bundle:[NSBundle mainBundle] order:self.currentOrder];
        vc.nextViewControllers = @[];
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if ([orderType isEqualToString:@"Meatball Sandwich"]) {
        MonteguesBreadViewController *vc = [[MonteguesBreadViewController alloc] initWithNibName:@"MonteguesBreadView" bundle:[NSBundle mainBundle] order:self.currentOrder];
        vc.nextViewControllers = @[[[MonteguesCheeseViewController alloc] initWithNibName:@"MonteguesCheeseView" bundle:[NSBundle mainBundle] order:self.currentOrder]];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
