//
//  UIViewController+GestureStateBlock.m
//  McMusicFly
//
//  Created by TANZHIWEN on 2017/12/4.
//  Copyright © 2017年 TANZHIWEN. All rights reserved.
//

#import "UIViewController+GestureStateBlock.h"
#import <objc/runtime.h>

//objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy)
//id object                     :表示关联者，是一个对象，变量名理所当然也是object
//const void *key               :获取被关联者的索引key
//id value                      :被关联者，这里是一个block
//objc_AssociationPolicy policy : 关联时采用的协议，有assign，retain，copy等协议，一般使用

static char GestureBeganBlkKey;
static char GestureChangeBlkKey;
static char GestureEndBlkKey;

@implementation UIViewController (GestureStateBlock)

-(void)setGestureBeganBlk:(GestureBeganBlk)gestureBeganBlk{
    objc_setAssociatedObject(self, &GestureBeganBlkKey, gestureBeganBlk, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (GestureBeganBlk)gestureBeganBlk{
    return objc_getAssociatedObject(self, &GestureBeganBlkKey);
}

-(void)setGestureChangeBlk:(GestureChangeBlk)gestureChangeBlk{
    objc_setAssociatedObject(self, &GestureChangeBlkKey, gestureChangeBlk, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(GestureChangeBlk)gestureChangeBlk{
    return objc_getAssociatedObject(self, &GestureChangeBlkKey);
}

-(void)setGestureEndBlk:(GestureEndBlk)gestureEndBlk{
    objc_setAssociatedObject(self, &GestureEndBlkKey, gestureEndBlk, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(GestureEndBlk)gestureEndBlk{
    return objc_getAssociatedObject(self, &GestureEndBlkKey);
}

@end
