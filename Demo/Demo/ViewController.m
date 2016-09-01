//
//  ViewController.m
//  Demo
//
//  Created by 磊吴 on 16/9/1.
//  Copyright © 2016年 磊吴. All rights reserved.
//

#import "ViewController.h"
#import "CPTextViewPlaceholder.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor lightGrayColor];
    CPTextViewPlaceholder *pb = [[CPTextViewPlaceholder alloc] initWithFrame:CGRectMake(0, 90, 320, 44)];
    pb.showSecret = false;
//    pb.inputLines = 5;
    pb.placeholder = @"asdasd";
    pb.backgroundColor = [UIColor redColor];
    [self.view addSubview:pb];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
