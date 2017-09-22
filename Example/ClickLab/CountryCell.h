//
//  CountryCell
//  ClickLab
//
//  Copyright © 2017 ClickLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountryCell : UITableViewCell

@property (nonatomic) NSString *countryName;
@property (nonatomic) NSString *countryCode;

@property (weak, nonatomic) IBOutlet UILabel *name;

@end
