package com.haxepunk.graphics;



import com.haxepunk.gl.BlendMode;
import com.haxepunk.gl.SpriteBatch;
import com.haxepunk.Graphic;
import com.haxepunk.gl.Clip;
import com.haxepunk.gl.Game;
import com.haxepunk.Graphic;
import com.haxepunk.HXP;
import com.haxepunk.gl.Texture;
import openfl.geom.Matrix;

import flash.display.Graphics;
import flash.geom.Point;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;
import openfl.Assets;


/**
 * ...
 * @author djoker
 */
class BitmapFont extends Graphic
{
public var align:Int;
public var customSpacingX:Int;
public var customSpacingY:Int;


	
private var image:Texture;
private var offsetX:Int;
private var offsetY:Int;
private var characterWidth:Int;
private var characterHeight:Int;
private var characterSpacingX:Int;
private var characterSpacingY:Int;
private var characterPerRow:Int;

private var glyphs:Array<Clip>;


public function new(x:Float, y:Float, text:String, tex:Texture,
width:Int, height:Int, 
charsPerRow:Int, 
xSpacing:Int = 0, ySpacing:Int = 0, 
xOffset:Int = 0, yOffset:Int = 0,
//?chars:String = " 0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[/]^-'abcdefghijklmnopqrstuvwxyz{|]~"):Void
chars:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ.,\"-+!?()':;0123456789"):Void
{

super();


image = tex;
align = 0;
customSpacingX = 0;
customSpacingY = 0;


scale = 1;
scaleX = 1;
scaleY = 1;


		
characterWidth = width;
characterHeight = height;
characterSpacingX = xSpacing;
characterSpacingY = ySpacing;
characterPerRow = charsPerRow;
offsetX = xOffset;
offsetY = yOffset;


glyphs = [];

var currentX:Int = offsetX;
var currentY:Int = offsetY;
var r:Int = 0;
var index:Int = 0;

for(c in 0...chars.length)

{
 

glyphs[chars.charCodeAt(c)]=new Clip(currentX, currentY, characterWidth, characterHeight);
r++;
if (r == characterPerRow)
{
r = 0;
currentX = offsetX;
currentY += characterHeight + characterSpacingY;
}
else
{
currentX += characterWidth + characterSpacingX;
}
}
}




 public function print(batch:SpriteBatch, caption:String, x:Float, y:Float,?align:Int=0)
{
		var fsx = HXP.screen.fullScaleX,
			fsy = HXP.screen.fullScaleY;

		var sx = scale * scaleX  * fsx,
			sy = scale * scaleY  * fsy;

			
    var cx:Int = 0;
    var cy:Int = 0;
	var X:Float = x;
	var Y:Float = y;
	var newLine:Float = characterHeight + characterSpacingY;

	   switch (align) 
       { 
       case 0:
       cx = 0;
       case 1:
       cx = getTextWidth(caption);
       case 2:
       cx = Std.int(getTextWidth(caption) / 2);
       }
	   


  for (c in 0...caption.length)   
   {
    if(caption.charAt(c) == " ")
    {
       X += characterWidth + customSpacingX;
    }
    else
	  if(caption.charAt(c) == "\n")
    {
	   Y += newLine;	
       X = x-characterWidth + customSpacingX;
    } else
      {
        var glyph = glyphs[caption.charCodeAt(c)];// Std.int(caption.charCodeAt(c));
        X += characterWidth + customSpacingX;
		 if (glyph != null) batch.RenderFont(image, (X - cx) - characterWidth, Y, scale, glyph, false, true, _red, _green, _blue, alpha, BlendMode.NORMAL);
		 
		//this.sheet.draw(glyph, (X - cx) - characterWidth, Y, sx, sy, 0, red, green, blue, alpha);
	   }
  }		
  

}

override public function render(m:Matrix, point:Point, camera:Point)
	{
		// determine drawing location
	
		var fsx = HXP.screen.fullScaleX,
			fsy = HXP.screen.fullScaleY;

		var sx = scale * scaleX *  fsx,
			sy = scale * scaleY *  fsy;

		//_point.x = Math.floor(point.x + x - camera.x * scrollX);
		//_point.y = Math.floor(point.y + y - camera.y * scrollY);
		/*
		
	var cx:Int = 0;
    var cy:Int = 0;
	var X:Float = _point.x;
	var Y:Float = _point.y;
	var newLine:Float = characterHeight + characterSpacingY;

	   switch (align) 
       { 
       case 0:
       cx = 0;
       case 1:
       cx = getTextWidth(caption);
       case 2:
       cx = Std.int(getTextWidth(caption) / 2);
       }
	   


  for (c in 0...caption.length)   
   {
    if(caption.charAt(c) == " ")
    {
       X += characterWidth + customSpacingX;
    }
    else
	  if(caption.charAt(c) == "\n")
    {
	   Y += newLine;	
       X = x-characterWidth + customSpacingX;
    } else
      {
        var glyph = Std.int(caption.charCodeAt(c));
        X += characterWidth + customSpacingX;
		this.sheet.draw(glyph, (X - cx) - characterWidth, Y, sx, sy, 0, red, green, blue, alpha);
    }
  }		
  
 */
}

public function getTextWidth(caption:String):Int 
	{
		var w:Int = 0;
		var textLength:Int = caption.length;
		for (i in 0...(textLength)) 
		{
        var glyph:Int = Std.int(caption.charCodeAt(i));
		w += characterWidth;
		w = Math.round(w * scale);
		if (textLength > 1)
		{
			w += (textLength - 1) * characterSpacingX;
		}
		}
		return w;
	}


	
}