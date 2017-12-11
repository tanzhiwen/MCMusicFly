//
//  WMPlayer.h
//  McMusicFly
//
//  Created by TANZHIWEN on 2017/12/6.
//  Copyright © 2017年 TANZHIWEN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "FastForwardView.h"
#import <UIKit/UIKit.h>

//播放器的状态
typedef NS_ENUM(NSInteger,WMPlayerState){
    WMPlayerStateFailed,   //失败
    WMPlayerStateBuffering, //缓冲
    WMPlayerStatePlaying, //播放中
    WMPlayerStateStoped,  // 停止
    WMPlayerStateFinished,  //完成
    WMPlayerStatePause  //暂停
};

// 枚举值，包含播放器左上角的关闭按钮的类型
typedef NS_ENUM(NSInteger, CloseBtnStyle){
    CloseBtnStylePop, //pop箭头<-
    CloseBtnStyleClose  //关闭（X）
};

// 手势操作的类型
typedef NS_ENUM(NSInteger,WMControlType){
    progressControl, // 视频进度调节的操作
    voiceControl,  //声音调节的操作
    lightControl, //亮度调节的操作
    noneControl
};

@class WMPlayer;
@protocol WMPlayerDelegate<NSObject>
@optional
///播放器事件
//点击播放暂停按钮代理方法
-(void)wmplayer:(WMPlayer *)wmplayer clickedPlayOrPauseButton:(UIButton *)playOrPauseBtn;
//点击关闭按钮代理方法
-(void)wmplayer:(WMPlayer *)wmplayer clickedCloseButton:(UIButton *)closeBtn;
//点击全屏按钮代理方法
-(void)wmplayer:(WMPlayer *)wmplayer clickedFullScreenButton:(UIButton *)fullScreenBtn;
//单击WMPlayer的代理方法
-(void)wmplayer:(WMPlayer *)wmplayer singleTaped:(UITapGestureRecognizer *)singleTap;
//双击WMPlayer的代理方法
-(void)wmplayer:(WMPlayer *)wmplayer doubleTaped:(UITapGestureRecognizer *)doubleTap;
//WMPlayer的的操作栏隐藏和显示
-(void)wmplayer:(WMPlayer *)wmplayer isHiddenTopAndBottomView:(BOOL )isHidden;
///播放状态
//播放失败的代理方法
-(void)wmplayerFailedPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state;
//准备播放的代理方法
-(void)wmplayerReadyToPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state;
//播放完毕的代理方法
-(void)wmplayerFinishedPlay:(WMPlayer *)wmplayer;

@end

@interface WMPlayer : UIView

// 播放器的player
@property (nonatomic,strong) AVPlayer *player;

// AVPlayerLayer  修改frame
@property (nonatomic,strong) AVPlayerLayer *playerLayer;

// 播放器的代理
@property (nonatomic,weak) id <WMPlayerDelegate>  delegate;

/**
 *  底部操作工具栏
 */
@property (nonatomic,strong ) UIImageView *bottomView;
/**
 *  顶部操作工具栏
 */
@property (nonatomic,strong ) UIImageView *topView;
/**
 *  是否使用手势控制音量
 */
@property (nonatomic,assign) BOOL  enableVolumeGesture;
/**
 *  是否使用手势控制音量
 */
@property (nonatomic,assign) BOOL  enableFastForwardGesture;
/**
 *  显示播放视频的title
 */
@property (nonatomic,strong) UILabel  *titleLabel;

/**
 ＊  播放器状态
 */
@property (nonatomic, assign) WMPlayerState  state;
/**
 ＊  播放器左上角按钮的类型
 */
@property (nonatomic, assign) CloseBtnStyle   closeBtnStyle;

// 定时器
@property (nonatomic,strong) NSTimer  *autoDismissTimer;

// BOOL 值判断当前的状态
@property (nonatomic,assign) BOOL isFullScreen;

/**
 *  控制全屏的按钮
 */
@property (nonatomic,strong) UIButton *fullScreenBtn;
/**
 *  播放暂停按钮
 */
@property (nonatomic,strong) UIButton  *playOrPauseBtn;
/**
 *  左上角关闭按钮
 */
@property (nonatomic,strong) UIButton  *closeBtn;
/**
 *  显示加载失败的UILabel
 */
@property (nonatomic,strong) UILabel  *loadFailedLabel;

//给显示亮度的view添加毛玻璃效果
@property (nonatomic,strong) UIVisualEffectView *effectView;

/**
 *  wmPlayer内部一个UIView，所有的控件统一管理在此view中
 */
@property (nonatomic,strong) UIView  *contentView;

/**
 *  当前播放的item
 */
@property (nonatomic, strong) AVPlayerItem   *currentItem;
/**
 *  菊花（加载框）
 */
@property (nonatomic,strong) UIActivityIndicatorView *loadingView;

/**
 *  设置播放视频的USRLString，可以是本地的路径也可以是http的网络路径
 */
@property (nonatomic,copy) NSString       *URLString;

//这个用来显示滑动屏幕时的时间
@property (nonatomic,strong) FastForwardView * FF_View;
/**
 *  跳到time处播放
 */
@property (nonatomic, assign) double  seekTime;

/** 播放前占位图片，不设置就显示默认占位图（需要在设置视频URL之前设置） */
@property (nonatomic, strong) UIImage  *placeholderImage ;

/**
 播放
 */
-(void)play;

/**
 暂停
 */
-(void)pause;

/**
 获取当前播放的时间点
 */
- (double)currentTime;

/**
 重置播放器
 */
-(void)resetWMPlayer;

/**
 获取版本号
 */
-(void)version;

/**
 获取当前的选取状态
 */
+(CGAffineTransform)getCurrentDeviceOrigination;

@end
