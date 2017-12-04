//
//  BaseNavViewController.m
//  McMusicFly
//
//  Created by TANZHIWEN on 2017/12/4.
//  Copyright © 2017年 TANZHIWEN. All rights reserved.
//

#import "BaseNavViewController.h"
#import "AppDelegate.h"

// 打开边界多少距离才触发pop
#define DISTANCE_TO_POP 80

@interface BaseNavViewController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@end

@implementation BaseNavViewController

#warning 是否支持转屏
- (BOOL)shouldAutorotate
{
    return [self.visibleViewController shouldAutorotate];
}
#warning 支持往哪个方向转
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.visibleViewController supportedInterfaceOrientations];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrayScreenshot = [NSMutableArray array];
    self.interactivePopGestureRecognizer.enabled = NO;
    self.panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanGesture:)];
    _panGesture.delegate = self;
    [self.view addGestureRecognizer:_panGesture];
    self.navigationBar.barTintColor = [UIColor greenColor];
    
    UIImage *backButtonImage = [[UIImage imageNamed:@"navigator_btn_back"]resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
    
    [[UIBarButtonItem appearance]setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    self.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:17.0],NSFontAttributeName,nil];

}

-(BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer.view == self.view) {
        BaseViewController *topView = (BaseViewController *)self.topViewController;
        if (!topView.enablePanGesture) {
            return NO;
        }else{
            CGPoint translate= [gestureRecognizer translationInView:self.view];
            BOOL possible = translate.x != 0 && fabs(translate.y)==0;
            if (possible) {
                return YES;
            }else{
                
                return NO;
            }
            return YES;
        }
        
    }
    return NO;
}


-(void)handlePanGesture:(UIPanGestureRecognizer *)panGesture{
    AppDelegate *appdelegate = [AppDelegate shareAppDelegate];
    UITabBarController * tabController = (UITabBarController *)appdelegate.window.rootViewController;
    UINavigationController *navVc = tabController.selectedViewController;
    UIViewController *currentVc = navVc.topViewController;
    UIViewController *presentVc = tabController.presentedViewController;
    
    if (self.viewControllers.count==1) {
        return;
    }
    
    if (panGesture.state == UIGestureRecognizerStateBegan) {
        if (currentVc.gestureBeganBlk) {
            currentVc.gestureBeganBlk(currentVc);
        }
        appdelegate.screenshotView.hidden = NO;
    }else if (panGesture.state == UIGestureRecognizerStateChanged){
        CGPoint point_inView = [panGesture translationInView:self.view];
        if (currentVc.gestureChangeBlk) {
            currentVc.gestureChangeBlk(currentVc);
        }
        if (point_inView.x>=10) {
            tabController.view.transform = CGAffineTransformMakeTranslation(point_inView.x-10, 0);
            presentVc.view.transform = CGAffineTransformMakeTranslation(point_inView.x-10,0);
        }
        
    }else if(panGesture.state== UIGestureRecognizerStateEnded){
        if (currentVc.gestureEndBlk) {
            currentVc.gestureEndBlk(currentVc);
        }
        CGPoint point_inView = [panGesture translationInView:self.view];
        if (point_inView.x>= DISTANCE_TO_POP) {
            [UIView animateWithDuration:0.3 animations:^{
                tabController.view.transform = CGAffineTransformMakeTranslation(320, 0);
                presentVc.view.transform = CGAffineTransformMakeTranslation(320, 0);
            } completion:^(BOOL finished) {
                [self popViewControllerAnimated:NO];
                tabController.view.transform = CGAffineTransformIdentity;
                presentVc.view.transform = CGAffineTransformIdentity;
                appdelegate.screenshotView.hidden = YES;
            }];
        }else{
            [UIView animateWithDuration:0.3 animations:^{
                tabController.view.transform = CGAffineTransformIdentity;
                presentVc.view.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                appdelegate.screenshotView.hidden = YES;
            }];
        }
    }
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSArray *arr = [super popToViewController:viewController animated:animated];
    
    if (self.arrayScreenshot.count > arr.count)
    {
        for (int i = 0; i < arr.count; i++) {
            [self.arrayScreenshot removeLastObject];
        }
    }
    return arr;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count == 0){
        return [super pushViewController:viewController animated:animated];
    }else if (self.viewControllers.count>=1) {
        viewController.hidesBottomBarWhenPushed = YES;//隐藏二级页面的tabbar
    }
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(appdelegate.window.frame.size.width, appdelegate.window.frame.size.height), YES, 0);
    [appdelegate.window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.arrayScreenshot addObject:viewImage];
    appdelegate.screenshotView.imgView.image = viewImage;
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [self.arrayScreenshot removeLastObject];
    UIImage *image = [self.arrayScreenshot lastObject];
    if (image)
        appdelegate.screenshotView.imgView.image = image;
    
    UIViewController *v = [super popViewControllerAnimated:animated];
    return v;
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (self.arrayScreenshot.count > 2)
    {
        [self.arrayScreenshot removeObjectsInRange:NSMakeRange(1, self.arrayScreenshot.count - 1)];
    }
    UIImage *image = [self.arrayScreenshot lastObject];
    if (image)
        appdelegate.screenshotView.imgView.image = image;
    return [super popToRootViewControllerAnimated:animated];
}

/**
 *  导航控制器 统一管理状态栏颜色
 *  @return 状态栏颜色
 */
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
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
