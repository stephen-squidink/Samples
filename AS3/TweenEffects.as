/**
 * Starling Tween Effects
 * 
 * Starling uses a similar tween structure to TweenMax. When creating a flashing text effect for Hackdoken, we wanted an effect
 * that gave the game life and made text and messages stand out. We initially had a sequence of images, but it ended up using a
 * lot of memory, so decided to use the tween engine to build a similar effect.
 * 
 * The code snippet shows the Ready and the Fight text effect. I initiate the properties that are being affected, so we stretch
 * the text so it’s double the size and set the alpha to 0. I scale the Ready text down and fade it in. The Ready displays for 
 * 0.75 seconds and then fades out so the Fight text can scale down and fade in. Yet again the Fight text displays for 0.75 
 * seconds and fades out.
 */

_readyImage.alpha = 0;
_readyImage.scaleX = _readyImage.scaleY = 2;
_fightImage.alpha = 0;
_fightImage.scaleX = _fightImage.scaleY = 2

Starling.juggler.tween(_readyImage, 0.1, {alpha:1, transition: Transitions.EASE_OUT, scaleX: 1, scaleY: 1, 
  onComplete:function():void
  {
    Starling.juggler.delayCall(function():void
    {
      AssetEmbeds_2x.ASSETS.playSound("fight", 0,0, new SoundTransform(5));
			
      Starling.juggler.tween(_readyImage, 0.1, {alpha:0, transition: Transitions.EASE_OUT, scaleX: 2, scaleY: 2});
      Starling.juggler.tween(_fightImage, 0.1, {alpha:1, transition: Transitions.EASE_OUT, scaleX: 1, scaleY: 1, 
        onComplete:function():void
        {			
          Starling.juggler.delayCall(function():void
	  {
            Starling.juggler.tween(_fightImage, 0.1, {alpha:0, transition: Transitions.EASE_OUT, scaleX: 2, scaleY: 2});
          
	    _gameState = GameStates.FIGHT;
          }, 0.75);
        }
      });
    }, 0.75);
  }
});
