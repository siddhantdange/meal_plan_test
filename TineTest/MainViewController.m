//
//  ViewController.m
//  TineTest
//
//  Created by Siddhant Dange on 11/2/15.
//  Copyright © 2015 Siddhant Dange. All rights reserved.
//

#import "MainViewController.h"
#import "MonteguesSandwichSelectionViewController.h"

@interface MainViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *restaurants;
@property (weak, nonatomic) IBOutlet UITableView *restaurantTableView;


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.restaurants = @[@"Montegues"];
    self.restaurantTableView.delegate = self;
    self.restaurantTableView.dataSource = self;
}


- (void)viewDidAppear:(BOOL)animated {
    [self.currentOrder clearOrder];
}


- (void)dealloc {
    self.restaurantTableView.delegate = nil;
    self.restaurantTableView.dataSource = nil;
}


#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int numRows = (int)self.restaurants.count;
    return numRows;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Identifier for retrieving reusable cells.
    static NSString *cellIdentifier = @"cellIdentifier";
    
    // Attempt to request the reusable cell.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // No cell available - create one.
    if(cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
    
    cell.textLabel.text = self.restaurants[indexPath.row];
    
    return cell;
}


#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *restaurant = self.restaurants[indexPath.row];
    
    [self.currentOrder.details addObject:restaurant];
    
    if ([restaurant isEqualToString:@"Montegues"]) {
        MonteguesSandwichSelectionViewController *mvc = [[MonteguesSandwichSelectionViewController alloc] initWithNibName:@"MonteguesSandwichSelectionView" bundle:[NSBundle mainBundle] order:self.currentOrder];
        [self.navigationController pushViewController:mvc animated:nil];
    }
}

@end
