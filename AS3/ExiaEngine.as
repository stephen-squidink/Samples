/**
 * Exia Engine Structure
 * 
 * I developed the Exia engine to help me construct games very quickly in Flash and the Starling Framework. I went for 
 * a standard structure using GameObjects and GameScenes.
 * 
 * The GameScene manages all the game objects created for that specific scene. It will automatically destroy and dispose
 * the game objects when they are no longer needed.
 */

for (var i : int = _objectPool.length - 1; i >= 0; i--) 
{
  GameObject(_objectPool[i]).update();

  if(GameObject(_objectPool[i]).isDestroy) 
  {
    destroyGameObject(i);
  }
}

/**
 * We also check the collision in the GameScene class. It only checks GameObjects that have the collision feature; if 
 * the GameObject does not implement the IHasCollision it does not do the check for that GameObject.
 */
	
for( var i : int = objectPool.length - 1; i >= 0; i--) 
{
  if(objectPool[i] is IHasCollision) 
  {
    for( var j : int = objectPool.length - 1; j >= 0; j--)
    {
      if(objectPool[j] is IHasCollision)
      {
        IHasCollision(objectPool[j]).onCollision(objectPool[i]);
        IHasCollision(objectPool[i]).onCollision(objectPool[j])	
      }
    }
  }
}
