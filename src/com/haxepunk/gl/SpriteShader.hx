package com.haxepunk.gl;



import openfl.display.Bitmap;
import openfl.geom.Matrix;
import openfl.geom.Matrix3D;
import openfl.geom.Point;
import lime.graphics.opengl.GLBuffer;
import lime.graphics.opengl.GLProgram;
import lime.graphics.opengl.GLShader;
import lime.graphics.opengl.GLUniformLocation;
import lime.utils.Float32Array;
import lime.utils.Int16Array;



import com.haxepunk.gl.filter.Filter;
import com.haxepunk.gl.Game;

/**
 * ...
 * @author djoker
 */
class SpriteShader
{
private var shaderProgram:GLProgram;
	
 public var m:Float32Array;

 public var projectionMatrixUniform:Dynamic;
 public var modelViewMatrixUniform:Dynamic;
 public var imageUniform:Dynamic;
 public var invertUniform:Dynamic;


	
	public function new() 
	{


   m = new Float32Array(16);

 
var vertexShader = HXP.gl.createShader (HXP.gl.VERTEX_SHADER);
HXP.gl.shaderSource (vertexShader, Filter.textureVertexShader);
HXP.gl.compileShader (vertexShader);

if (HXP.gl.getShaderParameter (vertexShader, HXP.gl.COMPILE_STATUS) == 0) 
{

throw (HXP.gl.getShaderInfoLog(vertexShader));

}

var fragmentShader = HXP.gl.createShader (HXP.gl.FRAGMENT_SHADER);
HXP.gl.shaderSource (fragmentShader, Filter.textureFragmentShader);
HXP.gl.compileShader (fragmentShader);

if (HXP.gl.getShaderParameter (fragmentShader, HXP.gl.COMPILE_STATUS) == 0) {

 throw(HXP.gl.getShaderInfoLog(fragmentShader));

}

shaderProgram = HXP.gl.createProgram ();
HXP.gl.attachShader (shaderProgram, vertexShader);
HXP.gl.attachShader (shaderProgram, fragmentShader);
HXP.gl.linkProgram (shaderProgram);

if (HXP.gl.getProgramParameter (shaderProgram, HXP.gl.LINK_STATUS) == 0) {


throw "Unable to initialize the shader program.";
}

Filter.vertexAttribute = HXP.gl.getAttribLocation (shaderProgram, "aVertexPosition");
//HXP.gl.bindAttribLocation(shaderProgram,Filter.vertexAttribute,"aVertexPosition");
Filter.texCoordAttribute = HXP.gl.getAttribLocation (shaderProgram, "aTexCoord");
//HXP.gl.bindAttribLocation(shaderProgram,Filter.texCoordAttribute,"aTexCoord");
Filter.colorAttribute = HXP.gl.getAttribLocation (shaderProgram, "aColor");
//HXP.gl.bindAttribLocation(shaderProgram,Filter.colorAttribute,"aColor");
projectionMatrixUniform = HXP.gl.getUniformLocation (shaderProgram, "uProjectionMatrix");
modelViewMatrixUniform = HXP.gl.getUniformLocation (shaderProgram, "uModelViewMatrix");
imageUniform = HXP.gl.getUniformLocation (shaderProgram, "uImage0");
//invertUniform = HXP.gl.getUniformLocation (shaderProgram, "invert");
//HXP.gl.uniform1f (invertUniform, 1);

 		
	}

	public function Enable()
	{
	   HXP.gl.useProgram (shaderProgram);
	   
       HXP.gl.enableVertexAttribArray (Filter.vertexAttribute);
       HXP.gl.enableVertexAttribArray (Filter.texCoordAttribute);
	   HXP.gl.enableVertexAttribArray (Filter.colorAttribute);
	}
	public function Disable()
	{
       HXP.gl.disableVertexAttribArray (Filter.vertexAttribute);
       HXP.gl.disableVertexAttribArray (Filter.texCoordAttribute);
	   HXP.gl.disableVertexAttribArray (Filter.colorAttribute);
	   HXP.gl.useProgram (null);
	
	}
	public function dispose()
	{
		HXP.gl.deleteProgram(shaderProgram);

	}
	public function setTexture(tex:Texture)
	{
		if (tex != null)
		{
 	     tex.Bind();
		 HXP.gl.uniform1i (imageUniform, 0);
         
		}
	}
	public function setMatrix()
	{
   // HXP.gl.uniformMatrix3D(projectionMatrixUniform, false,Game.camera.projMatrix);
   // HXP.gl.uniformMatrix3D(modelViewMatrixUniform, false, Game.camera.viewMatrix);
	}
	public function setProjMatrix(mat:Matrix3D)
	{
   // HXP.gl.uniformMatrix3D(projectionMatrixUniform, false,null);

		 for (index in 0...16) 
		 {
            m[index] = mat.rawData[index];
        }
	   HXP.gl.uniformMatrix4fv(projectionMatrixUniform, false,  m);
	   
	    //new Float32Array
	
   	}
	public function setViewMatrix(mat:Matrix3D)
	{ 
		// var m:Float32Array = new Float32Array(16);
		 for (index in 0...16) 
		 {
            m[index] = mat.rawData[index];
        }
	   HXP.gl.uniformMatrix4fv(modelViewMatrixUniform, false, m);
	
    //HXP.gl.uniformMatrix3D(modelViewMatrixUniform, false, mat);

	}
}