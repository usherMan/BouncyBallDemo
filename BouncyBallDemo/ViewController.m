//
//  ViewController.m
//  BouncyBallDemo
//
//  Created by Usher Man on 2017/11/19.
//  Copyright © 2017年 Usher Man. All rights reserved.
//

#import "ViewController.h"
#import "BouncyBallView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{    
    BouncyBallView *ballView=[[BouncyBallView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
    [self.view addSubview:ballView];
    [ballView startMotion];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[BouncyBallTool shareBallTool] stopMotion];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
