package com.box2hxp;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.Mask;
import com.haxepunk.World;

/**
 * An interface for a Box2DEntity for later use.
 * Note that this doesn't include Entity functions such as 'moveTo' 
 * 	or 'clampHorizontal' as they don't mix well with Box2DEntities
 * 	right now (TODO!)
 * @author Paul Sztajer
 */
interface IBox2DEntity 
{
	//getters for simple Entity variables
	private function getX():Float;
	private function setX(v:Float):Float;
	private function getY():Float;
	private function setY(v:Float):Float;
	private function getWidth():Float;
	private function setWidth(v:Float):Float;
	private function getHeight():Float;
	private function setHeight(v:Float):Float;

	//Entity hooks
	private function added():Void;
	private function removed():Void;
	private function update():Void;
	private function render():Void;

	//Entity Collisions
	private function collide(type:String, x:Float, y:Float):Entity;
	private function collideTypes(types:Dynamic, x:Float, y:Float):Entity;
	private function collideWith(e:Entity, x:Float, y:Float):Entity;
	private function collideRect(x:Float, y:Float, rX:Float, rY:Float, rWidth:Float, rHeight:Float):Bool;
	private function collidePoint(x:Float, y:Float, pX:Float, pY:Float):Bool;
	private function collideInto(type:String, x:Float, y:Float, array:Array<Entity>):Void;
	private function collideTypesInto(types:Array<String>, x:Float, y:Float, array:Array<Entity>):Void;
		
	//Entity getters
	private function getOnCamera():Bool;
	private function getWorld():World;
	private function getHalfWidth():Float;
	private function getHalfHeight():Float;
	private function getCenterX():Float; 
	private function getCenterY():Float;
	private function getLeft():Float;
	private function getRight():Float;
	private function getTop():Float;
	private function getBottom():Float;

	//Layers and Types
	private function getLayer():Int;
	private function setLayer(value:Int):Int;
	private function getType():String;
	private function setType(value:String):String;

	//Masks and Graphics
	private function getMask():Mask;
	private function setMask(value:Mask):Mask;
	private function getGraphic():Graphic;
	private function setGraphic(value:Graphic):Graphic;
	private function addGraphic(g:Graphic):Graphic;
	private function setHitbox(width:Int = 0, height:Int = 0, originX:Int = 0, originY:Int = 0):Void;
	private function setHitboxTo(o:Dynamic):Void;
	private function setOrigin(x:Int = 0, y:Int = 0):Void;
	private function centerOrigin():Void;

	//Distances
	private function distanceFrom(e:Entity, useHitboxes:Bool = false):Float;
	private function distanceToPoint(px:Float, py:Float, useHitbox:Bool = false):Float;
	private function distanceToRect(rx:Float, ry:Float, rwidth:Float, rheight:Float):Float;
}