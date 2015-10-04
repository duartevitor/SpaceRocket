package screens.components
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;
	
	import managers.AssetsManager;
	import managers.SettingsManager;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class CompBackground extends Sprite
	{
		private var _back1	:Image;
		private var _back2	:Image;
		
		public function CompBackground()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		/**
		 * 
		 * @param evt
		 * 
		 */		
		private function onAddedToStage(evt:Event):void			
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			this._back1 = new Image(AssetsManager.getTexture("BgSpace"));
			this.addChild(this._back1);
			this._back1.x = 0;
			
			this._back2 = new Image(AssetsManager.getTexture("BgSpace"));
			this.addChild(this._back2);
			this._back2.height = SettingsManager.BACKGROUND_IMG_HEIGHT;
			this._back2.x = stage.stageWidth;
			
			this._back1.width = this._back2.width= stage.stageWidth;
			this._back1.height = this._back2.height = stage.stageHeight;
		}
		
		/**
		 * 
		 * @param bgLayer
		 * 
		 */		
		private function onCompleteBackgroundLayer(bgLayer:Image):void
		{
			var nextX:int = -stage.stageWidth;
			if(bgLayer.x == -stage.stageWidth){
				bgLayer.x = stage.stageWidth;
				nextX = 0;
			}
			
			trace(bgLayer.name,nextX);
			TweenMax.to(bgLayer,SettingsManager.BACK_MOVE_TIME,{x:nextX, ease:Linear.easeNone, onComplete:onCompleteBackgroundLayer, onCompleteParams:[bgLayer]});
		}
		
		/**
		 * 
		 * 
		 */		
		public function startBackground():void
		{
			this._back1.x = 0;
			trace("tween to:",-stage.stageWidth);
			TweenMax.to(this._back1,SettingsManager.BACK_MOVE_TIME,{x:-stage.stageWidth, ease:Linear.easeNone, onComplete:onCompleteBackgroundLayer, onCompleteParams:[this._back1]});
			TweenMax.to(this._back2,SettingsManager.BACK_MOVE_TIME,{x:0, ease:Linear.easeNone, onComplete:onCompleteBackgroundLayer, onCompleteParams:[this._back2]});
			
			// increase background in yoyo mode
			TweenMax.to(this,10,{scaleY:1.05, repeat:-1, yoyo:true, ease:Linear.easeNone});
		}
		
		/**
		 * 
		 * 
		 */		
		public function stopBackground():void
		{
			TweenMax.killTweensOf(this); 
		}
	}
}