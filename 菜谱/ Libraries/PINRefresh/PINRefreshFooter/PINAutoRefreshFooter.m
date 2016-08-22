//
//  PINAutoRefreshFooter.m
//  PINRefresh
//
//  Created by 雷亮 on 16/7/27.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import "PINAutoRefreshFooter.h"

@interface PINAutoRefreshFooter ()

@property (nonatomic, copy) PINRefreshClosure closure;

@end

@implementation PINAutoRefreshFooter

#pragma mark -
#pragma mark - External Call Methods
+ (instancetype)footer {
    return [[PINAutoRefreshFooter alloc] init];
}

- (void)setGifImages:(NSArray <UIImage *>*)images {
    if (images.count > 0) {
        self.gifImageView.animationImages = images;
    }
}

- (void)endRefreshing {
    if (self.currentState == PINRefreshStateNoMoreData) {
        return;
    }
    self.currentState = PINRefreshStatePullCanRefresh;
}

- (void)addAutoRefreshFooterWithClosure:(PINRefreshClosure)closure {
    self.closure = closure;
}

#pragma mark -
#pragma mark - Private Call Methods
- (instancetype)init {
    self = [super init];
    if (self) {
        self.autoRefreshFooterStyle = PINAutoRefreshFooterStyleGifImages;
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    [self.superview removeObserver:self forKeyPath:kContentSizeKey context:nil];
    [self.superview removeObserver:self forKeyPath:kContentOffsetKey context:nil];
    
    if (newSuperview) {
        [newSuperview addObserver:self forKeyPath:kContentSizeKey options:NSKeyValueObservingOptionNew context:nil];
        [newSuperview addObserver:self forKeyPath:kContentOffsetKey options:NSKeyValueObservingOptionNew context:nil];
        [self.stateLabel addObserver:self forKeyPath:kTextKey options:NSKeyValueObservingOptionNew context:nil];
        
        self.scrollView = (UIScrollView *)newSuperview;
        
        self.size = CGSizeMake(newSuperview.width, kPINRefreshControlHeight);
        self.top = self.scrollView.contentSize.height;
        
        if (self.scrollView.contentSize.height < self.scrollView.height) {
            self.top = self.scrollView.height;
            self.scrollView.contentSizeHeight = self.scrollView.height;
        } else {
            self.top = self.scrollView.contentSize.height;
        }
        self.left = 0;
        self.scrollView.edgeBottom += self.height;

        self.isLastPage = NO;
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
        if (self.scrollView.contentSize.height < self.scrollView.height) {
            self.top = self.scrollView.height;
            self.scrollView.contentSizeHeight = self.scrollView.height;
        } else {
            self.top = self.scrollView.contentSize.height;
        }
    } else if ([keyPath isEqualToString:kContentOffsetKey]) {
        if (self.currentState == PINRefreshStateRefreshing || self.currentState == PINRefreshStateNoMoreData) {
            return;
        }
        // 调整控件状态
        [self reloadStateWithContentOffsetY];
    } else if ([keyPath isEqualToString:kTextKey]) {
        if (self.stateLabel.superview) {
            WeakSelf(self)
            if (self.stateLabel.text.length > 0) {
                [self.gifImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo(CGSizeMake(50, 50));
                    make.left.equalTo(weakSelf.stateLabel.mas_right).offset(5);
                    make.centerY.equalTo(weakSelf);
                }];
            } else {
                [self.gifImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo(CGSizeMake(50, 50));
                    make.centerX.equalTo(weakSelf);
                    make.centerY.equalTo(weakSelf);
                }];
            }            
        }
    }
}

- (void)reloadStateWithContentOffsetY {
    // 当前偏移量
    CGFloat contentOffsetY = self.scrollView.contentOffset.y;
    // 刚好出现刷新footer的偏移量
    CGFloat appearOffsetY = self.scrollView.contentSize.height - self.scrollView.height;
    if (appearOffsetY < 0) {
        appearOffsetY = 0;
    }
    
    if (contentOffsetY <= appearOffsetY) { } else {
        self.currentState = PINRefreshStateRefreshing;
        // 回调
        BLOCK_EXE(_closure);
    }
}

#pragma mark -
#pragma mark - setter methods
- (void)setCurrentState:(PINRefreshState)currentState {
    [super setCurrentState:currentState];
    
    switch (currentState) {
        case PINRefreshStatePullCanRefresh:
        case PINRefreshStateReleaseCanRefresh:
        case PINRefreshStateRefreshing: {
            switch (self.autoRefreshFooterStyle) {
                case PINAutoRefreshFooterStyleGifImages: {
                    [self.gifImageView startAnimating];
                    self.stateLabel.text = self.refreshingText;
                    break;
                }
                case PINAutoRefreshFooterStyleGifImagesWithoutState: {
                    [self.gifImageView startAnimating];
                    break;
                }
                case PINAutoRefreshFooterStyleActivityIndicator: {
                    [self.activityView startAnimating];
                    self.stateLabel.text = self.refreshingText;
                    break;
                }
                case PINAutoRefreshFooterStyleActivityIndicatorWithoutState: {
                    [self.activityView startAnimating];
                    break;
                }
            }
            break;
        }
        case PINRefreshStateNoMoreData: {
            self.hiddenStateLabel = NO;
            self.stateLabel.text = self.noMoreDataText;
            break;
        }
    }
}

- (void)setAutoRefreshFooterStyle:(PINAutoRefreshFooterStyle)autoRefreshFooterStyle {
    _autoRefreshFooterStyle = autoRefreshFooterStyle;
    switch (autoRefreshFooterStyle) {
        case PINAutoRefreshFooterStyleGifImages: {
            self.hiddenStateLabel = NO;
            self.imageView.hidden = YES;
            self.activityView.hidden = YES;
            [self addSubview:self.gifImageView];
            self.gifImageView.animationDuration = 0.3;
            break;
        }
        case PINAutoRefreshFooterStyleGifImagesWithoutState: {
            self.hiddenStateLabel = YES;
            self.imageView.hidden = YES;
            self.activityView.hidden = YES;
            [self addSubview:self.gifImageView];
            self.gifImageView.animationDuration = 0.3;
            break;
        }
        case PINAutoRefreshFooterStyleActivityIndicator: {
            self.hiddenStateLabel = NO;
            self.imageView.hidden = YES;
            break;
        }
        case PINAutoRefreshFooterStyleActivityIndicatorWithoutState: {
            self.hiddenStateLabel = YES;
            self.imageView.hidden = YES;
            break;
        }
    }
}

- (void)setIsLastPage:(BOOL)isLastPage {
    _isLastPage = isLastPage;
    if (_isLastPage) {
        self.currentState = PINRefreshStateNoMoreData;
        [self.gifImageView stopAnimating];
        [self.activityView stopAnimating];
    } else {
        self.currentState = PINRefreshStatePullCanRefresh;
        [self.gifImageView startAnimating];
    }
}

- (void)dealloc {
    [self.stateLabel removeObserver:self forKeyPath:kTextKey context:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
