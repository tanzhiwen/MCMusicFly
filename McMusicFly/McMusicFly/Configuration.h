//
//  Configuration.h
//  McMusicFly
//
//  Created by TANZHIWEN on 2017/12/4.
//  Copyright © 2017年 TANZHIWEN. All rights reserved.
//

#ifndef Configuration_h
#define Configuration_h

#define Window [UIApplication sharedApplication].keyWindow
#define iOS8 [UIDevice currentDevice].systemVersion.floatValue >= 8.0

#define WMPlayerSrcName(file) [@"WMPlayer.bundle" stringByAppendingPathComponent:file]
#define WMPlayerFrameworkSrcName(file) [@"Frameworks/WMPlayer.framework/WMPlayer.bundle" stringByAppendingPathComponent:file]
#define WMPlayerImage(file)      [UIImage imageNamed:WMPlayerSrcName(file)] ? :[UIImage imageNamed:WMPlayerFrameworkSrcName(file)]

#define kHalfWidth self.frame.size.width * 0.5
#define kHalfHeight self.frame.size.height * 0.5
//整个屏幕代表的时间
#define TotalScreenTime 90
#define LeastDistance 15

#endif /* Configuration_h */
