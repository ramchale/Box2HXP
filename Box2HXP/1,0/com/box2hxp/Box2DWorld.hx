package com.box2hxp;

import box2D.collision.B2AABB;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2DebugDraw;
import box2D.dynamics.B2World;

import nme.display.Sprite;

import com.haxepunk.HXP;
import com.haxepunk.World;
import com.haxepunk.utils.Draw;

/**
 * A Flashpunk world which automatically creates and manages a Box2D world within it
 */
class Box2DWorld extends World
{
	/**
	 * Constructor.
	 */
	public function new()
	{
		super();
		
		_paused = false;
		debug = false;
		b2world = new B2World(new B2Vec2(0.0, 0.0), true);
	}

	/**
	 * The Box2D world object
	 */
	public var b2world(getB2world, null):B2World;
	private function getB2world():B2World
	{
		return b2world;
	}

	/** The default framerate (use in HXP.Engine constructor if the same) */
	public static inline var DEFAULT_FRAMERATE:Float = 30;
	/** Overridable function for getting the framerate */
	public var framerate(getFramerate, null):Float;
	private function getFramerate():Float
	{
		return DEFAULT_FRAMERATE;
	}

	/** The default pixel/metre scale */
	private static inline var DEFAULT_SCALE:Float = 30; // pixels per metre
	/** Overridable function for getting the scale of the world */
	public var scale(getScale, null):Float;
	private function getScale():Float
	{
		return DEFAULT_SCALE;
	}

	/** The default number of position iterations */
	private static inline var DEFAULT_PITERATIONS:Float = 10; // pixels per metre
	/** Overridable function for getting the number of position iterations */
	private var positionIterations(getPositionIterations, null):Int;
		private function getPositionIterations():Int
	{
		return DEFAULT_PITERATIONS;
	}
	/** The default number of velocity iterations */
	private static inline var DEFAULT_VITERATIONS:Float = 10; // pixels per metre
	/** Overridable function for getting the number of velocity iterations */
	private var velocityIterations(getVelocityIterations, null):Int;
	private function getVelocityIterations():Int
	{
		return DEFAULT_VITERATIONS;
	}

	/**
	 * Set the gravity of the world
	 */
	public function setGravity(grav:B2Vec2):Void
	{
		b2world.setGravity(grav);
	}

	/**
	 * Update override.
	 * When not paused, updates the b2world.
	 * draws debugging data
	 */
	override public function update():Void
	{
		if (!paused)
		{
			b2world.step(1.0 / framerate, velocityIterations, positionIterations);
			b2world.clearForces();
		}
		if (debug)
		{
			debug_sprite.x = -camera.x * HXP.screen.scale + HXP.screen.x;
			debug_sprite.y = -camera.y * HXP.screen.scale + HXP.screen.y;
			debug_sprite.scaleX = HXP.screen.scale;
			debug_sprite.scaleY = HXP.screen.scale;
			b2world.drawDebugData();
		}
		super.update();
	}

	/**
	 * Setup debug drawing
	 */
	private function debug_draw():Void
	{
		debug_sprite = new Sprite();
		HXP.stage.addChild(debug_sprite);
		var dbgDraw:B2DebugDraw = new B2DebugDraw();
		var dbgSprite:Sprite = new Sprite();
		debug_sprite.addChild(dbgSprite);
		dbgDraw.setSprite(debug_sprite);
		dbgDraw.setDrawScale(scale);
		dbgDraw.setFillAlpha(0.5);
		dbgDraw.setLineThickness(1);
		dbgDraw.setFlags(B2DebugDraw.e_shapeBit|
						B2DebugDraw.e_jointBit |
						B2DebugDraw.e_pairBit |
						B2DebugDraw.e_centerOfMassBit);
		b2world.setDebugDraw(dbgDraw);
	}

	/**
	 * Called to set up debugging in the world
	 */
	private function doDebug():Void
	{
		debug_draw();
		debug = true;
	}

	/**
	 * Override End function. Finalises debugging.
	 */
	override public function end():Void
	{
		if (debug)
		HXP.stage.removeChild(debug_sprite);
	}

	/** Pauses the game */
	public function pause():Void { _paused = true; }
	/** Unpauses the game */
	public function unpause():Void { _paused = false; }
	/** The current pause state */
	public var paused(getPaused, null):Bool;
	private function getPaused():Bool { return _paused; }

	private var _paused:Bool;
	private var debug:Bool;
	private var debug_sprite:Sprite;
}