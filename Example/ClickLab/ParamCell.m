//
//  ParamCell
//  ClickLab
//
//  Copyright © 2017 ClickLab. All rights reserved.
//

#import "ParamCell.h"

@implementation ParamCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)loadParamDescription {
    self.paramLabel.text = [NSString stringWithFormat:@"%@: %@", self.paramKey, self.paramValue];
}

@end
