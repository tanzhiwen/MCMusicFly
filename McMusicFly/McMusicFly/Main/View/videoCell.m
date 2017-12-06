//
//  videoCell.m
//  McMusicFly
//
//  Created by TANZHIWEN on 2017/12/6.
//  Copyright © 2017年 TANZHIWEN. All rights reserved.
//

#import "videoCell.h"
#import "VideoModel.h"
#import <UIImageView+WebCache.h>

@implementation videoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setViewModel:(VideoModel *)viewModel{
    _viewModel = viewModel;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.lbTitle.text = viewModel.title;
    self.lbDesc.text = viewModel.descriptionDe;
    [self.imgBack sd_setImageWithURL:[NSURL URLWithString:viewModel.cover] placeholderImage:[UIImage imageNamed:@"logo"]];
    self.lbCount.text = [NSString stringWithFormat:@"%ld.%ld万",viewModel.playCount/10000,viewModel.playCount/1000-viewModel.playCount/10000];
    self.lbTime.text = [viewModel.ptime substringWithRange:NSMakeRange(12, 4)];
}

@end
