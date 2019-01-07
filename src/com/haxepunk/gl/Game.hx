package com.haxepunk.gl;


import com.haxepunk.gl.filter.Filter;



import lime.utils.Float32Array;
import lime.utils.Int16Array;


import openfl.Lib;
import openfl.geom.Rectangle;
import openfl.display.BitmapData;

/**
 * ...
 * @author djoker
 */

 typedef TRender=Rectangle-> Void;
 
class Game 
{
   public static inline var vertexStrideSize =  (3 + 2 + 4) * 4;
//   public static var primitiveShader:PrimitiveShader;
   //public static var spriteShader:SpriteShader;
   public static var game:Game;
   public static var camera:Camera;
   public static var spriteBatch:SpriteBatch;
   public static var lines:BatchPrimitives;
   private var textures:Map<String,Texture>;
   public var screenWidth:Int ;
   public var screenHeight:Int ;
	
	private var enableDepth:Bool;
    public var red:Float;
    public var green:Float;
    public var blue:Float;
	

	public function new():Void
	{
     trace("crate gl");
	
	 
	   Game.game = this;
	   screenWidth = Lib.current.stage.stageWidth;
	   screenHeight = Lib.current.stage.stageHeight;
	   Game.camera = new Camera(screenWidth, screenHeight);
	
	   
		
       
		textures = new  Map<String,Texture>();
		spriteBatch = new SpriteBatch(1500);
		lines = new BatchPrimitives(500);
	
	
    HXP.gl.disable(HXP.gl.CULL_FACE);
	HXP.gl.disable(HXP.gl.BLEND);
	HXP.gl.enable(HXP.gl.BLEND);
	//HXP.gl.blendFunc(HXP.gl.SRC_ALPHA,HXP.gl.DST_ALPHA );
	//HXP.gl.pixelStorei(HXP.gl.PACK_ALIGNMENT, 2);
	HXP.gl.enable(HXP.gl.DEPTH_TEST);
    setDeph(true);
	clearColor(0, 0, 0);
	HXP.gl.depthMask(true);
	HXP.gl.colorMask(true, true, true, true);
	HXP.gl.activeTexture(HXP.gl.TEXTURE0);
	/*
	
 HXP.gl.disableVertexAttribArray (Filter.vertexAttribute);
 HXP.gl.disableVertexAttribArray (Filter.texCoordAttribute);
 HXP.gl.disableVertexAttribArray (Filter.colorAttribute);	
 HXP.gl.bindBuffer (HXP.gl.ARRAY_BUFFER, null);	
 HXP.gl.useProgram (null);	
 HXP.gl.blendFunc(HXP.gl.SRC_ALPHA, HXP.gl.DST_ALPHA );
 */
 HXP.gl.blendFunc(HXP.gl.SRC_ALPHA,HXP.gl.ONE_MINUS_SRC_ALPHA );

	}

	public function setDeph(v:Bool)
	{
		enableDepth = v;
		if (v == true)
		{
		 HXP.gl.disable(HXP.gl.DEPTH_TEST);
		} else
		{
		HXP.gl.enable(HXP.gl.DEPTH_TEST);
		HXP.gl.depthFunc(HXP.gl.FASTEST);
    	}
	}
	public function clearColor(r:Float, g:Float, b:Float)
	{
		red = r;
		green = g;
		blue = b;

	
	}

	

public function addTexture(bitmap:BitmapData,name:String, ?flip:Bool = false ):Texture 
{
 if (textures.exists(name))
	{
		return textures.get(name);
	} else
	{	
	var tex = new Texture();
	tex.setData(bitmap,flip,name);
	textures.set(name,tex);
	return tex;
	}
}

public function getTexture(url:String, ?flip:Bool = false ):Texture 
{
	
	
 if (textures.exists(url))
	{
		return textures.get(url);
	} else
	{	
	var tex = new Texture();
	tex.load(url, flip);
	textures.set(url,tex);
	return tex;
	}
}

public function getTextureEx(url:String,name:String, ?flip:Bool = false ):Texture 
{
 if (textures.exists(url))
	{
		return textures.get(url);
	} else
	{	
	var tex = new Texture();
	tex.load(url, flip);
	textures.set(name,tex);
	return tex;
	}
}



}