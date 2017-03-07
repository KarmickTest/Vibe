//
//  UIView+Border.h
//  DeliveryExpress
//
//  Created by Abdur Rahim on 18/06/15.
//  Copyright (c) 2015 karmick. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Border)
- (void)addBottomBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth;

- (void)addLeftBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth;

- (void)addRightBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth;

- (void)addTopBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth;
@end
