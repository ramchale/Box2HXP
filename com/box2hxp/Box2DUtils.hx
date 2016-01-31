package com.box2hxp;

import box2D.common.math.B2Vec2;

/**
 * Utility class
 */
class Box2DUtils
{
	/**
	 * Convert HaxePunk to Box2d Coordinates.
	 * Note that HaxePunk co-ordinates are from top-left, and Box2D
	 * 	coordinates are from the centre.
	 * @param p		The position (in pixels)
	 * @param w		The height (in pixels)
	 * @param h		The width (in pixels)
	 * @param scale	The world scale
	 * @return		The position (in metres)
	 */
	public static function FP2BoxCoords(p:B2Vec2, w:Float, h:Float, scale:Float):B2Vec2
	{
		var ret:B2Vec2 = p.copy();
		ret.add(new B2Vec2(w/2, h/2));
		ret.multiply(1.0 / scale);
		return ret;
	}

	/**
	 * Convert Box2d to HaxePunk Coordinates.
	 * Note that HaxePunk co-ordinates are from top-left, and Box2D
	 * 	coordinates are from the centre.
	 * @param p		The position (in metres)
	 * @param w		The height (in pixels)
	 * @param h		The width (in pixels)
	 * @param scale	The world scale
	 * @return		The position (in pixels)
	 */
	public static function Box2FPCoords(p:B2Vec2, w:Float, h:Float, scale:Float):B2Vec2
	{
		var ret:B2Vec2 = p.copy();
		ret.multiply(scale);
		ret.subtract(new B2Vec2(w/2, h/2));
		return ret;
	}
}