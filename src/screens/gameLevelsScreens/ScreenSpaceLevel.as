package screens.gameLevelsScreens
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;
	import com.greensock.easing.Quart;
	import com.greensock.easing.Quint;
	
	import managers.AssetsManager;
	import managers.SettingsManager;
	
	import screens.AScreen;
	import screens.components.CompBackground;
	import screens.components.CompRocketExaustParticle;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.deg2rad;
	
	public class ScreenSpaceLevel extends AScreen
	{
		private var _background	:CompBackground;
		private var _rocketExaust:CompRocketExaustParticle;
		
		private var _world		:Image;
		private var _rocket		:Image;
		
		
		private var _touch:Touch;
		private var _touchX:Number;
		private var _touchY:Number;
		
		public function ScreenSpaceLevel()
		{
			super();
		}
		
		/**
		 * This is where we draw our screen! 
		 * 
		 */		
		override protected function drawScreen():void
		{
			this._background = new CompBackground();
			this.addChild(this._background);
			
			this._world = new Image(AssetsManager.getTexture("BgWorld"));
			this.addChild(this._world);
			
			// shift pivot to center
			this._world.pivotX = this._world.width * .5;
			this._world.pivotY = this._world.height * .5;
			this._world.scaleX = this._world.scaleY = 2;
			this._world.y = stage.stageHeight;
			
			//
			this._rocketExaust = new CompRocketExaustParticle();
			this.addChild(this._rocketExaust);
			this._rocketExaust.x = -200;
			
			this._rocket = new Image(AssetsManager.getTexture("Rocket"));
			this._rocket.pivotY = this._rocket.height * .5;
			this.addChild(this._rocket);
		}
		
		/**
		 * Put all the necessary elements moving
		 * World
		 * Background 
		 * 
		 */		
		private function moveElements():void{
			
			// forever spinning world 
			TweenMax.to(this._world,SettingsManager.WORLD_MOVE_TIME,{rotation:deg2rad(360), repeat:-1, ease:Linear.easeNone});
			
			// start moving background
			this._background.startBackground();
			
			// start rocket exaust
			this._rocketExaust.startRocketExaust();
			this._rocketExaust.setFastSpeed();
			
			// hide rocket
			this._rocket.x = -100-this._rocket.width;
			this._rocket.y = (this.stage.stageHeight - this._rocket.height) * .5;
			// launch rocket in
			TweenMax.to(this._rocket,5,{x:100, ease:Quint.easeInOut, onComplete:addGameEvents});
		}
		
		/**
		 * 
		 * 
		 */		
		private function addGameEvents():void
		{
			// game tick
			this.addEventListener(Event.ENTER_FRAME, onGameTick);
			
			// rocket to normal speed
			this._rocketExaust.setNormalSpeed();
			
			// touch
			this.addEventListener(TouchEvent.TOUCH,onTouch);
		}
		
		/**
		 * 
		 * @param evt
		 * 
		 */		
		private function onTouch(evt:TouchEvent):void
		{
			//var touches:Vector.<Touch> = evt.getTouches(stage);			
			//for each (var touch:Touch in touches)
			//trace(touch);
			
			this._touch = evt.getTouch(stage);
			if(this._touch && (this._touch.phase == TouchPhase.BEGAN || this._touch.phase == TouchPhase.MOVED)){
				this._touchX = _touch.globalX;
				this._touchY = _touch.globalY;
				
				//trace("touch xy:",_touchX,_touchY);
			}
			else if(this._touch && (this._touch.phase == TouchPhase.ENDED || this._touch.phase == TouchPhase.STATIONARY)){
				this._touchX = -1;
				this._touchY = -1;
				onRocketComplete();
			}
		}
		
		/**
		 * 
		 * 
		 */		
		private function onGameTick():void
		{
			// update particle x,y
			this._rocketExaust.x = this._rocket.x+70;
			this._rocketExaust.y = this._rocket.y;
			
			// update rocket y position
			if(this._touchY > 0 && this._touchY < this.stage.stageHeight){
				// tween to position and tilt rocket a bit
				TweenMax.to(this._rocket,0.2,{y:this._touchY , rotation:deg2rad((this._rocket.y > this._touchY)?(-5):(5)), ease:Linear.easeOut, onComplete:onRocketComplete});
				trace("Rocket Tweens:",TweenMax.getTweensOf(this._rocket).length);
			}
			// update rocket x position
			if(this._touchX > 0 && this._touchX < this.stage.stageWidth*.5){
				this._rocketExaust.setFastSpeed();
				TweenMax.to(this._rocket,0.2,{x:this._touchX , ease:Linear.easeOut, onComplete:this._rocketExaust.setNormalSpeed});
			}
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */		
		private function onRocketComplete():void
		{
			TweenMax.to(this._rocket,0.2,{ rotation:0, ease:Linear.easeOut});
		}
		
		/**
		 * 
		 * 
		 */		
		override public function initialize():void{
			
			moveElements();
			
			super.initialize();
		}
	}
}