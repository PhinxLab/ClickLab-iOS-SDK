//
//  CountryCell
//  ClickLab
//
//  Copyright © 2017 ClickLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrencyCell : UITableViewCell

@property (nonatomic) NSString *currencyName;
@property (nonatomic) NSString *currencyCode;

@property (weak, nonatomic) IBOutlet UILabel *name;

- (void)loadCurrencyDescription;

@end
