package
{
	import org.flixel.*;

	public class PlayState extends FlxState
	{
		//Tile Testing.
		[Embed(source = "../assets/sprites/EnemyTest.png")] private var ImgTech:Class
		
		//UTILITY CLASS
		public static var util:Utility = new Utility(0.1);
		
		//Data on player and enemies.
		public var player:Player;
		
		//Timer for Event purposes.
		public var timer:Number;
		private static var DELAY:Number = 0.5;
		
		//major game object storage
		protected var _blocks:FlxGroup;
		protected var _player:Player;
		protected var _enemies:FlxGroup;
		protected var _floor:FlxGroup;
		
		//meta groups, to help speed up collisions
		protected var _objects:FlxGroup;
		protected var _hazards:FlxGroup;
		
		//HUD
		protected var _hud:FlxGroup;
		protected var _enemyCount:FlxText;
		
		//music info object
		private var music:MusicAnalyzer;
		
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
			
			//Now that we have references to the bullets and metal bits,
			//we can create the player object.
			_player = new Player(316,300);

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
			
			//derp
			_enemyCount = new FlxText(FlxG.width/2, 500, 100, "DERP");
			_hud.add(_enemyCount);
			add(_enemyCount);

			//Then we add the player and set up the scrolling camera,
			//which will automatically set the boundaries of the world.
			add(_player);
			FlxG.camera.setBounds(0,0,640,640,true);
			FlxG.camera.follow(_player, FlxCamera.STYLE_PLATFORMER);
			
			//Finally we are going to sort things into a couple of helper groups.
			//We don't add these groups to the state, we just use them for collisions later!
			_hazards = new FlxGroup();
			_hazards.add(_enemies);
			_objects = new FlxGroup();
			//_objects.add(_enemies);
			_objects.add(_player);
			
			FlxG.flash(0xff131c1b);
			
			music.playSong();
		}

		override public function destroy():void
		{
			super.destroy();

			_blocks = null;
			_player = null;
			_enemies = null;

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
			
			//FlxG.overlap(_enemies, _player, overlapped);
			
			timer += FlxG.elapsed;
			
			if (music.returnBeats()[0] != 0 && timer >= DELAY) 
			{
				timer -= DELAY;
				for (var blks:int = 1; blks > 0; blks--)
				{
					var e:Enemy = _enemies.getFirstAvailable() as Enemy;
					if (e == null) {
						e = _enemies.recycle(Enemy) as Enemy;
					}
					e.reset(FlxG.width, util.nextRandom());
					//if (e == null) { return; }
					e.velocity.x = -100;
					e.y = 608-(500*util.nextRandom());
					add(e);
				}
				
				_enemyCount.text = ""+_enemies.length;
			}
		}

		//This is an overlap callback function, triggered by the calls to FlxU.overlap().
		protected function overlapped(Sprite1:FlxSprite,Sprite2:FlxSprite):void
		{
			FlxG.flash(0xff131c1b);
			//Sprite2.acceleration.x = -400;
		}
		
		//These next two functions look crazy, but all they're doing is generating
		//the level structure and placing the enemy spawners.
		protected function generateLevel():void
		{
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