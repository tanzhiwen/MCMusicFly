//
//  AppDelegate.h
//  McMusicFly
//
//  Created by TANZHIWEN on 2017/12/4.
//  Copyright © 2017年 TANZHIWEN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScreenShotView.h"

#import "RootTabBarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) ScreenShotView *screenshotView;


@property (copy, nonatomic) NSArray *sidArray;
@property (copy, nonatomic) NSArray *videoArray;

+(AppDelegate *)shareAppDelegate;

@end

