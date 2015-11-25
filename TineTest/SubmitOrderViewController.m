//
//  SubmitOrderViewController.m
//  TineTest
//
//  Created by Siddhant Dange on 11/18/15.
//  Copyright © 2015 Siddhant Dange. All rights reserved.
//

#import "SubmitOrderViewController.h"
#import "TNOrder.h"

#import "AppDelegate.h"

@interface SubmitOrderViewController () <UITextViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UITextView *orderDetailsTextView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@end

@implementation SubmitOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.orderDetailsTextView.delegate = self;
    self.tableview.dataSource = self;
    
    self.navigationItem.title = @"Details";
    
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Submit" style: UIBarButtonItemStyleDone target:self action:@selector(submitAction)];
    [self.navigationItem setRightBarButtonItem:nextButton];
}


- (IBAction)submitAction{
    BOOL valid = YES;
    NSString *details = self.orderDetailsTextView.text;
    
    NSString *name = self.nameTextField.text;
    valid = name.length > 0;
    
    if (valid) {
        TNOrder *order = self.currentOrder;
        order.additionalDetails = details;
        order.orderOwner = name;
        
        // send order
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Send?" message:@"Ok to send?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sendAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [order sendOrder];
            
            NSLog(@"%@", order);
            
            UIViewController *main = ((AppDelegate *)[UIApplication sharedApplication].delegate).mvc;
            [self.navigationController popToViewController:main animated:YES];
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
        
        [alert addAction:sendAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        // send order
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Invalid" message:@"Please fill out fields" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
        
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:^{
            self.nameTextField.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:222.0/255 blue:211/255.0 alpha:1.0f];
        }];
    }
}


-(void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"Additional Details (optional)"]) {
        textView.text = @"";
    }
}


#pragma -mark UITableViewDataSource Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    int numRows = (int)[self.currentOrder.details count];
    NSLog(@"current : %@", self.currentOrder);
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
    
    cell.textLabel.text = self.currentOrder.details[indexPath.row];
    
    return cell;
}


@end
