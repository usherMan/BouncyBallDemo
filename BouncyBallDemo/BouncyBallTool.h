//
//  BouncyBallTool.h
//  BouncyBallDemo
//
//  Created by Usher Man on 2017/11/21.
//  Copyright © 2017年 Usher Man. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BouncyBallTool : NSObject

@property (nonatomic, weak) UIView * referenceView;

+ (instancetype)shareBallTool;

- (void)addAimView:(UIView *)ballView referenceView:(UIView *)referenceView;

- (void)stopMotion;

@end
