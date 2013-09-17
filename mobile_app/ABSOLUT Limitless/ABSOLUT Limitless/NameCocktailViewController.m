//
//  NameCocktailViewController.m
//  ABSOLUT Limitless
//
//  Created by Owen van Dijk on 16-09-13.
//  Copyright (c) 2013 Owen van Dijk. All rights reserved.
//

#import "NameCocktailViewController.h"
#import "AppDelegate.h"

@implementation NameCocktailViewController {
    AFHTTPClient *httpClient;
    MPMoviePlayerController *moviePlayer;
}

@synthesize buttonMixIt;
@synthesize nameOfCocktail;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBackgroundVideo];
    httpClient = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:@"http://bykosmo.com"]];
    [buttonMixIt addTarget:self action:@selector(handleButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
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
    NSDictionary *parameters = @{
            @"id" : delegate.userId,
            @"drinkName" : nameOfCocktail.text,
    };
    NSLog(@"sending data %@", parameters);
    [httpClient setParameterEncoding:AFFormURLParameterEncoding];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [httpClient postPath:@"/limitless/addName.php"
              parameters:parameters
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     [self performSegueWithIdentifier:@"startAgainSegue" sender:self];
                 }
                 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     [self performSegueWithIdentifier:@"startAgainSegue" sender:self];
                 }];
}
@end
