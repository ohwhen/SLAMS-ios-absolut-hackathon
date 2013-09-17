//
//  VerticalUISlider.m
//  ABSOLUT Limitless
//
//  Created by Owen van Dijk on 15-09-13.
//  Copyright (c) 2013 Owen van Dijk. All rights reserved.
//

#import "VerticalUISlider.h"

@implementation VerticalUISlider

- (void)makeVertical {
    CGAffineTransform verticalTransformation = CGAffineTransformMakeRotation(M_PI * 0.5);
    self.transform = verticalTransformation;
}

@end
