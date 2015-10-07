package managers
{
	import flash.system.Capabilities;
	
	import screens.ScreenSettings;
	import screens.gameLevelsScreens.ScreenSpaceLevel;
	import screens.ScreenWelcome;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class ScreenManager extends Sprite
	{
		// Main Screens
		private var _screenWelcome		:ScreenWelcome;
		private var _screenSettings		:ScreenSettings;
		private var _screenSpaceGame	:ScreenSpaceLevel;
		
		public function ScreenManager()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(evt:Event):void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			
			// create and add screens
			this._screenSpaceGame = new ScreenSpaceLevel();
			this.addChild(this._screenSpaceGame);
			this._screenSpaceGame.initialize();
			
			this._screenSettings = new ScreenSettings();
			this.addChild(this._screenSettings);
			this._screenSettings.disposeTemporarily();
			
			this._screenWelcome = new ScreenWelcome();
			this.addChild(this._screenWelcome);
			this._screenWelcome.disposeTemporarily();
		}
	}
}
