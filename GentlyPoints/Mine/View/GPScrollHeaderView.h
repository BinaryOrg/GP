//
//  LHScrollHeaderView.h
//  SwipeTableView
//
//  Created by Roy lee on 16/6/24.
//  Copyright © 2016年 Roy lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GPScrollHeaderView;
@protocol LHScrollHeaderViewDelegate <NSObject>

- (CGPoint)minHeaderViewFrameOrgin;
- (CGPoint)maxHeaderViewFrameOrgin;

@optional
- (void)headerViewDidFrameChanged:(GPScrollHeaderView *)headerView;
- (void)headerView:(GPScrollHeaderView *)headerView didPan:(UIPanGestureRecognizer *)pan;
- (void)headerView:(GPScrollHeaderView *)headerView didPanGestureRecognizerStateChanged:(UIPanGestureRecognizer *)pan;

@end


/**
   采用 UIKitDynamics 实现自定的 swipeHeaderView
 
   只有当`SwipeTableView`的 swipeHeaderView 是`LHScrollHeaderView`或其子类的实例,拖拽`SwipeTableView`的 swipeHeaderView才能 同时滚动`SwipeTableView`的 currentItemView.
 */
NS_CLASS_AVAILABLE_IOS(7_0) @interface GPScrollHeaderView : UIView

@property (nonatomic, readonly, strong) UIPanGestureRecognizer * panGestureRecognizer;
@property (nonatomic, weak) id<LHScrollHeaderViewDelegate> delegate;
@property (nonatomic, readonly, getter=isTracking)     BOOL tracking;
@property (nonatomic, readonly, getter=isDragging)     BOOL dragging;
@property (nonatomic, readonly, getter=isDecelerating) BOOL decelerating;

/**
 *  结束视图的 惯性减速 & 弹性回弹 等效果
 */
- (void)endDecelerating;

@end
