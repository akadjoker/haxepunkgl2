package com.haxepunk.gl;

import com.haxepunk.math.Vector2;
import com.haxepunk.gl.Game;
import openfl.display.Bitmap;
import openfl.geom.Matrix;
import openfl.geom.Point;
import lime.graphics.opengl.GLBuffer;
import lime.graphics.opengl.GLProgram;
import lime.graphics.opengl.GLShader;
import lime.graphics.opengl.GLUniformLocation;
import lime.utils.Float32Array;
import lime.utils.Int16Array;






/**
 * ...
 * @author djoker
 */
class BatchPrimitives 
{
	public var colorBuffer:GLBuffer;
	public var colorIndex:Int;
	public var colors:Float32Array;
	public var vertexBuffer:GLBuffer;
	public var vertices:Float32Array;

	   
	private var cp:Vector2 = new Vector2(0, 0);
	
	public var fcolorBuffer:GLBuffer;
	public var fcolorIndex:Int;
	public var fcolors:Float32Array;
	public var fvertexBuffer:GLBuffer;
	public var fvertices:Float32Array;
	
	
    private var capacity:Int;



	private var alpha:Float = 1;
	public var _red:Float=1;
	public var _green:Float=1;
	public var _blue:Float=1;


	private var currentBlendMode:Int;


	private var idxCols:Int;
	private var idxPos:Int;

	
    private var fidxCols:Int;
	private var fidxPos:Int;

   
    public var shader:PrimitiveShader;
  




	
	public function new(capacity:Int) 
	{
	this.vertexBuffer =  HXP.gl.createBuffer();
	this.colorBuffer =  HXP.gl.createBuffer();
	this.fvertexBuffer =  HXP.gl.createBuffer();
	this.fcolorBuffer =  HXP.gl.createBuffer();
	this.capacity = capacity;

    idxPos=0;
	idxCols = 0;


	fidxPos=0;
	fidxCols = 0;

    vertices = new Float32Array(capacity * 3 *4);
	HXP.gl.bindBuffer(HXP.gl.ARRAY_BUFFER, this.vertexBuffer);
	HXP.gl.bufferData(HXP.gl.ARRAY_BUFFER,this.vertices , HXP.gl.DYNAMIC_DRAW);
	colors = new Float32Array(capacity * 4 * 4);
	HXP.gl.bindBuffer(HXP.gl.ARRAY_BUFFER, this.colorBuffer);
	HXP.gl.bufferData(HXP.gl.ARRAY_BUFFER, this.colors , HXP.gl.DYNAMIC_DRAW);
    
	fvertices = new Float32Array(capacity * 3 *4);
	HXP.gl.bindBuffer(HXP.gl.ARRAY_BUFFER, this.fvertexBuffer);
	HXP.gl.bufferData(HXP.gl.ARRAY_BUFFER,this.fvertices , HXP.gl.DYNAMIC_DRAW);
	fcolors = new Float32Array(capacity * 4 * 4);
	HXP.gl.bindBuffer(HXP.gl.ARRAY_BUFFER, this.fcolorBuffer);
	HXP.gl.bufferData(HXP.gl.ARRAY_BUFFER, this.fcolors , HXP.gl.DYNAMIC_DRAW);

	currentBlendMode = BlendMode.NORMAL;
	shader = new PrimitiveShader();
	}
	
	

	
	
public function vertex(x:Float, y:Float, ?z:Float = 0.0)
{
		vertices[idxPos++] = x;
        vertices[idxPos++] = y;
        vertices[idxPos++] = z;
	
}
public function color(r:Float, g:Float,b:Float, ?a:Float =0.0)
	{
	colors[idxCols++] = r;
	colors[idxCols++] = g;
	colors[idxCols++] = b;
	colors[idxCols++] = a;	
	}

public function fvertex(x:Float, y:Float, ?z:Float = 0.0)
{
		fvertices[fidxPos++] = x;
        fvertices[fidxPos++] = y;
        fvertices[fidxPos++] = z;
	
}
public function fcolor(r:Float, g:Float,b:Float, ?a:Float =0.0)
	{
	fcolors[fidxCols++] = r;
	fcolors[fidxCols++] = g;
	fcolors[fidxCols++] = b;
	fcolors[fidxCols++] = a;	
	}


	public function begin()
	{
	 idxPos=0;
	 idxCols = 0;
	 fidxPos=0;
	 fidxCols = 0;

	}
    public function end()
	{

	shader.Enable();
	BlendMode.setBlend(currentBlendMode);

	shader.setProjMatrix(Game.camera.projMatrix);
	shader.setViewMatrix(Game.camera.viewMatrix);
	

   
	 HXP.gl.bindBuffer(HXP.gl.ARRAY_BUFFER, this.fvertexBuffer);	
     HXP.gl.bufferSubData(HXP.gl.ARRAY_BUFFER, 0, this.fvertices);
     HXP.gl.vertexAttribPointer(shader.vertexAttribute, 3, HXP.gl.FLOAT, false, 0, 0);
	 HXP.gl.bindBuffer(HXP.gl.ARRAY_BUFFER, this.fcolorBuffer);
	 HXP.gl.bufferSubData(HXP.gl.ARRAY_BUFFER, 0, this.fcolors);
     HXP.gl.vertexAttribPointer(shader.colorAttribute, 4, HXP.gl.FLOAT, false, 0, 0);
 	 HXP.gl.drawArrays( HXP.gl.TRIANGLES, 0, Std.int(fidxPos / 3));

	 
	 
	 HXP.gl.bindBuffer(HXP.gl.ARRAY_BUFFER, this.vertexBuffer);	
     HXP.gl.bufferSubData(HXP.gl.ARRAY_BUFFER, 0, this.vertices);
     HXP.gl.vertexAttribPointer(shader.vertexAttribute, 3, HXP.gl.FLOAT, false, 0, 0);
	 HXP.gl.bindBuffer(HXP.gl.ARRAY_BUFFER, this.colorBuffer);
	 HXP.gl.bufferSubData(HXP.gl.ARRAY_BUFFER, 0, this.colors);
     HXP.gl.vertexAttribPointer(shader.colorAttribute, 4, HXP.gl.FLOAT, false, 0, 0);
	 HXP.gl.drawArrays(HXP.gl.LINES, 0, Std.int(idxPos / 3));
  
	
	}


	
	//**********
	public function circle (x:Float, y:Float, radius:Float , segments:Int,r:Float,g:Float,b:Float,?a:Float=1 ) 
	{
	
		var angle:Float = 2 * 3.1415926 / segments;
		var cos:Float = Math.cos(angle);
		var sin:Float = Math.sin(angle);
		var cx:Float = radius;
		var cy:Float = 0;
		for ( i  in 0...segments)
		 {
	
				vertex(x + cx, y + cy, 0);color(r, g, b, a);
				var temp = cx;
				cx = cos * cx - sin * cy;
				cy = sin * temp + cos * cy;
				
				vertex(x + cx, y + cy, 0);color(r, g, b, a);
			}
			
			vertex(x + cx, y + cy, 0);color(r, g, b, a);
			
			vertex(x, y, 0);color(r, g, b, a);
			
			vertex(x + cx, y + cy, 0);color(r, g, b, a);
		

		var temp:Float = cx;
		cx = radius;
		cy = 0;
		
		vertex(x + cx, y + cy, 0);color(r, g, b, a);
	}
public function fillcircle (x:Float, y:Float, radius:Float , segments:Int,r:Float,g:Float,b:Float,?a:Float=1 ) 
	{
	
		var angle:Float = 2 * 3.1415926 / segments;
		var cos:Float = Math.cos(angle);
		var sin:Float = Math.sin(angle);
		var cx:Float = radius;
		var cy:Float = 0;
		segments--;
		for ( i  in 0...segments)
		 {
				fvertex(x, y, 0);fcolor(r, g, b, a);
				fvertex(x + cx, y + cy, 0);fcolor(r, g, b, a);
				var temp:Float = cx;
				cx = cos * cx - sin * cy;
				cy = sin * temp + cos * cy;

				fvertex(x + cx, y + cy, 0);fcolor(r, g, b, a);
				
			}
		
			
	
			fvertex(x, y, 0);fcolor(r, g, b, a);
			fvertex(x + cx, y + cy, 0);fcolor(r, g, b, a);
		

		var temp:Float = cx;
		cx = radius;
		cy = 0;
		
		fvertex(x + cx, y + cy, 0);fcolor(r, g, b, a);
	}

	public function ellipse ( x:Float, y:Float, width:Float, height:Float, segments:Int,r:Float,g:Float,b:Float,?a:Float=1 ) 
	{
	
		var  angle:Float = 2 * 3.1415926/ segments;

		var cx:Float = x + width / 2; 
		var cy:Float = y + height / 2;
		

			for (i in 0... segments)
			{
	
				vertex(cx + (width * 0.5 * Math.cos(i * angle)), cy + (height * 0.5 * Math.sin(i * angle)), 0);
				color(r, g, b, a);

		
				vertex(cx + (width * 0.5 * Math.cos((i + 1) * angle)),cy + (height * 0.5 * Math.sin((i + 1) * angle)), 0);
				color(r, g, b, a);
			}
		
	}
	public function fillellipse ( x:Float, y:Float, width:Float, height:Float, segments:Int,r:Float,g:Float,b:Float,?a:Float=1 ) 
	{
	
		var  angle:Float = 2 * 3.1415926/ segments;

		var cx:Float = x + width / 2; 
		var cy:Float = y + height / 2;
		

			for (i in 0... segments)
			{
	
				fvertex(cx + (width * 0.5 * Math.cos(i * angle)), cy + (height * 0.5 * Math.sin(i * angle)), 0);
				fcolor(r, g, b, a);

		     	fvertex(cx ,cy, 0);
				fcolor(r, g, b, a);
				
				fvertex(cx + (width * 0.5 * Math.cos((i + 1) * angle)),cy + (height * 0.5 * Math.sin((i + 1) * angle)), 0);
				fcolor(r, g, b, a);
			}
		
	}	
public function line(x1:Float,y1:Float,x2:Float,y2:Float,r:Float,g:Float,b:Float,?a:Float=1)
{

vertex(x1, y1);
color(r, g, b, a);
vertex(x2, y2);
color(r, g, b, a);
}

public function rect(x:Float,y:Float,width:Float,height:Float,r:Float,g:Float,b:Float,?a:Float=1)
{
			vertex(x, y, 0);color(r, g, b, a);
			vertex(x + width, y, 0);color(r, g, b, a);
			vertex(x + width, y, 0);color(r, g, b, a);
			vertex(x + width, y + height, 0);color(r, g, b, a);
			vertex(x + width, y + height, 0);color(r, g, b, a);
			vertex(x, y + height, 0);color(r, g, b, a);
			vertex(x, y + height, 0);color(r, g, b, a);
			vertex(x, y, 0);color(r, g, b, a);
}

public function fillrect(x:Float,y:Float,width:Float,height:Float,r:Float,g:Float,b:Float,?a:Float=1)
{
		
			fvertex(x, y, 0);fcolor(r, g, b, a);
			fvertex(x + width, y, 0);fcolor(r, g, b, a);
			fvertex(x + width, y + height, 0);fcolor(r, g, b, a);
			fvertex(x + width, y + height, 0);fcolor(r, g, b, a);
			fvertex(x, y + height, 0);fcolor(r, g, b, a);
			fvertex(x, y, 0);fcolor(r, g, b, a);
}
 public function dispose():Void 
{
		this.vertices = null;
		this.colors = null;
    	HXP.gl.deleteBuffer(vertexBuffer);
		HXP.gl.deleteBuffer(colorBuffer);
	
		this.fvertices = null;
		this.fcolors = null;
    	HXP.gl.deleteBuffer(fvertexBuffer);
		HXP.gl.deleteBuffer(fcolorBuffer);

}

///****************************************FLASH COMPA
public function lineStyle(thickness:Float = 0, color:Int = 0, alpha:Float = 1.0):Void
{
	     this.alpha = alpha;
      	color &= 0xFFFFFF;
	    _red = HXP.getRed(color) / 255;
		_green = HXP.getGreen(color) / 255;
		_blue = HXP.getBlue(color) / 255;
}
public function beginFill(color:Int = 0, alpha:Float = 1.0):Void
{
	    this.alpha = alpha;
      	color &= 0xFFFFFF;
	    _red = HXP.getRed(color) / 255;
		_green = HXP.getGreen(color) / 255;
		_blue = HXP.getBlue(color) / 255;
}
public function endFill():Void
{
	    
}

public function drawRect(x:Float, y:Float, width:Float, height:Float):Void
{
rect(x, y, width, height, _red, _green, _blue, alpha);
}

public function moveTo(x:Float, y:Float):Void
{
cp.set(x, y);
}
public function lineTo(x:Float, y:Float):Void
{
	line(cp.x, cp.y,x,y,_red,_green,_blue,alpha);
	cp.set(x, y);

}
public function drawCircle(x:Float, y:Float,radius:Float):Void
{
circle(x,y,radius,12,_red, _green, _blue, alpha);
}



}