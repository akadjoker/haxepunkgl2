package com.haxepunk.gl;


import lime.graphics.opengl.GLBuffer;
import lime.graphics.opengl.GLProgram;
import lime.graphics.opengl.GLShader;


/**
 * ...
 * @author djoker
 */
class BlendMode
{

	public static inline var NORMAL:Int      = 0;
	public static inline var ADD:Int         = 1;
	public static inline var MULTIPLY:Int    = 2;
	public static inline var SCREEN:Int      = 3;
	public static inline var TRANSPARENT:Int      = 4;
	public static inline var OPAQUE:Int      = 5;
	public static inline var ADDMINS:Int      = 6;



static 	public function setBlend(mode:Int ) 
	{
		
	 switch( mode ) {
	
    case BlendMode.NORMAL:
		HXP.gl.blendFunc(HXP.gl.SRC_ALPHA,HXP.gl.ONE_MINUS_SRC_ALPHA );
    case BlendMode.ADD:
        HXP.gl.blendFunc(HXP.gl.SRC_ALPHA, HXP.gl.DST_ALPHA );
	case BlendMode.MULTIPLY:
        HXP.gl.blendFunc(HXP.gl.DST_COLOR,HXP.gl.ONE_MINUS_SRC_ALPHA );
    case BlendMode.SCREEN:
       HXP.gl.blendFunc(HXP.gl.SRC_ALPHA, HXP.gl.ZERO );	
	case BlendMode.TRANSPARENT:   
		HXP.gl.blendFunc(HXP.gl.ONE, HXP.gl.ONE_MINUS_SRC_ALPHA );	
	case BlendMode.OPAQUE:   
		HXP.gl.blendFunc(HXP.gl.ONE, HXP.gl.ZERO );	
	case BlendMode.ADDMINS:   
		HXP.gl.blendFunc(HXP.gl.SRC_ALPHA, HXP.gl.ONE );	    
		default:
        HXP.gl.blendFunc(HXP.gl.ONE, HXP.gl.ONE_MINUS_SRC_ALPHA );
		
    }

}
	
	
	
	
		
	
}