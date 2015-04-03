//
//  VCPictures.m
//  PastePcitures
//
//  Created by zhulin on 15-3-29.
//  Copyright (c) 2015年 qwerzl. All rights reserved.
//

#import "VCPictures.h"

@interface VCPictures ()

@end

@implementation VCPictures

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _rcScreen = [UIScreen mainScreen].bounds;
    _nImagesArry = [[NSMutableArray alloc] init];
    [self IniSelfView];
    [self IniUiScroll];
    [self IniUiPage];
    [self IniUiImage];
    [self IniUiLable];
    [self IniViewInfo];
    [self IniGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{/*
    _rcScreen = [UIScreen mainScreen].bounds;
    _nImagesArry = [[NSMutableArray alloc] init];
    [self IniSelfView];
    [self IniUiScroll];
    [self IniUiPage];
    [self IniUiImage];
    [self IniUiLable];
    [self IniViewInfo];*/
    [super viewWillAppear:animated];
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
    [self reloadImage];
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
    _CtrlScroll = [[UIScrollView alloc] initWithFrame:_rcScreen];
    _CtrlScroll.delegate = self;
    _CtrlScroll.contentSize = CGSizeMake(_rcScreen.size.width*3,_rcScreen.size.height);
    [_CtrlScroll setContentOffset:CGPointMake(_rcScreen.size.width, 0)];
    _CtrlScroll.pagingEnabled = YES;
    _CtrlScroll.showsHorizontalScrollIndicator=NO;
    //[_CtrlScroll setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:_CtrlScroll];
}

//初始化页面控件
- (void)IniUiPage{
    //左边ImageView
    _CtrlViewLeft = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,
                                                                  _rcScreen.size.width, _rcScreen.size.height)];
    _CtrlViewLeft.contentMode=UIViewContentModeScaleAspectFit;
    [_CtrlScroll addSubview:_CtrlViewLeft];
    
    //中间ImageView
    _img = [[ViewScrollImage alloc] initWithFrame:_rcScreen];
    [_CtrlScroll addSubview:_img];
    /*
    _CtrlViewMiddle = [[UIImageView alloc] initWithFrame:CGRectMake(_rcScreen.size.width, 0,
                                                                  _rcScreen.size.width, _rcScreen.size.height)];
    _CtrlViewMiddle.contentMode=UIViewContentModeScaleAspectFit;
    //[_CtrlScroll addSubview:_CtrlViewMiddle];
    _CtrlScrollTmp = [[UIScrollView alloc] initWithFrame:CGRectMake(_rcScreen.size.width, 0,
                                                                    _rcScreen.size.width, _rcScreen.size.height)];
    _CtrlScrollTmp.contentOffset =CGPointZero;
    _CtrlScrollTmp.contentSize=_rcScreen.size;
    _CtrlScrollTmp.backgroundColor = [UIColor redColor];
    _CtrlScrollTmp.contentMode = UIViewContentModeScaleAspectFit;
    _CtrlScrollTmp.delegate = self;
        [_CtrlScroll addSubview:_CtrlScrollTmp];
    [_CtrlScrollTmp addSubview:_CtrlViewMiddle];
    */
    //右边ImageView
    _CtrlViewRight = [[UIImageView alloc] initWithFrame:CGRectMake(2*_rcScreen.size.width, 0,
                                                                  _rcScreen.size.width, _rcScreen.size.height)];
    _CtrlViewRight.contentMode=UIViewContentModeScaleAspectFit;
    [_CtrlScroll addSubview:_CtrlViewRight];
    if (_iImageNum > 0) {
        _CtrlViewLeft.image=[UIImage imageNamed:[_nImagesArry objectAtIndex:_iImageNum-1]];
        _CtrlViewMiddle.image=[UIImage imageNamed:[_nImagesArry objectAtIndex:0]];
        _CtrlViewRight.image=[UIImage imageNamed:[_nImagesArry objectAtIndex:1]];
    }
}

//初始化图片框
- (void)IniUiImage{
    
}

//初始化文件名
- (void)IniUiLable{
    
}



//滚动结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self reloadImage];
    //移动到正中位置
    [_CtrlScroll setContentOffset:CGPointMake(_rcScreen.size.width, 0)];
}

- (void)reloadImage{
    CGPoint offset=[_CtrlScroll contentOffset];
    int ileftImageIndex,iRightImageIndex;
    if (offset.x >_rcScreen.size.width) {//右滑
        _iCurIndex = (_iCurIndex+_iImageNum-1)%_iImageNum;
    }else if(offset.x <_rcScreen.size.width){//左滑
        _iCurIndex = (_iCurIndex+1)%_iImageNum;
    }
    iRightImageIndex = (_iCurIndex + _iImageNum -1)%_iImageNum;
    ileftImageIndex = (_iCurIndex +1)%_iImageNum;
    _CtrlViewMiddle.image=[UIImage imageNamed:[_nImagesArry objectAtIndex:_iCurIndex]];
    _CtrlViewLeft.image=[UIImage imageNamed:[_nImagesArry objectAtIndex:ileftImageIndex]];
    _CtrlViewRight.image=[UIImage imageNamed:[_nImagesArry objectAtIndex:iRightImageIndex]];
    
    _img.CtrlImgView.image=[UIImage imageNamed:[_nImagesArry objectAtIndex:_iCurIndex]];
    CGRect rect1= _img.frame;
    CGRect rect2= _img.CtrlImgView.frame;
    CGRect rect3= _img.CtrlScrollView.frame;
}

- (void)HandleSingleTap:(UITapGestureRecognizer*)Reco{
    [_CtrlViewInfo ClickToVisableChange];
}



@end
