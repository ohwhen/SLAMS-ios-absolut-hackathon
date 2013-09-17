//
//  CircleButtonView.h
//  ABSOLUT Limitless
//
//  Created by Owen van Dijk on 16-09-13.
//  Copyright (c) 2013 Owen van Dijk. All rights reserved.
//

@interface CircleButtonView : UIView<UIGestureRecognizerDelegate>

@property (assign) float currentScale;

- (void)addGestures;
- (void)setLabel:(NSString *)newLabel;

@end
