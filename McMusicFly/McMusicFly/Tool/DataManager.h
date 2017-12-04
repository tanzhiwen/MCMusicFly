//
//  DataManager.h
//  McMusicFly
//
//  Created by TANZHIWEN on 2017/12/4.
//  Copyright © 2017年 TANZHIWEN. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^onSuccess)(NSArray *sidArray,NSArray *videoArray);
typedef void (^onFailed)(NSError *error);

@interface DataManager : NSObject

@property (nonatomic,strong) NSArray *sidArray;
@property (nonatomic,strong) NSArray *videoArray;

+(DataManager *)dataManager;

@end
