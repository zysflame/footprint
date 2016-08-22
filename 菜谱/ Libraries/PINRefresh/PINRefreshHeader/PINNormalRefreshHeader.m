//
//  PINNormalRefreshHeader.m
//  PINRefresh
//
//  Created by 雷亮 on 16/7/27.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import "PINNormalRefreshHeader.h"

@interface PINNormalRefreshHeader ()

@property (nonatomic, assign) CGFloat originEdgeTop;
@property (nonatomic, copy) PINRefreshClosure closure;

@end

@implementation PINNormalRefreshHeader

#pragma mark -
#pragma mark - External Call Methods
+ (instancetype)header {
    return [[PINNormalRefreshHeader alloc] init];
}

- (void)endRefreshing {
    [UIView animateWithDuration:kPINRefreshFastAnimationDuration animations:^{
        self.scrollView.edgeTop = self.originEdgeTop;
    }];
    self.currentState = PINRefreshStatePullCanRefresh;
}

- (void)addRefreshHeaderWithClosure:(PINRefreshClosure)closure {
    self.closure = closure;
}

#pragma mark -
#pragma mark - Private Call Methods
- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    [self.superview removeObserver:self forKeyPath:kContentOffsetKey context:nil];
    if (newSuperview) {
        [newSuperview addObserver:self forKeyPath:kContentOffsetKey options:NSKeyValueObservingOptionNew context:nil];
        
        self.scrollView = (UIScrollView *)newSuperview;
        self.size = CGSizeMake(newSuperview.width, kPINRefreshControlHeight);
        self.bottom = 0;
        self.left = 0;
        
        self.originEdgeTop = self.scrollView.edgeTop;
        
        self.currentState = PINRefreshStatePullCanRefresh;
        self.stateLabel.text = self.pullCanRefreshText;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:kContentOffsetKey]) {
        if (self.currentState != PINRefreshStateRefreshing) {
            // 调整控件状态
            [self reloadStateWithContentOffsetY];
        }
    }
}

- (void)reloadStateWithContentOffsetY {
    // 当前偏移量
    CGFloat contentOffsetY = self.scrollView.contentOffset.y;
    // 刚好出现刷新header的偏移量
    CGFloat appearOffsetY = 0;
    // 松开即可刷新的偏移量
    CGFloat releaseToRefreshOffsetY = appearOffsetY - self.height;
    
    // 如果是向下滚动，看不到头部header, 直接return
    if (contentOffsetY >= appearOffsetY) {
        return;
    }
    
    if (self.scrollView.isDragging) {
        // 拖拽的百分比
        self.pullingPercent = (appearOffsetY - contentOffsetY) / self.height;
        if (self.currentState == PINRefreshStatePullCanRefresh && contentOffsetY < releaseToRefreshOffsetY) {
            // 转为松开即可刷新状态
            self.currentState = PINRefreshStateReleaseCanRefresh;
        } else if (self.currentState == PINRefreshStateReleaseCanRefresh && contentOffsetY >= releaseToRefreshOffsetY) {
            // 转为拖拽即可刷新状态
            self.currentState = PINRefreshStatePullCanRefresh;
        }
    } else if (self.currentState == PINRefreshStateReleaseCanRefresh && !self.scrollView.isDragging) {
        // 开始刷新
        self.currentState = PINRefreshStateRefreshing;
        self.pullingPercent = 1.f;
        
        // 回调
        BLOCK_EXE(_closure);
    } else {
        self.pullingPercent = (contentOffsetY - appearOffsetY) / self.height;
    }
}

#pragma mark -
#pragma mark - setter methods
- (void)setCurrentState:(PINRefreshState)currentState {
    [super setCurrentState:currentState];
    
    switch (currentState) {
        case PINRefreshStatePullCanRefresh: {
            self.imageView.hidden = NO;
            self.activityView.hidden = YES;
            self.imageView.image = [UIImage imageNamed:@"arrow.png"];
            [UIView animateWithDuration:kPINRefreshFastAnimationDuration animations:^{
                self.imageView.transform = CGAffineTransformMakeRotation(0);
            }];
            break;
        }
        case PINRefreshStateReleaseCanRefresh: {
            self.imageView.hidden = NO;
            self.activityView.hidden = YES;
            [UIView animateWithDuration:kPINRefreshFastAnimationDuration animations:^{
                self.imageView.transform = CGAffineTransformMakeRotation(M_PI);
            }];
            break;
        }
        case PINRefreshStateRefreshing: {
            self.imageView.hidden = YES;
            self.activityView.hidden = NO;
            [self.activityView startAnimating];
            
            self.scrollView.edgeTop += self.height;
            break;
        }
        case PINRefreshStateNoMoreData: {
            self.imageView.hidden = YES;
            self.activityView.hidden = YES;
            [self.activityView stopAnimating];
            break;
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
