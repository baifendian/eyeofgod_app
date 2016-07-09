//
//  MainViewController.m
//  Thehandofgod
//
//  Created by linde on 16/7/7.
//  Copyright © 2016年 linde. All rights reserved.
//

#import "MainViewController.h"
#import "SettingViewController.h"
#import "DetailViewController.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    self.title=@"上帝之手";
      self.path=@"overview.html";
 
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton * leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame=CGRectMake(0, 0, 25, 25);
    [leftBtn addTarget:self action:NSSelectorFromString(@"leftView") forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"MQQAssist_DefaultHeadshot"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(webAction:) name:@"webAction" object:nil];
    
    
//   NSNumber * isfist = [[NSUserDefaults standardUserDefaults]objectForKey:@"isfist"];
//    if (!isfist) {
//        [self leftView];
//    }
    
    
}
-(void)webAction:(NSNotification*)obj{
    NSDictionary * dict=obj.object;
  
    if ([dict[@"cmd"] isEqualToString:@"pushViewController"] ) {
         [self pushToInfoView:dict[@"path"]];
    }else if([dict[@"cmd"] isEqualToString:@"dissmiss"] ){
        [self loadData];
    }else{
        if (dict[@"msg"]) {
              [self pushToInfoView:dict[@"msg"]];
        }
    
    }
    
    
    

}
-(void)leftView{
    
    UIStoryboard *  storyboard =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
   
    
    BaseViewController * baseViewController  = [storyboard instantiateViewControllerWithIdentifier:@"SettingViewController"];
    baseViewController.path=@"registered.html";
    
    UINavigationController * nav =[[UINavigationController  alloc]initWithRootViewController:baseViewController ];
    [self presentViewController:nav animated:YES completion:nil];


}
-(void)pushToInfoView:(NSString *)url{
   
        UIStoryboard *  storyboard =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        BaseViewController * baseViewController  = [storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
       baseViewController.path=url;
    [self.navigationController pushViewController:baseViewController animated:YES];
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
