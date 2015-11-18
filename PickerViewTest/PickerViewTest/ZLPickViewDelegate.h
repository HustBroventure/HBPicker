//
//  ZLPickViewDelegate.h
//  PickerViewTest
//
//  Created by wangfeng on 15/11/18.
//  Copyright (c) 2015年 HustBroventurre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ZLPickViewDelegate : NSObject<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic, strong) NSArray* areaArray;
@end
