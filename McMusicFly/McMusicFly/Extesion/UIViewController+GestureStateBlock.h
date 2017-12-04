//
//  UIViewController+GestureStateBlock.h
//  McMusicFly
//
//  Created by TANZHIWEN on 2017/12/4.
//  Copyright © 2017年 TANZHIWEN. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^GestureBeganBlk) (UIViewController *vc);
typedef void (^GestureChangeBlk) (UIViewController *vc);
typedef void (^GestureEndBlk) (UIViewController *vc);

@interface UIViewController (GestureStateBlock)

@property (nonatomic,copy) GestureBeganBlk gestureBeganBlk;

@property (nonatomic,copy) GestureChangeBlk gestureChangeBlk;

@property (nonatomic,copy) GestureEndBlk gestureEndBlk;

@end
