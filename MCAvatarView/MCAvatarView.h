//
//  MCAvatarView.h
//  MCAvatarView
//
//  Created by Marcus Oliveira on 21/01/14.
//  Copyright (c) 2014 MyAppControls. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MCAvatarView;

@protocol MCAvatarViewDelegate <NSObject>
-(void)avatarViewOnTouchAction:(MCAvatarView *)avatarView;
@end

@interface MCAvatarView : UIView

@property (nonatomic, assign) id <MCAvatarViewDelegate>delegate;
@property (nonatomic) BOOL shadowEnable; // default is YES
@property (nonatomic) CGFloat borderWidth; // default is [UIColor whiteColor]
@property (nonatomic, strong) UIColor *borderColor; // default is [UIColor whiteColor]
@property (nonatomic, strong) UIImage *image; // default is NIL

@end