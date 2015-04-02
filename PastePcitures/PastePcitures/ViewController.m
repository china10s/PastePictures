//
//  ViewController.m
//  PastePcitures
//
//  Created by zhulin on 15-3-29.
//  Copyright (c) 2015年 qwerzl. All rights reserved.
//

#import "ViewController.h"
#import "CDataReader.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //1】初始化照片viewControl
    _vcPictures = [[VCPictures alloc] init];
    [[NSBundle mainBundle] loadNibNamed:@"VCPictures" owner:_vcPictures options:nil];
    _vcPictures.SwitchDelegate = self;
    //_vcPictures.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self addChildViewController:_vcPictures];
    //2】初始化选择viewControl
    _vcSelected = [[VCSelected alloc] init];
    [[NSBundle mainBundle] loadNibNamed:@"VCSelected" owner:_vcSelected options:nil];
    _vcSelected.SwitchDelegate = self;
    [self addChildViewController:_vcSelected];
    //3】将选择Control首先加载上去
    [self.view addSubview:_vcSelected.view];
    [_vcSelected viewDidLoad];
    [_vcPictures viewDidLoad];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

//选择地区
- (void)Seleted:(NSString*)strDistrictName strSceneName:(NSString*)strSceneName{
    NSString* strPicName = [[NSString alloc] initWithFormat:@"%@_%@",strDistrictName,strSceneName];
    NSInteger nPicNum = [CDataReader GetNumberOfPictures:strDistrictName strSceName:strSceneName];
    [self ReplaceControllor:(ViewController*)_vcSelected toCont:(ViewController*)_vcPictures leftTurn:TRUE finishedBlock:^(){
        [_vcPictures SetCurrentPicture:strPicName nPicNum:nPicNum];
    }];
}

//图片view切换到选择view
- (void)PicSwitchBack{
    [self ReplaceControllor:(ViewController*)_vcPictures toCont:(ViewController*)_vcSelected  leftTurn:FALSE finishedBlock:nil] ;
}

//转换view
- (void)ReplaceControllor:(ViewController*)fromCont toCont:(ViewController*)toCont leftTurn:(BOOL)leftTurn 
            finishedBlock:(void (^) (void) )finishedBlock {
    UIViewAnimationOptions option = UIViewAnimationOptionTransitionFlipFromRight;
    if (leftTurn) {
        option = UIViewAnimationOptionTransitionFlipFromLeft;
    }
    else{
        option = UIViewAnimationOptionTransitionFlipFromRight;
    }
    [self transitionFromViewController:fromCont toViewController:toCont duration:0.7 options:option animations:nil completion:^(BOOL finished){
        if (finished) {
            if (finishedBlock) {
                finishedBlock();
            }
            [toCont didMoveToParentViewController:self];
            [fromCont willMoveToParentViewController:nil];
            //[fromCont removeFromParentViewController];
        }
    }];
}


@end
