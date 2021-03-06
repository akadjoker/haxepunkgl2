package com.haxepunk.math;

import flash.geom.Matrix;
import flash.geom.Point;


class Vector2 {
	
	public var x:Float;
	public var y:Float;
		

	static public function Sub(a:Vector2, b:Vector2):Vector2
	{
		return new Vector2(a.x - b.x, a.y - b.y);
	}
	static public function Add(a:Vector2, b:Vector2):Vector2
	{
		return new Vector2(a.x + b.x, a.y + b.y);
	}
	
	public function new(x:Float, y:Float) {
		this.x = x;
		this.y = y;
	}
	
	public function set(x:Float, y:Float) {
		this.x = x;
		this.y = y;
	}	
	public function toString():String {
		return "{X: " + this.x + " Y:" + this.y + "}";
	}

	// Operators
    inline public function add(otherVector:Vector2):Vector2 {
		return new Vector2(this.x + otherVector.x, this.y + otherVector.y);
	}	
	
	inline public function asArray():Array<Float> {
        var result = [];
        this.toArray(result, 0);
        return result;
    }

    inline public function toArray(array:Array<Float>, index:Int = 0) {
        array[index] = this.x;
        array[index + 1] = this.y;
    }
    
	inline public function subtract(otherVector:Vector2):Vector2 {
		return new Vector2(this.x - otherVector.x, this.y - otherVector.y);
	}
	
    inline public function negate():Vector2{
		return new Vector2( -this.x, -this.y);
	}
	
    inline public function scaleInPlace(scale:Float) {
		this.x *= scale;
		this.y *= scale;
	}
	
    inline public function scale(scale:Float):Vector2 {
		return new Vector2(this.x * scale, this.y * scale);
	}
	
    inline public function equals(otherVector:Vector2):Bool {
		return this.x == otherVector.x && this.y == otherVector.y;
	}
	
    inline public function length():Float {
		return Math.sqrt(this.x * this.x + this.y * this.y);
	}
	
    inline public function lengthSquared():Float {
		return (this.x * this.x + this.y * this.y);
	}
	
    inline public function normalize() {
		var len = length();

        if (len != 0) {
			var num = 1.0 / len;

			this.x *= num;
			this.y *= num;
		}
	}
	
    inline public function clone():Vector2 {
		return new Vector2(this.x, this.y);
	}
	
	
	// Statics
    inline public static function Zero():Vector2 {
		return new Vector2(0, 0);
	}
	
    inline public static function CatmullRom(value1:Vector2, value2:Vector2, value3:Vector2, value4:Vector2, amount:Float):Vector2 {
		var squared = amount * amount;
        var cubed = amount * squared;

        var x = 0.5 * ((((2.0 * value2.x) + ((-value1.x + value3.x) * amount)) +
                (((((2.0 * value1.x) - (5.0 * value2.x)) + (4.0 * value3.x)) - value4.x) * squared)) +
            ((((-value1.x + (3.0 * value2.x)) - (3.0 * value3.x)) + value4.x) * cubed));

        var y = 0.5 * ((((2.0 * value2.y) + ((-value1.y + value3.y) * amount)) +
                (((((2.0 * value1.y) - (5.0 * value2.y)) + (4.0 * value3.y)) - value4.y) * squared)) +
            ((((-value1.y + (3.0 * value2.y)) - (3.0 * value3.y)) + value4.y) * cubed));

        return new Vector2(x, y);
	}
	
    inline public static function Clamp(value:Vector2, min:Vector2, max:Vector2):Vector2 {
		var x = value.x;
        x = (x > max.x) ? max.x : x;
        x = (x < min.x) ? min.x : x;

        var y = value.y;
        y = (y > max.y) ? max.y : y;
        y = (y < min.y) ? min.y : y;

        return new Vector2(x, y);
	}
	
    inline public static function Hermite(value1:Vector2, tangent1:Vector2, value2:Vector2, tangent2:Vector2, amount:Float):Vector2 {
		var squared = amount * amount;
        var cubed = amount * squared;
        var part1 = ((2.0 * cubed) - (3.0 * squared)) + 1.0;
        var part2 = (-2.0 * cubed) + (3.0 * squared);
        var part3 = (cubed - (2.0 * squared)) + amount;
        var part4 = cubed - squared;

        var _x = (((value1.x * part1) + (value2.x * part2)) + (tangent1.x * part3)) + (tangent2.x * part4);
        var _y = (((value1.y * part1) + (value2.y * part2)) + (tangent1.y * part3)) + (tangent2.y * part4);

        return new Vector2(_x, _y);
	}
	
    inline public static function Lerp(start:Vector2, end:Vector2, amount:Float):Vector2 {
		var _x:Float = start.x + ((end.x - start.x) * amount);
        var _y:Float = start.y + ((end.y - start.y) * amount);

        return new Vector2(_x, _y);
	}
	
    inline public static function Dot(left:Vector2, right:Vector2):Float {
		return left.x * right.x + left.y * right.y;
	}
	
    inline public static function Normalize(vector:Vector2):Vector2 {
		var newVector = vector.clone();
        newVector.normalize();
        return newVector;
	}
	
    inline public static function Minimize(left:Vector2, right:Vector2):Vector2 {
		var _x = (left.x < right.x) ? left.x : right.x;
        var _y = (left.y < right.y) ? left.y : right.y;

        return new Vector2(_x, _y);
	}
	
    inline public static function Maximize(left:Vector2, right:Vector2):Vector2 {
		var _x = (left.x > right.x) ? left.x : right.x;
        var _y = (left.y > right.y) ? left.y : right.y;

        return new Vector2(_x, _y);
	}
	/*
    inline public static function Transform(vector:Vector2, transformation:Matrix):Vector2 {
		var _x = (vector.x * transformation.m[0]) + (vector.y * transformation.m[4]);
        var _y = (vector.x * transformation.m[1]) + (vector.y * transformation.m[5]);

        return new Vector2(_x, _y);
	}
	*/
    inline public static function Distance(value1:Vector2, value2:Vector2):Float {
		return Math.sqrt(Vector2.DistanceSquared(value1, value2));
	}
	
    inline public static function DistanceSquared(value1:Vector2, value2:Vector2):Float {
		var _x = value1.x - value2.x;
        var _y = value1.y - value2.y;

        return (_x * _x) + (_y * _y);
	}
	 inline public static function Angle(value1:Vector2, value2:Vector2):Float 
	 {
	return Math.atan2(value2.y - value1.y, value2.x - value1.x) ;
	}
	
	
		
}
