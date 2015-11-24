//
//  MonteguesBreadViewController.m
//  TineTest
//
//  Created by Siddhant Dange on 11/17/15.
//  Copyright © 2015 Siddhant Dange. All rights reserved.
//

#import "MonteguesBreadViewController.h"

#import "SubmitOrderViewController.h"

@interface MonteguesBreadViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, strong) NSArray *breads;

@end

@implementation MonteguesBreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"Breads";
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    self.breads = @[@"Dutch Crunch", @"Sourdough", @"Sweet", @"Whole Wheat"];
}

#pragma -mark UITableViewDataSource Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    int numRows = (int)self.breads.count;
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
    
    cell.textLabel.text = self.breads[indexPath.row];
    
    return cell;
}


#pragma -mark UITableViewDelegate Methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *bread = self.breads[indexPath.row];
    
    NSString *total = [NSString stringWithFormat:@"bread: %@", bread];
    
    [self.currentOrder.details addObject:total];
    
    NSMutableArray *nextA = [[self.nextViewControllers copy] mutableCopy];
    if ([nextA count]) {
        TNOrderViewController *next = nextA[0];
        [nextA removeObjectAtIndex:0];
        
        next.nextViewControllers = nextA;
        [self.navigationController pushViewController:next animated:YES];
    } else {
        SubmitOrderViewController *order = [[SubmitOrderViewController alloc] initWithNibName:@"SubmitOrderView" bundle:[NSBundle mainBundle] order:self.currentOrder];
        [self.navigationController pushViewController:order animated:YES];
    }
}

@end
