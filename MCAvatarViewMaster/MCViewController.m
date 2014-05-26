//
//  MCViewController.m
//  MCAvatarViewMaster
//
//  Created by Marcus Oliveira on 20/05/14.
//  Copyright (c) 2014 MyAppControls. All rights reserved.
//

#import "MCViewController.h"

@interface MCViewController ()

@end

@implementation MCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    MCAvatarView *avatarView2;
    MCAvatarView *avatarView3;

    avatarView2 = [[MCAvatarView alloc] initWithFrame:
        CGRectMake(100, 245, 120, 120)];

    avatarView3 = [[MCAvatarView alloc] initWithFrame:
                   CGRectMake(110, 375, 100, 100)];
    
    self.avatarView1.image = [UIImage imageNamed:@"fpo_avatar.png"];
    avatarView2.image = [UIImage imageNamed:(@"navi-avatar.png")];
    avatarView3.image = [UIImage imageNamed:(@"the-godfather.png")];
    
    [self.view addSubview:avatarView2];
    [self.view addSubview:avatarView3];
    
    self.avatarView1.delegate = self;
    avatarView2.delegate = self;
    avatarView3.delegate = self;
    
    avatarView3.image = [UIImage imageNamed:(@"the-godfather.png")];
    
}

-(void)avatarViewOnTouchAction:(MCAvatarView *)avatarView {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"MCAvatarView"
                                                    message:@"AvatarView Touched!"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}




@end
