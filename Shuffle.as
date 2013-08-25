/** 
 * The Shuffle Puzzle
 * 
 * Introduction
 * 
 * One of the projects we developed was a Shuffle Puzzle game using the CandiTV Platform (http://live.canditv.com/shuffle/audi.html). 
 * The game was built using Flash CS4 and used a lot of the timeline system in the IDE. As an experiment I decided to try and develop 
 * a shuffle puzzle game for the BlackBerry Playbook. 
 * 
 * I decided that I wasn’t going to use the QNX Framework or the Flex Framework and build it with pure AS3. This gives me the opportunity 
 * to port it for iOS, Android, Desktop and Web Browsers very easily from the BlackBerry Playbook, so there isn’t any dependant libraries
 * needed for specific OS’s and there can be one source base for multiple platforms. 
 * 
 * Well I thought I may have been able to use some of the code and work from the Game using the CandiTV Platform version, but this wasn’t 
 * so simple due to dependent classes, framework and the timeline. Therefore I had to rewrite a new version built using pure AS3 in Flash
 * Builder.
 * 
 * Code & Algoritms
 * 
 * I decided to use the Bitmap as its base class for a few reasons:
 * 
 *  - this allowed easy porting to different IDE’s
 * 	- can easily be used between different type of Flash applications
 * 	- can easily add to the Flash Stage and DisplayList
 * 	- can also take image data and store it in the bitmap, which can then be sliced into different pieces and rendered into the DisplayList
*/

public function ShuffleBitmap(	bitmapData:BitmapData=null, pixelSnapping:String="auto", smoothing:Boolean=false)

/**
 * Once the object is constructed the system just has to shuffle the image and this goes through a few processes. It needs to work out the 
 * size of each tile depending on the rowCount and columnCount passed into the function. Then it needs to slice the bitmap using these values. 
 * 
 * The algorithm creates a tile as it iterates through the column and row counts. It uses the bitmapdata stored in the Bitmap object to 
 * gather the pixels within the current sector of the tile and stores the tile data into a sprite. Each of the tiles are then stored into 
 * a global array.
*/

private function sliceBitmap():void
{
  var count : int = 0;
				
  for (var row : int = 0; row < _rowCount; row++)
  {
    for(var column : int = 0; column < _columnCount; column++)
    {
			if(_tiles.length < (_columnCount * _rowCount) - 1)
			{
				var tile : Sprite = new Sprite();
				tile.addEventListener(MouseEvent.CLICK, onTileClick);
							
				var bmp : Bitmap = new Bitmap(new BitmapData(Number(_tileWidth), Number(_tileHeight ), false)); 
				bmp.bitmapData.copyPixels( bitmapData, 
							   new Rectangle(column * _tileWidth, row * _tileHeight,  _tileWidth, _tileHeight), 
							   new Point(0,0));
							
				tile.addChild(bmp);
							
				_tiles.push({index: count, tile: tile});
			}
			else
			{
				_tiles.push({index: count, space:true});
			}
						
			count++
		}
	}
}

/**
 * The array of the tiles then needs to be shuffled using a simple random sort algorithm.
 */

private function randomArraySort(_array:Array) : Array 
{
	var _length:Number = _array.length;
	var mixed:Array = _array.slice();
	var rn:Number;
	var el:Object;
			
	for (var i : Number = 0; i < _length; i++) 
	{
		el = mixed[i];
		rn = Math.floor(Math.random() * _length);
		mixed[i] = mixed[rn];
		mixed[rn] = el;
	}
			
	return mixed;
}

/**
 * Once this is all done it is simple just adding and rendering each of the tiles into the display list. 
 * 
 * When a tile is clicked on, the tile must check and decide if it can move up, down, left or right depending if there is a space tile next to it.  
 */

private function checkDirection(obj : Object, index : int):String
{
	if(obj.tile.x - obj.tile.width + 0.5 > -0.5)
	{
		if(index - 1 >= 0)
		{
			if(_shuffledTiles[index - 1].space)
				return LEFT;
		}
	}
			
	if((obj.tile.x + obj.tile.width - 0.5) + (_tileWidth + 0.5) < this.width + 0.5)
	{
		if(index + 1 < _shuffledTiles.length)
		{
			if(_shuffledTiles[index + 1].space)
				return RIGHT;
		}
	}
			
	if(obj.tile.y - obj.tile.height + 0.5 > -0.5)
	{
		if(index - _rowCount >= 0)
		{
			if(_shuffledTiles[index - _rowCount].space)
				return UP;
		}		
	}
			
	if((obj.tile.y + obj.tile.height - 0.5) + (_tileHeight + 0.5) < this.height + 0.5)
	{
		if(index + _rowCount < _shuffledTiles.length)
		{
			if(_shuffledTiles[index + _rowCount].space)
				return DOWN;
		}
	}
			
	return NULL;
}

/**
 * If the tile can move, I currently use the Caurina AS3 tweening library to move and slide the tiles into the space area. 
 */

case UP:
	Tweener.addTween(piece.tile,{y: piece.tile.y - _tileHeight, time:0.25, onComplete:onPieceMoved});

/**
 * I then finally check if the shuffle has completed or not, by ensuring the indexes stored in the array are in the correct order.
 */ 
				
private function checkCompletion():Boolean
{
	for(var i : int = 0; i < _shuffledTiles.length;i++)
	{
		if(_shuffledTiles[i].index != i)
			return false
	}
					
	return true;
}
				
/** 
 * Improvements
 * 
 * There is always something to improve when developing algorithms and processes, speed and performances is always a good feature to improve,
 * as the algorithm to randomly sort an array can be written in many ways and each way can process at different rates. 
 * 
 * One of the major improvements is to remove the need of the Caurina library. As I stated, I wanted this to be a class and component to be
 * added to a DisplayList in Flash, without the dependencies of Flex components, Flash Timeline, QNX framework etc, but this class currently
 * depends on the Caurina library, so if I was to port this class to another project I will need to add the Caurina library to the project too.
 * 
 * To do this, I will probably have to write my own tweening and animation algorithms to move the tiles in the component. Maybe eventually
 * write my own tween engine that can be used across different applications.
 * 
 * Overall this class can now be treated as a component and can easily be added to a Flash Application; either it’s a mobile application for
 * the BlackBerry Playbook, iPad, iPhone or any Android device, but also desktop AIR applications and applications in the web browser.					
 */ 
