package
{
	import org.flixel.*;

	public class PlayState extends FlxState
	{
		//Tile Testing.
		[Embed(source = "../assets/sprites/EnemyTest1.png")] private var ImgTech:Class
		
		//Arrow Hit Box.
		[Embed(source = "../assets/sprites/arrowbox1.png")] private var ImgArrowHitBox:Class
		
		//UTILITY CLASS
		public static var util:Utility = new Utility(0.1);
		
		//Data on player and enemies.
		private static var PLAYER_X:int = 150;
		
		//Timer for Event purposes.
		public var timer:Number;
		//platforms will appear every 0.75 seconds; we can randomize this
		private static var PLATFORM_SPACING:Number = 0.85; 
		private static var ARROW_SPACING:Number = 0.5;
		private static var DELAY:Number = 0.5;
		
		//arrow data fields
		private var prevArrowKey:int = 0;
		
		//major game object storage
		protected var _blocks:FlxGroup;
		protected var _player:Player;
		protected var _enemies:FlxGroup;
		protected var _floor:FlxGroup;
		protected var _arrows:FlxGroup;
		protected var _arrowHitBox:FlxSprite;
		protected var _arrowFailBox:FlxSprite;
		
		//meta groups, to help speed up collisions
		protected var _objects:FlxGroup;
		protected var _hazards:FlxGroup;
		
		//cameras
		var playCam:FlxCamera;
		var arrowCam:FlxCamera;
		
		//HUD
		protected var _hud:FlxGroup;
		protected var _enemyCount:FlxText;
		//optional scoring text field
		private var _scorefield:FlxText;
		protected static var ARROW_BASE_SCORE = 50;
		private var score:Number;
		private var _arrowstreakfield:FlxText;
		private var arrowStreak:uint;
		
		//music info object
		private var music:MusicAnalyzer;
		private var arrowSpawnTime:Number;
		private var platformSpawnTime:Number;
		private var prevY:Number=550;
		
		public function PlayState(myMusic:MusicAnalyzer) {
			music = myMusic;
		}
		
		override public function create():void
		{
			FlxG.bgColor = 0xFF0044DD;
			
			timer = 0.0;
			
			FlxG.mouse.hide();
			
			//Then we'll set up the rest of our object groups or pools
			_floor = new FlxGroup();
			_blocks = new FlxGroup();
			_enemies = new FlxGroup();
			_hud = new FlxGroup();
			_arrows = new FlxGroup();
			
			//Now that we have references to the bullets and metal bits,
			//we can create the player object.
			_player = new Player(PLAYER_X,300);

			//HUD
			_hud = new FlxGroup();
			
			//This refers to a custom function down at the bottom of the file
			//that creates all our level geometry with a total size of 640x480.
			//This in turn calls buildRoom() a bunch of times, which in turn
			//is responsible for adding the spawners and spawn-cameras.
			generateLevel();

			//Add bots and spawners after we add blocks to the state,
			//so that they're drawn on top of the level, and so that
			//the bots are drawn on top of both the blocks + the spawners.
			add(_floor);
			add(_blocks);
			add(_enemies);
			add(_hud);
			add(_arrows);
			
			////derp!
			_enemyCount = new FlxText(FlxG.width/2, 500, 100, "DERP");
			_hud.add(_enemyCount);
			add(_enemyCount);
			score = 0;
			arrowStreak = 0;
			_scorefield = new FlxText(_arrowHitBox.x+(_arrowHitBox.width)+10, 685, 480, "SCORE: " + score, true);
			_scorefield.setFormat(null, 8, 0xFFFFFF, "left", 0x0000FF);
			add(_scorefield);
			_arrowstreakfield = new FlxText(_scorefield.x, _scorefield.y-40, 480, "STREAK: " + arrowStreak, true);
			_arrowstreakfield.setFormat(null, 8, 0xFFFFFF, "left", 0x0000FF);
			add(_arrowstreakfield);

			//Then we add the player and set up the scrolling camera,
			//which will automatically set the boundaries of the world.
			add(_player);
			
			
			var camBreak:int = 420;
			playCam = new FlxCamera(0, 0, 640, camBreak);
			playCam.setBounds(0, 0, 640, 640, true);
			playCam.follow(_player, FlxCamera.STYLE_PLATFORMER);
			FlxG.addCamera(playCam);
			
			
			arrowCam = new FlxCamera(0, camBreak, 640, 640);
			arrowCam.setBounds(0, 640, 640, 640); // change 600 to 640 once arrows are added!   
			FlxG.addCamera(arrowCam);
			
			//Finally we are going to sort things into a couple of helper groups.
			//We don't add these groups to the state, we just use them for collisions later!
			_hazards = new FlxGroup();
			_hazards.add(_enemies);
			_objects = new FlxGroup();
			//_objects.add(_enemies);
			_objects.add(_player);
			
			FlxG.flash(0xff131c1b);
			
			platformSpawnTime = 0;
			arrowSpawnTime = 0;
			
			FlxG.worldBounds = new FlxRect(-100, 0, 700, 700);
			
			music.playSong();
		}

		override public function destroy():void
		{
			super.destroy();

			_blocks = null;
			_player = null;
			_enemies = null;
			_arrows = null;

			//meta groups, to help speed up collisions
			_objects = null;
			_hazards = null;
		}

		override public function update():void
		{
			//update the game state
			super.update();

			//collisions with environment
			FlxG.collide(_blocks, _player);
			//FlxG.collide(_enemies, _floor);
			FlxG.collide(_enemies,_player);
			//FlxG.collide(_enemies, _enemies);
			
			if (FlxG.keys.justPressed("LEFT")) {
				prevArrowKey = Arrow.ARROW_LEFT;
				FlxG.overlap(_arrowHitBox, _arrows, overlapped);
			}
			if (FlxG.keys.justPressed("UP")) {
				prevArrowKey = Arrow.ARROW_UP;
				FlxG.overlap(_arrowHitBox, _arrows, overlapped);
			}
			if (FlxG.keys.justPressed("RIGHT")) {
				prevArrowKey = Arrow.ARROW_RIGHT;
				FlxG.overlap(_arrowHitBox, _arrows, overlapped);
			}
			if (FlxG.keys.justPressed("DOWN")) {
				prevArrowKey = Arrow.ARROW_DOWN;
				FlxG.overlap(_arrowHitBox, _arrows, overlapped);
			}
			
			FlxG.overlap(_arrowFailBox, _arrows, arrowFailFunc);
			
			if (score < 0)
			{
				score = 0;
			}
			
			_scorefield.text = "SCORE: " + score;
			_arrowstreakfield.text = "STREAK: " + arrowStreak;
			
			timer += FlxG.elapsed;
			if (music.returnBeats()[0] != 0 && timer >= DELAY && (timer-arrowSpawnTime) >= ARROW_SPACING) 
			{
				//timer -= MUSIC_DELAY;
				for (var blks:int = 1; blks > 0; blks--)
				{
					var a:Arrow = _arrows.getFirstAvailable() as Arrow;
					if (a == null) {
						a = _arrows.recycle(Arrow) as Arrow;
					}
					a.newArrow(640, 650, util.nextRandom());
					a.setProcessed(false);
				}
				a.velocity.x = -100;
				arrowSpawnTime = timer;
				add(a);
			}
			if ((timer >= DELAY) && ((timer-platformSpawnTime) >= PLATFORM_SPACING)) {
				var e:Enemy = _enemies.getFirstAvailable() as Enemy;
				if (e == null) {
					e = _enemies.recycle(Enemy) as Enemy;
				}
				e.reset(FlxG.width, util.nextRandom());
				//if (e == null) { return; }
				e.velocity.x = -100;
				var dir:int = ((int)(util.nextRandom() * 2));
				if (dir == 0) {
					dir--;
				}
				
				//var newY:Number = _player.getY() + (dir)(20 * util.nextRandom());
				var newY:Number = prevY + (dir * (50 * util.nextRandom()));
				if (newY <= 64) { 
					e.y = 32;
				}
				else if (newY >= (640 - 58)) { 
					e.y = 640 - 58;
				}
				else {
					e.y = newY;
				} 
				prevY = e.y;
				platformSpawnTime = timer;
				add(e);
			}
			
			_player.x = PLAYER_X; //- if we want to immobilize the player
		}
		
		//only called by overlapped, given the overlapping arrow
		protected function checkArrow(arrow:Arrow):void
		{
			if (arrow.isProcessed()) {
				return;
			}
			arrow.setProcessed(true);
			var dir:int = arrow.getDirection();
			if(dir == prevArrowKey) {
				arrow.kill();
				arrowStreak += 1;
				var dist:Number = (_arrowHitBox.width/2)-FlxU.abs(_arrowHitBox.x - arrow.x);
				var scoreDiff:Number = ARROW_BASE_SCORE * (dist / (_arrowHitBox.width / 2));
				score += FlxU.round(arrowStreak*scoreDiff) + 1;
				_enemyCount.text = "SUCCESS: DIFF = " + dist;
			}
			else {
				score -= ARROW_BASE_SCORE;
				resetArrowStreak();
			}
		}

		//This is an overlap callback function, triggered by the calls to FlxG.overlap().
		protected function overlapped(Sprite1:FlxSprite, Sprite2:FlxSprite)
		{
			//prevArrowKey set in update function!
			checkArrow((Arrow)(Sprite2));
		}
		
		//did not hit the arrow, do this
		protected function arrowFailFunc(Sprite1:FlxSprite, Sprite2:FlxSprite)
		{
			Sprite2.kill();
			score -= ARROW_BASE_SCORE;
			resetArrowStreak();
		}
		
		protected function resetArrowStreak():void
		{
			if(arrowStreak != 0) {
				arrowCam.flash(0x111111, 0.5);
			}
			arrowStreak = 0;
		}
		
		//These next two functions look crazy, but all they're doing is generating
		//the level structure and placing the enemy spawners.
		protected function generateLevel():void
		{
			_arrowHitBox = new FlxSprite(20, 640, ImgArrowHitBox);
			add(_arrowHitBox);
			_arrowFailBox = new FlxSprite( -50, _arrowHitBox.y);
			
			var r:uint = 160;
			var b:FlxTileblock;

			//First, we create the walls, ceiling and floors:
			b = new FlxTileblock(0, 0, 640, 16);
			b.loadTiles(ImgTech);
			_blocks.add(b);
			
			b = new FlxTileblock(0, 16, 16, 640 - 16);
			b.loadTiles(ImgTech);
			_blocks.add(b);

			b = new FlxTileblock(640-16,16,16,640-16);
			b.loadTiles(ImgTech);
			_blocks.add(b);
			
			b = new FlxTileblock(0,640-16,640,16);
			b.loadTiles(ImgTech);
			_blocks.add(b);
			_floor.add(b);
			
			//Then we split the game world up into a 4x4 grid,
			//and generate some blocks in each area.  Some grid spaces
			//also get a spawner!
			//buildRoom();
		}

		//Just plops down a spawner and some blocks - haphazard and crappy atm but functional!
		protected function buildRoom():void
		{
			//then place a bunch of blocks
			var b:FlxTileblock;
			b = new FlxTileblock(0,0,FlxG.width,8);
			b.loadTiles(ImgTech);
			_blocks.add(b);
		}
	}
}