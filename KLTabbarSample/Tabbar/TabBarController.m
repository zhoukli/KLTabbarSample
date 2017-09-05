//
//  TabBarController.m
//  KLTabbarSample
//
//  Created by kl zhou on 2017/9/4.
//  Copyright © 2017年 t. All rights reserved.
//

#import "TabBarController.h"
#import "ViewController.h"
#import "TabBar.h"
#import "PresentController.h"
@interface TabBarController ()<UITabBarControllerDelegate,UITabBarDelegate>

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    TabBar *tabBar  =[TabBar new];
    tabBar.addBlock = ^{
        [self addEvents];
    };
    [self setValue:tabBar forKey:@"tabBar"];//tabBar是只读的  所以只能用KVC来替换
    
    NSArray *txtArray = @[@"首页",@"鱼塘",@"消息",@"我的"];
    NSMutableArray *vcArray = [NSMutableArray array];
    for (NSInteger i = 0; i<4; i++) {
        ViewController *VC = [ViewController new];
        UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:VC];
        UIImage *normalImg = [UIImage imageNamed:[NSString stringWithFormat:@"tab_%ld",i+1]];
        UIImage *selectImage = [UIImage imageNamed:[NSString stringWithFormat:@"tab_%ld_select",i+1]];
        [self handleTabbarItem:nav1 title:txtArray[i] image:normalImg selectImage:selectImage];
        [vcArray addObject:nav1];
        if (i == 1) {
            [vcArray addObject:[UIViewController new]];
        }
    }
    self.viewControllers = vcArray;
    self.delegate =self;
}
#pragma mark - private
- (void)addEvents
{
    PresentController *presentVC = [PresentController new];
    [self presentViewController:presentVC animated:NO completion:^{
        
    }];
}
- (void)handleTabbarItem:(UIViewController *)controller title:(NSString *)title image:(UIImage *)image selectImage:(UIImage *)selectImage
{
    UIImage *originImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectImg = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:originImage selectedImage:selectImg];
    [controller.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor lightGrayColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:12], NSFontAttributeName, nil]  forState:UIControlStateNormal];
    [controller.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor orangeColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:12], NSFontAttributeName, nil] forState:UIControlStateSelected];
}

#pragma mark - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    return YES;
}
#pragma mark - UITabBarDelegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSMutableArray *tabArray = [NSMutableArray array];
    NSInteger index = [tabBar.items indexOfObject:item];
    for (UIView *view in tabBar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabArray addObject:view];
        }
    }
    UIView *tabbarButton = [tabArray objectAtIndex:index];
    for (UIView *view in tabbarButton.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
            
            CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            scale.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            scale.duration = 0.2;
            scale.repeatCount = 1;
            scale.autoreverses = YES;
            scale.fromValue = [NSNumber numberWithFloat:0.5];
            scale.toValue = [NSNumber numberWithFloat:1.2];
            [view.layer addAnimation:scale forKey:nil];
            continue;
        }
    }
}
@end
