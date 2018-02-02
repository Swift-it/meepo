//
//  ViewController.m
//  meepo
//
//  Created by Mikael Melander on 2018-02-02.
//  Copyright © 2018 Mikael Melander. All rights reserved.
//

#import "ViewController.h"


//#define k_testLink @"http://httpbin.org/ip"
#define k_testLink @"https://timesheet-1172.appspot.com/2a00ea83/notes"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    notesArray = [[NSArray alloc] init];
    httpData *loginNetHelper = [[httpData alloc]init];
    loginNetHelper.delegate = self;
    [loginNetHelper getData:k_testLink];
    
    
    self.view.backgroundColor = [Colors whiteColor];
    
    // Setting up Navbar
    [self setTitle:@"Meepo"];
    [[UIView appearance] setTintColor:[UIColor whiteColor]];
    UIBarButtonItem *newback = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [[self navigationItem] setBackBarButtonItem:newback];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarTintColor:[Colors mainColor]];
    [self.navigationController.navigationBar setTranslucent:NO];
    
    // Setting up tableView
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    self.table.backgroundColor = [Colors lightGray];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    [self.table setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_table];
    [notesCell setTableViewWidth:self.view.frame.size.width];
    
    
    

}


#pragma TableView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section)
    { case 0:
        {
            return notesArray.count;
        }
            
        default: return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    switch (indexPath.section)
    {
        case 0:
        {
            UITableViewCell * cell = [self cellForIndex:indexPath];
            
            
            NSDictionary *currentDict = [notesArray objectAtIndex:indexPath.row];
            [(notesCell *)cell  configureCellForText:currentDict];
            
            return cell;
            
        }
        default: return nil;
    }
    
}

// Setting up custom tableViewCell
- (UITableViewCell *)cellForIndex:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    NSString *cellId = kCellIdentifier;
    cell = [self.table dequeueReusableCellWithIdentifier:cellId];
    if (!cell)
    {
        cell = [notesCell cellForTableWidth:self.table.frame.size.width];
        cell.accessoryType =  UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 55;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
    }
    
}



#pragma Other
// Recive GET data
-(void)didFininshRequestWithJson:(NSArray *)responseJson
{
    NSLog(@"%@", responseJson);
    NSLog(@"count: %lu", (unsigned long)responseJson.count);
    notesArray = [NSArray arrayWithArray:responseJson];
    [self.table reloadData];
}

// Recive GET Failed.
-(void)didFailWithRequest:(NSString *)err {
    NSLog(@"%@", err);
}



// Setting the style of navigationbar Title
- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    UILabel *titleView = (UILabel *)self.navigationItem.titleView;
    if (!titleView) {
        titleView = [[UILabel alloc] initWithFrame:CGRectZero];
        titleView.backgroundColor = [UIColor clearColor];
        [titleView setFont:[Fonts navBar]];
        titleView.textColor = [UIColor whiteColor];
        self.navigationItem.titleView = titleView;
    }
    titleView.text = title;
    [titleView sizeToFit];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
