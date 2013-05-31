//
//  AppDelegate.m
//  CycleThumbnail
//
//  Created by justzt on 5/31/13.
//  Copyright (c) 2013 justzt. All rights reserved.
//

#import "AppDelegate.h"
#import "HeadView.h"
#import <QuartzCore/QuartzCore.h>


@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self loadCycleThumbnial];
    
    return YES;
}

- (void)loadCycleThumbnial{
    HeadView *headeView = [[[HeadView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)] autorelease];
    [headeView setHeadeIamgeWithUrl:@"http://a0.att.hudong.com/49/26/01200000311072118802608677949.jpg"];
    headeView.center = self.window.center;
    [self.window addSubview:headeView];    
}

@end
