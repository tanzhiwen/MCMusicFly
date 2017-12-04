//
//  VideoModel.m
//  McMusicFly
//
//  Created by TANZHIWEN on 2017/12/4.
//  Copyright © 2017年 TANZHIWEN. All rights reserved.
//

#import "VideoModel.h"

@implementation VideoModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"description"]) {
        self.descriptionDe = value;
    }
}

@end
