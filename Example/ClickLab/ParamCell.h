//
//  ParamCell
//  ClickLab
//
//  Copyright © 2017 ClickLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParamCell : UITableViewCell

@property (nonatomic) NSString *paramKey;
@property (nonatomic) NSString *paramValue;

@property (weak, nonatomic) IBOutlet UILabel *paramLabel;

- (void)loadParamDescription;

@end
