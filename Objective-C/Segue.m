/** 
 * Segue
 *
 * When using Storyboards we can create custom transitions between views by using Segues. Below code 
 * shows the implementation of a segue. Transitions are created and triggered in the perform function 
 * when view controllers are pushed and popped in and out of the navigation controller.
 */

-(void)perform
{
  CATransition* transition = [CATransition animation];
  transition.duration = 0.3;
  transition.type = kCATransitionFade;
    
  UIViewController *src = [self sourceViewController];
    
  [src.view.layer addAnimation:transition forKey:kCATransition];
  src.view.layer.hidden = true;
    
  [self performSelector:@selector(fadeOutDone:) withObject:nil afterDelay:0.5f];
}

- (void)fadeOutDone:(id)vc
{
  CATransition* transition = [CATransition animation];
  transition.duration = 0.3;
  transition.type = kCATransitionFade;
    
  [[self.sourceViewController navigationController].view.layer addAnimation:transition forKey:kCATransition];

  [[self.sourceViewController navigationController] pushViewController:[self destinationViewController] animated:NO];
}
