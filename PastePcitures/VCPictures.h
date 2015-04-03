//
//  VCPictures.h
//  PastePcitures
//
//  Created by zhulin on 15-3-29.
//  Copyright (c) 2015年 qwerzl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewInfo.h"
#import "HPublic.h"
#import "ViewScrollImage.h"

@interface VCPictures : UIViewController<UIScrollViewDelegate,VCPicturesSwitchDelegate>
@property (nonatomic,strong) UITapGestureRecognizer*        GestsingleTapRecon;
@property (nonatomic,strong) UIImageView*                   CtrlViewLeft;
@property (nonatomic,strong) UIImageView*                   CtrlViewMiddle;
@property (nonatomic,strong) UIImageView*                   CtrlViewRight;
@property (nonatomic,strong) UIScrollView*                  CtrlScrollTmp;
@property (nonatomic,strong) UIPageControl*                 CtrlPage;
@property (nonatomic,strong) UIScrollView*                  CtrlScroll;
@property (nonatomic,strong) UILabel*                       CtrlLabel;
@property (nonatomic,strong) ViewInfo*                      CtrlViewInfo;
@property (nonatomic,strong) NSMutableArray*                nImagesArry;
@property (nonatomic,assign) CGRect                         rcScreen;
@property (nonatomic,assign) NSInteger                      iCurIndex;
@property (nonatomic,assign) NSInteger                      iImageNum;
@property (nonatomic,retain) id<VCPicturesSwitchDelegate>   SwitchDelegate;

@property (nonatomic,strong) ViewScrollImage* img;

//初始化self.view
- (void)IniSelfView;
//初始化缩放窗控件
- (void)IniUiScroll;
//初始化页面控件
- (void)IniUiPage;
//初始化图片框
- (void)IniUiImage;
//初始化文件名
- (void)IniUiLable;
//滑动结束事件
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
- (void)reloadImage;
- (void)SetCurrentPicture:(NSString*)strPicMainName nPicNum:(NSInteger)nPicNum;
//- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index;
- (void)HandleSingleTap:(UITapGestureRecognizer*)Reco;
@end
