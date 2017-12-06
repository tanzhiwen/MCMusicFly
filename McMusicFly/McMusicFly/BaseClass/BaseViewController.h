//
//  BaseViewController.h
//  McMusicFly
//
//  Created by TANZHIWEN on 2017/12/4.
//  Copyright © 2017年 TANZHIWEN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+GestureStateBlock.h"
#import <MBProgressHUD.h>

/**
 用了自定义的手势返回，则系统的手势返回屏蔽
 不用自定义的手势返回，则系统的手势返回启用
 */
@interface BaseViewController : UIViewController

@property (nonatomic,assign) BOOL enablePanGesture;

@end
