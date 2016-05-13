//
//  TDTransitionFromFirToSec.m
//  iOSNote
//
//  Created by wangdong on 16/5/13.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "TDTransitionFromFirToSec.h"
#import "TransitionDemoVC.h"
#import "TransitionDemoSecVC.h"
#import "TDDemoCell.h"

@implementation TDTransitionFromFirToSec

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    [UIView animateWithDuration:0.3 animations:^{
        
        
        TransitionDemoVC *fromViewController = (TransitionDemoVC*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        TransitionDemoSecVC *toViewController = (TransitionDemoSecVC*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        
        UIView *containerView = [transitionContext containerView];
        NSTimeInterval duration = [self transitionDuration:transitionContext];
        
        // Get a snapshot of the thing cell we're transitioning from
        TDDemoCell *cell = (TDDemoCell*)[fromViewController.collectionView cellForItemAtIndexPath:[[fromViewController.collectionView indexPathsForSelectedItems] firstObject]];
        UIView *cellImageSnapshot = [cell.imageView snapshotViewAfterScreenUpdates:NO];
        cellImageSnapshot.frame = [containerView convertRect:cell.imageView.frame fromView:cell.imageView.superview];
        cell.imageView.hidden = YES;
        
        // Setup the initial view states
        toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
        toViewController.view.alpha = 0;
//        toViewController.imageView.hidden = YES;
        
        [containerView addSubview:toViewController.view];
//        [containerView addSubview:cellImageSnapshot];
        
        [UIView animateWithDuration:duration animations:^{
            // Fade in the second view controller's view
            toViewController.view.alpha = 1.0;
            
            // Move the cell snapshot so it's over the second view controller's image view
//            CGRect frame = [containerView convertRect:toViewController.imageView.frame fromView:toViewController.view];
//            cellImageSnapshot.frame = frame;
        } completion:^(BOOL finished) {
            // Clean up
//            toViewController.imageView.hidden = NO;
            cell.hidden = NO;
            [cellImageSnapshot removeFromSuperview];
            
            // Declare that we've finished
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
        
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3f;
}

@end
