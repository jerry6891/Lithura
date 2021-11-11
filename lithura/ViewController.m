//
//  ViewController.m
//  lithura
//
//  Created by [T.T.S.D.] on 2018-01-28.
//  Copyright © 2018 GWEB. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

@implementation ViewController
@synthesize myimageview;
@synthesize imgVwBlack;
@synthesize imgVwDark;

AVCaptureSession *session;
AVCaptureStillImageOutput *StillImageOutput;

- (void)viewDidLoad {
    [super viewDidLoad];
    // [myimageview initWithImage:[UIImage imageNamed:imageView]];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Lithurize Button Strokes
    [self.lithurize.layer setBorderWidth:6.0];
    [self.lithurize.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    
    // Lothurize Button Strokes
    [self.lothurize.layer setBorderWidth:6.0];
    [self.lothurize.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    
    // Upload Picture Button Strokes
    [self.uploadPicture.layer setBorderWidth:6.0];
    [self.uploadPicture.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    
    // Save Button Strokes
    [self.saVe.layer setBorderWidth:6.0];
    [self.saVe.layer setBorderColor:[[UIColor whiteColor] CGColor]];
}

-(UIImage*)balackImage:(UIImage*)image{
    CIImage* ciImage = [[CIImage alloc]initWithImage:image];
    CIImage* imgBlack = [ciImage imageByApplyingFilter:@"CIColorControls" withInputParameters:@{kCIInputSaturationKey : @0.0}];
    return [UIImage imageWithCIImage:imgBlack];
}

-(UIImage *)convertToBlurImage:(UIImage *)image{
    CIFilter *gaussianBlurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [gaussianBlurFilter setDefaults];
    CIImage *inputImage = [CIImage imageWithCGImage:[image CGImage]];
    [gaussianBlurFilter setValue:inputImage forKey:kCIInputImageKey];
    [gaussianBlurFilter setValue:@75 forKey:kCIInputRadiusKey];
    CIImage *outputImage = [gaussianBlurFilter outputImage];
    CIContext *context   = [CIContext contextWithOptions:nil];
    CGImageRef cgimg     = [context createCGImage:outputImage fromRect:[inputImage extent]];  // note, use input image extent if you want it the same size, the output image extent is larger
    UIImage *convertedImage = [UIImage imageWithCGImage:cgimg];
    return convertedImage;
}

/*- (IBAction)save:(id)sender{
    UIImageWriteToSavedPhotosAlbum(myimageview.image, self, nil, nil);
    NSLog(@"Image Saved!");
}*/

-(void)viewWillAppear:(BOOL)animated{
    session = [[AVCaptureSession alloc] init];
    [session setSessionPreset:AVCaptureSessionPresetPhoto];
    
    AVCaptureDevice *inputDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error;
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:inputDevice error:&error];
    
    if ([session canAddInput:deviceInput]){
        [session addInput:deviceInput];
    }
    
    AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    [previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    CALayer *rootLayer = [[self view] layer];
    [rootLayer setMasksToBounds:YES];
    CGRect frame = frameforcapture.frame;
    
    [previewLayer setFrame:frame];
    [rootLayer insertSublayer:previewLayer atIndex:0];
    
    StillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecTypeJPEG, AVVideoCodecKey, nil];
    [StillImageOutput setOutputSettings:outputSettings];
    
    [session addOutput:StillImageOutput];
    [session startRunning];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)takephoto:(id)sender {
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in StillImageOutput.connections) {
        for (AVCaptureInputPort *port in [connection inputPorts]) {
            if([[port mediaType] isEqual: AVMediaTypeVideo]){
                videoConnection = connection;
                break;
            }
        }
    }
    [StillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef  _Nullable imageDataSampleBuffer, NSError * _Nullable error) {
        if (imageDataSampleBuffer != NULL) {
            NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
            UIImage *image = [UIImage imageWithData:imageData];
            imageView.image = image;
        }
    }];
}

-(IBAction)lithurize:(id)sender{
    /* [self.lithurize.layer setBorderWidth:3.0];
    [self.lithurize.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    float blurRadius = 15.0f;
    UIImage *newBlurredImage = [[UIImage imageWithData:imageView.image] blurredImageWithRadius:blurRadius]; */
}

-(IBAction)lothurize:(id)sender{
    /* [self.lithurize.layer setBorderWidth:3.0];
     [self.lithurize.layer setBorderColor:[[UIColor whiteColor] CGColor]];
     float blurRadius = 15.0f;
     UIImage *newBlurredImage = [[UIImage imageWithData:imageView.image] blurredImageWithRadius:blurRadius]; */
}

-(IBAction)save:(id)sender{
    UIImage *imageToBeSaved = imgVwBlack.image;
    UIImageWriteToSavedPhotosAlbum(imageToBeSaved, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo{
    if (!error) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"SUCCESS!" message:@"The Picture Was Saved Successfully To Your Library!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)logotype:(id)sender {
    /* [UIView transitionWithView:containerView
                      duration:0.2
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{ [fromView removeFromSuperview]; [containerView addSubview:toView]; }
                    completion:NULL]; */
}

- (IBAction)PhotoLibrary:(id)sender {
    picker = [[UIImagePickerController alloc] init];
     picker.delegate = self;
     [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
     [self presentViewController:picker animated:YES completion:NULL];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [imageViewTwo setImage:image];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)saveImmage:(id)sender {
    UIImage *imageToBeSaved = imgVwDark.image;
    UIImageWriteToSavedPhotosAlbum(imageToBeSaved, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (IBAction)uploadPicture:(id)sender {
}

- (void)blurSaveImage:(UIVisualEffectView *)blurSaveImage didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo{
    if (!error) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"SUCCESS!" message:@"The Picture Was Saved Successfully To Your Library!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

+ (UIImage *) imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (IBAction)lith:(id)sender {
    // UIImage *newBlurredImage = [[UIImage imageWithData:imageView.image] blurredImage];
    imgVwBlack.image = [self convertToBlurImage:myimageview.image];
}

- (IBAction)loth:(id)sender {
    imgVwDark.image = [self convertToBlurImage:imageViewTwo.image];
}
@end
