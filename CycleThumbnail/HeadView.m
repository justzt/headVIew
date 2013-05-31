//
//  HeadVIew.m
//  CycleThumbnail
//
//  Created by justzt on 5/31/13.
//  Copyright (c) 2013 justzt. All rights reserved.
//

#import "HeadView.h"
#import <QuartzCore/QuartzCore.h>

#define kHeadImageViewTag 9876
#define kShadowColor  [UIColor redColor].CGColor

@implementation HeadView

- (void)dealloc
{
    [super dealloc];
}

#pragma mark - init methods
- (id)initWithFrame:(CGRect)frame{
   return  [self initWithFrame:frame headImageName:nil fromeNetwork:NO];
}

- (id)initWithFrame:(CGRect)frame headeImageName:(NSString *)imageName{
   return  [self initWithFrame:frame headImageName:imageName fromeNetwork:NO];
}

- (id)initWithFrame:(CGRect)frame headImageUrl:(NSString *)imageUrl{
   return  [self initWithFrame:frame headImageName:imageUrl fromeNetwork:YES];
}

- (id)initWithFrame:(CGRect)frame headImageName:(NSString *)imageName fromeNetwork:(BOOL)fromeNetwork{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        // round background view
        UIView *roundBackgrounView = [[[UIView alloc] initWithFrame:self.bounds] autorelease];
        roundBackgrounView.layer.cornerRadius = frame.size.width/2;;
        roundBackgrounView.backgroundColor = [UIColor whiteColor];
        roundBackgrounView.layer.shadowColor = kShadowColor;
        roundBackgrounView.layer.shadowRadius = 10;
        roundBackgrounView.layer.shadowOpacity = 0.7;
        roundBackgrounView.layer.shadowOffset = CGSizeMake(2.0, 2.0);
        [self addSubview:roundBackgrounView];
        
        CGRect headeFrame = frame;
        headeFrame.size.height = frame.size.height-10;
        headeFrame.size.width =  frame.size.width-10;
        
        // 防止有透明图片造成环形边框太宽,其frame与head image的frame保持一致
        UIView *fillBackgrounView = [[[UIView alloc] initWithFrame:headeFrame] autorelease];
        fillBackgrounView.backgroundColor = [UIColor blackColor];
        fillBackgrounView.layer.cornerRadius = headeFrame.size.width/2;
        fillBackgrounView.layer.masksToBounds = YES;
        fillBackgrounView.center = self.center;
        [self addSubview:fillBackgrounView];
        
        // head image
        UIImageView *headImageView = [[[UIImageView alloc] initWithFrame:headeFrame] autorelease];
        headImageView.center = self.center;
        if (imageName == nil) {
            imageName = @"test";
        }
        
        //load head image frome network
        if (fromeNetwork == YES) {
            [self loadHeadImageWithUrl:imageName];
        }
        headImageView.tag = kHeadImageViewTag;
        headImageView.image = [UIImage imageNamed:imageName];
        headImageView.layer.cornerRadius = headeFrame.size.width/2;
        headImageView.layer.masksToBounds = YES;
        [self addSubview:headImageView];
    }
    return self;
}

#pragma mark - public methods
- (void)setHeadeIamgeWithName:(NSString*)imageName{
    UIImageView *imgView = (UIImageView*)[self viewWithTag:kHeadImageViewTag];
    imgView.image = [UIImage imageNamed:imageName];
}

- (void)setHeadeIamgeWithUrl:(NSString*)imageUrl{
    [self loadHeadImageWithUrl:imageUrl];
}

- (void)setHeadImage:(UIImage*)image{
    UIImageView *imgView = (UIImageView*)[self viewWithTag:kHeadImageViewTag];
    imgView.image = image;
}

#pragma mark - private methods
- (void)loadHeadImageWithUrl:(NSString *)headImageUrl{
    NSURL *url = [NSURL URLWithString:headImageUrl];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    request.delegate = self;
    [request setDidFailSelector:@selector(requestDidFail:)];
    [request setDidFinishSelector:@selector(requestDidFinished:)];
    [request startAsynchronous];
}

#pragma mark - ASIHTTPRequestDelegate
- (void)requestDidFail:(ASIHTTPRequest*)request{
    NSLog(@"head download failed");
}

- (void)requestDidFinished:(ASIHTTPRequest*)request{
    NSData *imgData = [request responseData];
    UIImageView *imgView = (UIImageView*)[self viewWithTag:kHeadImageViewTag];
    imgView.image = [UIImage imageWithData:imgData];
}
@end
