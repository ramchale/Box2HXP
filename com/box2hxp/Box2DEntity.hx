package com.box2hxp;

import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2FilterData;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.B2FixtureDef;
import box2D.dynamics.B2World;
import com.box2hxp.Box2DScene;

import com.box2hxp.graphics.SuperGraphiclist;
import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.Graphic;
import com.haxepunk.Mask;

/**
 * An HaxePunk entity which contains a Box2D body, governed by both worlds.
 */
class Box2DEntity extends Entity
{
	private var box2DOptions:Dynamic;
	private var box2dScene:Box2DScene;
	
	/** Get the Box2D body object */
	public var body:B2Body;
	
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
	public function new(scene:Box2DScene, 
		x:Float = 0, 
		y:Float = 0, 
		b2Type:Int = 0, 
		group:Int = 0, 
		category:Int = 0, 
		collmask:Int = 0)
	{
		box2dScene = scene;

		super(x, y);
		
		box2DOptions = { type: b2Type, group: group, category: category, collmask: collmask };
		
		body = null;
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
			bodyDef.position.set((x + width/2) / box2dScene.scale, (y + height/2) / box2dScene.scale);
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
			x = pos.x * box2dScene.scale - width / 2 + 1;
			y = pos.y * box2dScene.scale - height / 2 + 1;
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

}