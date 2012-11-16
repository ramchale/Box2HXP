package com.box2hxp;

import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2FilterData;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.B2FixtureDef;
import box2D.dynamics.B2World;

import com.box2hxp.graphics.SuperGraphiclist;
import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.Graphic;
import com.haxepunk.Mask;

/**
 * An Flashpunk entity which contains a Box2D body, governed by both worlds.
 */
class Box2DEntity extends Entity, implements IBox2DEntity
{
	/**
	 * Constructor. Sets the graphic to a SuperGraphiclist
	 * @param x		x co-ord (pixels)
	 * @param y		y co-ord (pixels)
	 * @param w		width (pixels)
	 * @param h		height (pixels)
	 * @param b2Type	box2d body type (dynamic, kinematic, static)
	 * @param group		box2d collision group (ignored if 0)
	 * @param category	box2d collision category (ignored if 0)
	 * @param collmask	box2d collision mask (ignored if 0)
	 * @param friction
	 * @param density
	 * @param restitution	bounciness
	 */
	public function new(x:Float=0, y:Float=0, w:Int = 1, 
				h:Int = 1, b2Type:Int = 0, group:Int = 0, 
				category:Int = 0, collmask:Int = 0, friction:Float = 0.3, 
				density:Float = 1, restitution:Float = 1)
	{
		super(x, y, new SuperGraphiclist());
		
		_Box2DOptions = { type: b2Type, group: group, category: category, collmask: collmask,
				friction: friction, density: density, restitution: restitution };
		
		width = w;
		height = h;
		
		body = null;
	}
	
	private var _Box2DOptions:Dynamic;

	/** Sets the user data of the Box2D body to the Flashpunk entity */
	override public function added():Void
	{
		super.added();
		
		if (box2dworld != null)
		{
			makeBody(box2dworld.b2world);
		} else {
			HXP.console.enable();
			HXP.console.paused = true;
			HXP.console.log(["ERROR: Box2DEntity created in non Box2DWorld"]); 
		}
		
		body.setUserData(this);
	}

	/**
	 * Makes the body if it hasn't already been made.
	 * Note that you can call this in the entity's constructor if you'd like and supply the box2d world
	 * yourself to create the box2d shapes in the frame the object is built
	 */
	private function makeBody(world:B2World):Void
	{
		if (body == null)
		{
			var bodyDef:B2BodyDef = new B2BodyDef();
			bodyDef.position.set((x + width/2) / box2dworld.scale, (y + height/2) / box2dworld.scale);
			bodyDef.type = _Box2DOptions.type;
			
			body = world.createBody(bodyDef);
			
			buildShapes(_Box2DOptions.friction, _Box2DOptions.density, 
				_Box2DOptions.restitution, _Box2DOptions.group, _Box2DOptions.category, 
				_Box2DOptions.collmask);
			_Box2DOptions = null;
		}
	}

	/** Get the Box2D body object */
	public var body(getBody, null):B2Body;
	private function getBody():B2Body
	{
		return body;
	}

	/** Get the Box2D world the object is in */
	private var box2dworld(getBox2dworld, null):Box2DWorld;
	private function getBox2dworld():Box2DWorld
	{
		if (Std.is(HXP.world, Box2DWorld))
		return cast(HXP.world, Box2DWorld);
		return null;
	}

	/** 
	 * Overridable function to create Box2D shapes within the constructor 
	 * @param group		box2d collision group (ignore if 0)
	 * @param category	box2d collision category (ignore if 0)
	 * @param collmask	box2d collision mask (ignore if 0)
	 * @param friction
	 * @param density
	 * @param restitution	bounciness
	 */
	public function buildShapes(friction:Float, 
		density:Float, restitution:Float,
		group:Int, category:Int, collmask:Int):Void { }

	/**
	 * Overrided Update.
	 * Move the flashpunk entity to the co-ordinates specified by the 
	 * 	Box2D body. 
	 */
	override public function update():Void
	{
		if (body != null && body.getType() != B2Body.b2_staticBody)
		{
			var pos:B2Vec2 = body.getPosition();
			x = pos.x * box2dworld.scale - width / 2 + 1;
			y = pos.y * box2dworld.scale - height / 2 + 1;
			angleRads = body.getAngle();
		}
		super.update();
	}

	/**
	 * Remove the object from both worlds.
	 */
	public function remove():Void
	{
		if (box2dworld != null)
		{
			box2dworld.b2world.destroyBody(body);
			box2dworld.remove(this);
		}
	}

	/**
	 * Get the Box2D angle in degrees
	 */
	public var angle(getAngle, setAngle):Float;
	private function getAngle():Float
	{
		return body.getAngle() * 180.0 / Math.PI;
	}

	/**
	 * Set the Box2D angle in degrees (opposite of Flashpunk angle)
	 */
	private function setAngle(angle:Float):Float
	{
		body.setAngle(angle * Math.PI / 180.0);
		(cast(graphic, SuperGraphiclist)).angle = -angle;
		if (angle != 0)
		(cast(graphic, SuperGraphiclist)).smooth = true;
		return angle;
	}

	/**
	 * Get the Box2D angle in radians
	 */
	public var angleRads(getAngleRads, setAngleRads):Float;
	private function getAngleRads():Float
	{
		return body.getAngle();
	}

	/**
	 * Set the Box2D angle in radians (opposite of Flashpunk angle)
	 */
	private function setAngleRads(angle:Float):Float
	{
		body.setAngle(angle);
		(cast(graphic, SuperGraphiclist)).angle = -angle * 180.0 / Math.PI;
		if (angle != 0)
		(cast(graphic, SuperGraphiclist)).smooth = true;
		return angle;
	}

	public var X(getX, setX):Float;
	private function getX():Float { return X; }
	private function setX(v:Float):Float { X = v; return v;  }
	public var Y(getY, setY):Float;
	public function getY():Float { return Y; }
	private function setY(v:Float):Float { Y = v; return v; }
	public var Width(getWidth, setWidth):Float;
	private function getWidth():Float { return Width; }
	private function setWidth(v:Float):Float { Width = v; return v; }
	public var Height(getHeight, setHeight):Float;
	private function getHeight():Float { return Height; }
	private function setHeight(v:Float):Float { Height = v; return v; }
}