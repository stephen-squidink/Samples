/**
 * Nadleeh Ship & Bullets
 *
 * This code snippet shows how to make a ship move smoothly with acceleration and deceleration when the user 
 * holds down the forward key. It works out the rotation of the ship and moves towards that direction. 
 */

if (_buttons[1].key) 
{
	_player.rotation -= deg2rad(_rotationSpeed);
}

if (_buttons[2].key) 
{
  _player.rotation += deg2rad(_rotationSpeed);
}

if(_buttons[0].key)
{
  _speedX += _thrust * Math.sin(rad2deg(_player.rotation) * (Math.PI / 180));
  _speedY += _thrust * Math.cos(rad2deg(_player.rotation) * (Math.PI / 180));
}
else
{
  _speedX *= _decay;
  _speedY *= _decay;
}

_currentSpeed = Math.sqrt((_speedX * _speedX) + (_speedY * _speedY));

if (_currentSpeed > _maxSpeed) 
{
  _speedX *= _maxSpeed/_currentSpeed;
  _speedY *= _maxSpeed/_currentSpeed;
}

_player.y -= _speedY;
_player.x += _speedX;

/**
 * The bullets move in the direction of the ship and when the bullet was initially created. It checks all 
 * the bullets on the screens and moves them in the right direction. If the bullets go out of bounds of 
 * the view, the bullets are removed.
 */

for (var b : int = _bullets.length - 1; b >=0;b--)
{
  _bullets[b].x += 15 * Math.sin(rad2deg(_bullets[b].rotation) * (Math.PI / 180));
  _bullets[b].y -= 15 * Math.cos(rad2deg(_bullets[b].rotation) * (Math.PI / 180));
	
  if(_bullets[b].x - _bullets[b].pivotX < 0 || _bullets[b].x + _bullets[b].pivotX > stage.stageWidth || 
     _bullets[b].y - _bullets[b].pivotY < 0 || _bullets[b].y + _bullets[b].pivotY > stage.stageHeight)
  {
    removeBullet(_bullets[b]);
  }
}
