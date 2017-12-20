//
//  SetupViewController.m
//  ClickLab_Example
//
//  Created by Mauro Cardoselli on 19/12/17.
//  Copyright © 2017 ClickLab. All rights reserved.
//

#import "SetupViewController.h"
#import <ClickLab/ClickLab.h>

#define APP_NAME @"your_app_name"

@interface SetupViewController ()

@end

@implementation SetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.apiKeyField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)start:(id)sender {
    NSString *apiKey = self.apiKeyField.text;
    [self saveApiKey:apiKey];
    [self startTrackingWithApiKey:apiKey];
    [self goToMainScreen];
}

- (void)textFieldDidChange:(UITextField *)textField {
    self.startButton.enabled = (textField.text.length > 0);
}

- (void)saveApiKey:(NSString *)apiKey {
    [[NSUserDefaults standardUserDefaults] setObject:apiKey forKey:@"clickLabApiKey"];
}

- (void)startTrackingWithApiKey:(NSString *)apiKey {
    CLBAppConfiguration *config = [CLBAppConfiguration configurationWithKey:apiKey andAppName:APP_NAME];
    [CLBApp showDebugLog:YES];
    [CLBApp setupWithConfiguration:config];
}

- (void)goToMainScreen {
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"mainNavigation"];
    [[UIApplication sharedApplication].delegate.window setRootViewController:vc];
}

@end
