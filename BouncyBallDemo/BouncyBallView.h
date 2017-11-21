//
//  BouncyBallView.h
//  BouncyBallDemo
//
//  Created by Usher Man on 2017/11/21.
//  Copyright © 2017年 Usher Man. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BouncyBallTool.h"

@interface BouncyBallView : UIView
//边界view
@property (nonatomic,strong)UIView *refrenceView;
//开始运动
- (void)startMotion;
//结束运动
- (void)stopMotion;
@end
