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
    
}

@synthesize delegate;

@synthesize borderWidth = _borderWidth;
@synthesize borderColor = _borderColor;
@synthesize shadowEnable = _shadowEnable;
@synthesize presentingViewController;


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
    
    if (self.showImagePikerOnTouch && self.presentingViewController) {
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"Selecione a foto de perfil"
                                      delegate:self
                                      cancelButtonTitle:@"Cancel"
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"Tirar foto",
                                      @"Escolher da galeria", nil];
        
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
        
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        UIViewController *topView = window.rootViewController;
        
        [actionSheet showInView:topView.view];
    }
    
}

-(void)drawAvatarView {
    
    
    for(CALayer *layer in self.layer.sublayers)
    {
        [layer removeFromSuperlayer];
    }
    
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
    //imageLayer.cornerRadius = 10.0;
    
    if (_image != nil) {
        imageLayer.contents = (id) _image.CGImage;
        imageLayer.cornerRadius =roundf(borderLayer.frame.size.width / 2);
        
        imageLayer.masksToBounds = YES;

        [borderLayer addSublayer:imageLayer];
    }
    else {
        
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
    }
}

-(UIImage *)image {
    return _image;
}

- (void)setImage:(UIImage *)image {
    
    _image = image;
    
    [super setImage:nil];
    
    //imageLayer.contents = (id) image.CGImage;
    
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
    //NSLog(@"aqui %f", borderWidth);
    _borderWidth = borderWidth;
    borderLayer.borderWidth = borderWidth;
}

-(void)setBorderColor:(UIColor *)borderColor {
    
    _borderColor = borderColor;
    borderLayer.borderColor = [_borderColor CGColor];
}

-(void)initProperties {
    
    self.borderColor = [UIColor whiteColor];
    self.borderWidth = self.frame.size.width*0.05;
    self.showImagePikerOnTouch = YES;
    self.shadowEnable = YES;
    self.userInteractionEnabled = YES;
    
    //[actionSheet showInView:self];
    
}

-(id)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage {
    
    self = [super initWithImage:image highlightedImage:highlightedImage];
    
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

-(id) initWithImage:(UIImage *)image {
    self = [super initWithImage:image];
    
    if(self)
    {
        self.image = [super image];
        [self initProperties];
        [self drawAvatarView];
    }
    return self;
}

-(id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if(self)
    {
        self.image = [super image];
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
        [self drawAvatarView];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    borderLayer.contentsScale = [UIScreen mainScreen].scale;
    imageLayer.contentsScale = [UIScreen mainScreen].scale;
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    int i = buttonIndex;
    switch(i)
    {
        case 0:
        {
            UIImagePickerController * picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            
            [presentingViewController presentViewController:picker animated:YES completion:^{}];
        }
            break;
        case 1:
        {
            UIImagePickerController * picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            [presentingViewController presentViewController:picker animated:YES completion:^{}];
        }
        default:
            // Do Nothing.........
            break;
    }
}

- (UIImage *)scaleAndRotateImage:(UIImage *)image {
    int kMaxResolution = 1280; // Or whatever
    
    CGImageRef imgRef = image.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = roundf(bounds.size.width / ratio);
        }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = roundf(bounds.size.height * ratio);
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = image.imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}



#pragma - mark Selecting Image from Camera and Library

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // Picking Image from Camera/ Library
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image;
    
    image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    if (!image) {
        return;
    }

    UIImage *newImage = [self scaleAndRotateImage:image];
    self.image = newImage;

    // Saving Camera/ Library image to Document Directory
    
    //Calling on avatarViewOnImagePickedAction delegate
    if (self.delegate != nil &&
        [self.delegate respondsToSelector:@selector(avatarViewOnImagePickedAction:)]) {
        
        [self.delegate avatarViewOnImagePickedAction:self];
    }
    
}


@end
