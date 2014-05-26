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

@optional
-(void)avatarViewOnTouchAction:(MCAvatarView *)avatarView;
-(void)avatarViewOnImagePickedAction:(MCAvatarView *)avatarView;

@end

@interface MCAvatarView : UIImageView <UIImagePickerControllerDelegate,UIActionSheetDelegate,
UINavigationControllerDelegate>

@property (nonatomic, assign) id <MCAvatarViewDelegate>delegate;
@property (nonatomic) BOOL shadowEnable;
@property (nonatomic) CGFloat borderWidth;
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic) BOOL showImagePikerOnTouch;

@property (nonatomic, weak) UIViewController * presentingViewController;

-(id)initWithFrame:(CGRect)frame;

@end

