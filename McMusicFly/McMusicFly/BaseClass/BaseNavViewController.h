//
//  BaseNavViewController.h
//  McMusicFly
//
//  Created by TANZHIWEN on 2017/12/4.
//  Copyright © 2017年 TANZHIWEN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"



@interface BaseNavViewController : UINavigationController

@property (nonatomic,strong) NSMutableArray *arrayScreenshot;

@property (nonatomic,strong) UIPanGestureRecognizer *panGesture;

@end
