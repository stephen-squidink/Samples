/**
 * Image Effects
 * 
 * I created an app that allows you to take pictures and draw on the picture. I wanted to add some
 * image effects like saturation. The code sample shows how this was done with filters using the 
 * core image data.
 */

-(void) applyEffect
{
  CIImage *inputImage = [[CIImage alloc] initWithCGImage:[originalImage CGImage]];
    
  CIFilter* filter = [CIFilter filterWithName:@"CIColorControls"];
  [filter setValue:inputImage forKey:@"inputImage"];
  [filter setValue:[NSNumber numberWithFloat:(2 * saturationValue)] forKey:@"inputSaturation"];
    
  CIImage *outputImage = [filter valueForKey:@"outputImage"];
  CIContext* context = [CIContext contextWithOptions:nil];
  CGImageRef imgRef = [context createCGImage:outputImage fromRect:outputImage.extent];
  UIImage* img = [[UIImage alloc] initWithCGImage:imgRef];
  CGImageRelease(imgRef);
    
  drawingImage = [img stackBlur:(10 * blurValue)];
    
  [self setDrawingImage:drawingImage];
}
