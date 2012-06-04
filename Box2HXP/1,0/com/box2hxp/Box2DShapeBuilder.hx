package com.box2hxp;

import box2D.collision.shapes.B2CircleShape;
import box2D.collision.shapes.B2PolygonShape;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.B2FixtureDef;

/**
 * Utility class for building shapes.
 */
class Box2DShapeBuilder
{
	/**
	 * Builds a rectangle
	 * @param body		the body to add the shape to
	 * @param hw		half the width (metres)
	 * @param hh 		half the height (metres)
	 * @param friction
	 * @param density
	 * @param restitution	bounciness
	 * @param group		box2d collision group (ignore if 0)
	 * @param category	box2d collision category (ignore if 0)
	 * @param collmask	box2d collision mask (ignore if 0)
	 */
	public static function buildRectangle(body:B2Body, hw:Float, hh:Float, friction:Float = 0.3, 
		density:Float = 1, restitution:Float = 1, group:Int = 0, category:Int = 0, collmask:Int = 0):B2Fixture
	{
		var fd:B2FixtureDef = new B2FixtureDef();
		fd.density = density;
		fd.shape = B2PolygonShape.asBox(hw, hh);
		fd.restitution = restitution;
		fd.friction = friction;
		
		if (group != 0)
			fd.filter.groupIndex = group;
		if (category != 0)
			fd.filter.categoryBits = category;
		if (collmask != 0)
			fd.filter.maskBits = collmask;
		
		var fixture:B2Fixture = body.createFixture(fd);
		
		return fixture;
	}

	/**
	 * Builds a circle
	 * @param body		the body to add the shape to
	 * @param r		radius (metres)
	 * @param friction
	 * @param density
	 * @param restitution	bounciness
	 * @param group		box2d collision group (ignore if 0)
	 * @param category	box2d collision category (ignore if 0)
	 * @param collmask	box2d collision mask (ignore if 0)
	 */
	public static function buildCircle(body:B2Body, r:Float, friction:Float = 0.3, 
		density:Float = 1, restitution:Float = 1, group:Int = 0, category:Int = 0, collmask:Int = 0):B2Fixture
	{
		var fd:B2FixtureDef = new B2FixtureDef();
		fd.density = density;
		fd.shape = new B2CircleShape(r);
		fd.restitution = restitution;
		fd.friction = friction;
		
		if (group != 0)
			fd.filter.groupIndex = group;
		if (category != 0)
			fd.filter.categoryBits = category;
		if (collmask != 0)
			fd.filter.maskBits = collmask;
		
		var fixture:B2Fixture = body.createFixture(fd);
		
		return fixture;
	}
}