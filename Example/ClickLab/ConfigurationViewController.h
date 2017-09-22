//
//  ConfigurationViewController
//  ClickLab
//
//  Copyright © 2017 ClickLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfigurationViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UIButton *changeButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)changeEmail:(id)sender;
- (IBAction)saveEmail:(id)sender;

@end
