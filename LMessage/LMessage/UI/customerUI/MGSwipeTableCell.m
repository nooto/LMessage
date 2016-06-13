/*### WS@H Project:EHouse ###*/
/*
 * MGSwipeTableCell is licensed under MIT licensed. See LICENSE.md file for more information.
 * Copyright (c) 2014 Imanol Fernandez @MortimerGoro
 */

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "MGSwipeTableCell.h"

//#define SWITCHONSTR @"打开"
//#define SWITCHOFFSTR @"关闭"
#pragma mark Input Overlay Helper Class
/** Used to capture table input while swipe buttons are visible*/
@interface MGSwipeTableInputOverlay : UIView
@property (nonatomic, weak) MGSwipeTableCell * currentCell;
@end

@implementation MGSwipeTableInputOverlay

-(id) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return self;
}

-(UIView *) hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (_currentCell && CGRectContainsPoint(_currentCell.bounds, [self convertPoint:point toView:_currentCell])) {
        return nil;
    }
    [_currentCell hideSwipeAnimated:YES];
    return self;
}

@end

#pragma mark Button Container View and transitions

@interface MGSwipeButtonsView : UIView
@property (nonatomic, weak) MGSwipeTableCell * cell;
@end

@implementation MGSwipeButtonsView
{
    NSArray * buttons;
    UIView * container;
    BOOL fromLeft;
    UIView * expandedButton;
    CGFloat expansionOffset;
    BOOL autoHideExpansion;
}

#pragma mark Layout

-(instancetype) initWithButtons:(NSArray*) buttonsArray direction:(MGSwipeDirection) direction
{
    CGSize maxSize = CGSizeZero;
    for (UIView * button in buttonsArray) {
        maxSize.width = MAX(maxSize.width, button.bounds.size.width);
        maxSize.height = MAX(maxSize.height, button.bounds.size.height);
    }
    
    if (self = [super initWithFrame:CGRectMake(0, 0, maxSize.width * buttonsArray.count, maxSize.height)]) {
        fromLeft = direction == MGSwipeDirectionLeftToRight;
        container = [[UIView alloc] initWithFrame:self.bounds];
        container.clipsToBounds = YES;
        container.backgroundColor = [UIColor clearColor];
        [self addSubview:container];
        buttons = fromLeft ? buttonsArray: [[buttonsArray reverseObjectEnumerator] allObjects];
        for (UIView * button in buttons) {
            if ([button isKindOfClass:[UIButton class]]) {
                [(UIButton *)button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            }
            button.frame = CGRectMake(0, 0, maxSize.width, maxSize.height);
            button.autoresizingMask = UIViewAutoresizingFlexibleHeight;
            [container insertSubview:button atIndex: fromLeft ? 0: container.subviews.count];
        }
        [self resetButtons];
    }
    return self;
}

-(void) resetButtons
{
    int index = 0;
    for (UIView * button in buttons) {
        button.frame = CGRectMake(index * button.bounds.size.width, 0, button.bounds.size.width, self.bounds.size.height);
        button.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        index++;
    }
}

-(void) layoutExpansion: (CGFloat) offset
{
    expansionOffset = offset;
    container.frame = CGRectMake(fromLeft ? 0: self.bounds.size.width - offset, 0, offset, self.bounds.size.height);
}

-(void) layoutSubviews
{
    [super layoutSubviews];
    if (expandedButton) {
        [self layoutExpansion:expansionOffset];
    }
    else {
        container.frame = self.bounds;
    }
}

-(void) expandToOffset:(CGFloat) offset button:(NSInteger) index
{
    if (index < 0 || index>= buttons.count) {
        return;
    }
    if (!expandedButton) {
        expandedButton = [buttons objectAtIndex: fromLeft ? index : buttons.count - index - 1];
        container.backgroundColor = expandedButton.backgroundColor;
        [UIView animateWithDuration:0.2 animations:^{
            for (UIView * button in buttons) {
                button.hidden = YES;
            }
            expandedButton.hidden = NO;
            if (fromLeft) {
                expandedButton.frame = CGRectMake(container.bounds.size.width - expandedButton.bounds.size.width, 0, expandedButton.bounds.size.width, expandedButton.bounds.size.height);
                expandedButton.autoresizingMask|= UIViewAutoresizingFlexibleLeftMargin;
            }
            else {
                expandedButton.frame = CGRectMake(0, 0, expandedButton.bounds.size.width, expandedButton.bounds.size.height);
                expandedButton.autoresizingMask|= UIViewAutoresizingFlexibleRightMargin;
            }

        }];
    }
    
    [self layoutExpansion:offset];
}

-(void) endExpansioAnimated:(BOOL) animated
{
    if (expandedButton) {
        [UIView animateWithDuration: animated ? 0.2 : 0.0 animations:^{
            container.frame = self.bounds;
            [self resetButtons];
            expandedButton = nil;
        } completion:^(BOOL finished) {
            container.backgroundColor = [UIColor clearColor];
            for (UIView * view in buttons) {
                view.hidden = NO;
            }
        }];
    }
}

-(UIView*) getExpandedButton
{
    return expandedButton;
}

#pragma mark Trigger Actions

-(void) handleClick: (id) sender fromExpansion:(BOOL) fromExpansion
{
    bool autoHide = false;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    if ([sender respondsToSelector:@selector(callMGSwipeConvenienceCallback:)]) {
        //call convenience block callback if exits (usage of MGSwipeButton class is not compulsory)
        autoHide = [sender performSelector:@selector(callMGSwipeConvenienceCallback:) withObject:_cell];
    }
#pragma clang diagnostic pop
    
    if (_cell.delegate && [_cell.delegate respondsToSelector:@selector(swipeTableCell:tappedButtonAtIndex:direction:fromExpansion:)]) {
        NSInteger index = [buttons indexOfObject:sender];
        if (!fromLeft) {
            index = buttons.count - index - 1; //right buttons are reversed
        }
        autoHide|= [_cell.delegate swipeTableCell:_cell tappedButtonAtIndex:index direction:fromLeft ? MGSwipeDirectionLeftToRight : MGSwipeDirectionRightToLeft fromExpansion:fromExpansion];
    }
    
    if (fromExpansion) {
        expandedButton = nil;
        _cell.swipeOffset = 0;
    }
    else if (autoHide) {
        [_cell hideSwipeAnimated:YES];
    }

}
//button listener
-(void) buttonClicked: (id) sender
{
    [self handleClick:sender fromExpansion:NO];
}


#pragma mark Transitions

-(void) transitionStatic:(CGFloat) t
{
    const CGFloat dx = self.bounds.size.width * t;
    for (NSInteger i = buttons.count - 1; i >=0 ; --i) {
        UIView * button = [buttons objectAtIndex:i];
        const CGFloat x = fromLeft ? self.bounds.size.width - dx + button.bounds.size.width * i : dx - button.bounds.size.width * (buttons.count - i);
        button.frame = CGRectMake(x, 0, button.bounds.size.width, button.bounds.size.height);
    }
}

-(void) transitionDrag:(CGFloat) t
{
    //No Op, nothing to do ;)
}

-(void) transitionClip:(CGFloat) t
{
    const CGFloat dx = (self.bounds.size.width * t) / (buttons.count * 2);
    for (int i = 0; i < buttons.count; ++i) {
        UIView * button = [buttons objectAtIndex:i];
        CAShapeLayer * maskLayer = [[CAShapeLayer alloc] init];
        const CGSize size = button.bounds.size;
        CGRect maskRect = CGRectMake(size.width * 0.5 - dx, 0, dx * 2, size.height);
        CGPathRef path = CGPathCreateWithRect(maskRect, NULL);
        maskLayer.path = path;
        CGPathRelease(path);
        CGFloat ox =  dx * (2 * i + 1) - size.width * 0.5;
        button.frame = CGRectMake(fromLeft ?  self.bounds.size.width * (1-t) + ox: ox, 0, button.bounds.size.width, button.bounds.size.height);
        button.layer.mask = maskLayer;
    }
}

-(void) transtitionFloatBorder:(CGFloat) t
{
    const CGFloat x0 = self.bounds.size.width * (fromLeft ? (1.0 -t) : t);
    CGFloat dx = (self.bounds.size.width * t) / buttons.count;
    for (int i = 0; i < buttons.count; ++i) {
        UIView * button = [buttons objectAtIndex:i];
        const CGFloat x = fromLeft ? x0 + dx * (i + 1) - button.bounds.size.width : x0 - dx  * (buttons.count - i);
        button.frame = CGRectMake(x , 0, button.bounds.size.width, button.bounds.size.height);
    }
}

-(void) transition3D:(CGFloat) t
{
    const CGFloat invert = fromLeft ? 1.0 : -1.0;
    const CGFloat angle = M_PI_2 * (1.0 - t) * invert;
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0/400.0f; //perspective 1/z
    const CGFloat dx = -container.bounds.size.width * 0.5 * invert;
    const CGFloat offset = dx * 2 * (1.0 - t);
    transform = CATransform3DTranslate(transform, dx - offset, 0, 0);
    transform = CATransform3DRotate(transform, angle, 0.0, 1.0, 0.0);
    transform = CATransform3DTranslate(transform, -dx, 0, 0);
    container.layer.transform = transform;
}

-(void) transition:(MGSwipeTransition) mode percent:(CGFloat) t
{
    switch (mode) {
        case MGSwipeTransitionStatic: [self transitionStatic:t]; break;
        case MGSwipeTransitionDrag: [self transitionDrag:t]; break;
        case MGSwipeTransitionClipCenter: [self transitionClip:t]; break;
        case MGSwipeTransitionBorder: [self transtitionFloatBorder:t]; break;
        case MGSwipeTransition3D: [self transition3D:t]; break;
    }
}

@end

#pragma mark Settings Classes
@implementation MGSwipeSettings
-(instancetype) init
{
    if (self = [super init]) {
        self.transition = MGSwipeTransitionBorder;
        self.threshold = 0.5;
    }
    return self;
}
@end

@implementation MGSwipeExpansionSettings
-(instancetype) init
{
    if (self = [super init]) {
        self.buttonIndex = -1;
        self.threshold = 1.3;
    }
    return self;
}
@end

typedef struct MGSwipeAnimationData {
    CGFloat from;
    CGFloat to;
    CFTimeInterval duration;
    CFTimeInterval start;
} MGSwipeAnimationData;


#pragma mark MGSwipeTableCell Implementation

@interface MGSwipeTableCell ()
//@property (nonatomic, weak) UIImageView *mDeviceIcon;
//@property (nonatomic, weak) UILabel     *mDeviceName;
//@property (nonatomic, weak) TTTAttributedLabel     *mDeviceStatus;

@end

@implementation MGSwipeTableCell
{
    UITapGestureRecognizer * tapRecognizer;
    UIPanGestureRecognizer * panRecognizer;
    CGPoint panStartPoint;
    CGFloat panStartOffset;
    CGFloat targetOffset;
    
    UIView * swipeOverlay;
    UIView * swipeView;
    MGSwipeButtonsView * leftView;
    MGSwipeButtonsView * rightView;
    bool allowSwipeRightToLeft;
    bool allowSwipeLeftToRight;
    __weak MGSwipeButtonsView * activeExpansion;

    MGSwipeTableInputOverlay * tableInputOverlay;
    __weak UITableView * cachedParentTable;
    UITableViewCellSelectionStyle previusSelectionStyle;
    
    MGSwipeAnimationData animationData;
    void (^animationCompletion)();
    CADisplayLink * displayLink;
//    CGFloat cellHeight;
}

#pragma mark View creation & layout

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier height:(CGFloat)height
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.cellHeight = height;
        [self initViews];
//        [self setupView];
    }
    return self;
}

-(void) awakeFromNib
{
    [self initViews];
}

-(void) dealloc
{
    [self removeInputOverlayIfNeeded];
}

-(void) initViews
{
    _leftButtons = [[NSArray alloc] init];
    _rightButtons = [[NSArray alloc] init];
    _leftSwipeSettings = [[MGSwipeSettings alloc] init];
    _rightSwipeSettings = [[MGSwipeSettings alloc] init];
    _leftExpansion = [[MGSwipeExpansionSettings alloc] init];
    _rightExpansion = [[MGSwipeExpansionSettings alloc] init];
    panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandler:)];
    [self addGestureRecognizer:panRecognizer];
    panRecognizer.delegate = self;
    activeExpansion = nil;
}

-(void) cleanViews
{
    [self hideSwipeAnimated:NO];
    if (displayLink) {
        [displayLink invalidate];
        displayLink = nil;
    }
    if (swipeOverlay) {
        [swipeOverlay removeFromSuperview];
        swipeOverlay = nil;
        [self hiddenSubView:NO];
    }
    leftView = rightView = nil;
    if (panRecognizer) {
        panRecognizer.delegate = nil;
        [self removeGestureRecognizer:panRecognizer];
    }
}

-(void) layoutSubviews
{
    [super layoutSubviews];
    if (swipeOverlay) {
        swipeOverlay.frame = CGRectMake(0, 0, self.bounds.size.width, self.contentView.bounds.size.height);
        [self hiddenSubView:NO];
    }
}

-(void) fetchButtonsIfNeeded
{
    if (_leftButtons.count == 0 && _delegate && [_delegate respondsToSelector:@selector(swipeTableCell:swipeButtonsForDirection:swipeSettings:expansionSettings:)]) {
        _leftButtons = [_delegate swipeTableCell:self swipeButtonsForDirection:MGSwipeDirectionLeftToRight swipeSettings:_leftSwipeSettings expansionSettings:_leftExpansion];
    }
    if (_rightButtons.count == 0 && _delegate && [_delegate respondsToSelector:@selector(swipeTableCell:swipeButtonsForDirection:swipeSettings:expansionSettings:)]) {
        _rightButtons = [_delegate swipeTableCell:self swipeButtonsForDirection:MGSwipeDirectionRightToLeft swipeSettings:_rightSwipeSettings expansionSettings:_rightExpansion];
    }
}

//-(void)setupView{
//   UIImageView* deviceIcon = [[UIImageView alloc] initWithFrame:CGRectMake(MarginW(20), 0, MarginW(40), MarginW(40))];
//    [deviceIcon setBackgroundColor:[UIColor clearColor]];
////    deviceIcon.layer.masksToBounds = YES;
////    deviceIcon.layer.cornerRadius = CGRectGetWidth(deviceIcon.frame)/2;
//    deviceIcon.center = CGPointMake(deviceIcon.center.x, cellHeight/2);
//    [self.contentView addSubview:deviceIcon];
//    self.mDeviceIcon = deviceIcon;
//    
//    UILabel*    deviceName = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(deviceIcon.frame)+MarginW(10),  0, SCREEN_W - CGRectGetMaxX(deviceIcon.frame) - MarginW(30), 25)];
//    deviceName.textColor = Color_white_50;
//    deviceName.font = FontSmall;
//    deviceName.center = CGPointMake(deviceName.center.x, cellHeight/2-15);
//    [self.contentView addSubview:deviceName];
//    self.mDeviceName = deviceName;
//
//    
//    TTTAttributedLabel *deviceStatus = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(deviceName.frame), cellHeight/2, CGRectGetWidth(deviceName.frame), 25)];
//    deviceStatus.textColor = Color_white_50;
//    deviceStatus.font = Font13;
//    [self.contentView addSubview:deviceStatus];
//    self.mDeviceStatus = deviceStatus;
//    
//    UIView *lineView =  [[UIView alloc] initWithFrame:CGRectMake(MarginW(20), cellHeight-0.5f, SCREEN_W - MarginW(20), 0.5f)];
//    lineView.backgroundColor = Color_line;
//    [self.contentView addSubview:lineView];
//}

-(void) createSwipeViewIfNeeded
{
    if (!swipeOverlay) {
        swipeOverlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        swipeOverlay.backgroundColor = [self backgroundColorForSwipe];
        swipeOverlay.layer.zPosition = 10; //force render on top of the contentView;
        swipeView = [[UIImageView alloc] initWithImage:[self imageFromView:self]];
        swipeView.autoresizingMask =  UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
        swipeView.frame = swipeOverlay.bounds;
        swipeView.contentMode = UIViewContentModeCenter;
        swipeView.clipsToBounds = YES;
        [swipeOverlay addSubview:swipeView];
        [self addSubview:swipeOverlay];
    }
    
    [self fetchButtonsIfNeeded];
    if (!leftView && _leftButtons.count > 0) {
        leftView = [[MGSwipeButtonsView alloc] initWithButtons:_leftButtons direction:MGSwipeDirectionLeftToRight];
        leftView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
        leftView.cell = self;
        leftView.frame = CGRectMake(-leftView.bounds.size.width, 0, leftView.bounds.size.width, swipeOverlay.bounds.size.height);
        [swipeOverlay addSubview:leftView];
    }
    if (!rightView && _rightButtons.count > 0) {
        rightView = [[MGSwipeButtonsView alloc] initWithButtons:_rightButtons direction:MGSwipeDirectionRightToLeft];
        rightView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
        rightView.cell = self;
        rightView.frame = CGRectMake(swipeOverlay.bounds.size.width, 0, rightView.bounds.size.width, swipeOverlay.bounds.size.height);
        [swipeOverlay addSubview:rightView];
    }
}


- (void) addInputOverlayIfNeeded
{
    if (tableInputOverlay) {
        return;
    }
    swipeOverlay.hidden = NO;
    [self hiddenSubView:!swipeOverlay.hidden];
    
    UITableView * table = [self parentTable];
    table.scrollEnabled = NO;
    tableInputOverlay = [[MGSwipeTableInputOverlay alloc] initWithFrame:table.bounds];
    tableInputOverlay.currentCell = self;
    [table addSubview:tableInputOverlay];

    previusSelectionStyle = self.selectionStyle;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setAccesoryViewsHidden:YES];
    
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler:)];
    tapRecognizer.cancelsTouchesInView = YES;
    tapRecognizer.delegate = self;
    [self addGestureRecognizer:tapRecognizer];
}

-(void) removeInputOverlayIfNeeded
{
    if (!tableInputOverlay) {
        return;
    }
    swipeOverlay.hidden = YES;

    if (_delegate && [_delegate respondsToSelector:@selector(swipeTableRemoveInputOverlayCell:)]) {
        [_delegate swipeTableRemoveInputOverlayCell:self];
    }
    
    UITableView * table = [self parentTable];
    table.scrollEnabled = YES;
    [tableInputOverlay removeFromSuperview];
    tableInputOverlay = nil;
    
    self.selectionStyle = previusSelectionStyle;
    [self setAccesoryViewsHidden:NO];
    
    if (tapRecognizer) {
        [self removeGestureRecognizer:tapRecognizer];
        tapRecognizer = nil;
    }
}

#pragma mark Handle Table Events

-(void) willMoveToSuperview:(UIView *)newSuperview;
{
    if (newSuperview == nil) { //remove the table overlay when a cell is removed from the table
        [self removeInputOverlayIfNeeded];
    }
}

-(void) prepareForReuse
{
    [super prepareForReuse];
    [self cleanViews];
    [self initViews];
}

-(void) setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    if (editing) { //disable swipe buttons when the user sets table editing mode
        self.swipeOffset = 0;
    }
}

-(void) setEditing:(BOOL)editing
{
    [super setEditing:YES];
    if (editing) { //disable swipe buttons when the user sets table editing mode
        self.swipeOffset = 0;
    }
}

-(UIView *) hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    //override hitTest to give swipe buttons a higher priority (diclosure buttons can steal input)
    UIView * targets[] = {leftView, rightView};
    for (int i = 0; i< 2; ++i) {
        UIView * target = targets[i];
        if (!target) continue;
        
        CGPoint p = [self convertPoint:point toView:target];
        if (CGRectContainsPoint(target.bounds, p)) {
            return [target hitTest:p withEvent:event];
        }
    }
    return [super hitTest:point withEvent:event];
}

#pragma mark Some utility methods

- (UIImage *)imageFromView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [[UIScreen mainScreen] scale]);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(void) setAccesoryViewsHidden: (BOOL) hidden
{
    if (self.accessoryView) {
        self.accessoryView.hidden = hidden;
    }
    for (UIView * view in self.contentView.superview.subviews) {
        if (view != self.contentView && ([view isKindOfClass:[UIButton class]] || [NSStringFromClass(view.class) rangeOfString:@"Disclosure"].location != NSNotFound)) {
            view.hidden = hidden;
        }
    }
}

-(UIColor *) backgroundColorForSwipe
{
    if (_swipeBackgroundColor) {
        return _swipeBackgroundColor; //user defined color
    }
    else if (self.contentView.backgroundColor && ![self.contentView.backgroundColor isEqual:[UIColor clearColor]]) {
        return self.contentView.backgroundColor;
    }
    else if (self.backgroundColor && ![self.backgroundColor isEqual:[UIColor clearColor]]) {
        return self.backgroundColor;
    }
    return [UIColor whiteColor];
}

-(UITableView *) parentTable
{
    if (cachedParentTable) {
        return cachedParentTable;
    }
    
    UIView * view = self.superview;
    while(view != nil) {
        if([view isKindOfClass:[UITableView class]]) {
            cachedParentTable = (UITableView*) view;
        }
        view = view.superview;
    }
    return cachedParentTable;
}

#pragma mark Swipe Animation

- (void)setSwipeOffset:(CGFloat) newOffset;
{
    _swipeOffset = newOffset;
    [self hiddenSubView: _swipeOffset < 0 ? YES:NO];

    CGFloat sign = newOffset > 0 ? 1.0 : -1.0;
    CGFloat offset = fabs(newOffset);
    
    MGSwipeButtonsView * activeButtons = sign < 0 ? rightView : leftView;
    if (!activeButtons || offset == 0) {
        [self removeInputOverlayIfNeeded];
        targetOffset = 0;
    }
    else {
        [self addInputOverlayIfNeeded];
        CGFloat swipeThreshold = sign < 0 ? _rightSwipeSettings.threshold : _leftSwipeSettings.threshold;
        targetOffset = offset > activeButtons.bounds.size.width * swipeThreshold ? activeButtons.bounds.size.width * sign : 0;
    }
    
    swipeView.transform = CGAffineTransformMakeTranslation(newOffset, 0);
    
    //animate existing buttons
    MGSwipeButtonsView* but[2] = {leftView, rightView};
    MGSwipeSettings* settings[2] = {_leftSwipeSettings, _rightSwipeSettings};
    MGSwipeExpansionSettings * expansions[2] = {_leftExpansion, _rightExpansion};
    
    for (int i = 0; i< 2; ++i) {
        MGSwipeButtonsView * view = but[i];
        if (!view) continue;

        //buttons view position
        CGFloat translation = MIN(offset, view.bounds.size.width) * sign;
        view.transform = CGAffineTransformMakeTranslation(translation, 0);

        if (view != activeButtons) continue; //only transition if active (perf. improvement)
        bool expand = expansions[i].buttonIndex >= 0 && offset > view.bounds.size.width * expansions[i].threshold;
        if (expand) {
            [view expandToOffset:offset button:expansions[i].buttonIndex];
            targetOffset = expansions[i].fillOnTrigger ? self.contentView.bounds.size.width * sign : 0;
            activeExpansion = view;
        }
        else {
            [view endExpansioAnimated:YES];
            activeExpansion = nil;
            CGFloat t = MIN(1.0f, offset/view.bounds.size.width);
            [view transition:settings[i].transition percent:t];
        }
    }
}


-(void) updateSwipe: (CGFloat) offset
{
    bool allowed = offset > 0 ? allowSwipeLeftToRight : allowSwipeRightToLeft;
    UIView * buttons = offset > 0 ? leftView : rightView;
    if (!buttons || ! allowed) {
        offset = 0;
    }
    self.swipeOffset = offset;
}

-(void) hideSwipeAnimated: (BOOL) animated
{
    [self setSwipeOffset:0 animated:animated completion:nil];
}

-(void) showSwipe: (MGSwipeDirection) direction animated: (BOOL) animated
{
    [self createSwipeViewIfNeeded];
    UIView * buttonsView = direction == MGSwipeDirectionLeftToRight ? leftView : rightView;
    
    if (buttonsView) {
        CGFloat s = direction == MGSwipeDirectionLeftToRight ? 1.0 : -1.0;
        [self setSwipeOffset:buttonsView.bounds.size.width * s animated:animated completion:nil];
    }
}

-(void) animationTick: (CADisplayLink *) timer
{
    if (!animationData.start) {
        animationData.start = timer.timestamp;
    }
    CFTimeInterval elapsed = timer.timestamp - animationData.start;
    CGFloat t = MIN(elapsed/animationData.duration, 1.0f);
    bool completed = t>=1.0f;
    //CubicEaseOut interpolation
    t--;
    self.swipeOffset = (t * t * t + 1.0) * (animationData.to - animationData.from) + animationData.from;
    //call animation completion and invalidate timer
    if (completed){
        [timer invalidate];
        displayLink = nil;
        if (animationCompletion) {
            animationCompletion();
        }
    }
}

-(void)hiddenSubView:(BOOL)hidden{
    for (UIView *itemView in self.contentView.subviews) {
        itemView.hidden = hidden;
    }
}

-(void) setSwipeOffset:(CGFloat)offset animated: (BOOL) animated completion:(void(^)()) completion
{
    animationCompletion = completion;
    if (displayLink) {
        [displayLink invalidate];
        displayLink = nil;
    }
    
    if (!animated) {
        self.swipeOffset = offset;
        return;
    }
    
    animationData.from = _swipeOffset;
    animationData.to = offset;
    animationData.duration = 0.3;
    animationData.start = 0;
    displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(animationTick:)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

#pragma mark Gestures

-(void) tapHandler: (UITapGestureRecognizer *) recognizer
{
    [self hideSwipeAnimated:YES];
}

-(void) panHandler: (UIPanGestureRecognizer *)gesture
{
    CGPoint current = [gesture translationInView:self];
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.highlighted = NO;
        self.selected = NO;
        [self createSwipeViewIfNeeded];
        panStartPoint = current;
        panStartOffset = _swipeOffset;
    }
    else if (gesture.state == UIGestureRecognizerStateChanged) {
        CGFloat offset = panStartOffset + current.x - panStartPoint.x;
        [self updateSwipe:offset];
    }
    else if (gesture.state == UIGestureRecognizerStateEnded) {
        MGSwipeButtonsView * expansion = activeExpansion;
        if (expansion) {
            UIView * expandedButton = [expansion getExpandedButton];
            [self setSwipeOffset:targetOffset animated:YES completion:^{
                [expansion handleClick:expandedButton fromExpansion:YES];
            }];
        }
        else {
            [self setSwipeOffset:targetOffset animated:YES completion:nil];
        }
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    if (gestureRecognizer == panRecognizer) {
        
        if (self.isEditing) {
            return NO; //do not swipe while editing table
        }
        
        CGPoint translation = [panRecognizer translationInView:self];
        if (fabs(translation.y) > fabs(translation.x)) {
            return NO; // user is scrolling vertically
        }
        if (swipeView) {
            CGPoint point = [tapRecognizer locationInView:swipeView];
            if (!CGRectContainsPoint(swipeView.bounds, point)) {
                return NO; //user clicked outside the cell or in the buttons area
            }
        }
        
        if (_swipeOffset != 0.0) {
            return YES; //already swipped, don't need to check buttons or canSwipe delegate
        }
        
        //make a decision according to existing buttons or using he optional delegate
        if (_delegate && [_delegate respondsToSelector:@selector(swipeTableCell:canSwipe:)]) {
            allowSwipeLeftToRight = [_delegate swipeTableCell:self canSwipe:MGSwipeDirectionLeftToRight];
            allowSwipeRightToLeft = [_delegate swipeTableCell:self canSwipe:MGSwipeDirectionRightToLeft];
        }
        else {
            [self fetchButtonsIfNeeded];
            allowSwipeLeftToRight = _leftButtons.count > 0;
            allowSwipeRightToLeft = _rightButtons.count > 0;
        }
        
        return (allowSwipeLeftToRight && translation.x > 0) || (allowSwipeRightToLeft && translation.x < 0);
    }
    else if (gestureRecognizer == tapRecognizer) {
        CGPoint point = [tapRecognizer locationInView:swipeView];
        return CGRectContainsPoint(swipeView.bounds, point);
    }
    return YES;
}

//-(void)hiddenSubView:(BOOL)hidden{
//    self.mDeviceStatus.hidden = self.mDeviceName.hidden = self.mDeviceIcon.hidden = hidden;
//}
//
//-(void)setMCurData:(EHExeModeCellData *)mCurData{
//    _mCurData = mCurData;
//    //名称
//    RCEDevice *mDeviceData = [DBHelper deviceWithDeviceId:mCurData.deviceId];
//    [_mDeviceName setText:mDeviceData.name.length >0 ? mDeviceData.name: mDeviceData.product_name];
//    
//    //设备图标。
//    UIImage *deviceIcon = [UIImage imageNamed:[NSString stringWithFormat:@"%@_icon",mDeviceData.productId]];
//    if (!deviceIcon) deviceIcon = [UIImage imageNamed:@"ic_default_device"];
//    RCEProduct *product = [DBHelper productWithProductId:mDeviceData.productId];
//    [_mDeviceIcon setImageWithURL:[NSURL URLWithString:product.icon] placeholderImage:deviceIcon];
//
//    _mDeviceStatus.textColor = Color_greed_lighted;
//    if ([mDeviceData isKindOfClass:[EHSwitch class]]) {
//        [self setSwitchStatues:mCurData];
//    }
//    else if ([mDeviceData isKindOfClass:[EHThermometer class]]) {
//        [self setThermometerStatues:mCurData];
//    }
//    else if ([mDeviceData isKindOfClass:[EHInfrared class]]) {
//        [self setInfraredStatues:mCurData];
//    }
//    else if ([mDeviceData isKindOfClass:[EHSmokes class]]) {
//        [self setSmokeStatues:mCurData];
//    }
//    else if ([mDeviceData isKindOfClass:[EHDoorLock class]]) {
//        [self setDoorlockStatues:mCurData];
//    }
//    else if ([mDeviceData isKindOfClass:[EHDoorsensor class]]) {
//        [self setDoorSensorStatues:mCurData];
//    }
//}
//
////0:关 1：开  -1：没有设置
//-(NSInteger)switchIsON:(NSInteger)channelId cellData:(EHExeModeCellData*)cellData{
//    for (NSInteger i = 0 ; i <= cellData.arrCmdData.count; i ++) {
//        if (i == cellData.arrCmdData.count) {
//            return -1;
//        }
//        EHDeviceCmdData *cmdData = [cellData.arrCmdData objectAtIndex:i];
//        if ([cmdData.action isEqualToString:ptl_ctrl_switch_off]) {
//            NSDictionary *dict = [EHCommonMethod stringToDictionary:cmdData.payload];
//            NSArray *arr = [dict valueForKey:ptl_channels];
//            if (arr.count) {
//                for (NSString *channel in arr) {
//                    if ([channel integerValue]  == channelId) {
//                        return 0;
//                    }
//
//                }
//        
//            }
//        }
//        else if ([cmdData.action isEqualToString:ptl_ctrl_switch_on]) {
//            NSDictionary *dict = [EHCommonMethod stringToDictionary:cmdData.payload];
//            NSArray *arr = [dict valueForKey:ptl_channels];
//            if (arr.count) {
//                for (NSString *channel in arr) {
//                    if ([channel integerValue]  == channelId) {
//                        return 1;
//                    }
//                }
//            }
//        }
//    }
//    return -1;
//}
////开关。。
//-(void)setSwitchStatues:(EHExeModeCellData*)cellData{
//    NSMutableString *statusStr = [NSMutableString string];
//    EHSwitch *mDeviceData = (EHSwitch*)[DBHelper deviceWithDeviceId:cellData.deviceId];
//    
//    [_mDeviceName setText:[NSString stringWithFormat:@"%@(%d位)", mDeviceData.name.length >0 ? mDeviceData.name: mDeviceData.product_name, (int)mDeviceData.channels.count]];
//    for (NSInteger i =0 ; i< mDeviceData.channels.count; i++) {
//        EHSwitch_Channel *channale = [mDeviceData.channels objectAtIndex:i];
//        if ([self switchIsON:channale.channelID cellData:cellData] == 0) {
//            if (statusStr.length >0) {
//                [statusStr appendString:@"/"];
//            }
//            [statusStr appendString:SWITCHOFFSTR];
//            continue;
//        }
//        if ([self switchIsON:channale.channelID cellData:cellData] == 1) {
//            if (statusStr.length >0) {
//                [statusStr appendString:@"/"];
//            }
//            [statusStr appendString:SWITCHONSTR];
//            continue;
//        }
//    }
//    
////    [_mDeviceStatus setText:statusStr];
//    [_mDeviceStatus setTextColor:Color_greed_normal];
//    [_mDeviceStatus setText:statusStr afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
////        NSRange range = [statusStr rangeOfString:SWITCHONSTR];
////        
////        NSInteger i = 0;
////        NSString * tmpStr = statusStr;
////        range =  [tmpStr rangeOfString:SWITCHONSTR];
////        while (range.length > 0) {
////            [mutableAttributedString addAttribute:(NSString *)kCTForegroundColorAttributeName
////                                            value:(id)Color_greed_normal
////                                            range:NSMakeRange(range.location + i, range.length)];
////            i += range.location + range.length;
////            tmpStr = [tmpStr substringFromIndex:range.location+range.length];
////            range =  [tmpStr rangeOfString:SWITCHONSTR];
////        }
////        
////        i=0;
////        tmpStr = statusStr;
////        range =  [tmpStr rangeOfString:SWITCHOFFSTR];
////        while (range.length > 0) {
////            [mutableAttributedString addAttribute:(NSString *)kCTForegroundColorAttributeName
////                                            value:(id)Color_orange_FA5C43
////                                            range:NSMakeRange(range.location + i, range.length)];
////            i += range.location + range.length;
////            tmpStr = [tmpStr substringFromIndex:range.location+range.length];
////            range =  [tmpStr rangeOfString:SWITCHOFFSTR];
////        }
//        
//        return mutableAttributedString;
//    }];
//}
////温湿度。
//-(void)setThermometerStatues:(EHExeModeCellData*)cellData{
//    NSMutableString *statusStr = [NSMutableString string];
//    
//    for (EHDeviceCmdData *cmdData in cellData.arrCmdData) {
//        //湿度检测
//        if ([cmdData.action isEqualToString:ptl_event_detect_alarm_humi]) {
//            [statusStr appendString:[NSString stringWithFormat:@" %@ %@",NSLocalizedString(@"Moisture detection alarm", nil), NSLocalizedString(@"start", nil)]];
//        }
//        //温度检测。。
//        if ([cmdData.action isEqualToString:ptl_event_detect_alarm_temp]) {
//            [statusStr appendString:[NSString stringWithFormat:@" %@ %@",NSLocalizedString(@"Temperature alarm", nil), NSLocalizedString(@"start", nil)]];
//        }
//    }
//    [_mDeviceStatus setText:statusStr afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
//        NSRange range = [statusStr rangeOfString:NSLocalizedString(@"start", nil)];
//        if (range.length >0 ) {
//            [mutableAttributedString addAttribute:(NSString *)kCTForegroundColorAttributeName
//                                            value:(id)Color_greed_normal
//                                            range:range];
//            
//            //第二个
//            NSInteger pos = range.location+range.length;
//            NSString *temptext = [statusStr substringFromIndex:pos];
//            range = [temptext rangeOfString:NSLocalizedString(@"start", nil)];
//            if (range.length >0 ) {
//                range.location += pos;
//                [mutableAttributedString addAttribute:(NSString *)kCTForegroundColorAttributeName
//                                                value:(id)Color_greed_normal
//                                                range:range];
//            }
//        }
//        
//
//        return mutableAttributedString;
//    }];
//}
//
////红外
//-(void)setInfraredStatues:(EHExeModeCellData*)cellData{
//    NSMutableString *statusStr = [NSMutableString string];
//    
//    for (EHDeviceCmdData *cmdData in cellData.arrCmdData) {
//        if ([cmdData.action isEqualToString:ptl_ctrl_set_def]) {
//            [statusStr appendString:NSLocalizedString(@"security_set", nil)];
//            [_mDeviceStatus setTextColor:Color_greed_lighted];
//        }
//        else if ([cmdData.action isEqualToString:ptl_ctrl_cancel_def]){
//            [statusStr appendString:NSLocalizedString(@"security_cancel", nil)];
//            [_mDeviceStatus setTextColor:Color_greed_lighted];
//        }
//    }
//    [_mDeviceStatus setText:statusStr afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
//        return mutableAttributedString;
//    }];
//}
//
////烟感。
//-(void)setSmokeStatues:(EHExeModeCellData*)cellData{
//    NSMutableString *statusStr = [NSMutableString string];
//    
//    for (EHDeviceCmdData *cmdData in cellData.arrCmdData) {
//        if ([cmdData.action isEqualToString:ptl_event_detect_alarm]) {
//            [statusStr appendString:NSLocalizedString(@"detection alarm", nil)];
//            [_mDeviceStatus setTextColor:Color_greed_lighted];
//        }
//    }
//    [_mDeviceStatus setText:statusStr afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
//        return mutableAttributedString;
//    }];
//}
//
////门锁
//-(void)setDoorlockStatues:(EHExeModeCellData*)cellData{
//    NSMutableString *statusStr = [NSMutableString string];
//    
//    for (EHDeviceCmdData *cmdData in cellData.arrCmdData) {
//        if ([cmdData.action isEqualToString:ptl_ctrl_switch_on]) {
//            [statusStr appendString:NSLocalizedString(@"start", nil)];
//            [_mDeviceStatus setTextColor:Color_greed_lighted];
//        }
//        else if ([cmdData.action isEqualToString:ptl_ctrl_switch_off]) {
//            [statusStr appendString:NSLocalizedString(@"Close", nil)];
//            [_mDeviceStatus setTextColor:Color_greed_lighted];
//        }
//    }
//    [_mDeviceStatus setText:statusStr afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
//        return mutableAttributedString;
//    }];
//}
//
////门磁
//-(void)setDoorSensorStatues:(EHExeModeCellData*)cellData{
//    NSMutableString *statusStr = [NSMutableString string];
//    
//    for (EHDeviceCmdData *cmdData in cellData.arrCmdData) {
//        if ([cmdData.action isEqualToString:ptl_ctrl_set_def]) {
//            [statusStr appendString:NSLocalizedString(@"security_set", nil)];
//            [_mDeviceStatus setTextColor:Color_greed_lighted];
//        }
//        else if ([cmdData.action isEqualToString:ptl_ctrl_cancel_def]){
//            [statusStr appendString:NSLocalizedString(@"security_cancel", nil)];
//            [_mDeviceStatus setTextColor:Color_greed_lighted];
//        }
//    }
//    [_mDeviceStatus setText:statusStr afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
//        return mutableAttributedString;
//    }];
//}


@end
