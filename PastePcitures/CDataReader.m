//
//  CDataReader.m
//  JZPaste
//
//  Created by zhulin on 15-3-25.
//  Copyright (c) 2015年 qwerzl. All rights reserved.
//

#import "CDataReader.h"

@implementation CDataReader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


//初始加载
+ (CDataReader*)InitLoad
{
    static CDataReader * reader;

    @synchronized(self)
    {
        if(!reader){
            reader = [[CDataReader alloc] init];
            NSString* strProPath = [[NSBundle mainBundle] pathForResource:@"Dis2Sce2Pic" ofType:@"plist"];
            NSFileManager * manager = [NSFileManager defaultManager];
            if(![manager fileExistsAtPath:strProPath])
            {
                return nil;
            }
            reader.dData = [[NSMutableDictionary alloc] initWithContentsOfFile:strProPath];
            
            strProPath = [[NSBundle mainBundle] pathForResource:@"Chinese2English" ofType:@"plist"];
            manager = [NSFileManager defaultManager];
            if (![manager fileExistsAtPath:strProPath]) {
                return nil;
            }
            reader.dTranslator = [[NSMutableDictionary alloc] initWithContentsOfFile:strProPath];
        }
    }
    return reader;
}

//获取该城市该景点信息
+ (NSInteger)GetNumberOfPictures:(NSString*)strDisName strSceName:(NSString*)strSceName
{
    CDataReader* readerTmp = [CDataReader InitLoad];
    if(readerTmp){
        NSMutableDictionary * dSce2Pic = [readerTmp.dData objectForKey:strDisName];
        NSObject* oPicNum = [dSce2Pic objectForKey:strSceName];
        NSInteger iPicNum = [(NSString*)oPicNum integerValue];
        return iPicNum;
    }
    else{
        return 0;
    }
}


//获取当前城市所有景点
+ (NSMutableArray*)GetEnScenesOfDistrict:(NSString*)strDisName{
    CDataReader* readerTmp = [CDataReader InitLoad];
    if(readerTmp)
    {
        NSMutableArray* arry = [[NSMutableArray alloc] init];
        NSMutableDictionary * dSce2Pic = [readerTmp.dData objectForKey:strDisName];
        [dSce2Pic enumerateKeysAndObjectsUsingBlock:^(id key ,id obj ,BOOL *stop){
            [arry addObject:key];
        }];
        return arry;
    }
    else{
        return nil;
    }
}

//获取所有城市
+ (NSMutableArray*)GetCityEnName{
    CDataReader* readerTmp = [CDataReader InitLoad];
    if(readerTmp){
        NSMutableArray* arry = [[NSMutableArray alloc] init];
        [readerTmp.dData enumerateKeysAndObjectsUsingBlock:^(id key ,id obj ,BOOL *stop){
            [arry addObject:key];
        }];
        return arry;
    }
    else{
        return nil;
    }

}

//中英文转换
+ (NSString*)GetChByEn:(NSString*)strEnName{
    CDataReader* readerTmp = [CDataReader InitLoad];
    NSString* strChName = [readerTmp.dTranslator objectForKey:strEnName];
    return strChName;
}

@end
