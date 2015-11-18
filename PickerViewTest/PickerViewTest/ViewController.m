//
//  ViewController.m
//  PickerViewTest
//
//  Created by wangfeng on 15/11/18.
//  Copyright (c) 2015年 HustBroventurre. All rights reserved.
//

#import "ViewController.h"
#import "ZLPickerView.h"

@interface ViewController ()

@end

@implementation ViewController
{
    ZLPickerView* _picker;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    ZLPickerView* picker =[[ZLPickerView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 200)];
    [self.view addSubview:picker];
    _picker = picker;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)click:(id)sender {

//    [_picker showPickViewInView:self.view WithDataArray:@[@"1",@"2",@"3"] finishBlock:^(NSInteger selectedIndex, NSString *content) {
//        NSLog(@"%@",content);
//    }];
    [_picker showPickViewInView:self.view withAreasAndfinishBlock:^(NSString *areaId, NSString *areaDec) {
                  NSLog(@"%@",areaDec);

    }];

}
- (IBAction)click2:(id)sender {
            [_picker showPickViewInView:self.view WithDataArray:@[@"第一个",@"第二个",@"第三个"] finishBlock:^(NSInteger selectedIndex, NSString *content) {
                NSLog(@"%@",content);
            }];
}

@end
