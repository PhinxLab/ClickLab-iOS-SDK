//
//  SetupViewController.h
//  ClickLab_Example
//
//  Created by Mauro Cardoselli on 19/12/17.
//  Copyright © 2017 ClickLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetupViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *apiKeyField;
@property (weak, nonatomic) IBOutlet UIButton *startButton;

- (IBAction)start:(id)sender;

@end
