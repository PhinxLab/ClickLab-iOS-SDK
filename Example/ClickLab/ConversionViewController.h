//
//  ConversionViewController
//  ClickLab
//
//  Copyright © 2017 ClickLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConversionViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *transactionIdTextField;
@property (weak, nonatomic) IBOutlet UITextField *productTextField;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;
@property (weak, nonatomic) IBOutlet UITextField *exchangeRateTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)trackConversion:(id)sender;

@end
