package  {
	
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Vector3D;
	import flash.utils.getTimer;
	
	
	public class HydraMain extends MovieClip implements IListener {
		public var enemies:MovieClip;
		public var shots:MovieClip;
		public var _bg:DisplayObject;
		private var _hydras:Array = [];
		private var _lastFrame:int = 0;
		private var _bgModifier:Number;
		public var _ship:Ship;
		private var _shots:Array;
		private var _enemyShots:Array;
		public var gui:GUI;
		
		private var _spawnAmount:Number = 1;
		private var _extraHeadsCount:Number = 0;
		private var _timeMod:Number = 0;
		private var _gameOver:Boolean;
		
		public function HydraMain() {
			// constructor code
			trace("ctor!");
			ContentAsserter.assertContent(this, "enemies", "_ship");
			_shots = [];
			_enemyShots = [];
			
			createHydra();
			_bg.cacheAsBitmap = true;
			//_bg.scrollRect = new Rectangle(0, 0, 1280, 720);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			_bgModifier = 1.0;
			Messages.listen(this);
		}
		
		/* INTERFACE IListener */
		
		public function onMessage(o:Object):void {
			trace("function HydraMain.onMessage()");
			trace("\to=" + o);
			if (o is Shot) {
				var shot:Shot = o as Shot;
				trace("shot=" + shot);
				removeShot(shot);
			}
			else if (o is Enemy) {
				var hydra:Enemy = o as Enemy;
				trace("hydra=" + hydra);
				removeHydra(hydra);
				GUI.hydraKills += 1;
				if (_hydras.length == 0) {
					GUI.round += 1;
					_timeMod = Math.floor(GUI.hydraKills / 8);
					_spawnAmount = Math.floor((GUI.hydraKills / 3) + 1);
					_extraHeadsCount = Math.floor((GUI.hydraKills / 7) + 1);
					var maxExtraHeads:Number = 30;
					if (_spawnAmount * _extraHeadsCount > maxExtraHeads) {
						_extraHeadsCount = Math.floor(maxExtraHeads / _spawnAmount);
					}
					
					for (var i:int = 0; i < _spawnAmount; ++i) {
						var h:Enemy = createHydra(true);
						if (_extraHeadsCount > 0) {
							for (var j:int = 0; j < _extraHeadsCount; ++j) {
								h.createHead();
							}
						}
						Head.TimeMultiplier = Utils.clamp(1.33 - (0.05 * _timeMod), 0.05, 2);
						Enemy.TimeMultiplier = Utils.clamp(1.33 - (0.05 * _timeMod), 0.05, 2);
						EnemyShot.TIME_MODIFIER += 0.05;
					}
				}
			}
			else if (o is Head) {
				var head:Head = o as Head;
				trace("head=" + head);
				var tar:Vector3D = new Vector3D(_ship.x + _ship.width/2, _ship.y + _ship.height / 2);
				var r = head.getRect(enemies);
				trace("var=" + r);
				var hydraShot:EnemyShot = new EnemyShot(r.x, r.y, tar);
				_enemyShots.push(hydraShot);
				shots.addChild(hydraShot);
				GUI.headKills += 1;
			}
		}
		
		private function onEnterFrame(e:Event):void {
			if (_gameOver) {
				
				return;
			}
			var now:int = getTimer();
			var dt:int = now - _lastFrame;

			_bg.x -= 7 * _bgModifier;
			if (_bg.x < -2560) {
				_bg.x = _bg.x % 2560;
				increaseTime();
			}
			
			for (var i:int = 0; i < _hydras.length; ++i) {
				var item:Enemy = _hydras[i];
				item.update(dt);
			}
			
			for (var j:int = 0; j < _shots.length; ++j) {
				var shot:Shot = _shots[j];
				shot.update(dt);
				if (shot.x > 1280) {
					removeShot(shot);
				}
				else {
					if (!shot.enabled)
						continue;
					for (var k:int = 0; k < _hydras.length; ++k) {
						var hydra:Enemy = _hydras[k];
						if (hydra.handleHitTestObject(shot)) {
							shot.die();
							break;
						}
					}
				}
			}
			
			updateEnemyShots(dt);

			for (var l:int = 0; l < _enemyShots.length; ++l) {
				var hydShot:EnemyShot = _enemyShots[l] as EnemyShot;
				if (hydShot.enabled && hydShot.collisionDetection(_ship)) {
					hydShot.die();
					_enemyShots.splice(l, 1);
					shots.removeChild(hydShot);
					_ship.takeDamage();
					GUI.hp -= 1;
					if (GUI.hp <= 0) {
						_gameOver = true;
					}
				}
			}
			_ship.update(dt);
			_ship.addEventListener(Ship.ShotFired, onShot);
			
			gui.update(dt);
			_lastFrame = now;
		}
		
		private function updateEnemyShots(dt:int):void {
			for (var i:int = 0; i < _enemyShots.length; ++i) {
				var shot:EnemyShot = _enemyShots[i];
				shot.update(i);
			}
		}
		
		private function removeShot(shot:Shot):void {
			shot.stop();
			_shots.splice(_shots.indexOf(shot), 1);
			shots.removeChild(shot);
		}
		
		private function removeHydra(hydra:Enemy):void {
			hydra.stop();
			_hydras.splice(_hydras.indexOf(hydra), 1);
			enemies.removeChild(hydra);
		}
		
		private function increaseTime():void {
			_bgModifier += 0.17;
		}
		
		private function onShot(e:Event):void {
			trace("function HydraMain.onShot()");
			trace("\te=" + e);
			var shot:Shot = new Shot();
			shot.x = _ship.x + 170;
			shot.y = _ship.y + 38;
			_shots.push(shot);
			shots.addChild(shot);
		}
		
		private function createHydra(transition:Boolean = false):Enemy {
			var e:Enemy = new Enemy();
			_hydras.push(e);
			Utils.placeItemInsideBounds(e, Utils.SpawningBounds);
			enemies.addChild(e);
			if (transition) {
				e.enterScreen();
			}
			return e;
		}
	}
	
}
