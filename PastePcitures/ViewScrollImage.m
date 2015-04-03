//
//  ViewScrollImage.m
//  PastePcitures
//
//  Created by zhulin on 15-4-2.
//  Copyright (c) 2015年 qwerzl. All rights reserved.
//

#import "ViewScrollImage.h"

@implementation ViewScrollImage

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    //必须得
    _CtrlScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(frame.origin.x+frame.size.width,frame.origin.y, frame.size.width, frame.size.height)];
    _CtrlScrollView.delegate = self;
    _CtrlScrollView.contentSize = frame.size;
    _CtrlScrollView.contentOffset = CGPointZero;
    //_CtrlScrollView.backgroundColor = [UIColor redColor];
    [self addSubview:_CtrlScrollView];
    _CtrlScrollView.minimumZoomScale=0.6;
    _CtrlScrollView.maximumZoomScale=3.0;
    
    _CtrlImgView = [[UIImageView alloc] initWithFrame:frame];
    _CtrlImgView.contentMode = UIViewContentModeScaleAspectFit;
    //_CtrlImgView.backgroundColor = [UIColor blueColor];
    [_CtrlScrollView addSubview:_CtrlImgView];
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _CtrlImgView;
}

@end
