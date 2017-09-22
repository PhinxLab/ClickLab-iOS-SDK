//
//  MainViewController
//  ClickLab
//
//  Copyright © 2017 ClickLab. All rights reserved.
//

#import "MainViewController.h"
#import "ClickLab.h"

#define EVENT_PARAMS @{ @"param1":@"Test", @"param2":@155 }

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self removeExtraRows];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)removeExtraRows {
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(nonnull UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *v = (UITableViewHeaderFooterView *)view;
    v.backgroundView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    v.textLabel.font = [UIFont systemFontOfSize:UIFont.systemFontSize];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Track event section
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            // Generic event
            [self trackGenericEvent];
        } else if (indexPath.row == 1) {
            // OpenApp event
            [self trackOpenAppEvent];
        } else if (indexPath.row == 2) {
            // Conversion
            [self trackConversion];
        }
        
        [self showAlert];
    }
}


#pragma mark - Track event

- (void)trackGenericEvent {
    CLBGenericEvent *event = [CLBGenericEvent genericEventWithName:@"genericTest" andParams:EVENT_PARAMS];
    [[CLBApp shared] logGenericEvent:event];
}

- (void)trackOpenAppEvent {
    CLBOpenAppEvent *event = [CLBOpenAppEvent openAppEvent];
    event.url = @"www.google.com";
    event.referer = @"referer";
    event.params = EVENT_PARAMS;
    
    [[CLBApp shared] logOpenAppEvent:event];
}

- (void)trackConversion {
    CLBConversionProduct *product = [CLBConversionProduct conversionProductWithSubtransactionId:[NSString stringWithFormat:@"%i", (int)[NSDate new].timeIntervalSince1970]];
    product.product = @"Product1";
    product.price = [NSNumber numberWithFloat:123.45];
    product.params = EVENT_PARAMS;
    
    CLBConversion *conversion = [CLBConversion conversionWithTransactionId:[NSString stringWithFormat:@"12%i", (int)[NSDate new].timeIntervalSince1970]];
    conversion.product = @"Product";
    conversion.price = [NSNumber numberWithFloat:987.65];
    conversion.exchange = [NSNumber numberWithFloat:1];
    conversion.currency = @"USD";
    conversion.params = EVENT_PARAMS;
    conversion.cart = @[product];
    
    [[CLBApp shared] logConversion:conversion];
}


#pragma mark - Alert

- (void)showAlert {
    // Create alert
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Event sent." preferredStyle:UIAlertControllerStyleAlert];
    // Create OK action
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okAction];
    // Show alert on viewcontroller
    [self presentViewController:alert animated:YES completion:nil];
}

@end
