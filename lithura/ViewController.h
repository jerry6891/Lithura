//
//  ViewController.h
//  lithura
//
//  Created by [T.T.S.D.] on 2018-01-28.
//  Copyright © 2018 GWEB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>

@interface ViewController : UIViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    IBOutlet UIView *frameforcapture;
    IBOutlet UIImageView *imageView;
    IBOutlet UIVisualEffectView *blurView;
    
    IBOutlet UIVisualEffectView *blurSaveImage;
    IBOutlet UIImageView *imageViewTwo;
    UIImagePickerController *picker;
    UIImage *image;
}
@property (weak, nonatomic) IBOutlet UIImageView *myimageview;
- (IBAction)save:(id)sender;
- (IBAction)takephoto:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *lithurize;
- (IBAction)logotype:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *saVe;
- (IBAction)PhotoLibrary:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *saVeTwo;
- (IBAction)saveImmage:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *uploadPicture;
- (IBAction)lith:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imgVwBlack;
@property (weak, nonatomic) IBOutlet UIImageView *imgVwDark;
- (IBAction)loth:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *lothurize;

@end

