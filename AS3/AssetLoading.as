/**
 * Asset Loading
 * 
 * Mobile game development requires a lot of memory management, but with the top end devices that have 1gb of memory, they
 * can now manage a lot of assets and data in memory. With devices like the iPhone 4 & 4S that only have 512mb of memory, 
 * assets need to be managed.  The code snippet shows how I use the AssetManager to queue up assets to load, so I load the 
 * generic assets that are used globally in the game, and then we load the other assets for the scenes. I check if the game 
 * is running on an iPhone4 or not, if it is then I don’t queue the game assets and only load the menu assets, I load the 
 * game assets when they are needed.
 */

GENERAL_ASSET = new AssetManager(1);
GENERAL_ASSET.enqueue(GeneralAssets);
GENERAL_ASSET.loadQueue(function(ratio:Number):void 
{
  generalRatio = (ratio/2);
  _currentRatio = _assetRatio + _generalRatio;
  
  dispatcher.dispatchEventWith(Event.CHANGE,false,_currentRatio);
	
  if (ratio == 1.0)
  {
    loadAssets();
  }
});

function loadAssets():void 
{
  ASSETS = new AssetManager(1);
  ASSETS.enqueue(MenuAssets);			

  if(!Game.instance.isIphone4)
  {
    ASSETS.enqueue(GameAssets);	
  }

  ASSETS.loadQueue(function(ratio:Number):void 
  {
    _assetRatio = ratio/2;
    _currentRatio = _assetRatio + _generalRatio;
		
    dispatcher.dispatchEventWith(Event.CHANGE,false,_currentRatio);
		
    if (_currentRatio == 1.0)
    {
      dispatcher.dispatchEventWith(Event.COMPLETE);
    }
  });
}