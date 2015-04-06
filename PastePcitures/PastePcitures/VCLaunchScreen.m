//
//  VCLaunchScreen.m
//  PastePcitures
//
//  Created by zhulin on 15-4-4.
//  Copyright (c) 2015年 qwerzl. All rights reserved.
//

#import "VCLaunchScreen.h"

@interface VCLaunchScreen ()

@end

@implementation VCLaunchScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = [UIScreen mainScreen].bounds;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)viewWillAppear:(BOOL)animated{
    //[self.view setBackgroundColor:[UIColor redColor]];
    [super viewWillAppear:animated];
    self.view.frame = [UIScreen mainScreen].bounds;
}

@end
