package managers
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class AssetsManager
	{
		/** 
		 * PARTICLES RELATED MEDIA
		 **/ 
		[Embed(source="../media/particles/particleCoffee.pex", mimeType="application/octet-stream")]
		public static var particleXML:Class;
		
		[Embed(source="../media/particles/texture.png")]
		public static var particleTexture:Class;
		
		/** 
		 * BACKGROUND RELATED MEDIA
		 **/
		[Embed(source="../media/graphics/background_8b.png")]
		public static const BgSpace:Class;
		
		[Embed(source="../media/graphics/world_2.png")]
		public static const BgWorld:Class;
		
		
		/**
		 *  FONTS - mac usar glyphdesigner 
		 **/
		
		[Embed(source="../media/graphics/myGlyphs.png")]
		public static const FontTexture:Class;
		
		[Embed(source="../media/graphics/myGlyphs.fnt", mimeType="application/octet-stream")]
		public static const FontXML:Class;
		
		public static var myFont:BitmapFont;
		
		public static function getFont():BitmapFont
		{
			//if(myFont == null){
			var fontTexture:Texture = Texture.fromBitmap(new FontTexture());
			var fontXml:XML = XML(new FontXML());
			
			var font:BitmapFont = new BitmapFont(fontTexture, fontXml);
			
			// register as a font ( starling textfield )
			TextField.registerBitmapFont(font);
			
			return font;
			//}
		}
		
		/**
		 * SPRITESHEET IMAGES / ANIMATIONS / ETC
		 * AND
		 * EMBED IMAGES
		 **/
		private static var gameTextures:Dictionary = new Dictionary();
		
		private static var gameTextureAtlas:TextureAtlas;
		
		[Embed(source="../media/graphics/mySpritesheet.png")]
		public static const AtlasTextureGame:Class;
		
		[Embed(source="../media/graphics/mySpritesheet.xml", mimeType="application/octet-stream")]
		public static const AtlasXmlGame:Class;
		
		public static function getAtlas():TextureAtlas
		{
			if(gameTextureAtlas == null)
			{
				var texture:Texture = getTexture("AtlasTextureGame");
				var xml:XML = XML(new AtlasXmlGame());
				gameTextureAtlas = new TextureAtlas(texture,xml);
			}
			
			return gameTextureAtlas;
		}
		
		public static function getTexture(name:String):Texture
		{
			if(gameTextures[name] == undefined)
			{
				var bitmap:Bitmap 	= new AssetsManager[name]();
				gameTextures[name] 	= Texture.fromBitmap(bitmap);
			}
			
			return gameTextures[name];
		}
	}
}