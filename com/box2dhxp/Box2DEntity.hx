package com.box2dhxp;

import box2D.collision.shapes.B2CircleShape;
import box2D.collision.shapes.B2PolygonShape;
import box2D.collision.shapes.B2Shape;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2BodyType;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.B2FixtureDef;
import box2D.dynamics.B2World;
import com.box2dhxp.Box2DScene;
import com.haxepunk.Entity;


/**
 * An HaxePunk entity which contains a Box2D body, governed by both worlds.
 */
class Box2DEntity extends Entity
{
	private var box2DOptions:Dynamic;
	private var box2dScene:Box2DScene;
	
	/** Get the Box2D body object */
	public var body:B2Body;
	
	public var defaultDensity = 1.0;
	public var defaultFriction = 0.7;
	public var defaultRestitution = 0.4;
	
	public var graphicalXOffset = 0;
	public var graphicalYOffest = 0;
	
	/**
	 * Constructor. Sets the graphic to a SuperGraphiclist
	 * @param x		x co-ord (pixels)
	 * @param y		y co-ord (pixels)
	 * @param b2Type	box2d body type (dynamic, kinematic, static), if null then no body will be created by the constructor
	 * @param group		box2d collision group (ignored if 0)
	 * @param category	box2d collision category (ignored if 0)
	 * @param collmask	box2d collision mask (ignored if 0)
	 */
	public function new(scene:Box2DScene, 
		x:Float = 0, 
		y:Float = 0, 
		?b2Type:B2BodyType = 0, 
		group:Int = 0, 
		category:Int = 0, 
		collmask:Int = 0)
	{
		box2dScene = scene;

		super(x, y);
		
		box2DOptions = { type: b2Type, group: group, category: category, collmask: collmask };
		
		//If a body type is specifed, create one
		if(b2Type != null)
		{
			makeBody(box2dScene.b2world);
		}
		else
		{
			body = null;
		}
	}

	/** Sets the user data of the Box2D body to the Flashpunk entity */
	override public function added():Void
	{
		super.added();
		
		makeBody(box2dScene.b2world);
		
		body.setUserData(this);
	}

	/**
	 * Makes the body if it hasn't already been made.
	 * Note that you can call this in the entity's constructor if you'd like and supply the box2d world
	 * yourself to create the box2d shapes in the frame the object is built
	 */
	private function makeBody(b2World:B2World) : Void
	{
		if (body == null)
		{
			var bodyDef:B2BodyDef = new B2BodyDef();
			bodyDef.position.set(toBox2dScale(x + width / 2), toBox2dScale(y + height / 2));
			bodyDef.type = box2DOptions.type;
			
			body = b2World.createBody(bodyDef);
		}
	}
	
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
			x = (fromBox2dScale(pos.x) - width / 2 + 1) + graphicalXOffset;
			y = (fromBox2dScale(pos.y) - height / 2 + 1) + graphicalYOffest;
		}
		super.update();
	}

	/**
	 * Remove the object from both worlds.
	 */
	public function remove():Void
	{
		if (box2dScene != null)
		{
			box2dScene.b2world.destroyBody(body);
			box2dScene.remove(this);
		}
	}
	
	// TODO : y position
	@:isVar public var xPosition(get, set) : Float;
	
	private function get_xPosition() : Float
	{
		if (body != null)
		{
			var pos = body.getPosition();
			return pos.x * box2dScene.scale;
		}
		
		return x;
	}
	
	private function set_xPosition(v:Float) : Float
	{
		if (body != null)
		{
			var pos = body.getPosition();
			pos.x = toBox2dScale(v);
			body.setPosition(pos);
		}
		
		return x = v;
	}
	
	public inline function toBox2dScale(f:Float) : Float
	{
		return f / box2dScene.scale;
	}
	
	public inline function fromBox2dScale(f:Float) : Float
	{
		return f * box2dScene.scale;
	}
	
	public function movePolygonShapeByPixel(shape:B2PolygonShape, x:Float, y:Float, angle:Float = 0) : Void
	{
		Box2DUtils.movePolygonShape(shape, toBox2dScale(x), toBox2dScale(y), angle);
	}
	
	public function moveCircleShapeByPixel(shape:B2CircleShape, x:Float, y:Float, angle:Float = 0) : Void
	{
		Box2DUtils.moveCircleShape(shape, toBox2dScale(x), toBox2dScale(y));
	}
	
	public function setCircleShapePositionByPixel(shape:B2CircleShape, x:Float, y:Float, angle:Float = 0) : Void
	{
		Box2DUtils.setCircleShapePosition(shape, toBox2dScale(x), toBox2dScale(y));
	}
	
	// Fixture helpers
	
	public function addFixture(shape:B2Shape, ?density:Float, ?friction:Float, ?restitution:Float) : B2Fixture
	{
		var fixtureDef:B2FixtureDef = new B2FixtureDef();
		fixtureDef.shape = shape;
		
		fixtureDef.density = (density != null) ? density : this.defaultDensity;
		fixtureDef.friction = (friction != null) ? friction : this.defaultFriction;
		fixtureDef.restitution = (restitution != null) ? restitution : this.defaultRestitution;
		
		return body.createFixture(fixtureDef);
	}
	
	public function addRectangleFixture(width:Float, height:Float, ?density:Float, ?friction:Float, ?restitution:Float) : B2Fixture
	{
		var rectangle:B2PolygonShape = new B2PolygonShape();
		
		// SetAsBox expects half dimensions
		rectangle.setAsBox(toBox2dScale(width * 0.5), toBox2dScale(height * 0.5));
		
		return addFixture(rectangle, density, friction, restitution);
	}
	
	public function addRectangleFixtureOffset(width:Float, height:Float, xOffset:Float = 0, yOffset:Float = 0, angle:Float = 0, ?density:Float, ?friction:Float, ?restitution:Float) : B2Fixture
	{
		var rectangle:B2PolygonShape = new B2PolygonShape();
		
		// SetAsBox expects half dimensions	
		rectangle.setAsOrientedBox(toBox2dScale(width * 0.5), toBox2dScale(height * 0.5), new B2Vec2(toBox2dScale(xOffset), toBox2dScale(yOffset)), angle);
		
		return addFixture(rectangle, density, friction, restitution);
	}
	
	public function addCircleFixture(radius:Float, ?density:Float, ?friction:Float, ?restitution:Float) : B2Fixture
	{
		var circle:B2CircleShape = new B2CircleShape(toBox2dScale(radius));
		
		return addFixture(circle, density, friction, restitution);
	}
	
	public function addCircleFixtureOffset(radius:Float, xOffset:Float = 0, yOffset:Float = 0, ?density:Float, ?friction:Float, ?restitution:Float) : B2Fixture
	{
		var circle:B2CircleShape = new B2CircleShape(toBox2dScale(radius));
		circle.setLocalPosition(new B2Vec2(toBox2dScale(xOffset), toBox2dScale(yOffset)));
		
		return addFixture(circle, density, friction, restitution);
	}
}