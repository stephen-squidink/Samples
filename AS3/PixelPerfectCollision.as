/**
 * Pixel Perfect Collision
 * 
 * To make a game like Stargrasper with dynamic terrain and giving the terrain a lot of life, I needed to look into a collision detection
 * that can make this happen and look realistic. Pixel perfect collision detection was the best way to do this, but with the Starling framework
 * we don’t have access to the BitmapData to do a hit test. To solve this issue what I had to do was load the texture file in and store a copy
 * of the BitmapData in memory.
 */

_shipbmp = BitmapDataCacher.getBitmapDataByName("GAME", _asset.name);
_firstPoint = _asset.localToGlobal(new Point());
	
if(this.bounds.intersects(obj.bounds))
{
  _secondbmp = BitmapDataCacher.getFlippedBitmapData("GAME",obj.name);
  _secondPoint = obj.localToGlobal(new Point());
		
  _isHitTest = _shipbmp.hitTest(_firstPoint,255,_secondbmp,_secondPoint, 255);	
		
  if(_isHitTest)
  {
    setCollided(true);
  }
  else
  {
    setCollided(false);
  }
}

/**
 * To save performance we don’t always need to do the pixel check, we first check if the object collides with the objects rectangle bound first
 * then we can check the pixel hit test between them 2 objects.

 */