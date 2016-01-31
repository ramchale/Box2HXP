*Note: Still a work in progress, but the basics are working*

Getting started

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
        image.x - 3;

        this.makeBody(scene.b2world);
        
        var fixtureDef:B2FixtureDef = new B2FixtureDef();
        
        var rectangle:B2PolygonShape = new B2PolygonShape();
        // SetAsBox expects half dimensions
        rectangle.setAsBox(10 * 0.5 * (1 / scene.scale), 30 * 0.5 * (1 / scene.scale));

        fixtureDef.shape = rectangle;
        fixtureDef.density = 1.0;
        fixtureDef.friction = 0.4;
        fixtureDef.restitution = 0.8;
        var fixture = body.createFixture(fixtureDef);

        this.graphic = image;

        this.body.setLinearVelocity(new B2Vec2(0, 1));
    }
