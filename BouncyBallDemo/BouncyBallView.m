//
//  BouncyBallView.m
//  BouncyBallDemo
//
//  Created by Usher Man on 2017/11/21.
//  Copyright © 2017年 Usher Man. All rights reserved.
//

#import "BouncyBallView.h"

@interface BouncyBallView ()

// 碰撞界限的枚举类型(矩形／椭圆／路径)
@property (nonatomic, assign) UIDynamicItemCollisionBoundsType collisionBoundsType;
@end

@implementation BouncyBallView

@synthesize collisionBoundsType;

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = self.frame.size.width*0.5;
        self.collisionBoundsType  =UIDynamicItemCollisionBoundsTypeEllipse;//椭圆
        self.backgroundColor=[UIColor orangeColor];
    }
    
    return self;
}

-(void)startMotion
{
    [[BouncyBallTool shareBallTool] addAimView:self referenceView:self.superview];
}

-(void)stopMotion
{
    [[BouncyBallTool shareBallTool] stopMotion];
}
@end

