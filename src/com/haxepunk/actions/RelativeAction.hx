package com.haxepunk.actions;

/**
 * ...
 * @author djoker
 */
class RelativeAction extends BaseAction
{
	private var lastPercent:Float = 0;

     override	public function  start () 
	{
		lastPercent = 0;
	}

	override private function update ( percent:Float)
	{
		updateRelative(percent - lastPercent);
		lastPercent = percent;
	}
	 private function updateRelative ( percentDelta:Float)
	{
	}	
	
	
}