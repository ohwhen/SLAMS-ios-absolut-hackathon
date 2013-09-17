//
//  CircleButtonView.m
//  ABSOLUT Limitless
//
//  Created by Owen van Dijk on 16-09-13.
//  Copyright (c) 2013 Owen van Dijk. All rights reserved.
//

#import "CircleButtonView.h"

@implementation CircleButtonView {
    UIImageView *backgroundImage;
    UILabel *label;
    float firstX;
    float firstY;
    float lastScale;
}

@synthesize currentScale;

- (CircleButtonView *)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"buttonCircle.png"]];
        [self addSubview:backgroundImage];

        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 150, 30)];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        [self addSubview:label];

        self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.5, 1.5);
    }
    return self;
}

- (void)addGestures {
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scale:)];
    [pinchRecognizer setDelegate:self];
    [self addGestureRecognizer:pinchRecognizer];

    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [panRecognizer setDelegate:self];
    [self addGestureRecognizer:panRecognizer];
}

- (void)setLabel:(NSString *)newLabel {
    label.text = newLabel;
}

- (void)scale:(UIPinchGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        lastScale = 1.0;
        return;
    }
    CGFloat scale = 1.0 - (lastScale - sender.scale);
    CGAffineTransform currentTransform = sender.view.transform;

    CGFloat xScale = currentTransform.a;
    if (xScale > 0.5f && xScale <= 3.0f) {
        CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale, scale);
        if (newTransform.a < 0.5) {
            newTransform.a = 0.5f;
            newTransform.d = 0.5f;
        } else if (newTransform.a > 3) {
            newTransform.a = 3.0f;
            newTransform.d = 3.0f;
        }
        [sender.view setTransform:newTransform];
        lastScale = sender.scale;
    }
}

- (void)move:(id)sender {
    [self bringSubviewToFront:[(UIPanGestureRecognizer *) sender view]];
    CGPoint translatedPoint = [(UIPanGestureRecognizer *) sender translationInView:self];

    if ([(UIPanGestureRecognizer *) sender state] == UIGestureRecognizerStateBegan) {
        firstX = [[sender view] center].x;
        firstY = [[sender view] center].y;
    }
    translatedPoint = CGPointMake(firstX + translatedPoint.x, firstY + translatedPoint.y);
    [[sender view] setCenter:translatedPoint];
}

@end
