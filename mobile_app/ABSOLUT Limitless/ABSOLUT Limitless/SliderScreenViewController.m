//
// Created by Owen van Dijk on 15-09-13.
// Copyright (c) 2013 Owen van Dijk. All rights reserved.

#import "SliderScreenViewController.h"
#import "AppDelegate.h"

@implementation SliderScreenViewController {
    AFHTTPClient *httpClient;
    MPMoviePlayerController *moviePlayer;
}

@synthesize buttonStart;
@synthesize button1;
@synthesize button2;
@synthesize button3;
@synthesize button4;
@synthesize button5;
@synthesize button6;
@synthesize button7;
@synthesize button8;

- (void)viewDidLoad {
    [self setupBackgroundVideo];
    [self setupButtons];
    httpClient = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:@"http://bykosmo.com"]];
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

- (void)setupButtons {

    float currentAlpha = 60 + arc4random() % 40;

    button1 = [[CircleButtonView alloc] initWithFrame:CGRectMake(95, 165, 150, 150)];
    [button1 addGestures];
    [button1 setLabel:@"SWEET"];
    button1.alpha = currentAlpha;
    [self.view addSubview:button1];

    currentAlpha = 60 + arc4random() % 40;

    button2 = [[CircleButtonView alloc] initWithFrame:CGRectMake(205, 445, 150, 150)];
    [button2 addGestures];
    [button2 setLabel:@"SOUR"];
    button2.alpha = currentAlpha;
    [self.view addSubview:button2];

    currentAlpha = 60 + arc4random() % 40;

    button3 = [[CircleButtonView alloc] initWithFrame:CGRectMake(367, 186, 150, 150)];
    [button3 addGestures];
    [button3 setLabel:@"BITTER"];
    button3.alpha = currentAlpha;
    [self.view addSubview:button3];

    currentAlpha = 60 + arc4random() % 40;

    button4 = [[CircleButtonView alloc] initWithFrame:CGRectMake(467, 400, 150, 150)];
    [button4 addGestures];
    [button4 setLabel:@"REFRESHING"];
    button4.alpha = currentAlpha;
    [self.view addSubview:button4];

    currentAlpha = 60 + arc4random() % 40;

    button5 = [[CircleButtonView alloc] initWithFrame:CGRectMake(623, 220, 150, 150)];
    [button5 addGestures];
    [button5 setLabel:@"CITRUS"];
    button5.alpha = currentAlpha;
    [self.view addSubview:button5];

    currentAlpha = 60 + arc4random() % 40;

    button6 = [[CircleButtonView alloc] initWithFrame:CGRectMake(740, 467, 150, 150)];
    [button6 addGestures];
    [button6 setLabel:@"FRUITY"];
    button6.alpha = currentAlpha;
    [self.view addSubview:button6];
}

- (void)handleButtonEvent:(id)sender {

    CGFloat number1 = arc4random() % 100;
    CGFloat number2 = arc4random() % 100;
    CGFloat number3 = arc4random() % 100;
    CGFloat number4 = arc4random() % 100;

    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];

    NSDictionary *parameters = @{
            @"userName" :delegate.userName,
            @"slider1" : [NSString stringWithFormat: @"%f", number1],
            @"slider2" : [NSString stringWithFormat: @"%f", number2],
            @"slider3" : [NSString stringWithFormat: @"%f", number3],
            @"slider4" : [NSString stringWithFormat: @"%f", number4],
    };
    NSLog(@"sending data %@", parameters);
    [httpClient setParameterEncoding:AFFormURLParameterEncoding];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [httpClient postPath:@"/limitless/newDrink.php"
              parameters:parameters
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {

                     NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                     NSLog(@"response %@", response);
                     NSDictionary *drink = [response objectForKey:@"drink"];
                     NSNumber *userId = [drink objectForKey:@"id"];
                     delegate.userId = userId;
                 }
                 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     [self performSegueWithIdentifier:@"startAgainSegue" sender:self];
                 }];

    //addName.php
}

@end