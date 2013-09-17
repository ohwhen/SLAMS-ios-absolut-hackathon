//
//  RecipeViewController.m
//  ABSOLUT Limitless
//
//  Created by Owen van Dijk on 16-09-13.
//  Copyright (c) 2013 Owen van Dijk. All rights reserved.
//

#import "RecipeViewController.h"

@interface RecipeViewController ()

@end

@implementation RecipeViewController {
    MPMoviePlayerController *moviePlayer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBackgroundVideo];
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

@end
