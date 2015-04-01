//
//  VCSelected.h
//  PastePcitures
//
//  Created by zhulin on 15-3-29.
//  Copyright (c) 2015年 qwerzl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeRippleButton.h"

@protocol VCSeletedSwitchDelegate <NSObject>

- (void)Seleted:(NSString*)strDistrictName strSceneName:(NSString*)strSceneName;
@end

@interface VCSelected : UIViewController
@property (nonatomic)NSInteger intScenesCount;
@property (nonatomic,strong)NSString* strCurDicName;
@property (nonatomic,strong)NSMutableArray* arryDistrict;
@property (nonatomic,strong)id<VCSeletedSwitchDelegate> SwitchDelegate;
@property (nonatomic,strong) UISegmentedControl* CtrlSegment;
@property (nonatomic,strong) UIScrollView *CtrlScroll;


- (void)ValChanged:(UISegmentedControl*)sender;
- (void)SelectDistrict:(NSInteger)intDistrictIndex;
- (void)CreateScenes:(NSString*)strSelDistrict;

@end
