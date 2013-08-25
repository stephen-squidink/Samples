/**
 * Green Atom Accelerometer
 *
 * This game uses the Accelerometer to control the movement of the character. The user simply tilts their device to 
 * navigate the character around the screen. I decided to add a acceleration and deceleration on the character based
 * on how fast the user tilts and moves their device. I simply record a number of points when the accelerometer has 
 * moved, and changed. I then work out the average speed from those points to finally give me the speed the character
 * should move on the X and Y axis.
 */

UIAccelerometer *accelerometer = [UIAccelerometer sharedAccelerometer];
accelerometer.updateInterval = 1.0/30.0;
accelerometer.delegate = self;

- (void) accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
  [currentScene accelerometer:[SPPoint pointWithX:acceleration.x y:acceleration.y]];
}

- (void) accelerometer:(SPPoint *)acceleration
{
  [super accelerometer:acceleration];
    
  [rawAccel removeObjectAtIndex:NUM_FILTER_POINTS - 1];
  [rawAccel insertObject: [SPPoint pointWithX:acceleration.x +
                          [UserDataManager getCalibration].x y:acceleration.y + [UserDataManager getCalibration].y] atIndex:0];
    
  acceleration = nil;
    
  accelX = 0.0;
  accelY = 0.0;
    
  for (SPPoint *raw in rawAccel)
  {
    accelX += [raw x];
    accelY += [raw y];
  }
    
  float num = ACCEL_FACTOR;
  num /= NUM_FILTER_POINTS;
    
  accelX *= num;
  accelY *= num;
}
