//
//  ViewController.h
//  PastePcitures
//
//  Created by zhulin on 15-3-29.
//  Copyright (c) 2015年 qwerzl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCPictures.h"
#import "VCSelected.h"

@interface ViewController : UIViewController<VCSeletedSwitchDelegate,VCPicturesSwitchDelegate>

@property (nonatomic,strong)VCSelected* vcSelected;
@property (nonatomic,strong)VCPictures* vcPictures;

//切换controllor
- (void)ReplaceControllor:(ViewController*)fromCont toCont:(ViewController*)toCont finishedBlock:(void(^)(void))finishedBlock ;
@end