//
//  PickerView.h
//  hqd
//
//  Created by YuanDee on 15/6/28.
//  Copyright (c) 2015年 Mucfc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^pickerConfirmBlockWithContent)(NSInteger selectedIndex,NSString* content);
typedef void(^pickerConfirmBlockWithAreaId)(NSString* areaId,NSString* areaDec);

@interface ZLPickerView : UIView
@property(nonatomic, strong)UIPickerView *pickerView;


-(void)showPickViewInView:(UIView*)view WithDataArray:(NSArray *)dataArray finishBlock:(pickerConfirmBlockWithContent)finishBlock;
    //数组中放入的是数组，每一组是一列

-(void)showPickViewInView:(UIView *)view withAreasAndfinishBlock:(pickerConfirmBlockWithAreaId)finishBlock;
@end
