//
//  ViewScrollImage.h
//  PastePcitures
//
//  Created by zhulin on 15-4-2.
//  Copyright (c) 2015年 qwerzl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewScrollImage : UIView<UIScrollViewDelegate>

@property (nonatomic,strong)UIImageView *CtrlImgView;
@property (nonatomic,strong)UIScrollView *CtrlScrollView;
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView;
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event;
- (void)zoomInOrOut;
@end
