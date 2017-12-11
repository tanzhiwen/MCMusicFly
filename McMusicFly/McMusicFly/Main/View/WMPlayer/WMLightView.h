//
//  WMLightView.h
//  McMusicFly
//
//  Created by TANZHIWEN on 2017/12/10.
//  Copyright © 2017年 TANZHIWEN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WMLightView : UIView

@property (nonatomic,strong) UIView *lightBackView;

@property (nonatomic,strong) UIImageView *centerLightTv;

@property (nonatomic,strong) NSMutableArray *lightViewArr;

+ (instancetype)sharedLightView;
@end
