*Note: Still a work in progress, but the basics are working*

Getting started
---------------

From a command line run

    haxelib git box2d-hxp https://github.com/ramchale/Box2HXP.git

Add the dependency to the project.xml

    <haxelib name="box2d-hxp" />

For your scene use Box2DScene

For any physics objects use Box2DEntity

Then in the entity constructor create the box2d body and fixtures

    public function new(scene:Box2DScene, x:Float, y:Float)
    {
        super(scene, x, y, B2BodyType.KINEMATIC_BODY);
        
        image = new Image("graphics/SomeImage.png");
        this.graphic = image;
		this.graphicalXOffset = -4;
		this.graphicalYOffest = -10;

        this.makeBody(scene.b2world);
		this.addRectangleFixture(10, 30);

		this.body.setLinearVelocity(new B2Vec2(0, 1));
    }
