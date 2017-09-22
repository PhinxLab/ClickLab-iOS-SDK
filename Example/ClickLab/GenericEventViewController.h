//
//  GenericEventViewController
//  ClickLab
//
//  Copyright © 2017 ClickLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GenericEventViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *eventTypeTextField;
@property (weak, nonatomic) IBOutlet UITextField *keyTextField;
@property (weak, nonatomic) IBOutlet UITextField *valueTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)addParam:(id)sender;
- (IBAction)clearFields:(id)sender;
- (IBAction)trackEvent:(id)sender;

@end
