

typedef void (^PINRefreshClosure) ();

static NSString *const kContentOffsetKey = @"contentOffset";
static NSString *const kContentSizeKey = @"contentSize";
static NSString *const kTextKey = @"text";

/// 刷新控件的宽度，在这里调整
static CGFloat const kPINRefreshControlHeight = 44.0;
static CGFloat const kPINRefreshFastAnimationDuration = 0.28;
static CGFloat const kPINRefreshSlowAnimationDuration = 0.4;

typedef NS_ENUM(NSUInteger, PINRefreshState) {
    PINRefreshStatePullCanRefresh = 1, // 拖拽可以刷新状态
    PINRefreshStateReleaseCanRefresh = 2, // 松开即可刷新状态
    PINRefreshStateRefreshing = 3, // 正在刷新状态
    PINRefreshStateNoMoreData = 4, // 没有更多数据状态
};

#ifndef WeakSelf
#define WeakSelf(self) __weak typeof(self) weakSelf = self;
#endif

#ifndef StrongSelf
#define StrongSelf(weakSelf) __strong typeof(weakSelf) strongSelf = weakSelf;
#endif

#ifndef YYSYNTH_DYNAMIC_PROPERTY_OBJECT
#define YYSYNTH_DYNAMIC_PROPERTY_OBJECT(_getter_, _setter_, _association_, _type_) \
- (void)_setter_ : (_type_)object { \
    [self willChangeValueForKey:@#_getter_]; \
    objc_setAssociatedObject(self, _cmd, object, OBJC_ASSOCIATION_ ## _association_); \
    [self didChangeValueForKey:@#_getter_]; \
} \
- (_type_)_getter_ { \
    return objc_getAssociatedObject(self, @selector(_setter_:)); \
}
#endif

#ifndef BLOCK_EXE
#define BLOCK_EXE(block, ...) \
    if (block) { \
        block(__VA_ARGS__); \
    }
#endif

#ifndef PIN_VIEW_SAFE_RELEASE
#define PIN_VIEW_SAFE_RELEASE(__REF) \
\
{ \
    if ((__REF) != nil) { \
        [__REF removeFromSuperview]; \
        __REF = nil; \
    } \
}
#endif

