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
		private var _back1_1	:Image;
		private var _back1_2	:Image;
		private var _back2_1	:Image;
		private var _back2_2	:Image;
		
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
			
			loadBackgroundImage(this._back1_1 = new Image(AssetsManager.getTexture("BgSpace1")));
			loadBackgroundImage(this._back1_2 = new Image(AssetsManager.getTexture("BgSpace1")));
			loadBackgroundImage(this._back2_1 = new Image(AssetsManager.getTexture("BgSpace2")));
			loadBackgroundImage(this._back2_2 = new Image(AssetsManager.getTexture("BgSpace2")));
		}
		
		/**
		 * 
		 * @param img
		 * @param bgName
		 * 
		 */		
		private function loadBackgroundImage(img:Image):void
		{
			this.addChild(img);
			img.x 		= -stage.stageWidth;
			img.width 	= stage.stageWidth;
			img.height 	= stage.stageHeight;
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
				// random next bg layer
				if(Math.round(Math.random()*9) > 4){ // next layer will be layer 2_X
					bgLayer = (this._back2_1.x == -stage.stageWidth)?(this._back2_1):(this._back2_2);					
				}
				else{// next layer will be layer 1_X
					bgLayer = (this._back1_1.x == -stage.stageWidth)?(this._back1_1):(this._back1_2);
				}
				
				bgLayer.x = stage.stageWidth;
				nextX = 0;
			}
			
			TweenMax.to(bgLayer,SettingsManager.BACK_MOVE_TIME,{x:nextX, ease:Linear.easeNone, onComplete:onCompleteBackgroundLayer, onCompleteParams:[bgLayer]});
		}
		
		/**
		 * 
		 * 
		 */		
		public function startBackground():void
		{
			// default will be layer 1_X
			this._back1_1.x = 0;
			this._back1_2.x = stage.stageWidth;

			TweenMax.to(this._back1_1,SettingsManager.BACK_MOVE_TIME,{x:-stage.stageWidth, ease:Linear.easeNone, onComplete:onCompleteBackgroundLayer, onCompleteParams:[this._back1_1]});
			TweenMax.to(this._back1_2,SettingsManager.BACK_MOVE_TIME,{x:0, ease:Linear.easeNone, onComplete:onCompleteBackgroundLayer, onCompleteParams:[this._back1_2]});
			
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