//
//  PresentController.m
//  KLTabbarSample
//
//  Created by kl zhou on 2017/9/5.
//  Copyright © 2017年 t. All rights reserved.
//

#import "PresentController.h"
#import "UIView+Frame.h"
@interface PresentController ()

@property (strong, nonatomic) NSMutableArray *imgArray;//


@end

@implementation PresentController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    UIBlurEffect *blurEffect=[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *visualEffectView=[[UIVisualEffectView alloc]initWithEffect:blurEffect];
    [visualEffectView setFrame:self.view.bounds];
    [self.view addSubview:visualEffectView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 200, self.view.width - 20, 40)];
    label.text = @"随便点哪里关闭吧！！！";
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    for (UIImageView *imgView in self.imgArray)
    {
        NSInteger i  =[self.imgArray indexOfObject:imgView];
        [UIView animateWithDuration:0.55 delay:i*0.14 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            imgView.frame = CGRectMake(imgView.left, imgView.top - 150, imgView.width, imgView.height);
            imgView.alpha =1;
            
        } completion:^(BOOL finished) {
            
        }];
    }
}
- (void)cancelAnimation
{
    for (UIImageView *imgView in self.imgArray)
    {
        NSInteger i  =[self.imgArray indexOfObject:imgView];
        [UIView animateWithDuration:0.25 delay:i*0.14 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            imgView.frame = CGRectMake(imgView.left, imgView.top + 150, imgView.width, imgView.height);
            imgView.alpha = 0;
            
        } completion:^(BOOL finished) {
            if (i == 2) {
                [self dismissViewControllerAnimated:NO completion:^{
                    
                }];
            }
        }];
    }
}
- (NSMutableArray *)imgArray
{
    if (!_imgArray) {
        _imgArray = [NSMutableArray array];
        CGFloat padding = (self.view.width - 68*3)/4.0;
        for (NSInteger i = 0; i <3; i++) {
            CGFloat x = padding + (padding + 68)*i;
            UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%ld",i+1]];
            UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
            imgView.frame = CGRectMake(x, self.view.height - 100, 68, 68);
            [self.view addSubview:imgView];
            imgView.alpha =0;
            [_imgArray addObject:imgView];
        }
    }
    return _imgArray;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];

    [self cancelAnimation];
}


@end
