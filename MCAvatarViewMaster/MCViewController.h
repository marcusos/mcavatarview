//
//  MCViewController.h
//  MCAvatarViewMaster
//
//  Created by Marcus Oliveira on 20/05/14.
//  Copyright (c) 2014 MyAppControls. All rights reserved.
//

#import "MCAvatarView.h"
#import <UIKit/UIKit.h>

@interface MCViewController : UIViewController <MCAvatarViewDelegate>

@property (weak, nonatomic) IBOutlet MCAvatarView *avatarView1;

@end
