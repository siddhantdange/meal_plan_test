//
//  MonteguesCheeseViewController.m
//  TineTest
//
//  Created by Siddhant Dange on 11/17/15.
//  Copyright © 2015 Siddhant Dange. All rights reserved.
//

#import "MonteguesCheeseViewController.h"

#import "SubmitOrderViewController.h"

@interface MonteguesCheeseViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, strong) NSArray *cheeses;
@property (nonatomic, strong) NSMutableArray *selectedCheese;

@end

@implementation MonteguesCheeseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"Cheeses";
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    self.cheeses = @[@"American", @"Swiss", @"Cheddar", @"Monteray Jack", @"Pepper Jack", @"Provolone"];
    self.selectedCheese = @[].mutableCopy;
    
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(nextButtonHit)];
    [self.navigationItem setRightBarButtonItem:nextButton];
}


- (void)nextButtonHit {
    if ([self.selectedCheese count]) {
        if ([self.selectedCheese count] > 2) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Attention  " message:@"Every extra cheese after 2 is extra" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *nextAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self advance];
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:nextAction];
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
        [self advance];
        
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Invalid" message:@"Please select at least one cheese" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}


#pragma -mark UITableViewDataSource Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    int numRows = (int)self.cheeses.count;
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
    
    cell.textLabel.text = self.cheeses[indexPath.row];
    
    return cell;
}


#pragma -mark UITableViewDelegate Methods

- (void)advance {
    NSString *total = [NSString stringWithFormat:@"cheeses: %@", [self prettyPrintArray:self.selectedCheese]];
    
    [self.currentOrder.details addObject:total];
    
    NSMutableArray *nextA = [[self.nextViewControllers copy] mutableCopy];
    
    NSLog(@"current : %@", self.currentOrder);
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

- (NSString *)prettyPrintArray:(NSArray *)arr {
    NSMutableString *pp = @"[".mutableCopy;
    for (NSString *str in arr) {
        [pp appendFormat:@"%@, ", str];
    }
    
    [pp appendFormat:@"]"];
    return pp;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        [self.selectedCheese removeObject:self.cheeses[indexPath.row]];
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        [self.selectedCheese addObject:self.cheeses[indexPath.row]];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
}

@end

