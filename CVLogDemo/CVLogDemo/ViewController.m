//
//  ViewController.m
//  CVLogDemo
//
//  Created by John on 2016/12/15.
//  Copyright © 2016年 Chivox. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [CVLog getInstance].reportLogLevel=CVLog_WARN;
    [CVLog getInstance].reportServer = @"http://127.0.0.1:8000/upload";
    CVLogDebug(@"%@",@{@"errorId":@(0),@"message":@"init failed"});
    CVLogWarn(@"%@",@{@"errorId":@(0),@"message":@"init failed"});
    CVLogError(@"%@",@{@"errorId":@(0),@"message":@"init failed"});

    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
