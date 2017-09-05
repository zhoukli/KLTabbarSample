//
//  TabBar.h
//  KLTabbarSample
//
//  Created by kl zhou on 2017/9/4.
//  Copyright © 2017年 t. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TabBar : UITabBar

@property (strong, nonatomic) void(^addBlock)();//加号回调



@end
