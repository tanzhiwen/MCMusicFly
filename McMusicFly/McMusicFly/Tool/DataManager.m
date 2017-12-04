//
//  DataManager.m
//  McMusicFly
//
//  Created by TANZHIWEN on 2017/12/4.
//  Copyright © 2017年 TANZHIWEN. All rights reserved.
//

#import "DataManager.h"
#import "VideoModel.h"
#import "SidModel.h"

@implementation DataManager


+(DataManager *)dataManager{
    static DataManager *dataManager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        dataManager = [[DataManager alloc]init];
        
    });
    return dataManager;
}

-(void)getSidArrayWithUrlString:(NSString *)urlString success:(onSuccess)success failed:(onFailed)failed{
    dispatch_queue_t global_t = dispatch_get_global_queue(0,0);
    dispatch_async(global_t, ^{
        NSURL *url = [NSURL URLWithString:urlString];
        NSMutableArray *sidArray = [NSMutableArray array];
        NSMutableArray *videoArray = [NSMutableArray array];
    
        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
            if (connectionError) {
                NSLog(@"错误是%@",connectionError);
                
            }else{
                NSDictionary *dic= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                for (NSDictionary *dict in [dic valueForKey:@"videoSidList"]) {
                    SidModel *sidM = [[SidModel alloc]init];
                    [sidM setValuesForKeysWithDictionary:dict];
                    [sidArray addObject:sidM];
                }
                self.sidArray = [NSArray arrayWithArray:sidArray];
            }
            if (success) {
                success(sidArray,videoArray);
            }
        }];
    });
}
    

-(void)getVideoArrayWithUrlString:(NSString *)urlString ListID:(NSString *)listId success:(onSuccess)success failed:(onFailed)failed{
    dispatch_queue_t global_t = dispatch_get_global_queue(0, 0);
    dispatch_async(global_t, ^{
        NSURL *url = [NSURL URLWithString:urlString];
        NSMutableArray *listArray = [NSMutableArray array];
        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * response, NSData *  data, NSError *  connectionError) {
            if (connectionError) {
                NSLog(@"错误%@",connectionError);
                failed(connectionError);
            }else{
                NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSArray *videoList = [dict objectForKey:listId];
                for (NSDictionary * video in videoList) {
                    VideoModel * model = [[VideoModel alloc] init];
                    [model setValuesForKeysWithDictionary:video];
                    [listArray addObject:model];
                }
                if (success) {
                    success(listArray,nil);
                }
            }
            
        }];
        
    });
}

@end
