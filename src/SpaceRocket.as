package
{
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.display.StageAspectRatio;
	import flash.system.Capabilities;
	import flash.text.TextField;
	
	[SWF(width="1024", height="768", frameRate="60", backgroundColor="#ffaa22")]
	public class SpaceRocket extends Sprite
	{
		public function SpaceRocket()
		{
			super();
			
			// 
			stage.setAspectRatio(StageAspectRatio.LANDSCAPE);
			
			about();
		}
		
		/**
		 * Gives Air Status  
		 * 
		 */			
		private function about():void
		{
			var about:String = "\nRuntime Version:"+Capabilities.version+
				"\nAir SDK Compiler Version:"+NativeApplication.nativeApplication.runtimeVersion+
				"\nRuntime PatchLevel:"+NativeApplication.nativeApplication.runtimePatchLevel+
				"\:";
			
			trace("About:"+about);	
			
			
			var text:TextField = new TextField();
			text.text = "My ipad app!!\n"+about;
			
			addChild(text);
			text.textColor = 0x000000;
			text.scaleX = text.scaleY = 3;
			
			text.wordWrap = true;
			
			text.x = 100;
			text.y = 200;
		}
	}
}