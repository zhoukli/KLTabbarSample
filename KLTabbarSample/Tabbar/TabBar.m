//
//  TabBar.m
//  KLTabbarSample
//
//  Created by kl zhou on 2017/9/4.
//  Copyright © 2017年 t. All rights reserved.
//

#import "TabBar.h"
#import "UIView+Frame.h"

//定义文本高度
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
#define MB_MULTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) \
attributes:@{NSFontAttributeName:font} context:nil].size : CGSizeZero;
#else
#define MB_MULTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
sizeWithFont:font constrainedToSize:maxSize lineBreakMode:mode] : CGSizeZero;
#endif
@implementation TabBar
{
    UIButton *_addButton;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat w = self.width/5.0;
    _addButton.frame = CGRectMake((self.width - w)/2.0, self.height - 75, w, 75);
    [self bringSubviewToFront:_addButton];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [_addButton setTitle:@" 添加" forState:UIControlStateNormal];
        _addButton.adjustsImageWhenHighlighted = NO;
        _addButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_addButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_addButton];
        
        CGSize imageSize = [_addButton imageForState:UIControlStateNormal].size;
        CGSize titleSize = MB_MULTILINE_TEXTSIZE([_addButton titleForState:UIControlStateNormal], _addButton.titleLabel.font, CGSizeMake(100, 100), 0);
        _addButton.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (imageSize.height + 3), 0);
        _addButton.imageEdgeInsets = UIEdgeInsetsMake(- (titleSize.height + 3), 0, 0, - titleSize.width);
    }
    return self;
}
- (void)addButtonClick:(id)sender
{
    if (self.addBlock) {
        self.addBlock();
    }
}
- (nullable UIView *)hitTest:(CGPoint)point withEvent:(nullable UIEvent *)event
{
    //tabbar 没有隐藏  并且点击按钮的位置时候 可以响应
    if (self.hidden == NO) {
        CGPoint newPoint = [self convertPoint:point toView:_addButton];
        if ([_addButton pointInside:newPoint withEvent:event]) {
            return _addButton;
        }
        return [super hitTest:point withEvent:event];
    }
    return [super hitTest:point withEvent:event];
}

@end
