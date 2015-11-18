//
//  ZLPickViewDelegate.m
//  PickerViewTest
//
//  Created by wangfeng on 15/11/18.
//  Copyright (c) 2015年 HustBroventurre. All rights reserved.
//

#import "ZLPickViewDelegate.h"

@implementation ZLPickViewDelegate
{
    NSArray *_arr1;
    NSArray *_arr2;
    NSArray *_arr3;

}
-(instancetype)init
{
    if (self = [super init]) {
        _arr1 = self.areaArray;
        _arr2 = self.areaArray[0][@"cities"];
        _arr3 = _arr2[0][@"countries"];
    }
    return self;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{

        return 3;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
        switch (component) {
            case 0:
                return _arr1.count;
                break;
            case 1:
                return [_arr2 count];
                break;
            case 2:
                return [_arr3 count];
                break;
            default:
                break;
        }
        return 0;

}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
        switch (component) {
            case 0:
                return [_arr1 objectAtIndex:row][@"areaName"];
                break;
            case 1:
                return [_arr2 objectAtIndex:row][@"areaName"];
                break;
            case 2:
                return [_arr3 objectAtIndex:row][@"areaName"];
                break;
            default:
                break;



    }
     return @"";
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
        switch (component) {
        case 0:

            _arr2 = _arr1[row][@"cities"];
            [pickerView reloadComponent:1];
            [pickerView selectRow:0 inComponent:1 animated:YES];
            _arr3 = _arr2[0][@"countries"];
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:2 animated:YES];

            break;
        case 1:
            _arr3 = _arr2[row][@"countries"];
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:2 animated:YES];
            break;
        case 2:
            break;
        default:
            break;
    }

}



- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{

    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];

        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:20]];
    }
        // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}
-(NSArray *)areaArray{
    if (!_areaArray) {
        _areaArray = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cities" ofType:@"plist"]];
    }
    return _areaArray;
}
@end
