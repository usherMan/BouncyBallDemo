//
//  BouncyBallTool.m
//  BouncyBallDemo
//
//  Created by Usher Man on 2017/11/21.
//  Copyright © 2017年 Usher Man. All rights reserved.
//

#import "BouncyBallTool.h"
#import <CoreMotion/CoreMotion.h>

@interface BouncyBallTool ()

@property (nonatomic,strong) CMMotionManager *motionManger;//运动管理者
@property (nonatomic, strong) UIGravityBehavior * gravity;//重力行为
@property (nonatomic, strong) UIDynamicAnimator * animator;//动力学仿真对象
@property (nonatomic, strong) UICollisionBehavior * collision;//碰撞行为
@property (nonatomic, strong) UIDynamicItemBehavior * dynamic;//动力学属性

@end
@implementation BouncyBallTool

static dispatch_once_t onceToken;
+(instancetype)shareBallTool
{
    static BouncyBallTool *ballTool;
    dispatch_once(&onceToken, ^{
        ballTool = [[BouncyBallTool alloc] init];
    });
    return ballTool;
}

-(void)addAimView:(UIView *)ballView referenceView:(UIView *)referenceView
{
    _referenceView = referenceView;
    
    [self.dynamic addItem:ballView];
    [self.collision addItem:ballView];
    [self.gravity addItem:ballView];
    
    [self run];
}

- (void)run
{
    //设备传感器是否在活跃状态（第一次获取传感器数据之后，是活跃状态）
    NSLog(@"====%d",[self.motionManger isDeviceMotionActive]);
     //设备是否有传感器（加速计／陀螺仪／磁力计）
    if (![self.motionManger isDeviceMotionAvailable]) {
        NSLog(@"手机的不支持传感器功能");
        return;
    }
    //设备状态更新帧率
    self.motionManger.deviceMotionUpdateInterval=0.01;
    
    __weak typeof(self) weakSelf = self;
    
    //push方式更新加速度数据
    [self.motionManger startDeviceMotionUpdatesToQueue:([NSOperationQueue mainQueue]) withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",error);
            return ;
        }
        //重力方向
        weakSelf.gravity.gravityDirection = CGVectorMake(motion.gravity.x * 3, -motion.gravity.y * 3);
    }];
    
}
#pragma  运动管理者
- (CMMotionManager *)motionManger
{
    if (nil == _motionManger) {
        _motionManger = [[CMMotionManager alloc] init];
    }
    return _motionManger;
}
# pragma mark - 动力学仿真对象
-  (UIDynamicAnimator *)animator {
    
    if (_animator == nil) {
        // 设置参考边界
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.referenceView];
        
    }
    
    return _animator;
}
# pragma mark - 重力
-  (UIGravityBehavior *)gravity {
    
    if (_gravity == nil) {
        
        _gravity = [[UIGravityBehavior alloc] init];
        _gravity.angle = M_PI_2;//重力矢量方向与坐标轴x的夹角;
        _gravity.magnitude = 1.0;//重力加速度的倍数
        [self.animator addBehavior:_gravity];
    }
    
    return _gravity;
}
# pragma mark - 碰撞
-  (UICollisionBehavior *)collision {
    
    if (_collision == nil) {
        
        _collision = [[UICollisionBehavior alloc] init];
        _collision.translatesReferenceBoundsIntoBoundary = YES;//设置碰撞到边界会反弹
        _collision.collisionMode = UICollisionBehaviorModeEverything;
        [self.animator addBehavior:_collision];
    }
    
    return _collision;
}
# pragma mark - 动力学属性
-  (UIDynamicItemBehavior *)dynamic {
    
    if (_dynamic == nil) {
        
        _dynamic = [[UIDynamicItemBehavior alloc] init];
        _dynamic.friction = 0.2;//摩擦系数
        _dynamic.elasticity = 0.8;//弹性系数
        _dynamic.density = 0.2;//相对质量密度,用于动态元素相对密度。其连同动态元素大小，决定动态元素的有效质量
        _dynamic.allowsRotation = YES;
        _dynamic.resistance = 0;//线速度阻尼
        [self.animator addBehavior:_dynamic];
    }
    
    return _dynamic;
}
# pragma mark - 停止运动
- (void)stopMotion {
    
    if (self.motionManger.isDeviceMotionActive) {
        [self.motionManger stopDeviceMotionUpdates];
        [self.animator removeAllBehaviors];
    }
}
@end
