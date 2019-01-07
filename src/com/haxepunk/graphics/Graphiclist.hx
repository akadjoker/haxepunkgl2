package com.haxepunk.graphics;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.Graphic;
import flash.display.BitmapData;
import flash.geom.Matrix3D;
import flash.geom.Point;
import openfl.geom.Matrix;

/**
 * A Graphic that can contain multiple Graphics of one or various types.
 * Useful for drawing sprites with multiple different parts, etc.
 */
class Graphiclist extends Graphic
{
	/**
	 * Constructor.
	 * @param	...graphic		Graphic objects to add to the list.
	 */
	public function new(graphic:Array<Dynamic> = null)
	{
		_graphics = new Array<Graphic>();
		_temp = new Array<Graphic>();
		_camera = new Point();
		_count = 0;

		super();

		if (graphic != null)
		{
			for (g in graphic) if (cast(g, Graphic) != null) add(g);
		}
	}

	/** @private Updates the graphics in the list. */
	override public function update()
	{
		for (g in _graphics)
		{
			if (g.active) g.update();
		}
	}

	private inline function renderList(renderFunc:Graphic->Void, point:Point, camera:Point)
	{
		

		for (g in _graphics)
		{
			if (g.visible)
			{
			
				renderFunc(g);
			}
		}
	}



	/** @private Renders the Graphics in the list. */
	override public function render(m:Matrix, point:Point, camera:Point)
	{
		renderList(function(g:Graphic) {
			g.render(m, point,_camera);
		},point,  camera);
	}

	/**
	 * Destroys the list of graphics
	 */
	override public function destroy()
	{
		for (g in _graphics)
		{
			g.destroy();
		}
	}

	/**
	 * Adds the Graphic to the list.
	 * @param	graphic		The Graphic to add.
	 * @return	The added Graphic.
	 */
	public function add(graphic:Graphic):Graphic
	{
		if (graphic == null) return graphic;


		_graphics[_count ++] = graphic;
		if (!active) active = graphic.active;
		return graphic;
	}

	/**
	 * Removes the Graphic from the list.
	 * @param	graphic		The Graphic to remove.
	 * @return	The removed Graphic.
	 */
	public function remove(graphic:Graphic):Graphic
	{
		if (HXP.indexOf(_graphics, graphic) < 0) return graphic;
		HXP.clear(_temp);

		for (g in _graphics)
		{
			if (g == graphic) _count --;
			else _temp[_temp.length] = g;
		}
		var temp:Array<Graphic> = _graphics;
		_graphics = _temp;
		_temp = temp;
		updateCheck();
		return graphic;
	}

	/**
	 * Removes the Graphic from the position in the list.
	 * @param	index		Index to remove.
	 */
	public function removeAt(index:Int = 0)
	{
		if (_graphics.length == 0) return;
		index %= _graphics.length;
		remove(_graphics[index % _graphics.length]);
		updateCheck();
	}

	/**
	 * Removes all Graphics from the list.
	 */
	public function removeAll()
	{
		HXP.clear(_graphics);
		HXP.clear(_temp);
		_count = 0;
		active = false;
	}

	/**
	 * All Graphics in this list.
	 */
	public var children(get, null):Array<Graphic>;
	private function get_children():Array<Graphic> { return _graphics; }

	/**
	 * Amount of Graphics in this list.
	 */
	public var count(get, null):Int;
	private function get_count():Int { return _count; }

	/**
	 * Check if the Graphiclist should update.
	 */
	private function updateCheck()
	{
		active = false;
		for (g in _graphics)
		{
			if (g.active)
			{
				active = true;
				return;
			}
		}
	}

	// List information.
	private var _graphics:Array<Graphic>;
	private var _temp:Array<Graphic>;
	private var _count:Int;
	private var _camera:Point;
}
