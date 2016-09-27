//
//  ViewController.m
//  FQInteraction
//
//  Created by 冯倩 on 16/9/27.
//  Copyright © 2016年 冯倩. All rights reserved.
//

#import "ViewController.h"
#import "TViewController.h"

@interface ViewController ()<UIWebViewDelegate>
{
    UIWebView  *_webView;
    JSContext  *_jsContext;
}


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(10, 100, 300, 450)];
    _webView.backgroundColor = [UIColor whiteColor];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"JS_OC" withExtension:@"html"];
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    _jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    _jsContext[@"appJsContext"] = self;
    
    //第一种
    JSValue *shareCallback = _jsContext[@"refreshPage"];
    [shareCallback callWithArguments:nil];
}
//第二种
- (id)getUserInfo
{
    return @{@"state":@"login"};
}

//第三种
- (void)showView:(NSString *)str
{
    NSLog(@"str:%@", str);
    //备注:JS的交互都是在子线程进行,若直接跳转,也是在子线程中跳转,无法做刷新 UI 等操作,必须手动回到子线程
    dispatch_async(dispatch_get_main_queue(), ^
                   {
                       NSLog(@"页面1内 - 当前线程为%@",[NSThread currentThread]);
                       TViewController *vc = [[TViewController alloc] init];
                       [self.navigationController pushViewController:vc animated:YES];
                   });
}

@end
