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
    
    _CtrlScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(frame.origin.x+frame.size.width,frame.origin.y, frame.size.width, frame.size.height)];
    _CtrlScrollView.delegate = self;
    _CtrlScrollView.contentSize = frame.size;
    _CtrlScrollView.contentOffset = CGPointZero;
    _CtrlScrollView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    [self addSubview:_CtrlScrollView];
    _CtrlScrollView.minimumZoomScale=1;
    _CtrlScrollView.maximumZoomScale=2;
    
    _CtrlImgView = [[UIImageView alloc] initWithFrame:frame];
    _CtrlImgView.contentMode = UIViewContentModeScaleAspectFit;
    _CtrlImgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
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
//放大
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _CtrlImgView;
}
//缩的比图框小后，要放置在中心位置
-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    CGSize originalSize=_CtrlScrollView.bounds.size;
    CGSize contentSize=_CtrlScrollView.contentSize;
    CGFloat offsetX=originalSize.width>contentSize.width?(originalSize.width-contentSize.width)/2:0;
    CGFloat offsetY=originalSize.height>contentSize.height?(originalSize.height-contentSize.height)/2:0;
    
    _CtrlImgView.center=CGPointMake(contentSize.width/2+offsetX, contentSize.height/2+offsetY);
}

//事件传递给子类
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    return TRUE;
}
@end
