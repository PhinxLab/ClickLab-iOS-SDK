//
//  ConversionViewController
//  ClickLab
//
//  Copyright © 2017 ClickLab. All rights reserved.
//

#import "ConversionViewController.h"
#import "CurrencyCell.h"
#import "ClickLab.h"

#define CURRENCIES @[ @{ @"name":@"Euro", @"code":@"EUR" }, @{ @"name":@"Yen", @"code":@"JPY" }, @{ @"name":@"Dollar", @"code":@"USD" } ]

@interface ConversionViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) NSString *currency;

@end

@implementation ConversionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addDelegates];
    [self removeExtraRows];
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

- (void)trackConversion:(id)sender {
    
    NSString *transactionId = self.transactionIdTextField.text;
    NSString *product = self.productTextField.text;
    NSNumber *price = [self parseNumber:self.priceTextField.text];
    NSNumber *exchange = [self parseNumber:self.exchangeRateTextField.text];
    
    if ([self isEmpty:transactionId]) {
        [self showAlertWithMessage:@"Transaction Id should not be empty."];
    } else if (price && (!exchange || !self.currency)) {
        [self showAlertWithMessage:@"All Price Exchange rate and Currency should be set."];
    } else {
        
        CLBConversion *conversion = [CLBConversion conversionWithTransactionId:transactionId];
        conversion.product = product;
        conversion.price = price;
        conversion.exchange = exchange;
        conversion.currency = self.currency;
        
        [[CLBApp shared] logConversion:conversion];
        [self showSuccessAlert];
    }
}

- (NSNumber *)parseNumber:(NSString *)text {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    return [formatter numberFromString:text];
}

- (void)hideKeyboard {
    [self.transactionIdTextField resignFirstResponder];
    [self.productTextField resignFirstResponder];
    [self.priceTextField resignFirstResponder];
    [self.exchangeRateTextField resignFirstResponder];
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
    return CURRENCIES.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CurrencyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"currencyCell" forIndexPath:indexPath];
    cell.currencyName = [[CURRENCIES objectAtIndex:indexPath.row] valueForKey:@"name"];
    cell.currencyCode = [[CURRENCIES objectAtIndex:indexPath.row] valueForKey:@"code"];
    [cell loadCurrencyDescription];
    
    if ([cell.currencyCode isEqualToString:self.currency])
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    else
        cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Currency section
    CurrencyCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (self.currency && [self.currency isEqualToString:cell.currencyCode])
        self.currency = nil;
    else
        self.currency = cell.currencyCode;
    
    [tableView reloadData];
    [self hideKeyboard];
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
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Conversion sent." preferredStyle:UIAlertControllerStyleAlert];
    // Create OK action
    __weak ConversionViewController *weakSelf = self;
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [alert addAction:okAction];
    // Show alert on viewcontroller
    [self presentViewController:alert animated:YES completion:nil];
}

- (BOOL)isEmpty:(NSString *)text {
    return (!text || text.length == 0);
}

@end
