package screens
{
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class AScreen extends Sprite
	{
		public function AScreen()
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
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			
			drawScreen();
		}
		
		/**
		 * Init of graphics for this screen
		 * 
		 */		
		protected function drawScreen():void
		{
			
		}
		
		public function initialize():void
		{
			this.visible = true;		
		}
		
		public function disposeTemporarily():void
		{
			this.visible = false;
		}
	}
}