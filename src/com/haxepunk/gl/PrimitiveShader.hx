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


/**
 * ...
 * @author djoker
 */
class PrimitiveShader
{
private var shaderProgram:GLProgram;
	
 public var vertexAttribute :Int;
 public var colorAttribute :Int;
 public var projectionMatrixUniform:Dynamic;
 public var modelViewMatrixUniform:Dynamic;
 public var m:Float32Array;


	
	public function new() 
	{

   m = new Float32Array(16);

var vertexShader = HXP.gl.createShader (HXP.gl.VERTEX_SHADER);
HXP.gl.shaderSource (vertexShader, Filter.colorVertexShader);
HXP.gl.compileShader (vertexShader);

if (HXP.gl.getShaderParameter (vertexShader, HXP.gl.COMPILE_STATUS) == 0) 
{

throw (HXP.gl.getShaderInfoLog(vertexShader));

}


var fragmentShader = HXP.gl.createShader (HXP.gl.FRAGMENT_SHADER);
HXP.gl.shaderSource (fragmentShader, Filter.colorFragmentShader);
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

vertexAttribute = HXP.gl.getAttribLocation (shaderProgram, "aVertexPosition");
colorAttribute = HXP.gl.getAttribLocation (shaderProgram, "aColor");
projectionMatrixUniform = HXP.gl.getUniformLocation (shaderProgram, "uProjectionMatrix");
modelViewMatrixUniform = HXP.gl.getUniformLocation (shaderProgram, "uModelViewMatrix");

 		
	}

	public function Enable()
	{
	   HXP.gl.useProgram (shaderProgram);
       HXP.gl.enableVertexAttribArray (vertexAttribute);
	   HXP.gl.enableVertexAttribArray (colorAttribute);


	}
	public function Disable()
	{
		HXP.gl.disableVertexAttribArray (vertexAttribute);
		HXP.gl.disableVertexAttribArray (colorAttribute);
		HXP.gl.useProgram (null);
	}
		public function dispose()
	{
		HXP.gl.deleteProgram(shaderProgram);

	}
	public function setProjMatrix(mat:Matrix3D)
	{
   // HXP.gl.uniformMatrix3D(projectionMatrixUniform, false,null);
 
		 for (index in 0...16) 
		 {
            m[index] = mat.rawData[index];
        }
	   HXP.gl.uniformMatrix4fv(projectionMatrixUniform, false, m);
	   
	   	//HXP.gl.uniformMatrix4fv(uniform, false, #if html5 matrix.toArray() #else new Float32Array(matrix.toArray()) #end );
		
	
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