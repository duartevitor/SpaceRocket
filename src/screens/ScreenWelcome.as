package screens
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;
	
	import managers.AssetsManager;
	import managers.SettingsManager;
	
	import screens.components.CompBackground;
	
	import starling.display.Image;
	import starling.utils.deg2rad;
	
	public class ScreenWelcome extends AScreen
	{
		private var _background	:CompBackground;
		
		private var _world		:Image;
		private var _rocket		:Image;
		
		public function ScreenWelcome()
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
			
			this._background.startBackground();
		}
		
		/**
		 * 
		 * 
		 */		
		override public function initialize():void{
			super.initialize();
			
			moveElements();
		}
	}
}
