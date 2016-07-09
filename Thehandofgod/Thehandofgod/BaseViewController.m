//
//  ViewController.m
//  Thehandofgod
//
//  Created by linde on 16/7/7.
//  Copyright © 2016年 linde. All rights reserved.
//

#import "BaseViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <AdSupport/AdSupport.h>
#import "WKProgressHUD.h"
#import "BFDMarsURLConnection.h"
@interface BaseViewController ()<UIWebViewDelegate>
{
    WKProgressHUD *hud ;
}


@property (strong,nonatomic) UIWebView * webView;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
       self.baseUrl=@"http://192.168.1.140:9000/app/page/";

    
    
    self.webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    self.webView.delegate=self;
    [self.view addSubview:self.webView];
    
    [self loadData];
    

    
}
-(void)loadData{
    NSString  * mac =[NSString stringWithFormat:@"mac=%@",[self  getDefultInfo]];
    hud = [WKProgressHUD showInView:self.view withText:@"加载中" animated:YES];
    NSData * params =[mac dataUsingEncoding:NSUTF8StringEncoding];
    [BFDMarsURLConnection BFDURL_POSTRequestWithUrl:[NSString stringWithFormat:@"%@%@",self.baseUrl,self.path] Params:params successBlock:^(NSString *json) {
        [self.webView loadHTMLString:json baseURL:[NSURL URLWithString:_baseUrl]];
    } failedBlock:^(NSError *error) {
        [hud dismiss:YES];
        [WKProgressHUD popMessage:@"网络异常" inView:self.view duration:1.5 animated:YES];
    }];

}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    JSContext *context=[_webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    NSString *urlString =[[request URL] absoluteString];
    
    NSArray *urlComps = [urlString
                         componentsSeparatedByString:@"?"];
    if ([urlComps count] >1) {
        urlComps = [urlComps[1]
                    componentsSeparatedByString:@"&"];
    }
    if ([[urlComps objectAtIndex:0]
         isEqualToString:@"callobjectC"]) {
        
            if( [[urlComps objectAtIndex:1]
                 isEqualToString:@"pushViewController"])
            {
                [[NSNotificationCenter defaultCenter]postNotificationName:@"webAction" object:[NSDictionary dictionaryWithObjectsAndKeys:urlComps[1],@"cmd",urlComps[2],@"path", nil]];
                
            }else if([[urlComps objectAtIndex:1]
                      isEqualToString:@"deviceToken"]){
                NSString * js=[NSString stringWithFormat:@"getDeviceToken('%@')",[self getDeviceToken]];
                 [context evaluateScript:js];
            
            }else if([[urlComps objectAtIndex:1]
                      isEqualToString:@"mac"]){
                NSString * js=[NSString stringWithFormat:@"getMac('%@')",[self getDefultInfo]];
                [context evaluateScript:js];
                
            }else if([[urlComps objectAtIndex:1]
                      isEqualToString:@"dissmiss"]){
                [self dismissViewControllerAnimated:YES completion:^{
                          [[NSNotificationCenter defaultCenter]postNotificationName:@"webAction" object:[NSDictionary dictionaryWithObjectsAndKeys:@"dissmiss",@"cmd" ,nil]];
                }];
                
    
                
            }
        
        
        return NO;
        
    }
   
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{


}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    
    
[webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
  [hud dismiss:YES];

}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
    [WKProgressHUD popMessage:@"网络异常" inView:self.view duration:1.5 animated:YES];

}
-(NSString *)getDefultInfo{

return   [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
}
-(NSString *)getDeviceToken{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"deviceToken"];;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
