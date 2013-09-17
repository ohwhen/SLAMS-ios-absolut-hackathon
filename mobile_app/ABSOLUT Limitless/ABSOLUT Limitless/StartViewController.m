//
//  ViewController.m
//  ABSOLUT Limitless
//
//  Created by Owen van Dijk on 15-09-13.
//  Copyright (c) 2013 Owen van Dijk. All rights reserved.
//

#import "StartViewController.h"
#import "AppDelegate.h"

@interface StartViewController ()

@end


@implementation StartViewController {
    MPMoviePlayerController *moviePlayer;
}

@synthesize buttonStart;
@synthesize userName;

- (void)viewDidLoad {
    [self setupBackgroundVideo];
    [buttonStart addTarget:self action:@selector(handleButtonEvent:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)setupBackgroundVideo {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"background.mp4" ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:path];
    moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
    moviePlayer.view.frame = CGRectMake(0, 0, 1024, 768);
    moviePlayer.movieSourceType = MPMovieSourceTypeFile;
    moviePlayer.scalingMode = MPMovieScalingModeFill;
    moviePlayer.controlStyle = MPMovieControlStyleNone;
    moviePlayer.repeatMode = MPMovieRepeatModeOne;
    [[MPMusicPlayerController applicationMusicPlayer] setVolume:0];
    [self.view addSubview:moviePlayer.view];
    [self.view sendSubviewToBack:moviePlayer.view];
    [moviePlayer play];
}

- (void)handleButtonEvent:(id)sender {
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    delegate.userName = userName.text;
}
@end
