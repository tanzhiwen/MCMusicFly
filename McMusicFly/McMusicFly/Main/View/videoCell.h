//
//  videoCell.h
//  McMusicFly
//
//  Created by TANZHIWEN on 2017/12/6.
//  Copyright © 2017年 TANZHIWEN. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VideoModel;

@interface videoCell : UITableViewCell

@property (nonatomic,weak) IBOutlet UILabel *lbTitle;

@property (nonatomic,weak) IBOutlet UILabel *lbDesc;

@property (nonatomic,weak) IBOutlet UILabel *lbTime;

@property (nonatomic,weak) IBOutlet UIImageView *imgBack;

@property (nonatomic,weak) IBOutlet UILabel *lbCount;

@property (nonatomic,weak) IBOutlet UIButton *btnPlay;

@property (nonatomic,strong) VideoModel *viewModel;

@end
