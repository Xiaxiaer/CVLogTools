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
    CVLogError(@"%@",@{@"test":@(0),@"date":@[@(1),@(2)]});
    CVLogDebug(@"%@",@{@"test":@(0),@"date":@[@(1),@(2)]});
    CVLogWarn(@"%@",@{@"test":@(0),@"date":@[@(1),@(2)]});

    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
