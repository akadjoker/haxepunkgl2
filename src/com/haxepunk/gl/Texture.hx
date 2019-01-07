package com.haxepunk.gl;


import lime.graphics.PixelFormat;
import lime.graphics.opengl.GLBuffer;
import lime.graphics.opengl.GLProgram;
import lime.graphics.opengl.GLShader;
import lime.graphics.opengl.GLTexture;
import lime.utils.UInt8Array;


import openfl.display.Bitmap;
import openfl.utils.ByteArray;
import openfl.utils.Endian;
import openfl.geom.Matrix;
import openfl.display.BitmapData;
import openfl.Lib;
import lime.math.ARGB;
import lime.math.BGRA;
import lime.math.RGBA;
import lime.math.Rectangle;
import openfl.Assets;

import com.haxepunk.utils.Util;



	#if neko

import sys.io.File;
import sys.io.FileOutput;
		#end
		

/**
 * ...
 * @author djoker
 */
class Texture
{
	
	  public var data:GLTexture;
	public var width:Int;	
	public var height:Int;
	public var texHeight:Int;
	public var texWidth:Int;
	public var name:String;
	private var exists:Bool;
	public var invTexWidth:Float;
	public var invTexHeight:Float;
	
	public function Bind()
	{
	 if (!exists) return;
     HXP.gl.bindTexture(HXP.gl.TEXTURE_2D, data);
	}

	public function setData(bitmapData:BitmapData, ?flip:Bool = false,?newname:String="bitmap" )
	{
		exists = false;
		if (bitmapData==null) return ;
		
		this.name = newname;
	
	if (flip)
	{
	bitmapData = Util.flipBitmapData(bitmapData);
	}
    data = HXP.gl.createTexture ();	
	HXP.gl.bindTexture(HXP.gl.TEXTURE_2D, data);
		
		this.width = bitmapData.width;
		this.height = bitmapData.height;

		this.texWidth =  Util.getNextPowerOfTwo(width);
		this.texHeight = Util.getNextPowerOfTwo(height);
	
		
			
		 var isPot = (bitmapData.width == texWidth && bitmapData.height == texHeight);

			
	HXP.gl.texParameteri (HXP.gl.TEXTURE_2D, HXP.gl.TEXTURE_WRAP_S, HXP.gl.CLAMP_TO_EDGE);
    HXP.gl.texParameteri (HXP.gl.TEXTURE_2D, HXP.gl.TEXTURE_WRAP_T, HXP.gl.CLAMP_TO_EDGE);
    HXP.gl.texParameteri(HXP.gl.TEXTURE_2D, HXP.gl.TEXTURE_MAG_FILTER, HXP.gl.NEAREST);
	HXP.gl.texParameteri(HXP.gl.TEXTURE_2D, HXP.gl.TEXTURE_MIN_FILTER, HXP.gl.NEAREST);

			
			if (!isPot)
			{
			var workingCanvas:BitmapData = Util.getScaled(bitmapData, texWidth, texHeight);
			
			#if debug
			
			trace("rescale : " + texWidth + "," + texHeight);
			#end
			
		
		    //var pixelData = new UInt8Array (workingCanvas.getPixels (workingCanvas.rect));
			var pixelData = new UInt8Array (getPixels(workingCanvas));
			
		    
			HXP.gl.texImage2D(HXP.gl.TEXTURE_2D, 0, HXP.gl.RGBA, workingCanvas.width, workingCanvas.height, 0, HXP.gl.RGBA, HXP.gl.UNSIGNED_BYTE, pixelData);
			} else
			{
		
		    //var pixelData = new UInt8Array (bitmapData.getPixels (bitmapData.rect));
			var pixelData = new UInt8Array (getPixels(bitmapData));
		    
			HXP.gl.texImage2D(HXP.gl.TEXTURE_2D, 0, HXP.gl.RGBA, texWidth, texHeight, 0, HXP.gl.RGBA, HXP.gl.UNSIGNED_BYTE, pixelData);
      		}
			HXP.gl.bindTexture(HXP.gl.TEXTURE_2D, null);


		     invTexWidth  = 1.0 / texWidth;
             invTexHeight = 1.0 /texHeight;
	
			exists = true;
	}
	private function getPixels (bmp:BitmapData):ByteArray 
	{
		
		var byteArray = ByteArray.fromBytes (bmp.image.getPixels(new Rectangle(bmp.rect.x,bmp.rect.y,bmp.rect.width,bmp.rect.height), PixelFormat.RGBA32));
		byteArray.endian = BIG_ENDIAN;
		return byteArray;
		
	}
	
	
	public function load(url:String, ?flip:Bool = false ) 
	{
	name = url;
	var  bitmapData:BitmapData ;	
    bitmapData = Assets.getBitmapData(url);
	if (bitmapData==null) return ;
	
	if (flip)
	{
	bitmapData = Util.flipBitmapData(bitmapData);
	}
    data = HXP.gl.createTexture ();	
	HXP.gl.bindTexture(HXP.gl.TEXTURE_2D, data);
		
		this.width = bitmapData.width;
		this.height = bitmapData.height;

		this.texWidth =  Util.getNextPowerOfTwo(width);
		this.texHeight = Util.getNextPowerOfTwo(height);
	
		
			
		 var isPot = (bitmapData.width == texWidth && bitmapData.height == texHeight);
		  

			
	HXP.gl.texParameteri (HXP.gl.TEXTURE_2D, HXP.gl.TEXTURE_WRAP_S, HXP.gl.CLAMP_TO_EDGE);
    HXP.gl.texParameteri (HXP.gl.TEXTURE_2D, HXP.gl.TEXTURE_WRAP_T, HXP.gl.CLAMP_TO_EDGE);
    HXP.gl.texParameteri(HXP.gl.TEXTURE_2D, HXP.gl.TEXTURE_MAG_FILTER, HXP.gl.NEAREST);
	HXP.gl.texParameteri(HXP.gl.TEXTURE_2D, HXP.gl.TEXTURE_MIN_FILTER, HXP.gl.NEAREST);
/*
			if (!isPot)
			{
			
			#if debug
			trace("rescale : " +this.width+" x "+ texWidth + "," +this.height+" x " + texHeight);
			#end
			
			var workingCanvas:BitmapData = Util.getScaled(bitmapData,texWidth, texHeight);
		    //var pixelData = new UInt8Array (workingCanvas.getPixels (workingCanvas.rect));
			var pixelData = new UInt8Array (getPixels(workingCanvas));
			//ARGB32
			HXP.gl.texImage2D(HXP.gl.TEXTURE_2D, 0, HXP.gl.RGBA, workingCanvas.width, workingCanvas.height, 0, HXP.gl.RGBA, HXP.gl.UNSIGNED_BYTE, pixelData);
		//    var pixelData = new UInt8Array (bitmapData.getPixels (bitmapData.rect));
	//		HXP.gl.texImage2D(HXP.gl.TEXTURE_2D, 0, HXP.gl.RGBA, bitmapData.width, bitmapData.height, 0, HXP.gl.RGBA, HXP.gl.UNSIGNED_BYTE, pixelData);
			
			} else
			*/
			{
		    #if debug
			trace("create  : " + texWidth + "," + texHeight);
			#end
			
		   // var pixelData = new UInt8Array (bitmapData.getPixels (bitmapData.rect));
			var pixelData = new UInt8Array (getPixels(bitmapData));
		    
			HXP.gl.texImage2D(HXP.gl.TEXTURE_2D, 0, HXP.gl.RGBA, bitmapData.width, bitmapData.height, 0, HXP.gl.RGBA, HXP.gl.UNSIGNED_BYTE, pixelData);
      		}

              HXP.gl.bindTexture(HXP.gl.TEXTURE_2D, null);

		     invTexWidth  = 1.0 / texWidth;
             invTexHeight = 1.0 /texHeight;

       
			exists = true;
	
		
	}
	public function new() 
	{
		this.width =0;
		this.height = 0;
		this.texWidth = 0;
		this.texHeight = 0;
		exists = false;
	}
	
	public function dispose()
	{
		HXP.gl.deleteTexture(data);
	}
	
	
}