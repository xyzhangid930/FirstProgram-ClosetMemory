//
//  WebViewController.m
//  MushroomStreet
//
//  Created by LLLL on 14-5-26.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"我的衣柜" style:UIBarButtonItemStylePlain target:self action:@selector(backBarButtonItemAction:)];
    self.navigationItem.rightBarButtonItem = backBarButtonItem;
    
//    NSString *str = [NSString stringWithFormat:@"http://item.taobao.com/item.htm?id=38467142875"];
//    
//    NSURL *url = [NSURL URLWithString:@"http://item.taobao.com/item.htm?id=38467142875"];
//    NSURLRequest *resquest = [[NSURLRequest alloc]initWithURL:url];
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, 550)];
    [_webView loadRequest:_resquest];
    NSLog(@"网络请求%@",_resquest);
    [self.view addSubview:_webView];
    
	// Do any additional setup after loading the view.
}

- (void)backBarButtonItemAction:(UIBarButtonItem *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSURLRequest *)modelAttributeIndexPath:(NSIndexPath *)indexPath
{
//    NSString *strURL = [[self.list.single objectAtIndex:(indexPath.row-1)]objectForKey:@"url"];
//    NSLog(@"0000000000000000%@",strURL);
//    NSUInteger integer = strURL.length;
//    NSRange range = {7,integer-7};
//    NSString *str = [strURL substringWithRange:range];
//    NSURL *url = [NSURL URLWithString:str];
//    NSLog(@"=================%@",url);
    NSString *str = [NSString stringWithFormat:@"http://item.taobao.com/item.htm?id=38467142875"];
    
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *resquest = [[NSURLRequest alloc]initWithURL:url];
    
    return resquest;
}

@end
