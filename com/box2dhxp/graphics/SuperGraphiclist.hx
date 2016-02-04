package com.box2dhxp.graphics;

import com.haxepunk.Graphic;
import com.haxepunk.graphics.Canvas;
import com.haxepunk.graphics.Graphiclist;
import com.haxepunk.graphics.Image;

/**
 * A type of Graphiclist that can update certain characteristics
 * 	of all of its children.
 * 	Where possible, when attributes are set they are altered relative
 * 	to the child's curent value of that attribute.
 * @author Paul Sztajer
 */
class SuperGraphiclist extends Graphiclist
{
	//public function new(graphic:Array<Dynamic> = null)
	//{
		//super();
		//if(graphic != null)
			//for (g in graphic) add(g);
		//
		//scale = 1;
		//scaleX = 1;
		//scaleY = 1;
		//angle = 0;
		//color = 0xFFFFFF;
		//#if (flash || js)
		//blend = BlendMode.MULTIPLY;
		//#else
		//blend = "multiply";
		//#end
		//alpha = 1;
		//smooth = false;
		//flipped = false;
	//}
//
	///**
	 //* Get the scale of the graphiclist
	 //*/
	//public var scale(getScale, setScale):Float;
	//private function getScale():Float { return scale; }
	///**
	 //* Set the scale. Multiplies with the current scale of children
	 //*/
	//private function setScale(v:Float):Float
	//{
		//if (scale == v) return scale; 
		//for (g in children)
		//{
			//if (Std.is(g, Image))
				//(cast(g, Image)).scale *= v/scale;
			//else if (Std.is(g, SuperGraphiclist))
				//(cast(g, SuperGraphiclist)).scale *= v/scale;
		//}
		//
		//scale = v;
		//return v;
	//}
//
	///**
	 //* Get the scaleX of the graphiclist
	 //*/
	//public var scaleX(getScaleX, setScaleX):Float;
	//private function getScaleX():Float { return scaleX; }
	///**
	 //* Set the x scale. Multiplies with the current scaleX of children
	 //*/
	//private function setScaleX(v:Float):Float
	//{
		//if (scaleX == v) return scaleX;
		//for (g in children)
		//{
		//if (Std.is(g, Image))
			//(cast(g, Image)).scaleX *= v/scaleX;
		//else if (Std.is(g, SuperGraphiclist))
			//(cast(g, SuperGraphiclist)).scaleX *= v/scaleX;
		//}
		//
		//scaleX = v;
		//return v;
	//}
//
	///**
	 //* Get the scaleY of the graphiclist
	 //*/
	//public var scaleY(getScaleY, setScaleY):Float;
	//private function getScaleY():Float { return scaleY; }
	///**
	 //* Set the y scale. Multiplies with the current scaleY of children
	 //*/
	//private function setScaleY(v:Float):Float
	//{
		//if (scaleY == v) return scaleY;
		//for (g in children)
		//{
			//if (Std.is(g, Image))
				//(cast(g, Image)).scaleY *= v/scaleY;
			//else if (Std.is(g, SuperGraphiclist))
				//(cast(g, SuperGraphiclist)).scaleY *= v/scaleY;
		//}
		//
		//scaleY = v;
		//return v;
	//}
//
	///**
	 //* Get the angle of the graphiclist
	 //*/
	//public var angle(getAngle, setAngle):Float;
	//private function getAngle():Float { return angle; }
	///**
	 //* Set the angle. Adds to the current angle of children
	 //*/
	//private function setAngle(v:Float):Float
	//{
		//if (angle == v) return angle;
		//for (g in children)
		//{
			//if (Std.is(g, Image))
				//(cast(g, Image)).angle += v - angle;
			//else if (Std.is(g, SuperGraphiclist))
				//(cast(g, SuperGraphiclist)).angle += v - angle;
		//}
		//
		//angle = v;
		//return v;
	//}
//
	///**
	 //* Get the color of the graphiclist
	 //*/
	//public var color(getColor, setColor):Int;
	//private function getColor():Int { return color; }
	///**
	 //* Set the color of all children.
	 //*/
	//private function setColor(v:Int):Int
	//{
		//if (color == v) return color;
		//color = v;
		//for (g in children)
		//{
			//if (Std.is(g, Image))
				//(cast(g, Image)).color = v;
			//else if (Std.is(g, SuperGraphiclist))
				//(cast(g, SuperGraphiclist)).color = v;
			//else if (Std.is(g, Canvas))
				//(cast(g, Canvas)).color = v;
		//}
		//
		//return v;
	//}
//
	///**
	 //* Get the blend mode of the graphiclist
	 //*/
	//#if (flash || js)
	//public var blend(getBlend, setBlend):BlendMode;
	//private function getBlend():BlendMode { return blend; }
	//#else
	//public var blend(getBlend, setBlend):String;
	//private function getBlend():String { return blend; }
	//#end
	///**
	 //* Set the blend mode of all children
	 //*/
	//#if (flash || js)
	//private function setBlend(v:BlendMode):BlendMode
	//{
		//if (blend == v) return blend;
		//blend = v;
		//for (g in children)
		//{
			//if (Std.is(g, Image))
				//(cast(g, Image)).blend = v;
			//else if (Std.is(g, SuperGraphiclist))
				//(cast(g, SuperGraphiclist)).blend = v;
			//else if (Std.is(g, Canvas))
				//(cast(g, Canvas)).blend = v;
		//}
		//
		//return v;
	//}
	//#else
	//private function setBlend(v:String):String
	//{
		//if (blend == v) return blend;
		//blend = v;
		//for (g in children)
		//{
			//if (Std.is(g, Image))
				//(cast(g, Image)).blend = v;
			//else if (Std.is(g, SuperGraphiclist))
				//(cast(g, SuperGraphiclist)).blend = v;
			//else if (Std.is(g, Canvas))
				//(cast(g, Canvas)).blend = v;
		//}
		//
		//return v;
	//}
	//#end
//
	///**
	 //* Get the alpha of the graphiclist
	 //*/
	//public var alpha(getAlpha, setAlpha):Float;
	//private function getAlpha():Float { return alpha; }
	///**
	 //* Set the alpha. Multiplies with the current angle of children
	 //*/
	//private function setAlpha(v:Float):Float
	//{
		//if (alpha == v) return alpha;
		//for (g in children)
		//{
			//if (Std.is(g, Image))
				//(cast(g, Image)).alpha *= v/alpha;
			//else if (Std.is(g, SuperGraphiclist))
				//(cast(g, SuperGraphiclist)).alpha *= v/alpha;
			//else if (Std.is(g, Canvas))
				//(cast(g, Canvas)).alpha *= v/alpha;
		//}
		//alpha = v;
		//
		//return v;
	//}
//
	///**
	 //* Get the smooth attribute of the graphiclist
	 //*/
	//public var smooth(getSmooth, setSmooth):Bool;
	//private function getSmooth():Bool { return smooth; }
	///**
	 //* Set the smooth attribute for all children
	 //*/
	//private function setSmooth(v:Bool):Bool
	//{
		//smooth = v;
		//for (g in children)
		//{
			//if (Std.is(g, Image))
				//(cast(g, Image)).smooth = !(cast(g, Image)).smooth;
			//else if (Std.is(g, SuperGraphiclist))
				//(cast(g, SuperGraphiclist)).smooth = !(cast(g, SuperGraphiclist)).smooth;
		//}
		//
		//return v;
	//}
//
	///**
	 //* Get the flipped attribute of the graphiclist
	 //*/
	//public var flipped(getFlipped, setFlipped):Bool;
	//private function getFlipped():Bool { return flipped; }
	///**
	 //* Set the flipped attribute. Swaps the flipped state of children if it flips
	 //*/
	//private function setFlipped(v:Bool):Bool
	//{
		//if (flipped != v)
		//{	
			//flipped = v;
			//for (g in children)
			//{
				//if (Std.is(g, Image))
				//(cast(g, Image)).flipped = !(cast(g, Image)).flipped;
				//else if (Std.is(g, SuperGraphiclist))
				//(cast(g, SuperGraphiclist)).flipped = !(cast(g, SuperGraphiclist)).flipped;
			//}
		//}
		//
		//return v;
	//}
}