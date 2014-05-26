//
//  MCAvatarView.m
//  MCAvatarView
//
//  Created by Marcus Oliveira on 21/01/14.
//  Copyright (c) 2014 MyAppControls. All rights reserved.
//

#import "MCAvatarView.h"

@implementation MCAvatarView {
    
    CALayer *borderLayer;
    CALayer *imageLayer;
    UIImage *_image;
    BOOL *isFromSuper;
}

@synthesize delegate;

@synthesize borderWidth = _borderWidth;
@synthesize borderColor = _borderColor;
@synthesize shadowEnable = _shadowEnable;

@synthesize image = _image;


#pragma mark - Touche methods

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    //The touch may be cancelled, due to scrolling etc. Restore the alpha if that is the case.
    self.alpha = 1;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
        
    self.alpha = 0.6;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    self.alpha = 1.0;
    
    if (self.delegate != nil &&
        [self.delegate respondsToSelector:@selector(avatarViewOnTouchAction:)]) {
        
        [self.delegate avatarViewOnTouchAction:self];
        
        return;
    }
    
}

#pragma mark - Setters/Getters/Customization

-(UIImage *)image {
    return _image;
}

- (void)setImage:(UIImage *)image {
    
    _image = image;
    
    [self drawAvatarView];
}


-(void)setShadowEnable:(BOOL)shadowEnable {
    
    _shadowEnable = shadowEnable;
    
    if (shadowEnable == true) {
        borderLayer.shadowColor = [UIColor blackColor].CGColor;
        borderLayer.shadowRadius = 5.f;
        borderLayer.shadowOffset = CGSizeMake(0.f, 5.f);
        borderLayer.shadowOpacity = 0.8f;
    }
    else {
        borderLayer.shadowOffset = CGSizeZero;
        borderLayer.shadowRadius = 0;
    }
}

-(void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
}

-(void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
}

-(void)initProperties {
    
    self.backgroundColor = [UIColor clearColor];
    
    self.borderColor = [UIColor whiteColor];
    self.borderWidth = self.frame.size.width*0.05;
    self.shadowEnable = YES;
    self.userInteractionEnabled = YES;
    
}

#pragma mark - Draw Avatar View Layers

-(void)drawAvatarView {
    
    for(CALayer *layer in self.layer.sublayers)
    {
        [layer removeFromSuperlayer];
    }
    
    [self.layer setMasksToBounds:NO];
    
    borderLayer = [CALayer layer];
    
    UIColor *bgColor = [UIColor colorWithRed:224.0f/255.0f
                                       green:224.0f/255.0f blue:224.0f/255.0f  alpha:1.0f];
    
    borderLayer.backgroundColor = bgColor.CGColor;
    
    borderLayer.contentsScale = [UIScreen mainScreen].scale;
    
    if (self.shadowEnable) {
        borderLayer.shadowColor = [UIColor blackColor].CGColor;
        borderLayer.shadowRadius = 5.f;
        borderLayer.shadowOffset = CGSizeMake(0.f, 5.f);
        borderLayer.shadowOpacity = 0.8f;
    }
    
    borderLayer.frame = CGRectMake(0, 0,
                                   self.layer.bounds.size.width,
                                   self.layer.bounds.size.height);
    
    borderLayer.borderColor = self.borderColor.CGColor;
    borderLayer.borderWidth = self.borderWidth;
    
    borderLayer.cornerRadius = roundf(borderLayer.frame.size.width / 2);
    
    [self.layer addSublayer:borderLayer];
    
    imageLayer = [CALayer layer];
    imageLayer.frame = borderLayer.bounds;
    imageLayer.contentsScale = [UIScreen mainScreen].scale;
    
    
    if (_image != nil) {
        imageLayer.contents = (id) _image.CGImage;
        imageLayer.cornerRadius =roundf(borderLayer.frame.size.width / 2);
        
        imageLayer.masksToBounds = YES;
        
        [borderLayer addSublayer:imageLayer];
    }
    /*else {
        
        UILabel *textLabel = [[UILabel alloc] initWithFrame:
                              CGRectMake(0, 0, self.frame.size.height, self.frame.size.width)];
        
        textLabel.text = @"add pic";
        textLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:(20.0)];
        textLabel.backgroundColor            = [UIColor clearColor];
        textLabel.textAlignment              = NSTextAlignmentCenter;
        textLabel.adjustsFontSizeToFitWidth  = YES;
        textLabel.baselineAdjustment         = UIBaselineAdjustmentAlignCenters;
        
        textLabel.font = [textLabel.font fontWithSize:(self.frame.size.width*0.15)];
        
        //[self addSubview:textLabel];
        //[sublayer addSublayer:textLabel.layer];
    }*/
    
}


#pragma mark - Instance Methods

-(id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if(self)
    {
        [self initProperties];
        [self drawAvatarView];
    }
    return self;
    
}

-(id) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if(self)
    {
        [self initProperties];
        [self drawAvatarView];
        
    }
    return self;
}

- (id) init {
    self = [super init];
    
    if(self)
    {
        [self initProperties];
        //[self drawAvatarView];
    }
    return self;
}

@end
