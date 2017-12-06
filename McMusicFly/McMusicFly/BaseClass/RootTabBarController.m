//
//  RootTabBarController.m
//  McMusicFly
//
//  Created by TANZHIWEN on 2017/12/4.
//  Copyright © 2017年 TANZHIWEN. All rights reserved.
//

#import "RootTabBarController.h"
#import "BaseNavViewController.h"

@interface RootTabBarController ()

@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.tintColor= [UIColor yellowColor];
    
}

-(BOOL)shouldAutorotate{
    BaseNavViewController *nav = (BaseNavViewController *)self.selectedViewController;
    if ([nav.topViewController isKindOfClass:[NSClassFromString(@"DetailViewController") class]]) {
        return YES;
    }
    return NO;
}
-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    BaseNavViewController *nav = (BaseNavViewController *)self.selectedViewController;
    if ([nav.topViewController isKindOfClass:[NSClassFromString(@"DetailViewController") class]]) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    return UIInterfaceOrientationMaskPortrait;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    BaseNavViewController *nav = (BaseNavViewController *)self.selectedViewController;
    if ([nav.topViewController isKindOfClass:[NSClassFromString(@"DetailViewController") class]]) {
        return UIInterfaceOrientationPortrait|UIInterfaceOrientationLandscapeLeft|UIInterfaceOrientationLandscapeRight;
    }
    return UIInterfaceOrientationPortrait;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
