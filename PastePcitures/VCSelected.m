//
//  VCSelected.m
//  PastePcitures
//
//  Created by zhulin on 15-3-29.
//  Copyright (c) 2015年 qwerzl. All rights reserved.
//

#import "VCSelected.h"
#import "CDataReader.h"

#define KButtonHeight 80

@interface VCSelected ()

@end

@implementation VCSelected

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = [[UIScreen mainScreen] bounds];
    // Do any additional setup after loading the view from its nib.
    _CtrlScroll = [[UIScrollView alloc] init];
    _arryDistrict = [CDataReader GetCityEnName];
    
    NSMutableArray *mutDisChName = [[NSMutableArray alloc] init];
    [_arryDistrict enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        [mutDisChName addObject:[CDataReader GetChByEn:obj]];
    }];
    _CtrlSegment = [[UISegmentedControl alloc] initWithItems:mutDisChName];
    _CtrlSegment.selectedSegmentIndex = 0;
    
    [self.view addSubview:_CtrlSegment];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_CtrlSegment]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self.view,_CtrlSegment)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-40-[_CtrlSegment]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self.view,_CtrlSegment)]];
    [_CtrlSegment setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_CtrlSegment addTarget:self action:@selector(ValChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:_CtrlScroll];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_CtrlScroll]-20-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self.view,_CtrlScroll)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-70-[_CtrlScroll]-40-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self.view,_CtrlScroll)]];
    [_CtrlScroll setTranslatesAutoresizingMaskIntoConstraints:NO];
    _CtrlScroll.contentOffset = CGPointMake(0,0);
    _CtrlScroll.showsVerticalScrollIndicator = FALSE;
}

//- (id)init{
//    return self;
//}


//初始化
- (void)viewWillAppear:(BOOL)animated{
    if (_arryDistrict && _arryDistrict.count  > 0) {
        [self ValChanged:nil];
    }
    [super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 //- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 //}


- (void)ValChanged:(UISegmentedControl *)sender {
    NSInteger selIndex = _CtrlSegment.selectedSegmentIndex;
    [self SelectDistrict:selIndex];
}

- (void)SelectDistrict:(NSInteger)intDistrictIndex{
    //清空所有按钮
    for(UIView * viewTmp in [_CtrlScroll subviews]){
        [viewTmp removeFromSuperview];
    }
    _intScenesCount = 0;
    _strCurDicName =[_arryDistrict objectAtIndex:intDistrictIndex];
    NSMutableArray* arry = [CDataReader GetEnScenesOfDistrict:_strCurDicName];
    for (NSString* strTmpName in arry) {
        [self CreateScenes:strTmpName ];
    }
}

- (void)CreateScenes:(NSString*)strSelDistrict{
    //FeRippleButton * a_button=[[FeRippleButton alloc] initWithFrame:CGRectMake(0, 0,
                //self.view.frame.size.width -10 , KButtonHeight)];
    UIButton * a_button=[[UIButton alloc] initWithFrame:CGRectMake(0, 0,
                                                                   self.view.frame.size.width -10 , KButtonHeight)];
    a_button.tag = _intScenesCount;
    a_button.center = CGPointMake(self.view.center.x-20, 50 + _intScenesCount*(KButtonHeight+2));
    [a_button setTitle:[CDataReader GetChByEn:strSelDistrict] forState:UIControlStateNormal];
    [a_button setTag:_intScenesCount];
    a_button.backgroundColor = [UIColor colorWithRed:47.0f/255.0f green:134.0f/255.0f blue:235.0f/255.0f alpha:1];
    [a_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    a_button.titleLabel.font = [UIFont boldSystemFontOfSize:22];
    
    // Configure
    //a_button.rippleColor = [UIColor colorWithRed:33.0f/255.0f green:101.0f/255.0f blue:196.0f/255.0f alpha:1];
    //a_button.rippleBackgroundColor = [UIColor colorWithRed:42.0f/255.0f green:119.0f/255.0f blue:218.0f/255.0f alpha:1];
    [a_button addTarget:self action:@selector(SceneSelected:) forControlEvents:UIControlEventTouchUpInside];
    [_CtrlScroll addSubview:a_button];
    _CtrlScroll.contentSize = CGSizeMake(_CtrlScroll.contentSize.width,++_intScenesCount*(KButtonHeight+2) + KButtonHeight/2 );
}

- (void)SceneSelected:(UIButton*)sender
{
    NSInteger intIndex = ((UIButton*)sender).tag;
    NSMutableArray* arry = [CDataReader GetEnScenesOfDistrict:_strCurDicName];
    NSString* strSceneName = [arry objectAtIndex:intIndex];
    [_SwitchDelegate Seleted:_strCurDicName strSceneName:strSceneName];
}





@end
