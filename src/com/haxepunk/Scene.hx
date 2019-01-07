package com.haxepunk;

import com.haxepunk.gl.Game;
import com.haxepunk.gl.SpriteBatch;
import com.haxepunk.gl.Texture;
import com.haxepunk.graphics.SpriteSheet;
import com.haxepunk.graphics.Graphiclist;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Util;
import flash.display.Sprite;
import flash.geom.Point;
import com.haxepunk.Entity;
import com.haxepunk.Tweener;
import flash.geom.Rectangle;
import haxe.ds.IntMap;

  typedef TFadeComplete = Void->Void;
  
/**
 * Updated by Engine, main game container that holds all currently active Entities.
 * Useful for organization, eg. "Menu", "Level1", etc.
 */
class Scene extends Tweener
{
	private var folowActor:Entity;
	private var folowSpeed:Float;
	private var folowClip:Bool;
	
	public var minCameraX:Float;
	public var minCameraY:Float;
	public var maxCameraX:Float;
	public var maxCameraY:Float;
	public var cameraOffCetX:Float;
	public var cameraOffCetY:Float;
	
	private var FadeColor:Int;
	private var FadeDuration:Float;
	private var FadeAlpha:Float;
	private var FadeComplete:TFadeComplete;
	private var FadeIn:Bool;
	private var FadeEnd:Bool;
	private var FadeMin:Float;
	private var FadeMax:Float;
	


	/**
	 * Point used to determine drawing offset in the render loop.
	 */
	public var camera:Point;

	/**
	 * Constructor.
	 */
	public function new()
	{
		super();
		visible = true;
		camera = new Point();
		sprite = new Sprite();
		_count = 0;
		folowActor = null;
		 minCameraX = 0;
	 minCameraY = 0;
	 maxCameraX = HXP.width;
	 maxCameraY = HXP.height;
	 cameraOffCetX = 0;
	 cameraOffCetY = 0;
	 

		_layerList = new Array<Int>();
		_layerCount = new Map<Int, Int>();

		//_layers= new  Array <SpriteSheet>();
		
		_add = new Array<Entity>();
		_remove = new Array<Entity>();
		_recycle = new Array<Entity>();

		_layerDisplay = new Map<Int,Bool>();
		_renderFirst = new Map<Int,Entity>();
		_renderLast = new Map<Int,Entity>();
		_typeFirst = new Map<String,Entity>();

		_classCount = new Map<String,Int>();
		_typeCount = new Map<String,Int>();
		_recycled = new Map<String,Entity>();
		_entityNames = new Map<String,Entity>();
		
			FadeColor=0;
	FadeDuration = 1;
	FadeAlpha=0;
	FadeComplete = null;
	FadeIn = false;
	FadeEnd = true;
	FadeMin = 0;
	FadeMax = 1;
	}

	public function getTexture(fname:String, ?flip:Bool=false):Texture
	{
		if (HXP.engine == null)
		{
			trace("engine is null");
			return null;
		}
		if (HXP.engine.game==null)
		{
			trace("game is null");
			return null;
		}
		
		 return HXP.engine.game.getTexture(fname, flip);
		 
	}
	
	public function setCameraBounds(minx:Float, miny:Float, maxx:Float, maxy:Float, offx:Float, offy:Float)
	{
	 minCameraX = minx;
	 minCameraY = miny;
	 maxCameraX = maxx;
	 maxCameraY = maxy;
	 cameraOffCetX = offx;
	 cameraOffCetY = offy;
	 	
	}
	public function cameraFolow(actor:Entity,speed:Float,clip:Bool)
	{
		folowActor = actor;
		folowSpeed = speed;
		folowClip = clip;
		
		
	}
	
	/**
	 * Override this; called when Scene is switch to, and set to the currently active scene.
	 */
	public function begin() { }

	/**
	 * Override this; called when Scene is changed, and the active scene is no longer this.
	 */
	public function end() { }

	/**
	 * Override this, called when game gains focus
	 */
	public function focusGained() { }

	/**
	 * Override this, called when game loses focus
	 */
	public function focusLost() { }

	/**
	 * Performed by the game loop, updates all contained Entities.
	 * If you override this to give your Scene update code, remember
	 * to call super.update() or your Entities will not be updated.
	 */
	override public function update()
	{
		// update the entities
		var e:Entity = _updateFirst;
		while (e != null)
		{
			if (e.active)
			{
				if (e.hasTween) e.updateTweens();
				if (e.graphic != null)
				{
					e.graphic.update();
				}
				e.update();
				e.act(HXP.elapsed);
			}
			
			e = e._updateNext;
		}
	updateCamera();
	}
	
	public function updateCamera():Void
	{
		if (folowActor != null)
		{
			
		HXP.camera.x =  HXP.lerp(HXP.camera.x, (folowActor.x - cameraOffCetX), HXP.elapsed * folowSpeed);
		HXP.camera.y =  HXP.lerp(HXP.camera.y, (folowActor.y - cameraOffCetY), HXP.elapsed * folowSpeed);
		
		
		 
		if (folowClip)
		{
		HXP.camera.x = Util.bound(Math.round(HXP.camera.x), minCameraX, maxCameraX);
		HXP.camera.y = Util.bound(Math.round(HXP.camera.y), minCameraY, maxCameraY);
		}
		}
}

	/**
	 * Toggles the visibility of a layer
	 * @param layer the layer to show/hide
	 * @param show whether to show the layer (default: true)
	 */
	public inline function showLayer(layer:Int, show:Bool=true):Void
	{
		_layerDisplay.set(layer, show);
	}

	/**
	 * Checks if a layer is visible or not
	 */
	public inline function layerVisible(layer:Int):Bool
	{
		return !_layerDisplay.exists(layer) || _layerDisplay.get(layer);
	}

	/**
	 * Sorts layer from highest value to lowest
	 */
	private function layerSort(a:Int, b:Int):Int
	{
		return b - a;
	}

	/**
	 * Performed by the game loop, renders all contained Entities.
	 * If you override this to give your Scene render code, remember
	 * to call super.render() or your Entities will not be rendered.
	 */
	public function renderFades()
	{
			
	  if (!FadeEnd)
	  {
		  
		var   r:Float = HXP.getRed(FadeColor) / 255;
		var   g:Float = HXP.getGreen(FadeColor) / 255;
		var   b:Float = HXP.getBlue(FadeColor) / 255;
		
		  
       if (FadeIn)
	   {
        if((FadeAlpha > 0.0) && (FadeAlpha < 1.0))
		{
			FadeAlpha += HXP.elapsed /FadeDuration ;
			
			if(FadeAlpha >= 1.0)
			{
				FadeAlpha = 1.0;
				if (FadeComplete != null)
				{
					FadeComplete();
					
				}
				FadeEnd = true;
			} 
			

	 Game.lines.fillrect(0,0,HXP.windowWidth, HXP.windowHeight,r,g,b,FadeAlpha);
	
    	}
	} else //else fade out
	{
		
		 if((FadeAlpha > 0.0) )
		{
			FadeAlpha -= HXP.elapsed /FadeDuration ;
			
			if(FadeAlpha <= 0.0)
			{
				FadeAlpha = 0.0;
				if (FadeComplete != null)
				{
					FadeComplete();
					
				}
				FadeEnd = true;
			} 
			
			Game.lines.fillrect(0,0,HXP.windowWidth, HXP.windowHeight,r,g,b,FadeAlpha);
		}
	}
	  }
	  //*****************
	}
	
	public function setCenter()
	{
		pivotX = HXP.width / 2;
		pivotY = HXP.height / 2;
		x = HXP.width / 2;
		y = HXP.height / 2;
	}
	/**
	 * Performed by the game loop, renders all contained Entities.
	 * If you override this to give your Scene render code, remember
	 * to call super.render() or your Entities will not be rendered.
	 */
	public function preRender()
	{
		
	}
	public function preRenderBatch(batch:SpriteBatch)
	{
		
	}
	public function render()
	{
		// sort the depth list
		if (_layerSort)
		{
			if (_layerList.length > 1) _layerList.sort(layerSort);
			_layerSort = false;
		}
		
	

		// render the entities in order of depth
		var e:Entity;
		for (layer in _layerList)
		{
			if (!layerVisible(layer)) continue;
			e = _renderLast.get(layer);
			while (e != null)
			{
				
				if (e.visible) e.render();
				e = e._renderPrev;
			}
		}

	

	
	
	}
	
		public function renderEntityLines()
	{
		
		
	

		// render the entities in order of depth
		var e:Entity;
		for (layer in _layerList)
		{
			if (!layerVisible(layer)) continue;
			e = _renderLast.get(layer);
			while (e != null)
			{
				e.renderLines(Game.lines);
				
				
				 if (HXP.debugEntityBound)
				 {
						var sx:Float = HXP.screen.fullScaleX;
				        var sy:Float = HXP.screen.fullScaleY;
				
					 var graphicScrollX = e.graphic != null ? e.graphic.scrollX : 1;
				     var graphicScrollY = e.graphic != null ? e.graphic.scrollY : 1;
					 if (e.width != 0 && e.height != 0)
				{
					
					 Game.lines.rect((e.x - e.originX - HXP.camera.x * graphicScrollX) * sx, (e.y - e.originY - HXP.camera.y * graphicScrollY) * sy, e.width * sx, e.height * sy,0,1,1,1);

					if (HXP.debugDrawMask && e.mask != null)
					{
						//g.lineStyle(1, 0x0000FF);
						e.mask.debugDraw( Game.lines, sx, sy);
					}
				}
			
			   	Game.lines.circle((e.x - HXP.camera.x * graphicScrollX) * sx, (e.y - HXP.camera.y * graphicScrollY) * sy, 3,8,1,0,1,1);

				
					// var r = e.getBounds();
				    // Game.lines.rect(r.x, r.y, r.width, r.height, 1, 0, 0, 1);
					// Game.lines.rect(e.centerX, e.centerY, r.width, r.height, 1, 0, 1, 1);
					  
				 }
				e = e._renderPrev;
			}
		}

	
	

	
	
	}
	public function postRenderBatch(batch:SpriteBatch)
	{
		
	}
	public function postRender()
	{
		
	}

	/**
	 * X position of the mouse in the Scene.
	 */
	public var mouseX(get, null):Int;
	private inline function get_mouseX():Int
	{
		return Std.int(HXP.screen.mouseX + camera.x);
	}

	public function touchCircle(cx:Float, cy:Float, r:Float):Bool
	{
	   if (Input.mousePressed)
	   {
	    var 	distance:Float = Math.sqrt((HXP.screen.mouseX - cx) * (HXP.screen.mouseX - cx) + (HXP.screen.mouseY - cy) * (HXP.screen.mouseY - cy));
		return (distance < r);
	   }
	   return false;
	}
	
	public function pointCircle(px:Float,py:Float,cx:Float, cy:Float, r:Float):Bool
	{
	  
	    var 	distance:Float = Math.sqrt((px - cx) * (px- cx) + (py - cy) * (py - cy));
		return (distance < r);
	  
	}
	
	/**
	 * Y position of the mouse in the scene.
	 */
	public var mouseY(get, null):Int;
	private inline function get_mouseY():Int
	{
		return Std.int(HXP.screen.mouseY + camera.y);
	}

	/**
	 * Sprite used to store layer sprites when RenderMode.HARDWARE is set.
	 */
	public var sprite(default, null):Sprite;

	/**
	 * Adds the Entity to the Scene at the end of the frame.
	 * @param	e		Entity object you want to add.
	 * @return	The added Entity object.
	 */
	public function add<E:Entity>(e:E):E
	{
		 e.parent = this;
		_add[_add.length] = e;
		return e;
	}

	/**
	 * Removes the Entity from the Scene at the end of the frame.
	 * @param	e		Entity object you want to remove.
	 * @return	The removed Entity object.
	 */
	public function remove<E:Entity>(e:E):E
	{
		e.parent = null;
		e.removed();
		_remove[_remove.length] = e;
		return e;
	}

	public function clear()
	{
		 this.removeAll();
	     this.clearTweens();
	 
	}
	/**
	 * Removes all Entities from the Scene at the end of the frame.
	 */
	public function removeAll()
	{
		var e:Entity = _updateFirst;
		while (e != null)
		{
			e.parent = null;
			_remove[_remove.length] = e;
			e = e._updateNext;
		}
	}

	/**
	 * Adds multiple Entities to the scene.
	 * @param	...list		Several Entities (as arguments) or an Array/Vector of Entities.
	 */
	public function addList<E:Entity>(list:Iterable<E>)
	{
		for (e in list) add(e);
	}

	/**
	 * Removes multiple Entities from the scene.
	 * @param	...list		Several Entities (as arguments) or an Array/Vector of Entities.
	 */
	public function removeList<E:Entity>(list:Iterable<E>)
	{
		for (e in list) remove(e);
	}

	/**
	 * Adds an Entity to the Scene with the Graphic object.
	 * @param	graphic		Graphic to assign the Entity.
	 * @param	x			X position of the Entity.
	 * @param	y			Y position of the Entity.
	 * @param	layer		Layer of the Entity.
	 * @return	The Entity that was added.
	 */
	public function addGraphic(graphic:Graphic, layer:Int = 0, x:Float = 0, y:Float = 0):Entity
	{
		var e:Entity = new Entity(x, y, graphic);
		e.layer = layer;
	//	e.active = false;
		return add(e);
	}

	/**
	 * Adds an Entity to the Scene with the Mask object.
	 * @param	mask	Mask to assign the Entity.
	 * @param	type	Collision type of the Entity.
	 * @param	x		X position of the Entity.
	 * @param	y		Y position of the Entity.
	 * @return	The Entity that was added.
	 */
	public function addMask(mask:Mask, type:String, x:Int = 0, y:Int = 0):Entity
	{
		var e:Entity = new Entity(x, y, null, mask);
		if (type != "") e.type = type;
		e.active = e.visible = false;
		return add(e);
	}

	/**
	 * Returns a new Entity, or a stored recycled Entity if one exists.
	 * @param	classType			The Class of the Entity you want to add.
	 * @param	addToScene			Add it to the Scene immediately.
	 * @param	constructorsArgs	List of the entity constructor arguments (optional).
	 * @return	The new Entity object.
	 */
	public function create<E:Entity>(classType:Class<E>, addToScene:Bool = true, ?constructorsArgs:Array<Dynamic>):E
	{
		var className:String = Type.getClassName(classType);
		var e:Entity = _recycled.get(className);
		if (e != null)
		{
			_recycled.set(className, e._recycleNext);
			e._recycleNext = null;
		}
		else
		{
			if (constructorsArgs != null)
				e = Type.createInstance(classType, constructorsArgs);
			else
				e = Type.createInstance(classType, []);
		}

		return cast (addToScene ? add(e) : e);
	}

	/**
	 * Removes the Entity from the Scene at the end of the frame and recycles it.
	 * The recycled Entity can then be fetched again by calling the create() function.
	 * @param	e		The Entity to recycle.
	 * @return	The recycled Entity.
	 */
	public function recycle<E:Entity>(e:E):E
	{
		_recycle[_recycle.length] = e;
		return remove(e);
	}

	/**
	 * Clears stored reycled Entities of the Class type.
	 * @param	classType		The Class type to clear.
	 */
	public function clearRecycled<E:Entity>(classType:Class<E>)
	{
		var className:String = Type.getClassName(classType),
			e:Entity = _recycled.get(className),
			n:Entity;
		while (e != null)
		{
			n = e._recycleNext;
			e._recycleNext = null;
			e = n;
		}
		_recycled.remove(className);
	}

	/**
	 * Clears stored recycled Entities of all Class types.
	 */
	public function clearRecycledAll()
	{
		var e:Entity;
		for (e in _recycled)
		{
			clearRecycled(Type.getClass(e));
		}
	}

	/**
	 * Brings the Entity to the front of its contained layer.
	 * @param	e		The Entity to shift.
	 * @return	If the Entity changed position.
	 */
	public function bringToFront(e:Entity):Bool
	{
		if (e._scene != this || e._renderPrev == null) return false;
		// pull from list
		e._renderPrev._renderNext = e._renderNext;
		if (e._renderNext != null) e._renderNext._renderPrev = e._renderPrev;
		else _renderLast.set(e._layer, e._renderPrev);
		// place at the start
		e._renderNext = _renderFirst.get(e._layer);
		e._renderNext._renderPrev = e;
		_renderFirst.set(e._layer, e);
		e._renderPrev = null;
		return true;
	}

	/**
	 * Sends the Entity to the back of its contained layer.
	 * @param	e		The Entity to shift.
	 * @return	If the Entity changed position.
	 */
	public function sendToBack(e:Entity):Bool
	{
		if (e._scene != this || e._renderNext == null) return false;
		// pull from list
		e._renderNext._renderPrev = e._renderPrev;
		if (e._renderPrev != null) e._renderPrev._renderNext = e._renderNext;
		else _renderFirst.set(e._layer, e._renderNext);
		// place at the end
		e._renderPrev = _renderLast.get(e._layer);
		e._renderPrev._renderNext = e;
		_renderLast.set(e._layer, e);
		e._renderNext = null;
		return true;
	}

	/**
	 * Shifts the Entity one place towards the front of its contained layer.
	 * @param	e		The Entity to shift.
	 * @return	If the Entity changed position.
	 */
	public function bringForward(e:Entity):Bool
	{
		if (e._scene != this || e._renderPrev == null) return false;
		// pull from list
		e._renderPrev._renderNext = e._renderNext;
		if (e._renderNext != null) e._renderNext._renderPrev = e._renderPrev;
		else _renderLast.set(e._layer, e._renderPrev);
		// shift towards the front
		e._renderNext = e._renderPrev;
		e._renderPrev = e._renderPrev._renderPrev;
		e._renderNext._renderPrev = e;
		if (e._renderPrev != null) e._renderPrev._renderNext = e;
		else _renderFirst.set(e._layer, e);
		return true;
	}

	/**
	 * Shifts the Entity one place towards the back of its contained layer.
	 * @param	e		The Entity to shift.
	 * @return	If the Entity changed position.
	 */
	public function sendBackward(e:Entity):Bool
	{
		if (e._scene != this || e._renderNext == null) return false;
		// pull from list
		e._renderNext._renderPrev = e._renderPrev;
		if (e._renderPrev != null) e._renderPrev._renderNext = e._renderNext;
		else _renderFirst.set(e._layer, e._renderNext);
		// shift towards the back
		e._renderPrev = e._renderNext;
		e._renderNext = e._renderNext._renderNext;
		e._renderPrev._renderNext = e;
		if (e._renderNext != null) e._renderNext._renderPrev = e;
		else _renderLast.set(e._layer, e);
		return true;
	}

	/**
	 * If the Entity as at the front of its layer.
	 * @param	e		The Entity to check.
	 * @return	True or false.
	 */
	public inline function isAtFront(e:Entity):Bool
	{
		return e._renderPrev == null;
	}

	/**
	 * If the Entity as at the back of its layer.
	 * @param	e		The Entity to check.
	 * @return	True or false.
	 */
	public inline function isAtBack(e:Entity):Bool
	{
		return e._renderNext == null;
	}

	/**
	 * Returns the first Entity that collides with the rectangular area.
	 * @param	type		The Entity type to check for.
	 * @param	rX			X position of the rectangle.
	 * @param	rY			Y position of the rectangle.
	 * @param	rWidth		Width of the rectangle.
	 * @param	rHeight		Height of the rectangle.
	 * @return	The first Entity to collide, or null if none collide.
	 */
	public function collideRect(type:String, rX:Float, rY:Float, rWidth:Float, rHeight:Float):Entity
	{
		var e:Entity = _typeFirst.get(type);
		while (e != null)
		{
			if (e.collidable && e.collideRect(e.x, e.y, rX, rY, rWidth, rHeight)) return e;
			e = e._typeNext;
		}
		return null;
	}

	/**
	 * Returns the first Entity found that collides with the position.
	 * @param	type		The Entity type to check for.
	 * @param	pX			X position.
	 * @param	pY			Y position.
	 * @return	The collided Entity, or null if none collide.
	 */
	public function collidePoint(type:String, pX:Float, pY:Float):Entity
	{
		var e:Entity = _typeFirst.get(type),
			result:Entity = null;
		while (e != null)
		{
			// only look for entities that collide
			if (e.collidable && e.collidePoint(e.x, e.y, pX, pY))
			{
				// the first one might be the front one
				if (result == null)
				{
					result = e;
				// compare if the new collided entity is above the former one (lower valuer is toward, higher value is backward)
				}
				else if(e.layer < result.layer)
				{
					result = e;
				}
			}
			e = e._typeNext;
		}
		return result;
	}

	/**
	 * Returns the first Entity found that collides with the line.
	 * @param	type		The Entity type to check for.
	 * @param	fromX		Start x of the line.
	 * @param	fromY		Start y of the line.
	 * @param	toX			End x of the line.
	 * @param	toY			End y of the line.
	 * @param	precision   Distance between consecutive tests. Higher values are faster but increase the chance of missing collisions.
	 * @param	p           If non-null, will have its x and y values set to the point of collision.
	 * @return	The first Entity to collide, or null if none collide.
	 */
	public function collideLine(type:String, fromX:Int, fromY:Int, toX:Int, toY:Int, precision:Int = 1, p:Point = null):Entity
	{
		// If the distance is less than precision, do the short sweep.
		if (precision < 1) precision = 1;
		if (HXP.distance(fromX, fromY, toX, toY) < precision)
		{
			if (p != null)
			{
				if (fromX == toX && fromY == toY)
				{
					p.x = toX; p.y = toY;
					return collidePoint(type, toX, toY);
				}
				return collideLine(type, fromX, fromY, toX, toY, 1, p);
			}
			else return collidePoint(type, fromX, toY);
		}

		// Get information about the line we're about to raycast.
		var xDelta:Int = Std.int(Math.abs(toX - fromX)),
			yDelta:Int = Std.int(Math.abs(toY - fromY)),
			xSign:Float = toX > fromX ? precision : -precision,
			ySign:Float = toY > fromY ? precision : -precision,
			x:Float = fromX, y:Float = fromY, e:Entity;

		// Do a raycast from the start to the end point.
		if (xDelta > yDelta)
		{
			ySign *= yDelta / xDelta;
			if (xSign > 0)
			{
				while (x < toX)
				{
					if ((e = collidePoint(type, x, y)) != null)
					{
						if (p == null) return e;
						if (precision < 2)
						{
							p.x = x - xSign; p.y = y - ySign;
							return e;
						}
						return collideLine(type, Std.int(x - xSign), Std.int(y - ySign), toX, toY, 1, p);
					}
					x += xSign; y += ySign;
				}
			}
			else
			{
				while (x > toX)
				{
					if ((e = collidePoint(type, x, y)) != null)
					{
						if (p == null) return e;
						if (precision < 2)
						{
							p.x = x - xSign; p.y = y - ySign;
							return e;
						}
						return collideLine(type, Std.int(x - xSign), Std.int(y - ySign), toX, toY, 1, p);
					}
					x += xSign; y += ySign;
				}
			}
		}
		else
		{
			xSign *= xDelta / yDelta;
			if (ySign > 0)
			{
				while (y < toY)
				{
					if ((e = collidePoint(type, x, y)) != null)
					{
						if (p == null) return e;
						if (precision < 2)
						{
							p.x = x - xSign; p.y = y - ySign;
							return e;
						}
						return collideLine(type, Std.int(x - xSign), Std.int(y - ySign), toX, toY, 1, p);
					}
					x += xSign; y += ySign;
				}
			}
			else
			{
				while (y > toY)
				{
					if ((e = collidePoint(type, x, y)) != null)
					{
						if (p == null) return e;
						if (precision < 2)
						{
							p.x = x - xSign; p.y = y - ySign;
							return e;
						}
						return collideLine(type, Std.int(x - xSign), Std.int(y - ySign), toX, toY, 1, p);
					}
					x += xSign; y += ySign;
				}
			}
		}

		// Check the last position.
		if (precision > 1)
		{
			if (p == null) return collidePoint(type, toX, toY);
			if (collidePoint(type, toX, toY) != null) return collideLine(type, Std.int(x - xSign), Std.int(y - ySign), toX, toY, 1, p);
		}

		// No collision, return the end point.
		if (p != null)
		{
			p.x = toX;
			p.y = toY;
		}
		return null;
	}

	/**
	 * Populates an array with all Entities that collide with the rectangle. This
	 * function does not empty the array, that responsibility is left to the user.
	 * @param	type		The Entity type to check for.
	 * @param	rX			X position of the rectangle.
	 * @param	rY			Y position of the rectangle.
	 * @param	rWidth		Width of the rectangle.
	 * @param	rHeight		Height of the rectangle.
	 * @param	into		The Array or Vector to populate with collided Entities.
	 */
	public function collideRectInto<E:Entity>(type:String, rX:Float, rY:Float, rWidth:Float, rHeight:Float, into:Array<E>)
	{
		var e:Entity = _typeFirst.get(type),
			n:Int = into.length;
		while (e != null)
		{
			if (e.collidable && e.collideRect(e.x, e.y, rX, rY, rWidth, rHeight)) into[n ++] = cast e;
			e = e._typeNext;
		}
	}

	/**
	 * Populates an array with all Entities that collide with the circle. This
	 * function does not empty the array, that responsibility is left to the user.
	 * @param	type 		The Entity type to check for.
	 * @param	circleX		X position of the circle.
	 * @param	circleY		Y position of the circle.
	 * @param	radius		The radius of the circle.
	 * @param	into		The Array or Vector to populate with collided Entities.
	 */
	public function collideCircleInto<E:Entity>(type:String, circleX:Float, circleY:Float, radius:Float , into:Array<E>)
	{
		var e:Entity = _typeFirst.get(type),
			n:Int = into.length;

		radius *= radius;//Square it to avoid the square root
		while (e != null)
		{
			if (HXP.distanceSquared(circleX, circleY, e.x, e.y) < radius) into[n ++] = cast e;
			e = e._typeNext;
		}
	}

	/**
	 * Populates an array with all Entities that collide with the position. This
	 * function does not empty the array, that responsibility is left to the user.
	 * @param	type		The Entity type to check for.
	 * @param	pX			X position.
	 * @param	pY			Y position.
	 * @param	into		The Array or Vector to populate with collided Entities.
	 */
	public function collidePointInto<E:Entity>(type:String, pX:Float, pY:Float, into:Array<E>)
	{
		var e:Entity = _typeFirst.get(type),
			n:Int = into.length;
		while (e != null)
		{
			if (e.collidable && e.collidePoint(e.x, e.y, pX, pY)) into[n ++] = cast e;
			e = e._typeNext;
		}
	}

	/**
	 * Finds the Entity nearest to the rectangle.
	 * @param	type		The Entity type to check for.
	 * @param	x			X position of the rectangle.
	 * @param	y			Y position of the rectangle.
	 * @param	width		Width of the rectangle.
	 * @param	height		Height of the rectangle.
	 * @return	The nearest Entity to the rectangle.
	 */
	public function nearestToRect(type:String, x:Float, y:Float, width:Float, height:Float):Entity
	{
		var e:Entity = _typeFirst.get(type),
			nearDist:Float = HXP.NUMBER_MAX_VALUE,
			near:Entity = null, dist:Float;
		while (e != null)
		{
			dist = squareRects(x, y, width, height, e.x - e.originX, e.y - e.originY, e.width, e.height);
			if (dist < nearDist)
			{
				nearDist = dist;
				near = e;
			}
			e = e._typeNext;
		}
		return near;
	}

	/**
	 * Finds the Entity nearest to another.
	 * @param	type		The Entity type to check for.
	 * @param	e			The Entity to find the nearest to.
	 * @param	useHitboxes	If the Entities' hitboxes should be used to determine the distance. If false, their x/y coordinates are used.
	 * @return	The nearest Entity to e.
	 */
	public function nearestToEntity(type:String, e:Entity, useHitboxes:Bool = false):Entity
	{
		if (useHitboxes) return nearestToRect(type, e.x - e.originX, e.y - e.originY, e.width, e.height);
		var n:Entity = _typeFirst.get(type),
			nearDist:Float = HXP.NUMBER_MAX_VALUE,
			near:Entity = null,
			dist:Float,
			x:Float = e.x - e.originX,
			y:Float = e.y - e.originY;
		while (n != null)
		{
			dist = (x - n.x) * (x - n.x) + (y - n.y) * (y - n.y);
			if (dist < nearDist)
			{
				nearDist = dist;
				near = n;
			}
			n = n._typeNext;
		}
		return near;
	}


	/**
	 * Finds the Entity nearest to another.
	 * @param	type		The Entity type to check for.
	 * @param	e			The Entity to find the nearest to.
	 * @param	classType	The Entity class to check for.
	 * @param	useHitboxes	If the Entities' hitboxes should be used to determine the distance. If false, their x/y coordinates are used.
	 * @return	The nearest Entity to e.
	 */
	public function nearestToClass(type:String, e:Entity, classType:Dynamic, useHitboxes:Bool = false):Entity
	{
		if (useHitboxes) return nearestToRect(type, e.x - e.originX, e.y - e.originY, e.width, e.height);
		var n:Entity = _typeFirst.get(type),
			nearDist:Float = HXP.NUMBER_MAX_VALUE,
			near:Entity = null,
			dist:Float,
			x:Float = e.x - e.originX,
			y:Float = e.y - e.originY;
		while (n != null)
		{
			dist = (x - n.x) * (x - n.x) + (y - n.y) * (y - n.y);
			if (dist < nearDist && Std.is(e, classType))
			{
				nearDist = dist;
				near = n;
			}
			n = n._typeNext;
		}
		return near;
	}

	/**
	 * Finds the Entity nearest to the position.
	 * @param	type		The Entity type to check for.
	 * @param	x			X position.
	 * @param	y			Y position.
	 * @param	useHitboxes	If the Entities' hitboxes should be used to determine the distance. If false, their x/y coordinates are used.
	 * @return	The nearest Entity to the position.
	 */
	public function nearestToPoint(type:String, x:Float, y:Float, useHitboxes:Bool = false):Entity
	{
		var n:Entity = _typeFirst.get(type),
			nearDist:Float = HXP.NUMBER_MAX_VALUE,
			near:Entity = null,
			dist:Float;
		if (useHitboxes)
		{
			while (n != null)
			{
				dist = squarePointRect(x, y, n.x - n.originX, n.y - n.originY, n.width, n.height);
				if (dist < nearDist)
				{
					nearDist = dist;
					near = n;
				}
				n = n._typeNext;
			}
		}
		else
		{
			while (n != null)
			{
				dist = (x - n.x) * (x - n.x) + (y - n.y) * (y - n.y);
				if (dist < nearDist)
				{
					nearDist = dist;
					near = n;
				}
				n = n._typeNext;
			}
		}
		return near;
	}

	/**
	 * How many Entities are in the Scene.
	 */
	public var count(get, never):Int;
	private inline function get_count():Int { return _count; }

	/**
	 * Returns the amount of Entities of the type are in the Scene.
	 * @param	type		The type (or Class type) to count.
	 * @return	How many Entities of type exist in the Scene.
	 */
	public inline function typeCount(type:String):Int
	{
		return _typeCount.exists(type) ? _typeCount.get(type) : 0;
	}

	/**
	 * Returns the amount of Entities of the Class are in the Scene.
	 * @param	c		The Class type to count.
	 * @return	How many Entities of Class exist in the Scene.
	 */
	public inline function classCount(c:String):Int
	{
		return _classCount.exists(c) ? _classCount.get(c) : 0;
	}

	/**
	 * Returns the amount of Entities are on the layer in the Scene.
	 * @param	layer		The layer to count Entities on.
	 * @return	How many Entities are on the layer.
	 */
	public inline function layerCount(layer:Int):Int
	{
		return _layerCount.exists(layer) ? _layerCount.get(layer) : 0;
	}

	/**
	 * The first Entity in the Scene.
	 */
	public var first(get, null):Entity;
	private inline function get_first():Entity { return _updateFirst; }

	/**
	 * How many Entity layers the Scene has.
	 */
	public var layers(get, null):Int;
	private inline function get_layers():Int { return _layerList.length; }

	/**
	 * The first Entity of the type.
	 * @param	type		The type to check.
	 * @return	The Entity.
	 */
	public function typeFirst(type:String):Entity
	{
		if (_updateFirst == null) return null;
		return _typeFirst.get(type);
	}

	/**
	 * The first Entity of the Class.
	 * @param	c		The Class type to check.
	 * @return	The Entity.
	 */
	public function classFirst<E:Entity>(c:Class<E>):E
	{
		if (_updateFirst == null) return null;
		var e:Entity = _updateFirst;
		while (e != null)
		{
			if (Std.is(e, c)) return cast e;
			e = e._updateNext;
		}
		return null;
	}

	/**
	 * The first Entity on the Layer.
	 * @param	layer		The layer to check.
	 * @return	The Entity.
	 */
	public function layerFirst(layer:Int):Entity
	{
		if (_updateFirst == null) return null;
		return _renderFirst.get(layer);
	}

	/**
	 * The last Entity on the Layer.
	 * @param	layer		The layer to check.
	 * @return	The Entity.
	 */
	public function layerLast(layer:Int):Entity
	{
		if (_updateFirst == null) return null;
		return _renderLast.get(layer);
	}

	/**
	 * The Entity that will be rendered first by the Scene.
	 */
	public var farthest(get, null):Entity;
	private function get_farthest():Entity
	{
		if (_updateFirst == null) return null;
		return _renderLast.get(_layerList[_layerList.length - 1]);
	}

	/**
	 * The Entity that will be rendered last by the scene.
	 */
	public var nearest(get, null):Entity;
	private function get_nearest():Entity
	{
		if (_updateFirst == null) return null;
		return _renderFirst.get(_layerList[0]);
	}

	/**
	 * The layer that will be rendered first by the Scene.
	 */
	public var layerFarthest(get, null):Int;
	private function get_layerFarthest():Int
	{
		if (_updateFirst == null) return 0;
		return _layerList[_layerList.length - 1];
	}

	/**
	 * The layer that will be rendered last by the Scene.
	 */
	public var layerNearest(get, null):Int;
	private function get_layerNearest():Int
	{
		if (_updateFirst == null) return 0;
		return _layerList[0];
	}

	/**
	 * How many different types have been added to the Scene.
	 */
	public var uniqueTypes(get, null):Int;
	private inline function get_uniqueTypes():Int
	{
		var i:Int = 0;
		for (type in _typeCount) i++;
		return i;
	}

	/**
	 * Pushes all Entities in the Scene of the type into the Array or Vector. This
	 * function does not empty the array, that responsibility is left to the user.
	 * @param	type		The type to check.
	 * @param	into		The Array or Vector to populate.
	 */
	public function getType<E:Entity>(type:String, into:Array<E>)
	{
		var e:Entity = _typeFirst.get(type),
			n:Int = into.length;
		while (e != null)
		{
			into[n++] = cast e;
			e = e._typeNext;
		}
	}

	/**
	 * Pushes all Entities in the Scene of the Class into the Array or Vector. This
	 * function does not empty the array, that responsibility is left to the user.
	 * @param	c			The Class type to check.
	 * @param	into		The Array or Vector to populate.
	 */
	public function getClass<E:Entity>(c:Class<Dynamic>, into:Array<E>)
	{
		var e:Entity = _updateFirst,
			n:Int = into.length;
		while (e != null)
		{
			if (Std.is(e, c))
				into[n++] = cast e;
			e = e._updateNext;
		}
	}

	/**
	 * Pushes all Entities in the Scene on the layer into the Array or Vector. This
	 * function does not empty the array, that responsibility is left to the user.
	 * @param	layer		The layer to check.
	 * @param	into		The Array or Vector to populate.
	 */
	public function getLayer<E:Entity>(layer:Int, into:Array<E>)
	{
		var e:Entity = _renderLast.get(layer),
			n:Int = into.length;
		while (e != null)
		{
			into[n ++] = cast e;
			e = e._updatePrev;
		}
	}

	/**
	 * Pushes all Entities in the Scene into the array. This
	 * function does not empty the array, that responsibility is left to the user.
	 * @param	into		The Array or Vector to populate.
	 */
	public function getAll<E:Entity>(into:Array<E>)
	{
		var e:Entity = _updateFirst,
			n:Int = into.length;
		while (e != null)
		{
			into[n ++] = cast e;
			e = e._updateNext;
		}
	}

	/**
	 * Returns the Entity with the instance name, or null if none exists
	 * @param	name
	 * @return	The Entity.
	 */
	public function getInstance(name:String):Entity
	{
		return _entityNames.get(name);
	}
	/**
	 * Updates the states for transitions.
	 
	 */
	public function updateState()
		{
			 updateLists();
	   	if (hasTween) updateTweens();
			update();
		  updateLists(false);
			
		}

	/**
	 * Updates the add/remove lists at the end of the frame.
	 * @param	shouldAdd	If new Entities should be added to the scene.
	 */
	public function updateLists(shouldAdd:Bool = true)
	{
		var e:Entity;

		// remove entities
		if (_remove.length > 0)
		{
			for (e in _remove)
			{
				if (e._scene == null)
				{
					var idx = HXP.indexOf(_add, e);
					if (idx >= 0) _add.splice(idx, 1);
					continue;
				}
				if (e._scene != this)
					continue;
				e.removed();
				e._scene = null;
				removeUpdate(e);
				removeRender(e);
				if (e._type != "") removeType(e);
				if (e._name != "") unregisterName(e);
				if (e.autoClear && e.hasTween) e.clearTweens();
			}
			HXP.clear(_remove);
		}

		// add entities
		if (shouldAdd && _add.length > 0)
		{
			for (e in _add)
			{
				if (e._scene != null) continue;
				e._scene = this;
				addUpdate(e);
				addRender(e);
				if (e._type != "") addType(e);
				if (e._name != "") registerName(e);
				e.added();
			}
			HXP.clear(_add);
		}

		// recycle entities
		if (_recycle.length > 0)
		{
			for (e in _recycle)
			{
				if (e._scene != null || e._recycleNext != null)
					continue;

				e._recycleNext = _recycled.get(e._class);
				_recycled.set(e._class, e);
			}
			HXP.clear(_recycle);
		}
	}

	/** @private Adds Entity to the update list. */
	private function addUpdate(e:Entity)
	{
		// add to update list
		if (_updateFirst != null)
		{
			_updateFirst._updatePrev = e;
			e._updateNext = _updateFirst;
		}
		else e._updateNext = null;
		e._updatePrev = null;
		_updateFirst = e;
		_count ++;
		if (_classCount.get(e._class) != 0) _classCount.set(e._class, 0);
		_classCount.set(e._class, _classCount.get(e._class) + 1); // increment
	}

	/** @private Removes Entity from the update list. */
	private function removeUpdate(e:Entity)
	{
		// remove from the update list
		if (_updateFirst == e) _updateFirst = e._updateNext;
		if (e._updateNext != null) e._updateNext._updatePrev = e._updatePrev;
		if (e._updatePrev != null) e._updatePrev._updateNext = e._updateNext;
		e._updateNext = e._updatePrev = null;
		_count --;
		_classCount.set(e._class, _classCount.get(e._class) - 1); // decrement
	}

	/** @private Adds Entity to the render list. */
	@:allow(com.haxepunk.Entity)
	private function addRender(e:Entity)
	{
		var next:Entity = _renderFirst.get(e._layer);
		if (next != null)
		{
			// Append entity to existing layer.
			e._renderNext = next;
			next._renderPrev = e;
			_layerCount.set(e._layer, _layerCount.get(e._layer) + 1);
		}
		else
		{
			// Create new layer with entity.
			_renderLast.set(e._layer, e);
			_layerList[_layerList.length] = e._layer;
			_layerSort = true;
			e._renderNext = null;
			_layerCount.set(e._layer, 1);
		}
		_renderFirst.set(e._layer, e);
		e._renderPrev = null;
	}

	/** @private Removes Entity from the render list. */
	@:allow(com.haxepunk.Entity)
	private function removeRender(e:Entity)
	{
		if (e._renderNext != null) e._renderNext._renderPrev = e._renderPrev;
		else _renderLast.set(e._layer, e._renderPrev);
		if (e._renderPrev != null) e._renderPrev._renderNext = e._renderNext;
		else
		{
			// Remove this entity from the layer.
			_renderFirst.set(e._layer, e._renderNext);
			if (e._renderNext == null)
			{
				// Remove the layer from the layer list if this was the last entity.
				if (_layerList.length > 1)
				{
					_layerList[HXP.indexOf(_layerList, e._layer)] = _layerList[_layerList.length - 1];
					_layerSort = true;
				}
				_layerList.pop();
			}
		}
		var count:Int = _layerCount.get(e._layer) - 1;
		if (count > 0)
		{
			_layerCount.set(e._layer, count);
		}
		else
		{
			// Remove layer from maps if it contains 0 entities.
			_layerCount.remove(e._layer);
			_renderFirst.remove(e._layer);
			_renderLast.remove(e._layer);
		}
		e._renderNext = e._renderPrev = null;
	}

	/** @private Adds Entity to the type list. */
	@:allow(com.haxepunk.Entity)
	private function addType(e:Entity)
	{
		// add to type list
		if (_typeFirst.get(e._type) != null)
		{
			_typeFirst.get(e._type)._typePrev = e;
			e._typeNext = _typeFirst.get(e._type);
			_typeCount.set(e._type, _typeCount.get(e._type) + 1);
		}
		else
		{
			e._typeNext = null;
			_typeCount.set(e._type, 1);
		}
		e._typePrev = null;
		_typeFirst.set(e._type, e);
	}

	/** @private Removes Entity from the type list. */
	@:allow(com.haxepunk.Entity)
	private function removeType(e:Entity)
	{
		// remove from the type list
		if (_typeFirst.get(e._type) == e) _typeFirst.set(e._type, e._typeNext);
		if (e._typeNext != null) e._typeNext._typePrev = e._typePrev;
		if (e._typePrev != null) e._typePrev._typeNext = e._typeNext;
		e._typeNext = e._typePrev = null;
		var count:Int = _typeCount.get(e._type) - 1;
		if (count <= 0)
		{
			_typeCount.remove(e._type);
		}
		else
		{
			_typeCount.set(e._type, count);
		}
	}

	/** @private Register the entities instance name. */
	@:allow(com.haxepunk.Entity)
	private inline function registerName(e:Entity)
	{
		_entityNames.set(e._name, e);
	}

	/** @private Unregister the entities instance name. */
	@:allow(com.haxepunk.Entity)
	private inline function unregisterName(e:Entity):Void
	{
		_entityNames.remove(e._name);
	}
	
	
public function fadeIn(Duration:Float,?Color:Int=0, ?OnComplete:TFadeComplete = null )
{
		FadeColor = Color;
		FadeDuration = Duration;
		FadeComplete = OnComplete;
		FadeAlpha = 1.4E-45;
		FadeIn = true;
		FadeEnd = false;
}
public function fadeOut(Duration:Float, ?Color:Int=0,?OnComplete:TFadeComplete = null )
{
		FadeColor = Color;
		FadeDuration = Duration;
		FadeComplete = OnComplete;
		FadeAlpha = 1;
		FadeIn = false;
		FadeEnd = false;
}

public function fadeInTo(Duaration:Float, scene:Scene)
{
	fadeIn(Duaration, 0, function() 
		{
		 HXP.scene =  scene;
		}
		);
}
public function fadeOutTo(Duaration:Float, scene:Scene)
{
		fadeOut(Duaration, 0, function() 
		{
		HXP.scene =  scene;
		}
		);
	
}	
	
	
  
 

	/** @private Calculates the squared distance between two rectangles. */
	private static function squareRects(x1:Float, y1:Float, w1:Float, h1:Float, x2:Float, y2:Float, w2:Float, h2:Float):Float
	{
		if (x1 < x2 + w2 && x2 < x1 + w1)
		{
			if (y1 < y2 + h2 && y2 < y1 + h1) return 0;
			if (y1 > y2) return (y1 - (y2 + h2)) * (y1 - (y2 + h2));
			return (y2 - (y1 + h1)) * (y2 - (y1 + h1));
		}
		if (y1 < y2 + h2 && y2 < y1 + h1)
		{
			if (x1 > x2) return (x1 - (x2 + w2)) * (x1 - (x2 + w2));
			return (x2 - (x1 + w1)) * (x2 - (x1 + w1));
		}
		if (x1 > x2)
		{
			if (y1 > y2) return squarePoints(x1, y1, (x2 + w2), (y2 + h2));
			return squarePoints(x1, y1 + h1, x2 + w2, y2);
		}
		if (y1 > y2) return squarePoints(x1 + w1, y1, x2, y2 + h2);
		return squarePoints(x1 + w1, y1 + h1, x2, y2);
	}

	/** @private Calculates the squared distance between two points. */
	private static function squarePoints(x1:Float, y1:Float, x2:Float, y2:Float):Float
	{
		return (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2);
	}

	/** @private Calculates the squared distance between a rectangle and a point. */
	private static function squarePointRect(px:Float, py:Float, rx:Float, ry:Float, rw:Float, rh:Float):Float
	{
		if (px >= rx && px <= rx + rw)
		{
			if (py >= ry && py <= ry + rh) return 0;
			if (py > ry) return (py - (ry + rh)) * (py - (ry + rh));
			return (ry - py) * (ry - py);
		}
		if (py >= ry && py <= ry + rh)
		{
			if (px > rx) return (px - (rx + rw)) * (px - (rx + rw));
			return (rx - px) * (rx - px);
		}
		if (px > rx)
		{
			if (py > ry) return squarePoints(px, py, rx + rw, ry + rh);
			return squarePoints(px, py, rx + rw, ry);
		}
		if (py > ry) return squarePoints(px, py, rx, ry + rh);
		return squarePoints(px, py, rx, ry);
	}

	// Adding and removal.
	private var _add:Array<Entity>;
	private var _remove:Array<Entity>;
	private var _recycle:Array<Entity>;

	// Update information.
	private var _updateFirst:Entity;
	private var _count:Int;

	// Render information.
	private var _layerSort:Bool;
	private var _layerList:Array<Int>;
	private var _layerDisplay:Map<Int,Bool>;
	private var _layerCount:Map<Int, Int>;
	//private var _layers:Array <SpriteSheet>;

	private var _renderFirst:Map<Int,Entity>;
	private var _renderLast:Map<Int,Entity>;

	private var _classCount:Map<String,Int>;

	@:allow(com.haxepunk.Entity)
	private var _typeFirst:Map<String,Entity>;
	private var _typeCount:Map<String,Int>;

	private var _recycled:Map<String,Entity>;
	private var _entityNames:Map<String,Entity>;
}
