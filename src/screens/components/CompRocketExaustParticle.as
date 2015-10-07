package screens.components
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;
	
	import managers.AssetsManager;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;
	
	public class CompRocketExaustParticle extends Sprite
	{
		private var _exaustParticle:PDParticleSystem;
		
		public function CompRocketExaustParticle()
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
			
			// particle
			this._exaustParticle = new PDParticleSystem(XML(new AssetsManager.particleXML()), Texture.fromBitmap(new AssetsManager.particleTexture()));

			Starling.juggler.add(this._exaustParticle);
			
			this.addChild(this._exaustParticle);
			
			this._exaustParticle.stop(true);
			
			this.scaleX = this.scaleY = 1.2;
		}
		
		/**
		 * 
		 * 
		 */		
		public function setNormalSpeed():void
		{
			TweenMax.to(this._exaustParticle,0.5,{speed:100,ease:Linear.easeOut});	
		}
		
		/**
		 * 
		 * 
		 */		
		public function setFastSpeed():void
		{
			TweenMax.to(this._exaustParticle,0.5,{speed:200,ease:Linear.easeOut});	
		}
			
		/**
		 * 
		 * 
		 */		
		public function startRocketExaust():void
		{
			this._exaustParticle.start();
		}
		
		/**
		 * 
		 * @param clearParticles
		 * 
		 */		
		public function stopRocketExaust(clearParticles:Boolean = false):void
		{
			this._exaustParticle.stop(clearParticles);
		}
	}
}