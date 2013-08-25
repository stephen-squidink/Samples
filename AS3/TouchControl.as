/**
 * Stargrasper Touch
 * 
 * The touch system in Stargrasper uses a system that allows the user to touch anywhere and control the ship. The ship 
 * only moves in the Y axis, so instead of having to touch the ship they just have to touch the screen. 
 * 
 * Using that initial point the user touched we can work out how far they moved from that point and then work out how to
 * move the ship.
 */ 

private function onTouch(event : TouchEvent):void 
{
  touches = event.getTouches(this);
	
  for each(var touch : Touch in touches) 
  {
    point = touch.getLocation(this);
		
    if(touch.phase == TouchPhase.BEGAN) 
    {
      if(!_isTouchDown && !currentTouch) 
      {
        currentTouch = touch;		
        _isTouchDown = true;
        _initialPoint = _currentPoint = point.y;
      }
    }
    else if(touch.phase == TouchPhase.MOVED) 
    {
      if(currentTouch)
      {
        if(currentTouch.id == touch.id) 
        {
          _currentPoint = point.y;
        }
      }
    }
    else if(touch.phase == TouchPhase.ENDED) 
    {
      if(currentTouch && currentTouch.id == touch.id) 
      {
        currentTouch = null;
        _isTouchDown = false;
      }
    }
  }
}

public function get difference():Number 
{
  return _initialPoint - _currentPoint;
}