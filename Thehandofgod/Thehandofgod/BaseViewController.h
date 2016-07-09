//
//  ViewController.h
//  Thehandofgod
//
//  Created by linde on 16/7/7.
//  Copyright © 2016年 linde. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property(strong,nonatomic)   NSString * baseUrl;
@property (strong,nonatomic) NSString * path;
-(void)loadData;
@end

