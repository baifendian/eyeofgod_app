//
//  SettingViewController.m
//  Thehandofgod
//
//  Created by linde on 16/7/8.
//  Copyright © 2016年 linde. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title=@"个人中心";
    UIButton * leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame=CGRectMake(0, 0, 24, 36);
    [leftBtn addTarget:self action:NSSelectorFromString(@"back") forControlEvents:UIControlEventTouchUpInside];

    [leftBtn setImage:[UIImage imageNamed:@"MQQAssist_Arrow_Black"] forState:UIControlStateNormal];
   leftBtn.imageEdgeInsets=UIEdgeInsetsMake(-2, -2, -2, -2);
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftBtn];
}
-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];

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

@end
