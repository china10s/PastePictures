//
//  ViewInfo.h
//  PastePcitures
//
//  Created by zhulin on 15-4-1.
//  Copyright (c) 2015年 qwerzl. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "HPublic.h"



@interface ViewInfo:NSObject

@property (nonatomic,weak)UIView        *superView;
@property (nonatomic,strong)UIView      *ctrlUpBar;
@property (nonatomic,strong)UIView      *ctrlDownBar;
@property (nonatomic,strong)NSString    *strLabel;
@property (nonatomic,strong)UILabel     *ctrlLabelInfo;
@property (nonatomic,strong)UIButton    *ctrlButtonReturn;
@property (nonatomic,retain)id<VCPicturesSwitchDelegate> delBack;
//- (id)initWithFrame:(CGRect)frame;
- (id)initWithFrame:(CGRect)frame superView:(UIView*)superView;
- (void)IniBar;
- (void)IniLabel;
- (void)IniButton;
- (void)ButtonClick:(id)sender;
@end