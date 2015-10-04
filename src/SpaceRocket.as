package
{
	import com.greensock.TweenMax;
	import com.greensock.plugins.TransformAroundCenterPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageAspectRatio;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import flash.text.TextField;
	
	import managers.ScreenManager;
	
	import net.hires.debug.Stats;
	
	import starling.core.Starling;
	import starling.textures.RenderTexture;
	import starling.utils.SystemUtil;
	
	[SWF(frameRate="60", backgroundColor="#ffaa22")]
	public class SpaceRocket extends Sprite
	{
		// provides framerate and memory usage
		private var _stats		:Stats;
		// Starling framework
		private var _starling	:Starling;
		
		public function SpaceRocket()
		{
			super();
			
			// 
			stage.setAspectRatio(StageAspectRatio.LANDSCAPE);
			
			// Tweenmax plugins
			TweenPlugin.activate([TransformAroundCenterPlugin]);
			
			// add statistics
			this.addChild(this._stats = new Stats());
			
			// Info
			about();
			
			// start starling framework
			startup();
			
			// apply scales
			
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
			/*
			
			var text:TextField = new TextField();
			text.text = "My ipad app!!\n"+about;
			
			addChild(text);
			text.textColor = 0x000000;
			text.scaleX = text.scaleY = 3;
			
			text.wordWrap = true;
			
			text.x = 100;
			text.y = 200;*/
		}
		
		/**
		 * 
		 * 
		 */		
		public function startup():void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			var fw:Number = Math.max(stage.fullScreenWidth, stage.fullScreenHeight);
			var fh:Number = Math.min(stage.fullScreenWidth, stage.fullScreenHeight);
			
			Starling.multitouchEnabled = true; // useful on mobile devices
			Starling.handleLostContext = true; // recommended everywhere when using AssetManager
			
			RenderTexture.optimizePersistentBuffers = true; // safe on iOS, dangerous on Android
			trace(stage.stageWidth, stage.stageHeight);
			
			_starling = new Starling(ScreenManager, stage, new Rectangle(0,0,fw, fh)); // retina
			
			_starling.enableErrorChecking = Capabilities.isDebugger;
			_starling.antiAliasing = 8; // 1 lowest - 16 highest (poor performance) 
			_starling.start();
			
			trace(_starling.stage.stageWidth,_starling.stage.stageHeight)
			
			if(Capabilities.os != "Mac OS 10.10.5"){
				// apply scale to double
				this._stats.scaleX = this._stats.scaleY = 2;
			}
			
			// When the game becomes inactive, we pause Starling; otherwise, the enter frame event
			// would report a very long 'passedTime' when the app is reactivated.
			if (!SystemUtil.isDesktop)
			{
				//
				NativeApplication.nativeApplication.addEventListener(
					flash.events.Event.ACTIVATE, function (e:*):void { _starling.start(); });
				NativeApplication.nativeApplication.addEventListener(
					flash.events.Event.DEACTIVATE, function (e:*):void { _starling.stop(true); });
			}
		}
	}
}