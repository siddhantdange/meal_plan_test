//
//  ViewController.m
//  TineTest
//
//  Created by Siddhant Dange on 11/2/15.
//  Copyright © 2015 Siddhant Dange. All rights reserved.
//

#import "MainViewController.h"
#import "MonteguesSandwichSelectionViewController.h"
#import "SubmitOrderViewController.h"

@interface MainViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *viewLastOrderButton;
@property (nonatomic, strong) NSArray *restaurants;
@property (weak, nonatomic) IBOutlet UITableView *restaurantTableView;
@property (nonatomic, strong) TNOrder *lastOrder;


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.title = @"Order";
    
    self.restaurants = @[@"Montegues"];
    self.restaurantTableView.delegate = self;
    self.restaurantTableView.dataSource = self;
}


- (void)viewWillAppear:(BOOL)animated {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"last_order"];
    if (data) {
        self.viewLastOrderButton.userInteractionEnabled = YES;
        self.viewLastOrderButton.hidden = NO;
        self.lastOrder = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    } else {
        self.viewLastOrderButton.userInteractionEnabled = NO;
        self.viewLastOrderButton.hidden = YES;
    }
}


- (void)viewDidAppear:(BOOL)animated {
    [self.currentOrder clearOrder];
}


- (IBAction)viewLastOrder:(id)sender {
    SubmitOrderViewController *submit = [[SubmitOrderViewController alloc] initWithNibName:@"SubmitOrderView" bundle:[NSBundle mainBundle] order:self.lastOrder];
    [self.navigationController pushViewController:submit animated:YES];
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
