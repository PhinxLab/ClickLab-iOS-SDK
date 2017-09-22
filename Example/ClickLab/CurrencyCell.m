//
//  CountryCell
//  ClickLab
//
//  Copyright © 2017 ClickLab. All rights reserved.
//

#import "CurrencyCell.h"

@implementation CurrencyCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)loadCurrencyDescription {
    self.name.text = [NSString stringWithFormat:@"%@ (%@)", self.currencyName, self.currencyCode];
}

@end
