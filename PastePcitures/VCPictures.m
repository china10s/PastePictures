//
//  VCPictures.m
//  PastePcitures
//
//  Created by zhulin on 15-3-29.
//  Copyright (c) 2015年 qwerzl. All rights reserved.
//

#import "VCPictures.h"

@implementation UIScrollViewPictures

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    return TRUE;
}

@end

@interface VCPictures ()

@end

@implementation VCPictures

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    _rcScreen = [UIScreen mainScreen].bounds;
    _nImagesArry = [[NSMutableArray alloc] init];
    return  self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self IniSelfView];
    [self IniUiScroll];
    [self IniUiPage];
    [self IniUiImage];
    //[self IniUiLable];
    [self IniViewInfo];
    [self IniGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reloadImage];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//初始化事件
- (void)IniGesture{
    _GestsingleTapRecon = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(HandleSingleTap:)];
    _GestsingleTapRecon.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:_GestsingleTapRecon];
}


//设置当前图片列
- (void)SetCurrentPicture:(NSString*)strPicMainName nPicNum:(NSInteger)nPicNum{
    [_nImagesArry removeAllObjects];
    for (int i = 0; i < nPicNum; ++i) {
        [_nImagesArry addObject:[[NSString alloc] initWithFormat:@"%@%ld.jpg",strPicMainName,(long)i+1]];
    }
    _iImageNum = nPicNum;
    _iCurIndex = 0;
    _CtrlPage.numberOfPages = _iImageNum;
}

//设置当前图片名称
- (void)SetCurName:(NSString*)strPicMainName{
    _strCurName = strPicMainName;
}

- (void)IniSelfView{
    self.view.frame = _rcScreen;
}

- (void)IniViewInfo{
    _CtrlViewInfo = [[ViewInfo alloc]initWithFrame:_rcScreen superView:self.view];
    _CtrlViewInfo.delBack = self;
}

- (void)PicSwitchBack{
    [_SwitchDelegate PicSwitchBack];
}

//初始化缩放窗控件
- (void)IniUiScroll{
    self.CtrlScroll = [[UIScrollViewPictures alloc] initWithFrame:_rcScreen];
    self.CtrlScroll.delegate = self;
    self.CtrlScroll.contentSize = CGSizeMake(_rcScreen.size.width*3,_rcScreen.size.height);
    [self.CtrlScroll setContentOffset:CGPointMake(_rcScreen.size.width, 0)];
    self.CtrlScroll.pagingEnabled = YES;
    self.CtrlScroll.showsHorizontalScrollIndicator=NO;
    self.CtrlScroll.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    [self.view addSubview:_CtrlScroll];
    //test
    self.CtrlScroll.minimumZoomScale=1;
    self.CtrlScroll.maximumZoomScale=1;
}

//初始化页面控件
- (void)IniUiPage{
    _CtrlPage = [[UIPageControl alloc] init];
    CGSize size = [_CtrlPage sizeForNumberOfPages:_iImageNum];
    _CtrlPage.bounds = CGRectMake(0, 0, size.width, size.height);
    _CtrlPage.center = CGPointMake(_rcScreen.size.width/2, _rcScreen.size.height-100);
    _CtrlPage.pageIndicatorTintColor = [UIColor colorWithRed:140/255.0 green:140/255.0 blue:140/255.0  alpha:1];
    _CtrlPage.currentPageIndicatorTintColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
    _CtrlPage.numberOfPages = _iImageNum;
    
    [self.view addSubview:_CtrlPage];
}

//初始化图片框
- (void)IniUiImage{
    //左边ImageView
    _CtrlViewLeft = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,
                                                                  _rcScreen.size.width, _rcScreen.size.height)];
    _CtrlViewLeft.contentMode=UIViewContentModeScaleAspectFit;
    [_CtrlScroll addSubview:_CtrlViewLeft];
    
    //中间ImageView
    _img = [[ViewScrollImage alloc] initWithFrame:_rcScreen];
    [_CtrlScroll addSubview:_img];
    
    //右边ImageView
    _CtrlViewRight = [[UIImageView alloc] initWithFrame:CGRectMake(2*_rcScreen.size.width, 0,
                                                                   _rcScreen.size.width, _rcScreen.size.height)];
    _CtrlViewRight.contentMode=UIViewContentModeScaleAspectFit;
    [_CtrlScroll addSubview:_CtrlViewRight];
}


//滚动结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self reloadImage];
    //移动到正中位置
    [_CtrlScroll setContentOffset:CGPointMake(_rcScreen.size.width, 0)];
    //pagectrl控制
    _CtrlPage.currentPage = _iCurIndex;
}

- (void)reloadImage{
    CGPoint offset=[_CtrlScroll contentOffset];
    int ileftImageIndex,iRightImageIndex;
    if (offset.x >_rcScreen.size.width) {//右滑
        _iCurIndex = (_iCurIndex+1)%_iImageNum;
    }else if(offset.x <_rcScreen.size.width){//左滑
        _iCurIndex = (_iCurIndex+_iImageNum-1)%_iImageNum;
    }
    ileftImageIndex = (_iCurIndex + _iImageNum -1)%_iImageNum;
    iRightImageIndex = (_iCurIndex +1)%_iImageNum;
    //_CtrlViewMiddle.image=[UIImage imageNamed:[_nImagesArry objectAtIndex:_iCurIndex]];
    _CtrlViewLeft.image=[UIImage imageNamed:[_nImagesArry objectAtIndex:ileftImageIndex]];
    _CtrlViewRight.image=[UIImage imageNamed:[_nImagesArry objectAtIndex:iRightImageIndex]];
    
    _img.CtrlImgView.image=[UIImage imageNamed:[_nImagesArry objectAtIndex:_iCurIndex]];
    [_img.CtrlScrollView setZoomScale:1];
    
    //设置图片名称
    [self.CtrlViewInfo SetLabelText:_strCurName];
}

- (void)HandleSingleTap:(UITapGestureRecognizer*)Reco{
    [_CtrlViewInfo ClickToVisableChange];
}

@end
