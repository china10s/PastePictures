//
//  ViewInfo.m
//  PastePcitures
//
//  Created by zhulin on 15-4-1.
//  Copyright (c) 2015年 qwerzl. All rights reserved.
//

#import "ViewInfo.h"

@implementation ViewInfo

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame superView:(UIView*)superView{
    _superView = superView;
    [self IniBar];
    [self IniLabel];
    [self IniButton];
    _isBarShow = TRUE;
    return self;
}


- (void)IniBar{
    
    //up
    _ctrlUpBar = [[UIView alloc] init];
    [_ctrlUpBar setBackgroundColor:[UIColor colorWithRed:47.0f/255.0f green:134.0f/255.0f blue:235.0f/255.0f alpha:1]];
    [_ctrlUpBar setAlpha:0.3];
    [_ctrlUpBar setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_superView addSubview:_ctrlUpBar];
    [_superView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_ctrlUpBar]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_superView,_ctrlUpBar)]];
    [_superView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_ctrlUpBar(>=65)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_superView,_ctrlUpBar)]];
    
    //down
    _ctrlDownBar = [[UIView alloc] init];
    [_ctrlDownBar setBackgroundColor:[UIColor colorWithRed:47.0f/255.0f green:134.0f/255.0f blue:235.0f/255.0f alpha:1]];
    [_ctrlDownBar setAlpha:0.3];
    [_ctrlDownBar setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_superView addSubview:_ctrlDownBar];
    [_superView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_ctrlDownBar]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_superView,_ctrlDownBar)]];
    [_superView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_ctrlDownBar(>=100)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_superView,_ctrlDownBar)]];
}

- (void)IniLabel{
    _ctrlLabelInfo = [[UILabel alloc] init];
    //KVO_strLabel
    [self addObserver:self forKeyPath:@"strLabel" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"context"];
    [_superView addSubview:_ctrlLabelInfo];
}

- (void)IniButton{
    _ctrlButtonReturn = [[UIButton alloc] init];
    //[_ctrlButtonReturn setTitle:@"<" forState:UIControlStateNormal];
    [_ctrlButtonReturn setBackgroundColor:[UIColor colorWithRed:47.0f/255.0f green:134.0f/255.0f blue:235.0f/255.0f alpha:1]];
    [_ctrlUpBar addSubview:_ctrlButtonReturn];
    [_ctrlButtonReturn setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_ctrlUpBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_ctrlButtonReturn(==40)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_ctrlUpBar,_ctrlButtonReturn)]];
    [_ctrlUpBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_ctrlButtonReturn(==40)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_ctrlUpBar,_ctrlButtonReturn)]];
    [_ctrlButtonReturn addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_ctrlButtonReturn setBackgroundImage:[UIImage imageNamed:@"icon_btn_rtn.png"] forState:UIControlStateNormal];
}

//返回按钮
- (void)ButtonClick:(id)sender{
    [_delBack PicSwitchBack];
}

//KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"strLabel"]) {
        [_ctrlLabelInfo setText:[change objectForKey:@"new"]];
        return;
    }
}

//单击转换显示与否
- (void)ClickToVisableChange{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5f];
    
    if(_isBarShow){
        [_ctrlUpBar setAlpha:0];
        [_ctrlDownBar setAlpha:0];
        _isBarShow = FALSE;
    }
    else{
        [_ctrlUpBar setAlpha:0.5f];
        [_ctrlDownBar setAlpha:0.5f];
        _isBarShow = TRUE;
    }

    [UIView commitAnimations];
}
@end









