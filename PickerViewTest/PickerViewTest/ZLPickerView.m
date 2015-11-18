//
//  PickerView.m
//  hqd
//
//  Created by YuanDee on 15/6/28.
//  Copyright (c) 2015年 Mucfc. All rights reserved.
//

#import "ZLPickerView.h"
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@interface ZLPickerView()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic, strong)UIView *bgView;
@property (nonatomic, strong)UIButton *cancelButton;
@property (nonatomic, strong)UIButton *confirmButton;
@property (nonatomic, strong) NSArray* areaArray;
@end

@implementation ZLPickerView
{
    NSUInteger _componentNum;
    NSArray* _titleArray;
    NSArray* _titleArraies;
    pickerConfirmBlockWithContent _finishBlock;
    UIView* _parentView;

    NSArray *_arr1;
    NSArray *_arr2;
    NSArray *_arr3;
    BOOL    _isAreaPicker;
    pickerConfirmBlockWithAreaId _areaFinishBlock;
}
- (id)init
{
    if (self=[super init]) {
        [self initSubview];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self initSubview];
    }
    return self;
}

- (void)initSubview
{
    [self addSubview:self.bgView];
    [self.bgView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.bgView addSubview:self.cancelButton];
    [self.cancelButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView);
        make.top.equalTo(self.bgView).offset(2);
        make.height.equalTo(40);
        make.width.equalTo(80);
    }];
    
    [self.bgView addSubview:self.confirmButton];
    [self.confirmButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_bgView);
        make.top.equalTo(self.bgView).offset(2);
        make.height.equalTo(40);
        make.width.equalTo(80);
    }];
    
    [self addSubview:self.pickerView];
    [self.pickerView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cancelButton.bottom);
        make.centerX.equalTo(_bgView);
        make.left.right.equalTo(_bgView);
        make.height.equalTo(150);
    }];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;

}

#pragma mark - event response
- (void)cancelButtonClick
{
    [self hidePickViewInView:_parentView];
}

- (void)confirmButtonClick
{
    if (_isAreaPicker) {
        NSInteger i = [self.pickerView selectedRowInComponent:0];
        NSInteger j = [self.pickerView selectedRowInComponent:1];
        NSInteger k = [self.pickerView selectedRowInComponent:2];

        NSString *str1 = [[_arr1 objectAtIndex:i] objectForKey:@"areaName" ];
        NSString *str2 = [[_arr2 objectAtIndex:j]objectForKey:@"areaName" ];
        NSString* idArea = [[_arr2 objectAtIndex:j] objectForKey:@"areaId" ];
        NSString* str3 = @"";

        if (_arr3.count > 0) {
            str3 = [[_arr3 objectAtIndex:k] objectForKey:@"areaName" ];
            idArea = [[_arr3 objectAtIndex:k] objectForKey:@"areaId" ];
        }
            NSString* content = [NSString stringWithFormat:@"%@ %@ %@", str1, str2, str3];
        if (_areaFinishBlock) {
            _areaFinishBlock(idArea,content);
        }
         [self hidePickViewInView:_parentView];
        
            return;

    }
    NSUInteger selectIndex = [self.pickerView selectedRowInComponent:0];
    NSString* title = [_titleArray objectAtIndex:selectIndex];
    if (_finishBlock) {
        _finishBlock(selectIndex,title);
    }
    [self hidePickViewInView:_parentView];
}

#pragma -mark -getter
- (UIView*)bgView
{
    if (_bgView==nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

- (UIPickerView*)pickerView
{
    if (_pickerView==nil) {
        _pickerView = [[UIPickerView alloc] init];
    }
    return _pickerView;
}

- (UIButton*)cancelButton
{
    if (_cancelButton==nil) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UIButton*)confirmButton
{
    if (_confirmButton==nil) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmButton setTitle:@"完成" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

-(void)showPickViewInView:(UIView*)view WithDataArray:(NSArray *)dataArray finishBlock:(pickerConfirmBlockWithContent)finishBlock
{
    _isAreaPicker = NO;
    _titleArray = dataArray;
    _componentNum = dataArray.count;
    _finishBlock = finishBlock;
    _parentView = view;
    [self.pickerView reloadAllComponents];
    [self showPickViewInView:view];
}
-(void)showPickViewInView:(UIView *)view withAreasAndfinishBlock:(pickerConfirmBlockWithAreaId)finishBlock
{
    _isAreaPicker = YES;
    _areaFinishBlock = finishBlock;
    _parentView = view;

    _arr1 = self.areaArray;
    _arr2 = self.areaArray[0][@"cities"];
    _arr3 = _arr2[0][@"countries"];

    [self.pickerView reloadAllComponents];
    [self showPickViewInView:view];
}
#pragma mark -- delegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (_isAreaPicker) {
        return 3;
    }
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (_isAreaPicker) {
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
    return _titleArray.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (_isAreaPicker) {
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
    return _titleArray[row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (!_isAreaPicker) {
        return;
    }
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
        if (!_isAreaPicker) {
            [pickerLabel setFont:[UIFont systemFontOfSize:22]];
        }else
            [pickerLabel setFont:[UIFont boldSystemFontOfSize:18]];
    }
        // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}




-(void)showPickViewInView:(UIView*)view
{
    if (!self.superview) {
        [view addSubview:self];
    }
    [UIView animateWithDuration:0.4 animations:^{
        CGRect frame = self.frame;
        frame.origin.y = view.frame.size.height - self.frame.size.height;
        self.frame = frame;
    }];
}
-(void)hidePickViewInView:(UIView*)view
{
    [UIView animateWithDuration:0.4 animations:^{
        CGRect frame = self.frame;
        frame.origin.y = view.frame.size.height ;
        self.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];

}
-(NSArray *)areaArray{
    if (!_areaArray) {
        _areaArray = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cities" ofType:@"plist"]];
    }
    return _areaArray;
}

@end
