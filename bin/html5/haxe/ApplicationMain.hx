#if !macro


@:access(lime.Assets)


class ApplicationMain {
	
	
	public static var config:lime.app.Config;
	public static var preloader:openfl.display.Preloader;
	
	
	public static function create ():Void {
		
		var app = new lime.app.Application ();
		app.create (config);
		openfl.Lib.application = app;
		
		#if !flash
		var stage = new openfl.display.Stage (app.window.width, app.window.height, config.background);
		stage.addChild (openfl.Lib.current);
		app.addModule (stage);
		#end
		
		var display = new NMEPreloader ();
		
		preloader = new openfl.display.Preloader (display);
		preloader.onComplete = init;
		preloader.create (config);
		
		#if (js && html5)
		var urls = [];
		var types = [];
		
		
		urls.push ("gfx/04b.fnt");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("gfx/04b.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/04f.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/a-hd.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/about-bg.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/about-fade.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/alagard-bmfont.fnt");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("gfx/alagard-bmfont.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/arial.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/atlas.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/b1.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/b2.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/background.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/background3.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/block.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/blocks.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/btn-about-down.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/btn-about-normal.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/btn-about-selected.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/btn-about.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/btn-done-down.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/btn-done.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/btn-highscores-normal.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/btn-highscores-selected.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/btn-play-down.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/btn-play-normal.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/btn-play-selected.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/btn-play.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/character.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/defaultSkin.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/drugs_particle.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/esmoke.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/explosion.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/f1.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/f2.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/fire.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/fire_particle.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/fps_images.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/grossini.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/grossinis_sister1-testalpha.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/grossinis_sister1.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/grossinis_sister2.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/grossini_dance_atlas-mono.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/grossini_dance_atlas.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/heart.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/jellyfish_particle.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/magenta.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/menu.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/nesSkin.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/new_super_mario-littera.fnt");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("gfx/new_super_mario-littera.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/particle_circle.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/pattern1.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/pirate.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/powered.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/r1.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/r2.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/round_font-pixelizer.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/slope.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/smoke.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/snow.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/spark.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/spaz_font.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/spritesheet1.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/stars.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/stars2.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/streak.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/sun_particle.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/swordguy.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/texture.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/tile.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/tiles3.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/tinyfont.fnt");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("gfx/tinyfont.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/tuffy_bold_italic-charmap.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/tuffy_bold_italic-charmap_s.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("gfx/xfilesfnt.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("atlas/a-hd.plist");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("atlas/atlas.xml");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("atlas/campfire.pex");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("atlas/campfireSmoke.pex");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("atlas/candle.pex");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("atlas/drugs.pex");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("atlas/exahust.pex");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("atlas/explode.pex");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("atlas/explosion.pex");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("atlas/explosion.plist");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("atlas/fire.pex");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("atlas/jellyfish.pex");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("atlas/level0.tmx");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("atlas/level1.tmx");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("atlas/love.pex");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("atlas/particle.pex");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("atlas/particleCoffee.pex");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("atlas/particleMushroom.pex");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("atlas/shower.pex");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("atlas/snow.pex");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("atlas/sprites.xml");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("atlas/sun.pex");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("atlas/Torch.pex");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		
		if (config.assetsPrefix != null) {
			
			for (i in 0...urls.length) {
				
				if (types[i] != lime.Assets.AssetType.FONT) {
					
					urls[i] = config.assetsPrefix + urls[i];
					
				}
				
			}
			
		}
		
		preloader.load (urls, types);
		#end
		
		var result = app.exec ();
		
		#if (sys && !nodejs && !emscripten)
		Sys.exit (result);
		#end
		
	}
	
	
	public static function init ():Void {
		
		var loaded = 0;
		var total = 0;
		var library_onLoad = function (__) {
			
			loaded++;
			
			if (loaded == total) {
				
				start ();
				
			}
			
		}
		
		preloader = null;
		
		
		
		if (loaded == total) {
			
			start ();
			
		}
		
	}
	
	
	public static function main () {
		
		config = {
			
			antialiasing: Std.int (0),
			background: Std.int (16086510),
			borderless: false,
			company: "djoker soft",
			depthBuffer: false,
			file: "flashpunk",
			fps: Std.int (1000),
			fullscreen: false,
			hardware: true,
			height: Std.int (320),
			orientation: "landscape",
			packageName: "com.flashpunk.glteste",
			resizable: true,
			stencilBuffer: true,
			title: "flashpunk",
			version: "1.0.0",
			vsync: false,
			width: Std.int (480),
			
		}
		
		#if (js && html5)
		#if (munit || utest)
		openfl.Lib.embed (null, 480, 320, "F575EE");
		#end
		#else
		create ();
		#end
		
	}
	
	
	public static function start ():Void {
		
		var hasMain = false;
		var entryPoint = Type.resolveClass ("Main");
		
		for (methodName in Type.getClassFields (entryPoint)) {
			
			if (methodName == "main") {
				
				hasMain = true;
				break;
				
			}
			
		}
		
		lime.Assets.initialize ();
		
		if (hasMain) {
			
			Reflect.callMethod (entryPoint, Reflect.field (entryPoint, "main"), []);
			
		} else {
			
			var instance:DocumentClass = Type.createInstance (DocumentClass, []);
			
			/*if (Std.is (instance, openfl.display.DisplayObject)) {
				
				openfl.Lib.current.addChild (cast instance);
				
			}*/
			
		}
		
		openfl.Lib.current.stage.dispatchEvent (new openfl.events.Event (openfl.events.Event.RESIZE, false, false));
		
	}
	
	
	#if neko
	@:noCompletion public static function __init__ () {
		
		var loader = new neko.vm.Loader (untyped $loader);
		loader.addPath (haxe.io.Path.directory (Sys.executablePath ()));
		loader.addPath ("./");
		loader.addPath ("@executable_path/");
		
	}
	#end
	
	
}


@:build(DocumentClass.build())
@:keep class DocumentClass extends Main {}


#else


import haxe.macro.Context;
import haxe.macro.Expr;


class DocumentClass {
	
	
	macro public static function build ():Array<Field> {
		
		var classType = Context.getLocalClass ().get ();
		var searchTypes = classType;
		
		while (searchTypes.superClass != null) {
			
			if (searchTypes.pack.length == 2 && searchTypes.pack[1] == "display" && searchTypes.name == "DisplayObject") {
				
				var fields = Context.getBuildFields ();
				
				var method = macro {
					
					openfl.Lib.current.addChild (this);
					super ();
					dispatchEvent (new openfl.events.Event (openfl.events.Event.ADDED_TO_STAGE, false, false));
					
				}
				
				fields.push ({ name: "new", access: [ APublic ], kind: FFun({ args: [], expr: method, params: [], ret: macro :Void }), pos: Context.currentPos () });
				
				return fields;
				
			}
			
			searchTypes = searchTypes.superClass.t.get ();
			
		}
		
		return null;
		
	}
	
	
}


#end
