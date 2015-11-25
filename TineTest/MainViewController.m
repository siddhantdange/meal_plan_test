//
//  ViewController.m
//  TineTest //
//  Created by Siddhant Dange on 11/2/15.
//  Copyright © 2015 Siddhant Dange. All rights reserved.
//

#import "MainViewController.h"
#import "MonteguesSandwichSelectionViewController.h"
#import "SubmitOrderViewController.h"
#import "TNParseManager.h"

@interface MainViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *specialDetailView;
@property (weak, nonatomic) IBOutlet UILabel *specialPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *specialLabel;
@property (weak, nonatomic) IBOutlet UIButton *viewLastOrderButton;
@property (weak, nonatomic) IBOutlet UIImageView *specialImageView;
@property (weak, nonatomic) IBOutlet UITableView *restaurantTableView;

@property (nonatomic, strong) TNOrder *lastOrder;
@property (nonatomic, strong) NSArray *restaurants;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.title = @"Order";
    
    self.restaurants = @[@"Montegues"];
    self.restaurantTableView.delegate = self;
    self.restaurantTableView.dataSource = self;
    
    [self showSpecialDetails:NO];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(specialOrderPressed)];
    [self.specialImageView addGestureRecognizer:tap];
}


- (void)viewWillAppear:(BOOL)animated {
    [self.currentOrder clearOrder];
    [self loadLastOrder];
    [self showSpecialDetails:NO];
    
    [self loadSpecial];
}


- (void)loadLastOrder {
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


- (void)loadSpecial {
    [[TNParseManager sharedInstance] getSpecialDetails:^(NSNumber *existsN, NSNumber *price, UIImage *image,  TNOrder *specialOrder) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (existsN.boolValue) {
                self.specialPriceLabel.text = [NSString stringWithFormat:@"$%.02f", price.floatValue];
                [self.specialImageView setImage:image];
                [self showSpecialDetails:YES];
            }
        });
    }];
}


- (void)showSpecialDetails:(BOOL)show {
    self.specialImageView.hidden = !show;
    self.specialDetailView.hidden = !show;
    
    float nextY = 0.0f;
    if (show) {
        nextY = 350.0f;
    }
    
    CGRect frame = self.restaurantTableView.frame;
    frame.origin.y = nextY;
    self.restaurantTableView.frame = frame;
}


- (void)specialOrderPressed {
    TNOrder *special = self.lastOrder;
    SubmitOrderViewController *submit = [[SubmitOrderViewController alloc] initWithNibName:@"SubmitOrderView" bundle:[NSBundle mainBundle] order:special];
    [self.navigationController pushViewController:submit animated:YES];
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
