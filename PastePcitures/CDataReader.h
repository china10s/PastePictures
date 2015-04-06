//
//  CDataReader.h
//  JZPaste
//
//  Created by zhulin on 15-3-25.
//  Copyright (c) 2015年 qwerzl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDataReader : UIView

//存储图片数据
@property(nonatomic,strong)NSMutableDictionary* dData;

//存储中英文转换
@property(nonatomic,strong)NSMutableDictionary* dTranslator;

//初始加载
+ (CDataReader*)InitLoad;

//获取信息
+ (NSInteger)GetNumberOfPictures:(NSString*)strDisName strSceName:(NSString*)strSceName;

//获取当前城市所有景点
+ (NSMutableArray*)GetEnScenesOfDistrict:(NSString*)strDisName;

//获取所有城市
+ (NSMutableArray*)GetCityEnName;

//中英文转换
+ (NSString*)GetChByEn:(NSString*)strEnName;


@end
