//
//  TencentNewsViewController.m
//  McMusicFly
//
//  Created by TANZHIWEN on 2017/12/6.
//  Copyright © 2017年 TANZHIWEN. All rights reserved.
//

#import "TencentNewsViewController.h"
#import "videoCell.h"
#import <Masonry.h>
#import <MJRefresh.h>
#import <MBProgressHUD.h>
#import "DataManager.h"


@interface TencentNewsViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSIndexPath *currentIndexPath;
    BOOL isSmallSreen;
    
}

@property (nonatomic,strong) videoCell *currentCell;
@property (nonatomic,strong) NSMutableArray *dataList;

@end

@implementation TencentNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tbViiew registerNib:[UINib nibWithNibName:NSStringFromClass([videoCell class]) bundle:nil] forCellReuseIdentifier:@"videoCell"];
    
    [self addMJRefresh];
    
}

-(void)releaseWMPlayer{
    
}

-(void)addMJRefresh{
    __weak typeof(self) weakself = self;
    
    weakself.tbViiew.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//  下拉刷新
    [[DataManager dataManager]getSidArrayWithUrlString:@"http://c.m.163.com/nc/video/home/0-10.html" success:^(NSArray *sidArray, NSArray *videoArray) {
            [self.dataList removeAllObjects];
            [self.dataList addObjectsFromArray:videoArray];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (currentIndexPath.row>self.dataList.count) {
                    [weakself releaseWMPlayer];
                }
                
                [weakself.tbViiew reloadData];
                [weakself.tbViiew.mj_header endRefreshing];
            });
        } failed:^(NSError *error) {
            
        }];
    }];
    
// 设置自动切换透明度
    weakself.tbViiew.mj_header.automaticallyChangeAlpha = YES;
    
// 上拉刷新
    weakself.tbViiew.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        NSString *urlString = [NSString stringWithFormat:@"http://c.m.163.com/nc/video/home/%ld-10.html",self.dataList.count- self.dataList.count%10];
        [[DataManager dataManager]getSidArrayWithUrlString:urlString success:^(NSArray *sidArray, NSArray *videoArray) {
            [self.dataList removeAllObjects];
                dispatch_async(dispatch_get_main_queue(), ^{
                    //回调或者说是通知主线程刷新，
                    [weakself.tbViiew reloadData];
                    [weakself.tbViiew.mj_header endRefreshing];
                    
                });
        } failed:^(NSError *error) {
            
        }];
//    结束刷新
        [weakself.tbViiew.mj_footer endRefreshing];
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"videoCell";
    
    videoCell *cell = (videoCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    cell.viewModel = [self.dataList objectAtIndex:indexPath.row];
    [cell.btnPlay addTarget:self action:@selector(startPlay:) forControlEvents:UIControlEventTouchUpInside];
    cell.btnPlay.tag = indexPath.row;

#warning  这段代码好好分析一下
//    if (wmPlayer&&wmPlayer.superview) {
//        if (indexPath.row==currentIndexPath.row) {
//            [cell.playBtn.superview sendSubviewToBack:cell.playBtn];
//        }else{
//            [cell.playBtn.superview bringSubviewToFront:cell.playBtn];
//        }
//        NSArray *indexpaths = [tableView indexPathsForVisibleRows];
//        if (![indexpaths containsObject:currentIndexPath]&&currentIndexPath!=nil) {//复用
//            if ([[UIApplication sharedApplication].keyWindow.subviews containsObject:wmPlayer]) {
//                wmPlayer.hidden = NO;
//            }else{
//                wmPlayer.hidden = YES;
//                [cell.playBtn.superview bringSubviewToFront:cell.playBtn];
//            }
//        }else{
//            if ([cell.backgroundIV.subviews containsObject:wmPlayer]) {
//                [cell.backgroundIV addSubview:wmPlayer];
//                [wmPlayer play];
//                wmPlayer.hidden = NO;
//            }
//        }
//    }
    
    return cell;
}

-(void)startPlay:(UIButton *)sender{
    currentIndexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    UIView *cellView = [sender superview];
    while (![cellView isKindOfClass:[UITableViewCell class]]) {
        cellView = [cellView superview];
    }
    
    self.currentCell = (videoCell *)cellView;
    VideoModel *model  =  [self.dataList objectAtIndex:sender.tag];
    if (isSmallSreen) {
        [self releaseWMPlayer];
        isSmallSreen = NO;
    }

#warning 播放器的代码
//    if (wmPlayer) {
//        [self releaseWMPlayer];
//        wmPlayer = [[WMPlayer alloc]initWithFrame:self.currentCell.backgroundIV.bounds];
//        wmPlayer.delegate = self;
//        //关闭音量调节的手势
//        //        wmPlayer.enableVolumeGesture = NO;
//        wmPlayer.closeBtnStyle = CloseBtnStyleClose;
//        wmPlayer.URLString = model.mp4_url;
//        wmPlayer.titleLabel.text = model.title;
//        //        [wmPlayer play];
//    }else{
//        wmPlayer = [[WMPlayer alloc]initWithFrame:self.currentCell.backgroundIV.bounds];
//        wmPlayer.delegate = self;
//        wmPlayer.closeBtnStyle = CloseBtnStyleClose;
//        //关闭音量调节的手势
//        //        wmPlayer.enableVolumeGesture = NO;
//        wmPlayer.titleLabel.text = model.title;
//        wmPlayer.URLString = model.mp4_url;
//    }
//    [self.currentCell.backgroundIV addSubview:wmPlayer];
//    [self.currentCell.backgroundIV bringSubviewToFront:wmPlayer];
    
    [self.currentCell.btnPlay.superview sendSubviewToBack:self.currentCell.btnPlay];
    [self.tbViiew reloadData];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    VideoModel *model = [self.dataList objectAtIndex:indexPath.row];
//  详情
    
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
