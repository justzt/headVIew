//
//  HeadVIew.h
//  CycleThumbnail
//
//  Created by justzt on 5/31/13.
//  Copyright (c) 2013 justzt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../Pods/Headers/ASIHTTPRequest/ASIHTTPRequest.h"

@interface HeadView : UIView

- (id)initWithFrame:(CGRect)frame headeImageName:(NSString *)imageName;
- (id)initWithFrame:(CGRect)frame headImageName:(NSString *)imageName fromeNetwork:(BOOL)fromeNetwork;

- (void)setHeadeIamgeWithName:(NSString*)imageName;
- (void)setHeadeIamgeWithUrl:(NSString*)imageUrl;
- (void)setHeadImage:(UIImage*)image;
@end
