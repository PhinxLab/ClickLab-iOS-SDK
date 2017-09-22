//
//  CountryCell
//  ClickLab
//
//  Copyright © 2017 ClickLab. All rights reserved.
//

#import "CountryCell.h"

@implementation CountryCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setCountryName:(NSString *)countryName {
    _countryName = countryName;
    self.name.text = countryName;
}

@end
