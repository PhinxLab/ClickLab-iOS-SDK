//
//  OpenAppEventViewController
//  ClickLab
//
//  Copyright © 2017 ClickLab. All rights reserved.
//

#import "OpenAppEventViewController.h"
#import "ParamCell.h"
#import "ClickLab.h"

@interface OpenAppEventViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) NSMutableDictionary *params;
@property (nonatomic) NSMutableArray *paramList;

@end

@implementation OpenAppEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initValues];
    [self addDelegates];
    [self removeExtraRows];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)initValues {
    self.params = [NSMutableDictionary new];
}

- (void)addDelegates {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)removeExtraRows {
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)loadData {
    self.paramList = [NSMutableArray new];
    for (NSString *key in self.params.allKeys) {
        [self.paramList addObject:key];
    }
    [self sortParams:self.paramList];
    [self.tableView reloadData];
}

- (void)sortParams:(NSMutableArray *)params {
    [params sortUsingComparator:^NSComparisonResult(NSString *key1, NSString *key2){
        return [key1 compare:key2];
    }];
}

- (void)addParam {
    // Add param
    [self.params setObject:self.valueTextField.text forKey:self.keyTextField.text];
    // Reload table
    [self loadData];
}


- (IBAction)addParam:(id)sender {
    // Hide keyboard
    [self hideKeyboard];
    // Validate fields
    if ([self.keyTextField.text isEqualToString:@""] || [self.valueTextField.text isEqualToString:@""]) {
        [self showAlertWithMessage:@"Please complete all param fields."];
    } else {
        [self addParam];
        [self clearFields];
    }
}

- (IBAction)clearFields:(id)sender {
    [self clearFields];
}

- (void)clearFields {
    self.keyTextField.text = @"";
    self.valueTextField.text = @"";
}

- (void)hideKeyboard {
    [self.urlTextField resignFirstResponder];
    [self.refererTextField resignFirstResponder];
    [self.keyTextField resignFirstResponder];
    [self.valueTextField resignFirstResponder];
}

- (IBAction)trackEvent:(id)sender {
    // Hide keyboard
    [self hideKeyboard];
    
    [self trackEvent];
    [self showSuccessAlert];
}

- (void)trackEvent {
    CLBOpenAppEvent *event = [CLBOpenAppEvent openAppEvent];
    event.url = self.urlTextField.text;
    event.referer = self.refererTextField.text;
    if (self.params.count > 0)
        [event setParams:self.params];
    
    [[CLBApp shared] logOpenAppEvent:event];
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
    return self.paramList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ParamCell *cell = [tableView dequeueReusableCellWithIdentifier:@"paramCell" forIndexPath:indexPath];
    cell.paramKey = [self.paramList objectAtIndex:indexPath.row];
    cell.paramValue = [self.params objectForKey:cell.paramKey];
    [cell loadParamDescription];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ParamCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    self.keyTextField.text = cell.paramKey;
    self.valueTextField.text = cell.paramValue;
}


#pragma mark - Alert

- (void)showAlertWithMessage:(NSString *)message {
    // Create alert
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:message preferredStyle:UIAlertControllerStyleAlert];
    // Create OK action
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okAction];
    // Show alert on viewcontroller
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showSuccessAlert {
    // Create alert
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Event sent." preferredStyle:UIAlertControllerStyleAlert];
    // Create OK action
    __weak OpenAppEventViewController *weakSelf = self;
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [alert addAction:okAction];
    // Show alert on viewcontroller
    [self presentViewController:alert animated:YES completion:nil];
}

@end
