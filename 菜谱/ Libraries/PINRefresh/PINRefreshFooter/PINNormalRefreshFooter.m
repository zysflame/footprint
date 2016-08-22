//
//  PINNormalRefreshFooter.m
//  PINRefresh
//
//  Created by 雷亮 on 16/7/27.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import "PINNormalRefreshFooter.h"

@interface PINNormalRefreshFooter ()

@property (nonatomic, assign) CGFloat scrollViewOriginEdgeBottom;
@property (nonatomic, copy) PINRefreshClosure closure;

@end

@implementation PINNormalRefreshFooter

#pragma mark -
#pragma mark - External Call Methods
+ (instancetype)footer {
    return [[PINNormalRefreshFooter alloc] init];
}

- (void)endRefreshing {
    [UIView animateWithDuration:kPINRefreshFastAnimationDuration animations:^{
        self.scrollView.edgeBottom = self.scrollViewOriginEdgeBottom;
    }];
    if (self.currentState == PINRefreshStateNoMoreData) {
        return;
    }
    self.currentState = PINRefreshStatePullCanRefresh;
}

- (void)addRefreshFooterWithClosure:(PINRefreshClosure)closure {
    self.closure = closure;
}

#pragma mark -
#pragma mark - Private Call Methods
- (instancetype)init {
    self = [super init];
    if (self) {
        self.isLastPage = NO;
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    [self.superview removeObserver:self forKeyPath:kContentSizeKey];
    [self.superview removeObserver:self forKeyPath:kContentOffsetKey];
    
    if (newSuperview) {
        [newSuperview addObserver:self forKeyPath:kContentSizeKey options:NSKeyValueObservingOptionNew context:nil];
        [newSuperview addObserver:self forKeyPath:kContentOffsetKey options:NSKeyValueObservingOptionNew context:nil];
        
        self.scrollView = (UIScrollView *)newSuperview;

        self.size = CGSizeMake(newSuperview.width, kPINRefreshControlHeight);
        if (self.scrollView.contentSize.height < self.scrollView.height) {
            CGSize contentSize = self.scrollView.contentSize;
            contentSize.height = self.scrollView.height;
            self.scrollView.contentSize = contentSize;
        }
        self.top = self.scrollView.contentSize.height;
        self.left = 0;
        
        self.scrollViewOriginEdgeBottom = self.scrollView.contentInset.bottom;
        
        self.currentState = PINRefreshStatePullCanRefresh;
        self.stateLabel.text = self.pullCanRefreshText;
        
        if ([newSuperview isKindOfClass:[UITableView class]]) {
            UITableView *tableView = (UITableView *)newSuperview;
            if (!tableView.tableFooterView) {
                tableView.tableFooterView = [[UIView alloc] init];
            }
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:kContentSizeKey]) {
        // 刷新或加载完成后调整控件位置
        if (self.scrollView.contentSize.height < self.scrollView.height) {
            CGSize contentSize = self.scrollView.contentSize;
            contentSize.height = self.scrollView.height;
            self.scrollView.contentSize = contentSize;
        }
        self.top = self.scrollView.contentSize.height;
    } else if ([keyPath isEqualToString:kContentOffsetKey]) {
        if (self.currentState == PINRefreshStateRefreshing || self.currentState == PINRefreshStateNoMoreData) {
            return;
        }
        // 调整控件状态
        [self reloadStateWithContentOffsetY];
    }
}

- (void)reloadStateWithContentOffsetY {
    // 当前偏移量
    CGFloat contentOffsetY = self.scrollView.contentOffset.y;
    // 刚好出现刷新footer的偏移量
    CGFloat appearOffsetY = self.scrollView.contentSize.height - self.scrollView.height;

    if (self.scrollView.contentSize.height < self.scrollView.height) {
        appearOffsetY = 0;
    }
    
    // 松开即可刷新的偏移量
    CGFloat releaseToRefreshOffsetY = appearOffsetY + self.height;
    
    if (contentOffsetY <= appearOffsetY) {
        // 如果是向下滚动，看不到底部footer，直接return
        return;
    }
    
    if (self.scrollView.isDragging) {
        // 拖拽的百分比
        self.pullingPercent = (contentOffsetY - appearOffsetY) / self.height;
        if (self.currentState == PINRefreshStatePullCanRefresh && contentOffsetY > releaseToRefreshOffsetY) {
            // 转为松开即可刷新状态
            self.currentState = PINRefreshStateReleaseCanRefresh;
        } else if (self.currentState == PINRefreshStateReleaseCanRefresh && contentOffsetY <= releaseToRefreshOffsetY) {
            // 转为拖拽可以刷新状态
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
            
            self.scrollView.edgeBottom += self.height;            
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

- (void)setIsLastPage:(BOOL)isLastPage {
    _isLastPage = isLastPage;
    if (_isLastPage) {
        self.currentState = PINRefreshStateNoMoreData;
    } else {
        self.currentState = PINRefreshStatePullCanRefresh;
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
