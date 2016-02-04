package com.box2dhxp;

import box2D.collision.shapes.B2CircleShape;
import box2D.collision.shapes.B2PolygonShape;
import box2D.common.math.B2Math;
import box2D.common.math.B2Transform;
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
	public static function haxepunkToBox2dCoordinates(p:B2Vec2, w:Float, h:Float, scale:Float):B2Vec2
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
	public static function box2dToHaxepunkCoordinates(p:B2Vec2, w:Float, h:Float, scale:Float):B2Vec2
	{
		var ret:B2Vec2 = p.copy();
		ret.multiply(scale);
		ret.subtract(new B2Vec2(w/2, h/2));
		return ret;
	}
	
	/**
	 * Move a polygon shape
	 * Note that this will add to the current postion and angle
	 * @param shape	The shape to move
	 * @param x 	The amount to move along the x axis (in meters)
	 * @param y 	The amount to move along the y axis (in meters)
	 * @param angle The amount to rotate the shape
	 */
	public static function movePolygonShape(shape:B2PolygonShape, x:Float, y:Float, angle:Float = 0) : Void
	{
		var xf:B2Transform = new B2Transform();
		xf.position = new B2Vec2(x, y);
		xf.R.set(angle);

		// Transform vertices and normals.
		for (i in 0...shape.m_vertexCount)
		{
			shape.m_vertices[i] = B2Math.mulX(xf, shape.m_vertices[i]);
			shape.m_normals[i] = B2Math.mulMV(xf.R, shape.m_normals[i]);
		}
	}
	
	/**
	 * Move a circle shape
	 * Note that this will add to the current postion and angle
	 * @param shape	The shape to move
	 * @param x 	The amount to move along the x axis (in meters)
	 * @param y 	The amount to move along the y axis (in meters)
	 */
	public static function moveCircleShape(shape:B2CircleShape, x:Float, y:Float)
	{
		shape.m_p.x += x;
		shape.m_p.y += y;
	}
		
	/**
	 * Set a circle shapes position
	 * @param shape	The shape to move
	 * @param x 	The position on the x axis (in meters)
	 * @param y 	The position on the y axis (in meters)
	 */
	public static function setCircleShapePosition(shape:B2CircleShape, x:Float, y:Float)
	{
		shape.m_p.x = x;
		shape.m_p.y = y;
	}
}