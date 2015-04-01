//
//  CDataReader.h
//  JZPaste
//
//  Created by zhulin on 15-3-25.
//  Copyright (c) 2015年 qwerzl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDataReader : UIView

//存储数据
@property(nonatomic,strong)NSMutableDictionary* dData;


//初始加载
+ (CDataReader*)InitLoad;

//获取信息
+ (NSInteger)GetNumberOfPictures:(NSString*)strDisName strSceName:(NSString*)strSceName;

//获取当前城市所有景点
+ (NSMutableArray*)GetScenesOfDistrict:(NSString*)strDisName;

//获取所有城市
+ (NSMutableArray*)GetCity;
@end
