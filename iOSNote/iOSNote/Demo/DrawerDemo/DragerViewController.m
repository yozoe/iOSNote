//
//  DragerViewController.m
//  iOSNote
//
//  Created by 王东 on 2016/11/13.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "DragerViewController.h"

#define screenW [UIScreen mainScreen].bounds.size.width
#define targetR 275
#define targetL -275

@interface DragerViewController ()

@property (nonatomic, weak) UIView *mainV;
@property (nonatomic, weak) UIView *rightV;
@property (nonatomic, weak) UIView *leftV;

@end

@implementation DragerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUp];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [_mainV addGestureRecognizer:pan];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tap];
}

- (void)tap:(UITapGestureRecognizer *)tap
{
    [UIView animateWithDuration:0.5 animations:^{
        self.mainV.frame = self.view.bounds;
    }];
}

- (void)pan:(UIPanGestureRecognizer *)pan
{
    CGPoint transP = [pan translationInView:self.mainV];
    
//    self.mainV.transform = CGAffineTransformTranslate(self.mainV.transform, transP.x, transP.y);
    
    self.mainV.frame = [self frameWithOffsetX:transP.x];
    
    if (self.mainV.frame.origin.x > 0) {
        self.rightV.hidden = YES;
    }
    else if (self.mainV.frame.origin.x < 0) {
        self.rightV.hidden = NO;
    }
    
    CGFloat target = 0;
    if (pan.state == UIGestureRecognizerStateEnded) {
        if (self.mainV.frame.origin.x > screenW * 0.5) {
            target = targetR;
        }
        else if (CGRectGetMaxX(self.mainV.frame) < screenW * 0.5) {
            target = targetL;
        }
        
        CGFloat offset = target - self.mainV.frame.origin.x;
        
        [UIView animateWithDuration:0.5 animations:^{
            self.mainV.frame = [self frameWithOffsetX:offset];
        }];
        
        
        
        NSLog(@"%@", NSStringFromCGRect(self.mainV.frame));
    }
    
    
    
    [pan setTranslation:CGPointZero inView:self.mainV];
}

#define maxY 100
- (CGRect)frameWithOffsetX:(CGFloat)offsetX
{
    CGRect frame = self.mainV.frame;
    frame.origin.x += offsetX;
    
    //当拖动的view的x值等于屏幕宽度时,maxY为最大,最大为100
    //375*100/375=100
    frame.origin.y = fabs(frame.origin.x * maxY / screenW);
    
    //屏幕的高度减去两倍的Y值
    frame.size.height = [UIScreen mainScreen].bounds.size.height - (2 * frame.origin.y);
    
    return frame;
}

- (void)setUp
{
    UIView *leftV = [[UIView alloc] initWithFrame:self.view.bounds];
    leftV.backgroundColor = [UIColor blueColor];
    [self.view addSubview:leftV];
    self.leftV = leftV;
    
    UIView *rightV = [[UIView alloc] initWithFrame:self.view.bounds];
    rightV.backgroundColor = [UIColor greenColor];
    [self.view addSubview:rightV];
    self.rightV = rightV;
    
    UIView *mainV = [[UIView alloc] initWithFrame:self.view.bounds];
    mainV.backgroundColor = [UIColor redColor];
    self.mainV = mainV;
    [self.view addSubview:mainV];
    
}

@end
