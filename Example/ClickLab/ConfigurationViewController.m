//
//  ConfigurationViewController
//  ClickLab
//
//  Copyright © 2017 ClickLab. All rights reserved.
//

#import "ConfigurationViewController.h"
#import "CountryCell.h"
#import "ClickLab.h"

#define COUNTRIES @[ @{ @"name":@"Italy", @"code":@"IT" }, @{ @"name":@"Japan", @"code":@"JP" }, @{ @"name":@"USA", @"code":@"US" } ]

@interface ConfigurationViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation ConfigurationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addDelegates];
    [self removeExtraRows];
    [self emailEdition:NO];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)addDelegates {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)removeExtraRows {
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)loadData {
    self.emailTextField.text = [CLBApp shared].email;
}

- (IBAction)changeEmail:(id)sender {
    [self emailEdition:YES];
}

- (IBAction)saveEmail:(id)sender {
    [self emailEdition:NO];
    // TODO: validate email ???
    [CLBApp shared].email = self.emailTextField.text;
}

- (void)emailEdition:(BOOL)edition {
    self.changeButton.enabled = !edition;
    self.saveButton.enabled = edition;
    self.emailTextField.enabled = edition;
    
    if (edition)
        [self.emailTextField becomeFirstResponder];
    else
        [self.emailTextField resignFirstResponder];
}


#pragma mark - TableView

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(nonnull UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *v = (UITableViewHeaderFooterView *)view;
    v.backgroundView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    v.textLabel.font = [UIFont systemFontOfSize:UIFont.systemFontSize];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return COUNTRIES.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CountryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"countryCell" forIndexPath:indexPath];
    cell.countryName = [[COUNTRIES objectAtIndex:indexPath.row] valueForKey:@"name"];
    cell.countryCode = [[COUNTRIES objectAtIndex:indexPath.row] valueForKey:@"code"];
    
    if ([cell.countryCode isEqualToString:[CLBApp shared].country])
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    else
        cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Country section
    NSString *apiCountry = [CLBApp shared].country;
    CountryCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (apiCountry && [apiCountry isEqualToString:cell.countryCode])
        [CLBApp shared].country = nil;
    else
        [CLBApp shared].country = cell.countryCode;
    
    [tableView reloadData];
}

@end
