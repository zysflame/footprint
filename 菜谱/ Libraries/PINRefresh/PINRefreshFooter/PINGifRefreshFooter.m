//
//  PINGifRefreshFooter.m
//  PINRefresh
//
//  Created by 雷亮 on 16/7/27.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import "PINGifRefreshFooter.h"

@interface PINGifRefreshFooter ()

@property (nonatomic, strong) NSMutableDictionary *imagesDict;

@end

@implementation PINGifRefreshFooter

#pragma mark -
#pragma mark - External Call Methods
+ (instancetype)footer {
    return [[PINGifRefreshFooter alloc] init];
}

- (void)setImages:(NSArray <UIImage *>*)images forState:(PINRefreshState)state {
    if (images == nil) { return; }
    self.imagesDict[@(state)] = images;
    
    // 根据图片设置控件的高度
    UIImage *image = images.firstObject;
    if (image.size.height > self.height) {
        self.height = image.size.height;
    }
}

#pragma mark -
#pragma mark - Private Call Methods
- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    [self.imageView removeFromSuperview];
    [self.activityView removeFromSuperview];
    [self addSubview:self.gifImageView];
    
    self.gifImageView.frame = self.bounds;
    
    if (!self.hiddenStateLabel && self.stateLabel.text.length > 0) {
        self.gifImageView.center = CGPointMake(self.width / 2 + 120, self.height / 2);
    }
}

- (void)setCurrentState:(PINRefreshState)currentState {
    if (self.currentState == currentState) {
        return;
    }
    [super setCurrentState:currentState];
    
    NSArray *images = self.imagesDict[@(currentState)];
    switch (currentState) {
        case PINRefreshStatePullCanRefresh: {
            [self.gifImageView stopAnimating];
            self.gifImageView.hidden = NO;
            break;
        }
        case PINRefreshStateReleaseCanRefresh:
        case PINRefreshStateRefreshing: {
            [self.gifImageView stopAnimating];
            if (images.count == 1) {
                self.gifImageView.image = images.lastObject;
            } else {
                self.gifImageView.animationImages = images;
                self.gifImageView.animationDuration = images.count * 0.1;
                [self.gifImageView startAnimating];
            }
            break;
        }
        case PINRefreshStateNoMoreData: {
            self.gifImageView.hidden = YES;
            self.hiddenStateLabel = NO;
            [self.gifImageView stopAnimating];
            break;
        }
    }
}

- (void)setPullingPercent:(CGFloat)pullingPercent {
    [super setPullingPercent:pullingPercent];
    
    NSArray *images = self.imagesDict[@(self.currentState)];
    switch (self.currentState) {
        case PINRefreshStatePullCanRefresh: {
            [self.gifImageView stopAnimating];
            NSUInteger index = images.count * self.pullingPercent;
            if (index >= images.count) {
                index = images.count - 1;
            }
            self.gifImageView.image = images[index];
            break;
        }
        default:
            break;
    }
}

- (NSMutableDictionary *)imagesDict {
    if (!_imagesDict) {
        _imagesDict = [NSMutableDictionary dictionary];
    }
    return _imagesDict;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
