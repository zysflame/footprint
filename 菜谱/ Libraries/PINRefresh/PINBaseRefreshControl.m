//
//  PINBaseRefreshControl.m
//  PINRefresh
//
//  Created by 雷亮 on 16/7/26.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import "PINBaseRefreshControl.h"

@implementation PINBaseRefreshControl

- (instancetype)init {
    self = [super init];
    if (self) {
        self.currentState = PINRefreshStatePullCanRefresh;
        [self addSubview:self.stateLabel];
        [self addSubview:self.imageView];
        [self addSubview:self.activityView];
        
        self.hiddenStateLabel = NO;
        
        WeakSelf(self)
        [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(weakSelf);
        }];
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf);
            make.centerY.equalTo(weakSelf);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        
        [self.activityView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.imageView);
        }];
    }
    return self;
}

- (void)endRefreshing {

}

- (void)reloadDataWithState {
    switch (self.currentState) {
        case PINRefreshStatePullCanRefresh: {
            self.stateLabel.text = self.pullCanRefreshText;
            break;
        }
        case PINRefreshStateReleaseCanRefresh: {
            self.stateLabel.text = self.releaseCanRefreshText;
            break;
        }
        case PINRefreshStateRefreshing: {
            self.stateLabel.text = self.refreshingText;
            break;
        }
        case PINRefreshStateNoMoreData: {
            self.stateLabel.text = self.noMoreDataText;
            break;
        }
    }
    if (self.stateLabel.text.length > 0) {
        if (self.imageView.superview) {
            WeakSelf(self)
            [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf.stateLabel.mas_right);
                make.centerY.equalTo(weakSelf);
                make.size.mas_equalTo(CGSizeMake(40, 40));
            }];
        }
    }
}

- (void)setTitle:(NSString *)title forState:(PINRefreshState)state {
    if (!title) {
        return;
    }
    switch (state) {
        case PINRefreshStatePullCanRefresh: {
            self.pullCanRefreshText = title;
            break;
        }
        case PINRefreshStateReleaseCanRefresh: {
            self.releaseCanRefreshText = title;
            break;
        }
        case PINRefreshStateRefreshing: {
            self.refreshingText = title;
            break;
        }
        case PINRefreshStateNoMoreData: {
            self.noMoreDataText = title;
            break;
        }
    }
}

#pragma mark -
#pragma mark - setter methods
- (void)setPullingPercent:(CGFloat)pullingPercent {
    _pullingPercent = pullingPercent;
}

- (void)setCurrentState:(PINRefreshState)currentState {
    _currentState = currentState;
    [self reloadDataWithState];
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    self.stateLabel.textColor = textColor;
}

- (void)setFont:(UIFont *)font {
    _font = font;
    self.stateLabel.font = font;
}

- (void)setHiddenStateLabel:(BOOL)hiddenStateLabel {
    _hiddenStateLabel = hiddenStateLabel;
    self.stateLabel.hidden = hiddenStateLabel;
}

#pragma mark -
#pragma mark - getter methods
- (UILabel *)stateLabel {
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc] init];
        _stateLabel.font = [UIFont boldSystemFontOfSize:13];
        _stateLabel.textColor = [UIColor darkTextColor];
        _stateLabel.backgroundColor = [UIColor clearColor];
        _stateLabel.numberOfLines = 0;
        _stateLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _stateLabel;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeCenter;
    }
    return _imageView;
}

- (UIActivityIndicatorView *)activityView {
    if (!_activityView) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return _activityView;
}

- (UIImageView *)gifImageView {
    if (!_gifImageView) {
        _gifImageView = [[UIImageView alloc] init];
        _gifImageView.contentMode = UIViewContentModeCenter;
    }
    return _gifImageView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
