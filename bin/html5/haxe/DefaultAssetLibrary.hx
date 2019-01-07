package;


import haxe.Timer;
import haxe.Unserializer;
import lime.app.Preloader;
import lime.audio.AudioSource;
import lime.audio.openal.AL;
import lime.audio.AudioBuffer;
import lime.graphics.Image;
import lime.text.Font;
import lime.utils.ByteArray;
import lime.utils.UInt8Array;
import lime.Assets;

#if sys
import sys.FileSystem;
#end

#if flash
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.events.Event;
import flash.media.Sound;
import flash.net.URLLoader;
import flash.net.URLRequest;
#end


class DefaultAssetLibrary extends AssetLibrary {
	
	
	public var className (default, null) = new Map <String, Dynamic> ();
	public var path (default, null) = new Map <String, String> ();
	public var type (default, null) = new Map <String, AssetType> ();
	
	private var lastModified:Float;
	private var timer:Timer;
	
	
	public function new () {
		
		super ();
		
		#if flash
		
		className.set ("gfx/04b.fnt", __ASSET__gfx_04b_fnt);
		type.set ("gfx/04b.fnt", AssetType.TEXT);
		className.set ("gfx/04b.png", __ASSET__gfx_04b_png);
		type.set ("gfx/04b.png", AssetType.IMAGE);
		className.set ("gfx/04f.png", __ASSET__gfx_04f_png);
		type.set ("gfx/04f.png", AssetType.IMAGE);
		className.set ("gfx/a-hd.png", __ASSET__gfx_a_hd_png);
		type.set ("gfx/a-hd.png", AssetType.IMAGE);
		className.set ("gfx/about-bg.png", __ASSET__gfx_about_bg_png);
		type.set ("gfx/about-bg.png", AssetType.IMAGE);
		className.set ("gfx/about-fade.png", __ASSET__gfx_about_fade_png);
		type.set ("gfx/about-fade.png", AssetType.IMAGE);
		className.set ("gfx/alagard-bmfont.fnt", __ASSET__gfx_alagard_bmfont_fnt);
		type.set ("gfx/alagard-bmfont.fnt", AssetType.TEXT);
		className.set ("gfx/alagard-bmfont.png", __ASSET__gfx_alagard_bmfont_png);
		type.set ("gfx/alagard-bmfont.png", AssetType.IMAGE);
		className.set ("gfx/arial.png", __ASSET__gfx_arial_png);
		type.set ("gfx/arial.png", AssetType.IMAGE);
		className.set ("gfx/atlas.png", __ASSET__gfx_atlas_png);
		type.set ("gfx/atlas.png", AssetType.IMAGE);
		className.set ("gfx/b1.png", __ASSET__gfx_b1_png);
		type.set ("gfx/b1.png", AssetType.IMAGE);
		className.set ("gfx/b2.png", __ASSET__gfx_b2_png);
		type.set ("gfx/b2.png", AssetType.IMAGE);
		className.set ("gfx/background.png", __ASSET__gfx_background_png);
		type.set ("gfx/background.png", AssetType.IMAGE);
		className.set ("gfx/background3.png", __ASSET__gfx_background3_png);
		type.set ("gfx/background3.png", AssetType.IMAGE);
		className.set ("gfx/block.png", __ASSET__gfx_block_png);
		type.set ("gfx/block.png", AssetType.IMAGE);
		className.set ("gfx/blocks.png", __ASSET__gfx_blocks_png);
		type.set ("gfx/blocks.png", AssetType.IMAGE);
		className.set ("gfx/btn-about-down.png", __ASSET__gfx_btn_about_down_png);
		type.set ("gfx/btn-about-down.png", AssetType.IMAGE);
		className.set ("gfx/btn-about-normal.png", __ASSET__gfx_btn_about_normal_png);
		type.set ("gfx/btn-about-normal.png", AssetType.IMAGE);
		className.set ("gfx/btn-about-selected.png", __ASSET__gfx_btn_about_selected_png);
		type.set ("gfx/btn-about-selected.png", AssetType.IMAGE);
		className.set ("gfx/btn-about.png", __ASSET__gfx_btn_about_png);
		type.set ("gfx/btn-about.png", AssetType.IMAGE);
		className.set ("gfx/btn-done-down.png", __ASSET__gfx_btn_done_down_png);
		type.set ("gfx/btn-done-down.png", AssetType.IMAGE);
		className.set ("gfx/btn-done.png", __ASSET__gfx_btn_done_png);
		type.set ("gfx/btn-done.png", AssetType.IMAGE);
		className.set ("gfx/btn-highscores-normal.png", __ASSET__gfx_btn_highscores_normal_png);
		type.set ("gfx/btn-highscores-normal.png", AssetType.IMAGE);
		className.set ("gfx/btn-highscores-selected.png", __ASSET__gfx_btn_highscores_selected_png);
		type.set ("gfx/btn-highscores-selected.png", AssetType.IMAGE);
		className.set ("gfx/btn-play-down.png", __ASSET__gfx_btn_play_down_png);
		type.set ("gfx/btn-play-down.png", AssetType.IMAGE);
		className.set ("gfx/btn-play-normal.png", __ASSET__gfx_btn_play_normal_png);
		type.set ("gfx/btn-play-normal.png", AssetType.IMAGE);
		className.set ("gfx/btn-play-selected.png", __ASSET__gfx_btn_play_selected_png);
		type.set ("gfx/btn-play-selected.png", AssetType.IMAGE);
		className.set ("gfx/btn-play.png", __ASSET__gfx_btn_play_png);
		type.set ("gfx/btn-play.png", AssetType.IMAGE);
		className.set ("gfx/character.png", __ASSET__gfx_character_png);
		type.set ("gfx/character.png", AssetType.IMAGE);
		className.set ("gfx/defaultSkin.png", __ASSET__gfx_defaultskin_png);
		type.set ("gfx/defaultSkin.png", AssetType.IMAGE);
		className.set ("gfx/drugs_particle.png", __ASSET__gfx_drugs_particle_png);
		type.set ("gfx/drugs_particle.png", AssetType.IMAGE);
		className.set ("gfx/esmoke.png", __ASSET__gfx_esmoke_png);
		type.set ("gfx/esmoke.png", AssetType.IMAGE);
		className.set ("gfx/explosion.png", __ASSET__gfx_explosion_png);
		type.set ("gfx/explosion.png", AssetType.IMAGE);
		className.set ("gfx/f1.png", __ASSET__gfx_f1_png);
		type.set ("gfx/f1.png", AssetType.IMAGE);
		className.set ("gfx/f2.png", __ASSET__gfx_f2_png);
		type.set ("gfx/f2.png", AssetType.IMAGE);
		className.set ("gfx/fire.png", __ASSET__gfx_fire_png);
		type.set ("gfx/fire.png", AssetType.IMAGE);
		className.set ("gfx/fire_particle.png", __ASSET__gfx_fire_particle_png);
		type.set ("gfx/fire_particle.png", AssetType.IMAGE);
		className.set ("gfx/fps_images.png", __ASSET__gfx_fps_images_png);
		type.set ("gfx/fps_images.png", AssetType.IMAGE);
		className.set ("gfx/grossini.png", __ASSET__gfx_grossini_png);
		type.set ("gfx/grossini.png", AssetType.IMAGE);
		className.set ("gfx/grossinis_sister1-testalpha.png", __ASSET__gfx_grossinis_sister1_testalpha_png);
		type.set ("gfx/grossinis_sister1-testalpha.png", AssetType.IMAGE);
		className.set ("gfx/grossinis_sister1.png", __ASSET__gfx_grossinis_sister1_png);
		type.set ("gfx/grossinis_sister1.png", AssetType.IMAGE);
		className.set ("gfx/grossinis_sister2.png", __ASSET__gfx_grossinis_sister2_png);
		type.set ("gfx/grossinis_sister2.png", AssetType.IMAGE);
		className.set ("gfx/grossini_dance_atlas-mono.png", __ASSET__gfx_grossini_dance_atlas_mono_png);
		type.set ("gfx/grossini_dance_atlas-mono.png", AssetType.IMAGE);
		className.set ("gfx/grossini_dance_atlas.png", __ASSET__gfx_grossini_dance_atlas_png);
		type.set ("gfx/grossini_dance_atlas.png", AssetType.IMAGE);
		className.set ("gfx/heart.png", __ASSET__gfx_heart_png);
		type.set ("gfx/heart.png", AssetType.IMAGE);
		className.set ("gfx/jellyfish_particle.png", __ASSET__gfx_jellyfish_particle_png);
		type.set ("gfx/jellyfish_particle.png", AssetType.IMAGE);
		className.set ("gfx/magenta.png", __ASSET__gfx_magenta_png);
		type.set ("gfx/magenta.png", AssetType.IMAGE);
		className.set ("gfx/menu.png", __ASSET__gfx_menu_png);
		type.set ("gfx/menu.png", AssetType.IMAGE);
		className.set ("gfx/nesSkin.png", __ASSET__gfx_nesskin_png);
		type.set ("gfx/nesSkin.png", AssetType.IMAGE);
		className.set ("gfx/new_super_mario-littera.fnt", __ASSET__gfx_new_super_mario_littera_fnt);
		type.set ("gfx/new_super_mario-littera.fnt", AssetType.TEXT);
		className.set ("gfx/new_super_mario-littera.png", __ASSET__gfx_new_super_mario_littera_png);
		type.set ("gfx/new_super_mario-littera.png", AssetType.IMAGE);
		className.set ("gfx/particle_circle.png", __ASSET__gfx_particle_circle_png);
		type.set ("gfx/particle_circle.png", AssetType.IMAGE);
		className.set ("gfx/pattern1.png", __ASSET__gfx_pattern1_png);
		type.set ("gfx/pattern1.png", AssetType.IMAGE);
		className.set ("gfx/pirate.png", __ASSET__gfx_pirate_png);
		type.set ("gfx/pirate.png", AssetType.IMAGE);
		className.set ("gfx/powered.png", __ASSET__gfx_powered_png);
		type.set ("gfx/powered.png", AssetType.IMAGE);
		className.set ("gfx/r1.png", __ASSET__gfx_r1_png);
		type.set ("gfx/r1.png", AssetType.IMAGE);
		className.set ("gfx/r2.png", __ASSET__gfx_r2_png);
		type.set ("gfx/r2.png", AssetType.IMAGE);
		className.set ("gfx/round_font-pixelizer.png", __ASSET__gfx_round_font_pixelizer_png);
		type.set ("gfx/round_font-pixelizer.png", AssetType.IMAGE);
		className.set ("gfx/slope.png", __ASSET__gfx_slope_png);
		type.set ("gfx/slope.png", AssetType.IMAGE);
		className.set ("gfx/smoke.png", __ASSET__gfx_smoke_png);
		type.set ("gfx/smoke.png", AssetType.IMAGE);
		className.set ("gfx/snow.png", __ASSET__gfx_snow_png);
		type.set ("gfx/snow.png", AssetType.IMAGE);
		className.set ("gfx/spark.png", __ASSET__gfx_spark_png);
		type.set ("gfx/spark.png", AssetType.IMAGE);
		className.set ("gfx/spaz_font.png", __ASSET__gfx_spaz_font_png);
		type.set ("gfx/spaz_font.png", AssetType.IMAGE);
		className.set ("gfx/spritesheet1.png", __ASSET__gfx_spritesheet1_png);
		type.set ("gfx/spritesheet1.png", AssetType.IMAGE);
		className.set ("gfx/stars.png", __ASSET__gfx_stars_png);
		type.set ("gfx/stars.png", AssetType.IMAGE);
		className.set ("gfx/stars2.png", __ASSET__gfx_stars2_png);
		type.set ("gfx/stars2.png", AssetType.IMAGE);
		className.set ("gfx/streak.png", __ASSET__gfx_streak_png);
		type.set ("gfx/streak.png", AssetType.IMAGE);
		className.set ("gfx/sun_particle.png", __ASSET__gfx_sun_particle_png);
		type.set ("gfx/sun_particle.png", AssetType.IMAGE);
		className.set ("gfx/swordguy.png", __ASSET__gfx_swordguy_png);
		type.set ("gfx/swordguy.png", AssetType.IMAGE);
		className.set ("gfx/texture.png", __ASSET__gfx_texture_png);
		type.set ("gfx/texture.png", AssetType.IMAGE);
		className.set ("gfx/tile.png", __ASSET__gfx_tile_png);
		type.set ("gfx/tile.png", AssetType.IMAGE);
		className.set ("gfx/tiles3.png", __ASSET__gfx_tiles3_png);
		type.set ("gfx/tiles3.png", AssetType.IMAGE);
		className.set ("gfx/tinyfont.fnt", __ASSET__gfx_tinyfont_fnt);
		type.set ("gfx/tinyfont.fnt", AssetType.TEXT);
		className.set ("gfx/tinyfont.png", __ASSET__gfx_tinyfont_png);
		type.set ("gfx/tinyfont.png", AssetType.IMAGE);
		className.set ("gfx/tuffy_bold_italic-charmap.png", __ASSET__gfx_tuffy_bold_italic_charmap_png);
		type.set ("gfx/tuffy_bold_italic-charmap.png", AssetType.IMAGE);
		className.set ("gfx/tuffy_bold_italic-charmap_s.png", __ASSET__gfx_tuffy_bold_italic_charmap_s_png);
		type.set ("gfx/tuffy_bold_italic-charmap_s.png", AssetType.IMAGE);
		className.set ("gfx/xfilesfnt.png", __ASSET__gfx_xfilesfnt_png);
		type.set ("gfx/xfilesfnt.png", AssetType.IMAGE);
		className.set ("atlas/a-hd.plist", __ASSET__atlas_a_hd_plist);
		type.set ("atlas/a-hd.plist", AssetType.TEXT);
		className.set ("atlas/atlas.xml", __ASSET__atlas_atlas_xml);
		type.set ("atlas/atlas.xml", AssetType.TEXT);
		className.set ("atlas/campfire.pex", __ASSET__atlas_campfire_pex);
		type.set ("atlas/campfire.pex", AssetType.TEXT);
		className.set ("atlas/campfireSmoke.pex", __ASSET__atlas_campfiresmoke_pex);
		type.set ("atlas/campfireSmoke.pex", AssetType.TEXT);
		className.set ("atlas/candle.pex", __ASSET__atlas_candle_pex);
		type.set ("atlas/candle.pex", AssetType.TEXT);
		className.set ("atlas/drugs.pex", __ASSET__atlas_drugs_pex);
		type.set ("atlas/drugs.pex", AssetType.TEXT);
		className.set ("atlas/exahust.pex", __ASSET__atlas_exahust_pex);
		type.set ("atlas/exahust.pex", AssetType.TEXT);
		className.set ("atlas/explode.pex", __ASSET__atlas_explode_pex);
		type.set ("atlas/explode.pex", AssetType.TEXT);
		className.set ("atlas/explosion.pex", __ASSET__atlas_explosion_pex);
		type.set ("atlas/explosion.pex", AssetType.TEXT);
		className.set ("atlas/explosion.plist", __ASSET__atlas_explosion_plist);
		type.set ("atlas/explosion.plist", AssetType.TEXT);
		className.set ("atlas/fire.pex", __ASSET__atlas_fire_pex);
		type.set ("atlas/fire.pex", AssetType.TEXT);
		className.set ("atlas/jellyfish.pex", __ASSET__atlas_jellyfish_pex);
		type.set ("atlas/jellyfish.pex", AssetType.TEXT);
		className.set ("atlas/level0.tmx", __ASSET__atlas_level0_tmx);
		type.set ("atlas/level0.tmx", AssetType.TEXT);
		className.set ("atlas/level1.tmx", __ASSET__atlas_level1_tmx);
		type.set ("atlas/level1.tmx", AssetType.TEXT);
		className.set ("atlas/love.pex", __ASSET__atlas_love_pex);
		type.set ("atlas/love.pex", AssetType.TEXT);
		className.set ("atlas/particle.pex", __ASSET__atlas_particle_pex);
		type.set ("atlas/particle.pex", AssetType.TEXT);
		className.set ("atlas/particleCoffee.pex", __ASSET__atlas_particlecoffee_pex);
		type.set ("atlas/particleCoffee.pex", AssetType.TEXT);
		className.set ("atlas/particleMushroom.pex", __ASSET__atlas_particlemushroom_pex);
		type.set ("atlas/particleMushroom.pex", AssetType.TEXT);
		className.set ("atlas/shower.pex", __ASSET__atlas_shower_pex);
		type.set ("atlas/shower.pex", AssetType.TEXT);
		className.set ("atlas/snow.pex", __ASSET__atlas_snow_pex);
		type.set ("atlas/snow.pex", AssetType.TEXT);
		className.set ("atlas/sprites.xml", __ASSET__atlas_sprites_xml);
		type.set ("atlas/sprites.xml", AssetType.TEXT);
		className.set ("atlas/sun.pex", __ASSET__atlas_sun_pex);
		type.set ("atlas/sun.pex", AssetType.TEXT);
		className.set ("atlas/Torch.pex", __ASSET__atlas_torch_pex);
		type.set ("atlas/Torch.pex", AssetType.TEXT);
		
		
		#elseif html5
		
		var id;
		id = "gfx/04b.fnt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "gfx/04b.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/04f.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/a-hd.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/about-bg.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/about-fade.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/alagard-bmfont.fnt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "gfx/alagard-bmfont.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/arial.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/atlas.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/b1.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/b2.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/background.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/background3.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/block.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/blocks.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/btn-about-down.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/btn-about-normal.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/btn-about-selected.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/btn-about.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/btn-done-down.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/btn-done.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/btn-highscores-normal.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/btn-highscores-selected.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/btn-play-down.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/btn-play-normal.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/btn-play-selected.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/btn-play.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/character.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/defaultSkin.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/drugs_particle.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/esmoke.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/explosion.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/f1.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/f2.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/fire.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/fire_particle.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/fps_images.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/grossini.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/grossinis_sister1-testalpha.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/grossinis_sister1.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/grossinis_sister2.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/grossini_dance_atlas-mono.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/grossini_dance_atlas.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/heart.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/jellyfish_particle.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/magenta.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/menu.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/nesSkin.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/new_super_mario-littera.fnt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "gfx/new_super_mario-littera.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/particle_circle.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/pattern1.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/pirate.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/powered.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/r1.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/r2.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/round_font-pixelizer.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/slope.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/smoke.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/snow.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/spark.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/spaz_font.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/spritesheet1.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/stars.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/stars2.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/streak.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/sun_particle.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/swordguy.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/texture.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/tile.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/tiles3.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/tinyfont.fnt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "gfx/tinyfont.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/tuffy_bold_italic-charmap.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/tuffy_bold_italic-charmap_s.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "gfx/xfilesfnt.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "atlas/a-hd.plist";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "atlas/atlas.xml";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "atlas/campfire.pex";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "atlas/campfireSmoke.pex";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "atlas/candle.pex";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "atlas/drugs.pex";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "atlas/exahust.pex";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "atlas/explode.pex";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "atlas/explosion.pex";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "atlas/explosion.plist";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "atlas/fire.pex";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "atlas/jellyfish.pex";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "atlas/level0.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "atlas/level1.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "atlas/love.pex";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "atlas/particle.pex";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "atlas/particleCoffee.pex";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "atlas/particleMushroom.pex";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "atlas/shower.pex";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "atlas/snow.pex";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "atlas/sprites.xml";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "atlas/sun.pex";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "atlas/Torch.pex";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		
		
		var assetsPrefix = ApplicationMain.config.assetsPrefix;
		if (assetsPrefix != null) {
			for (k in path.keys()) {
				path.set(k, assetsPrefix + path[k]);
			}
		}
		
		#else
		
		#if openfl
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		#end
		
		#if (windows || mac || linux)
		
		var useManifest = false;
		
		className.set ("gfx/04b.fnt", __ASSET__gfx_04b_fnt);
		type.set ("gfx/04b.fnt", AssetType.TEXT);
		
		className.set ("gfx/04b.png", __ASSET__gfx_04b_png);
		type.set ("gfx/04b.png", AssetType.IMAGE);
		
		className.set ("gfx/04f.png", __ASSET__gfx_04f_png);
		type.set ("gfx/04f.png", AssetType.IMAGE);
		
		className.set ("gfx/a-hd.png", __ASSET__gfx_a_hd_png);
		type.set ("gfx/a-hd.png", AssetType.IMAGE);
		
		className.set ("gfx/about-bg.png", __ASSET__gfx_about_bg_png);
		type.set ("gfx/about-bg.png", AssetType.IMAGE);
		
		className.set ("gfx/about-fade.png", __ASSET__gfx_about_fade_png);
		type.set ("gfx/about-fade.png", AssetType.IMAGE);
		
		className.set ("gfx/alagard-bmfont.fnt", __ASSET__gfx_alagard_bmfont_fnt);
		type.set ("gfx/alagard-bmfont.fnt", AssetType.TEXT);
		
		className.set ("gfx/alagard-bmfont.png", __ASSET__gfx_alagard_bmfont_png);
		type.set ("gfx/alagard-bmfont.png", AssetType.IMAGE);
		
		className.set ("gfx/arial.png", __ASSET__gfx_arial_png);
		type.set ("gfx/arial.png", AssetType.IMAGE);
		
		className.set ("gfx/atlas.png", __ASSET__gfx_atlas_png);
		type.set ("gfx/atlas.png", AssetType.IMAGE);
		
		className.set ("gfx/b1.png", __ASSET__gfx_b1_png);
		type.set ("gfx/b1.png", AssetType.IMAGE);
		
		className.set ("gfx/b2.png", __ASSET__gfx_b2_png);
		type.set ("gfx/b2.png", AssetType.IMAGE);
		
		className.set ("gfx/background.png", __ASSET__gfx_background_png);
		type.set ("gfx/background.png", AssetType.IMAGE);
		
		className.set ("gfx/background3.png", __ASSET__gfx_background3_png);
		type.set ("gfx/background3.png", AssetType.IMAGE);
		
		className.set ("gfx/block.png", __ASSET__gfx_block_png);
		type.set ("gfx/block.png", AssetType.IMAGE);
		
		className.set ("gfx/blocks.png", __ASSET__gfx_blocks_png);
		type.set ("gfx/blocks.png", AssetType.IMAGE);
		
		className.set ("gfx/btn-about-down.png", __ASSET__gfx_btn_about_down_png);
		type.set ("gfx/btn-about-down.png", AssetType.IMAGE);
		
		className.set ("gfx/btn-about-normal.png", __ASSET__gfx_btn_about_normal_png);
		type.set ("gfx/btn-about-normal.png", AssetType.IMAGE);
		
		className.set ("gfx/btn-about-selected.png", __ASSET__gfx_btn_about_selected_png);
		type.set ("gfx/btn-about-selected.png", AssetType.IMAGE);
		
		className.set ("gfx/btn-about.png", __ASSET__gfx_btn_about_png);
		type.set ("gfx/btn-about.png", AssetType.IMAGE);
		
		className.set ("gfx/btn-done-down.png", __ASSET__gfx_btn_done_down_png);
		type.set ("gfx/btn-done-down.png", AssetType.IMAGE);
		
		className.set ("gfx/btn-done.png", __ASSET__gfx_btn_done_png);
		type.set ("gfx/btn-done.png", AssetType.IMAGE);
		
		className.set ("gfx/btn-highscores-normal.png", __ASSET__gfx_btn_highscores_normal_png);
		type.set ("gfx/btn-highscores-normal.png", AssetType.IMAGE);
		
		className.set ("gfx/btn-highscores-selected.png", __ASSET__gfx_btn_highscores_selected_png);
		type.set ("gfx/btn-highscores-selected.png", AssetType.IMAGE);
		
		className.set ("gfx/btn-play-down.png", __ASSET__gfx_btn_play_down_png);
		type.set ("gfx/btn-play-down.png", AssetType.IMAGE);
		
		className.set ("gfx/btn-play-normal.png", __ASSET__gfx_btn_play_normal_png);
		type.set ("gfx/btn-play-normal.png", AssetType.IMAGE);
		
		className.set ("gfx/btn-play-selected.png", __ASSET__gfx_btn_play_selected_png);
		type.set ("gfx/btn-play-selected.png", AssetType.IMAGE);
		
		className.set ("gfx/btn-play.png", __ASSET__gfx_btn_play_png);
		type.set ("gfx/btn-play.png", AssetType.IMAGE);
		
		className.set ("gfx/character.png", __ASSET__gfx_character_png);
		type.set ("gfx/character.png", AssetType.IMAGE);
		
		className.set ("gfx/defaultSkin.png", __ASSET__gfx_defaultskin_png);
		type.set ("gfx/defaultSkin.png", AssetType.IMAGE);
		
		className.set ("gfx/drugs_particle.png", __ASSET__gfx_drugs_particle_png);
		type.set ("gfx/drugs_particle.png", AssetType.IMAGE);
		
		className.set ("gfx/esmoke.png", __ASSET__gfx_esmoke_png);
		type.set ("gfx/esmoke.png", AssetType.IMAGE);
		
		className.set ("gfx/explosion.png", __ASSET__gfx_explosion_png);
		type.set ("gfx/explosion.png", AssetType.IMAGE);
		
		className.set ("gfx/f1.png", __ASSET__gfx_f1_png);
		type.set ("gfx/f1.png", AssetType.IMAGE);
		
		className.set ("gfx/f2.png", __ASSET__gfx_f2_png);
		type.set ("gfx/f2.png", AssetType.IMAGE);
		
		className.set ("gfx/fire.png", __ASSET__gfx_fire_png);
		type.set ("gfx/fire.png", AssetType.IMAGE);
		
		className.set ("gfx/fire_particle.png", __ASSET__gfx_fire_particle_png);
		type.set ("gfx/fire_particle.png", AssetType.IMAGE);
		
		className.set ("gfx/fps_images.png", __ASSET__gfx_fps_images_png);
		type.set ("gfx/fps_images.png", AssetType.IMAGE);
		
		className.set ("gfx/grossini.png", __ASSET__gfx_grossini_png);
		type.set ("gfx/grossini.png", AssetType.IMAGE);
		
		className.set ("gfx/grossinis_sister1-testalpha.png", __ASSET__gfx_grossinis_sister1_testalpha_png);
		type.set ("gfx/grossinis_sister1-testalpha.png", AssetType.IMAGE);
		
		className.set ("gfx/grossinis_sister1.png", __ASSET__gfx_grossinis_sister1_png);
		type.set ("gfx/grossinis_sister1.png", AssetType.IMAGE);
		
		className.set ("gfx/grossinis_sister2.png", __ASSET__gfx_grossinis_sister2_png);
		type.set ("gfx/grossinis_sister2.png", AssetType.IMAGE);
		
		className.set ("gfx/grossini_dance_atlas-mono.png", __ASSET__gfx_grossini_dance_atlas_mono_png);
		type.set ("gfx/grossini_dance_atlas-mono.png", AssetType.IMAGE);
		
		className.set ("gfx/grossini_dance_atlas.png", __ASSET__gfx_grossini_dance_atlas_png);
		type.set ("gfx/grossini_dance_atlas.png", AssetType.IMAGE);
		
		className.set ("gfx/heart.png", __ASSET__gfx_heart_png);
		type.set ("gfx/heart.png", AssetType.IMAGE);
		
		className.set ("gfx/jellyfish_particle.png", __ASSET__gfx_jellyfish_particle_png);
		type.set ("gfx/jellyfish_particle.png", AssetType.IMAGE);
		
		className.set ("gfx/magenta.png", __ASSET__gfx_magenta_png);
		type.set ("gfx/magenta.png", AssetType.IMAGE);
		
		className.set ("gfx/menu.png", __ASSET__gfx_menu_png);
		type.set ("gfx/menu.png", AssetType.IMAGE);
		
		className.set ("gfx/nesSkin.png", __ASSET__gfx_nesskin_png);
		type.set ("gfx/nesSkin.png", AssetType.IMAGE);
		
		className.set ("gfx/new_super_mario-littera.fnt", __ASSET__gfx_new_super_mario_littera_fnt);
		type.set ("gfx/new_super_mario-littera.fnt", AssetType.TEXT);
		
		className.set ("gfx/new_super_mario-littera.png", __ASSET__gfx_new_super_mario_littera_png);
		type.set ("gfx/new_super_mario-littera.png", AssetType.IMAGE);
		
		className.set ("gfx/particle_circle.png", __ASSET__gfx_particle_circle_png);
		type.set ("gfx/particle_circle.png", AssetType.IMAGE);
		
		className.set ("gfx/pattern1.png", __ASSET__gfx_pattern1_png);
		type.set ("gfx/pattern1.png", AssetType.IMAGE);
		
		className.set ("gfx/pirate.png", __ASSET__gfx_pirate_png);
		type.set ("gfx/pirate.png", AssetType.IMAGE);
		
		className.set ("gfx/powered.png", __ASSET__gfx_powered_png);
		type.set ("gfx/powered.png", AssetType.IMAGE);
		
		className.set ("gfx/r1.png", __ASSET__gfx_r1_png);
		type.set ("gfx/r1.png", AssetType.IMAGE);
		
		className.set ("gfx/r2.png", __ASSET__gfx_r2_png);
		type.set ("gfx/r2.png", AssetType.IMAGE);
		
		className.set ("gfx/round_font-pixelizer.png", __ASSET__gfx_round_font_pixelizer_png);
		type.set ("gfx/round_font-pixelizer.png", AssetType.IMAGE);
		
		className.set ("gfx/slope.png", __ASSET__gfx_slope_png);
		type.set ("gfx/slope.png", AssetType.IMAGE);
		
		className.set ("gfx/smoke.png", __ASSET__gfx_smoke_png);
		type.set ("gfx/smoke.png", AssetType.IMAGE);
		
		className.set ("gfx/snow.png", __ASSET__gfx_snow_png);
		type.set ("gfx/snow.png", AssetType.IMAGE);
		
		className.set ("gfx/spark.png", __ASSET__gfx_spark_png);
		type.set ("gfx/spark.png", AssetType.IMAGE);
		
		className.set ("gfx/spaz_font.png", __ASSET__gfx_spaz_font_png);
		type.set ("gfx/spaz_font.png", AssetType.IMAGE);
		
		className.set ("gfx/spritesheet1.png", __ASSET__gfx_spritesheet1_png);
		type.set ("gfx/spritesheet1.png", AssetType.IMAGE);
		
		className.set ("gfx/stars.png", __ASSET__gfx_stars_png);
		type.set ("gfx/stars.png", AssetType.IMAGE);
		
		className.set ("gfx/stars2.png", __ASSET__gfx_stars2_png);
		type.set ("gfx/stars2.png", AssetType.IMAGE);
		
		className.set ("gfx/streak.png", __ASSET__gfx_streak_png);
		type.set ("gfx/streak.png", AssetType.IMAGE);
		
		className.set ("gfx/sun_particle.png", __ASSET__gfx_sun_particle_png);
		type.set ("gfx/sun_particle.png", AssetType.IMAGE);
		
		className.set ("gfx/swordguy.png", __ASSET__gfx_swordguy_png);
		type.set ("gfx/swordguy.png", AssetType.IMAGE);
		
		className.set ("gfx/texture.png", __ASSET__gfx_texture_png);
		type.set ("gfx/texture.png", AssetType.IMAGE);
		
		className.set ("gfx/tile.png", __ASSET__gfx_tile_png);
		type.set ("gfx/tile.png", AssetType.IMAGE);
		
		className.set ("gfx/tiles3.png", __ASSET__gfx_tiles3_png);
		type.set ("gfx/tiles3.png", AssetType.IMAGE);
		
		className.set ("gfx/tinyfont.fnt", __ASSET__gfx_tinyfont_fnt);
		type.set ("gfx/tinyfont.fnt", AssetType.TEXT);
		
		className.set ("gfx/tinyfont.png", __ASSET__gfx_tinyfont_png);
		type.set ("gfx/tinyfont.png", AssetType.IMAGE);
		
		className.set ("gfx/tuffy_bold_italic-charmap.png", __ASSET__gfx_tuffy_bold_italic_charmap_png);
		type.set ("gfx/tuffy_bold_italic-charmap.png", AssetType.IMAGE);
		
		className.set ("gfx/tuffy_bold_italic-charmap_s.png", __ASSET__gfx_tuffy_bold_italic_charmap_s_png);
		type.set ("gfx/tuffy_bold_italic-charmap_s.png", AssetType.IMAGE);
		
		className.set ("gfx/xfilesfnt.png", __ASSET__gfx_xfilesfnt_png);
		type.set ("gfx/xfilesfnt.png", AssetType.IMAGE);
		
		className.set ("atlas/a-hd.plist", __ASSET__atlas_a_hd_plist);
		type.set ("atlas/a-hd.plist", AssetType.TEXT);
		
		className.set ("atlas/atlas.xml", __ASSET__atlas_atlas_xml);
		type.set ("atlas/atlas.xml", AssetType.TEXT);
		
		className.set ("atlas/campfire.pex", __ASSET__atlas_campfire_pex);
		type.set ("atlas/campfire.pex", AssetType.TEXT);
		
		className.set ("atlas/campfireSmoke.pex", __ASSET__atlas_campfiresmoke_pex);
		type.set ("atlas/campfireSmoke.pex", AssetType.TEXT);
		
		className.set ("atlas/candle.pex", __ASSET__atlas_candle_pex);
		type.set ("atlas/candle.pex", AssetType.TEXT);
		
		className.set ("atlas/drugs.pex", __ASSET__atlas_drugs_pex);
		type.set ("atlas/drugs.pex", AssetType.TEXT);
		
		className.set ("atlas/exahust.pex", __ASSET__atlas_exahust_pex);
		type.set ("atlas/exahust.pex", AssetType.TEXT);
		
		className.set ("atlas/explode.pex", __ASSET__atlas_explode_pex);
		type.set ("atlas/explode.pex", AssetType.TEXT);
		
		className.set ("atlas/explosion.pex", __ASSET__atlas_explosion_pex);
		type.set ("atlas/explosion.pex", AssetType.TEXT);
		
		className.set ("atlas/explosion.plist", __ASSET__atlas_explosion_plist);
		type.set ("atlas/explosion.plist", AssetType.TEXT);
		
		className.set ("atlas/fire.pex", __ASSET__atlas_fire_pex);
		type.set ("atlas/fire.pex", AssetType.TEXT);
		
		className.set ("atlas/jellyfish.pex", __ASSET__atlas_jellyfish_pex);
		type.set ("atlas/jellyfish.pex", AssetType.TEXT);
		
		className.set ("atlas/level0.tmx", __ASSET__atlas_level0_tmx);
		type.set ("atlas/level0.tmx", AssetType.TEXT);
		
		className.set ("atlas/level1.tmx", __ASSET__atlas_level1_tmx);
		type.set ("atlas/level1.tmx", AssetType.TEXT);
		
		className.set ("atlas/love.pex", __ASSET__atlas_love_pex);
		type.set ("atlas/love.pex", AssetType.TEXT);
		
		className.set ("atlas/particle.pex", __ASSET__atlas_particle_pex);
		type.set ("atlas/particle.pex", AssetType.TEXT);
		
		className.set ("atlas/particleCoffee.pex", __ASSET__atlas_particlecoffee_pex);
		type.set ("atlas/particleCoffee.pex", AssetType.TEXT);
		
		className.set ("atlas/particleMushroom.pex", __ASSET__atlas_particlemushroom_pex);
		type.set ("atlas/particleMushroom.pex", AssetType.TEXT);
		
		className.set ("atlas/shower.pex", __ASSET__atlas_shower_pex);
		type.set ("atlas/shower.pex", AssetType.TEXT);
		
		className.set ("atlas/snow.pex", __ASSET__atlas_snow_pex);
		type.set ("atlas/snow.pex", AssetType.TEXT);
		
		className.set ("atlas/sprites.xml", __ASSET__atlas_sprites_xml);
		type.set ("atlas/sprites.xml", AssetType.TEXT);
		
		className.set ("atlas/sun.pex", __ASSET__atlas_sun_pex);
		type.set ("atlas/sun.pex", AssetType.TEXT);
		
		className.set ("atlas/Torch.pex", __ASSET__atlas_torch_pex);
		type.set ("atlas/Torch.pex", AssetType.TEXT);
		
		
		if (useManifest) {
			
			loadManifest ();
			
			if (Sys.args ().indexOf ("-livereload") > -1) {
				
				var path = FileSystem.fullPath ("manifest");
				lastModified = FileSystem.stat (path).mtime.getTime ();
				
				timer = new Timer (2000);
				timer.run = function () {
					
					var modified = FileSystem.stat (path).mtime.getTime ();
					
					if (modified > lastModified) {
						
						lastModified = modified;
						loadManifest ();
						
						if (eventCallback != null) {
							
							eventCallback (this, "change");
							
						}
						
					}
					
				}
				
			}
			
		}
		
		#else
		
		loadManifest ();
		
		#end
		#end
		
	}
	
	
	public override function exists (id:String, type:String):Bool {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		var assetType = this.type.get (id);
		
		if (assetType != null) {
			
			if (assetType == requestedType || ((requestedType == SOUND || requestedType == MUSIC) && (assetType == MUSIC || assetType == SOUND))) {
				
				return true;
				
			}
			
			#if flash
			
			if (requestedType == BINARY && (assetType == BINARY || assetType == TEXT || assetType == IMAGE)) {
				
				return true;
				
			} else if (requestedType == null || path.exists (id)) {
				
				return true;
				
			}
			
			#else
			
			if (requestedType == BINARY || requestedType == null || (assetType == BINARY && requestedType == TEXT)) {
				
				return true;
				
			}
			
			#end
			
		}
		
		return false;
		
	}
	
	
	public override function getAudioBuffer (id:String):AudioBuffer {
		
		#if flash
		
		var buffer = new AudioBuffer ();
		buffer.src = cast (Type.createInstance (className.get (id), []), Sound);
		return buffer;
		
		#elseif html5
		
		return null;
		//return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		if (className.exists(id)) return AudioBuffer.fromBytes (cast (Type.createInstance (className.get (id), []), ByteArray));
		else return AudioBuffer.fromFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getBytes (id:String):ByteArray {
		
		#if flash
		
		switch (type.get (id)) {
			
			case TEXT, BINARY:
				
				return cast (Type.createInstance (className.get (id), []), ByteArray);
			
			case IMAGE:
				
				var bitmapData = cast (Type.createInstance (className.get (id), []), BitmapData);
				return bitmapData.getPixels (bitmapData.rect);
			
			default:
				
				return null;
			
		}
		
		return cast (Type.createInstance (className.get (id), []), ByteArray);
		
		#elseif html5
		
		var bytes:ByteArray = null;
		var data = Preloader.loaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			bytes = new ByteArray ();
			bytes.writeUTFBytes (data);
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}
		
		if (bytes != null) {
			
			bytes.position = 0;
			return bytes;
			
		} else {
			
			return null;
		}
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), ByteArray);
		else return ByteArray.readFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getFont (id:String):Font {
		
		#if flash
		
		var src = Type.createInstance (className.get (id), []);
		
		var font = new Font (src.fontName);
		font.src = src;
		return font;
		
		#elseif html5
		
		return cast (Type.createInstance (className.get (id), []), Font);
		
		#else
		
		if (className.exists (id)) {
			
			var fontClass = className.get (id);
			return cast (Type.createInstance (fontClass, []), Font);
			
		} else {
			
			return Font.fromFile (path.get (id));
			
		}
		
		#end
		
	}
	
	
	public override function getImage (id:String):Image {
		
		#if flash
		
		return Image.fromBitmapData (cast (Type.createInstance (className.get (id), []), BitmapData));
		
		#elseif html5
		
		return Image.fromImageElement (Preloader.images.get (path.get (id)));
		
		#else
		
		if (className.exists (id)) {
			
			var fontClass = className.get (id);
			return cast (Type.createInstance (fontClass, []), Image);
			
		} else {
			
			return Image.fromFile (path.get (id));
			
		}
		
		#end
		
	}
	
	
	/*public override function getMusic (id:String):Dynamic {
		
		#if flash
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif openfl_html5
		
		//var sound = new Sound ();
		//sound.__buffer = true;
		//sound.load (new URLRequest (path.get (id)));
		//return sound;
		return null;
		
		#elseif html5
		
		return null;
		//return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		return null;
		//if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		//else return new Sound (new URLRequest (path.get (id)), null, true);
		
		#end
		
	}*/
	
	
	public override function getPath (id:String):String {
		
		//#if ios
		
		//return SystemPath.applicationDirectory + "/assets/" + path.get (id);
		
		//#else
		
		return path.get (id);
		
		//#end
		
	}
	
	
	public override function getText (id:String):String {
		
		#if html5
		
		var bytes:ByteArray = null;
		var data = Preloader.loaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			return cast data;
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}
		
		if (bytes != null) {
			
			bytes.position = 0;
			return bytes.readUTFBytes (bytes.length);
			
		} else {
			
			return null;
		}
		
		#else
		
		var bytes = getBytes (id);
		
		if (bytes == null) {
			
			return null;
			
		} else {
			
			return bytes.readUTFBytes (bytes.length);
			
		}
		
		#end
		
	}
	
	
	public override function isLocal (id:String, type:String):Bool {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		
		#if flash
		
		//if (requestedType != AssetType.MUSIC && requestedType != AssetType.SOUND) {
			
			return className.exists (id);
			
		//}
		
		#end
		
		return true;
		
	}
	
	
	public override function list (type:String):Array<String> {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		var items = [];
		
		for (id in this.type.keys ()) {
			
			if (requestedType == null || exists (id, type)) {
				
				items.push (id);
				
			}
			
		}
		
		return items;
		
	}
	
	
	public override function loadAudioBuffer (id:String, handler:AudioBuffer -> Void):Void {
		
		#if (flash)
		if (path.exists (id)) {
			
			var soundLoader = new Sound ();
			soundLoader.addEventListener (Event.COMPLETE, function (event) {
				
				var audioBuffer:AudioBuffer = new AudioBuffer();
				audioBuffer.src = event.currentTarget;
				handler (audioBuffer);
				
			});
			soundLoader.load (new URLRequest (path.get (id)));
			
		} else {
			handler (getAudioBuffer (id));
			
		}
		#else
		handler (getAudioBuffer (id));
		
		#end
		
	}
	
	
	public override function loadBytes (id:String, handler:ByteArray -> Void):Void {
		
		#if flash
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bytes = new ByteArray ();
				bytes.writeUTFBytes (event.currentTarget.data);
				bytes.position = 0;
				
				handler (bytes);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getBytes (id));
			
		}
		
		#else
		
		handler (getBytes (id));
		
		#end
		
	}
	
	
	public override function loadImage (id:String, handler:Image -> Void):Void {
		
		#if flash
		
		if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bitmapData = cast (event.currentTarget.content, Bitmap).bitmapData;
				handler (Image.fromBitmapData (bitmapData));
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getImage (id));
			
		}
		
		#else
		
		handler (getImage (id));
		
		#end
		
	}
	
	
	#if (!flash && !html5)
	private function loadManifest ():Void {
		
		try {
			
			#if blackberry
			var bytes = ByteArray.readFile ("app/native/manifest");
			#elseif tizen
			var bytes = ByteArray.readFile ("../res/manifest");
			#elseif emscripten
			var bytes = ByteArray.readFile ("assets/manifest");
			#elseif (mac && java)
			var bytes = ByteArray.readFile ("../Resources/manifest");
			#elseif ios
			var bytes = ByteArray.readFile ("assets/manifest");
			#else
			var bytes = ByteArray.readFile ("manifest");
			#end
			
			if (bytes != null) {
				
				bytes.position = 0;
				
				if (bytes.length > 0) {
					
					var data = bytes.readUTFBytes (bytes.length);
					
					if (data != null && data.length > 0) {
						
						var manifest:Array<Dynamic> = Unserializer.run (data);
						
						for (asset in manifest) {
							
							if (!className.exists (asset.id)) {
								
								#if ios
								path.set (asset.id, "assets/" + asset.path);
								#else
								path.set (asset.id, asset.path);
								#end
								type.set (asset.id, cast (asset.type, AssetType));
								
							}
							
						}
						
					}
					
				}
				
			} else {
				
				trace ("Warning: Could not load asset manifest (bytes was null)");
				
			}
		
		} catch (e:Dynamic) {
			
			trace ('Warning: Could not load asset manifest (${e})');
			
		}
		
	}
	#end
	
	
	/*public override function loadMusic (id:String, handler:Dynamic -> Void):Void {
		
		#if (flash || html5)
		
		//if (path.exists (id)) {
			
		//	var loader = new Loader ();
		//	loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
		//		handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
		//	});
		//	loader.load (new URLRequest (path.get (id)));
			
		//} else {
			
			handler (getMusic (id));
			
		//}
		
		#else
		
		handler (getMusic (id));
		
		#end
		
	}*/
	
	
	public override function loadText (id:String, handler:String -> Void):Void {
		
		//#if html5
		
		/*if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				handler (event.currentTarget.data);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getText (id));
			
		}*/
		
		//#else
		
		var callback = function (bytes:ByteArray):Void {
			
			if (bytes == null) {
				
				handler (null);
				
			} else {
				
				handler (bytes.readUTFBytes (bytes.length));
				
			}
			
		}
		
		loadBytes (id, callback);
		
		//#end
		
	}
	
	
}


#if !display
#if flash

@:keep @:bind #if display private #end class __ASSET__gfx_04b_fnt extends null { }
@:keep @:bind #if display private #end class __ASSET__gfx_04b_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_04f_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_a_hd_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_about_bg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_about_fade_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_alagard_bmfont_fnt extends null { }
@:keep @:bind #if display private #end class __ASSET__gfx_alagard_bmfont_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_arial_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_atlas_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_b1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_b2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_background_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_background3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_block_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_blocks_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_btn_about_down_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_btn_about_normal_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_btn_about_selected_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_btn_about_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_btn_done_down_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_btn_done_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_btn_highscores_normal_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_btn_highscores_selected_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_btn_play_down_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_btn_play_normal_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_btn_play_selected_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_btn_play_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_character_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_defaultskin_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_drugs_particle_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_esmoke_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_explosion_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_f1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_f2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_fire_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_fire_particle_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_fps_images_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_grossini_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_grossinis_sister1_testalpha_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_grossinis_sister1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_grossinis_sister2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_grossini_dance_atlas_mono_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_grossini_dance_atlas_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_heart_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_jellyfish_particle_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_magenta_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_menu_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_nesskin_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_new_super_mario_littera_fnt extends null { }
@:keep @:bind #if display private #end class __ASSET__gfx_new_super_mario_littera_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_particle_circle_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_pattern1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_pirate_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_powered_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_r1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_r2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_round_font_pixelizer_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_slope_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_smoke_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_snow_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_spark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_spaz_font_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_spritesheet1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_stars_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_stars2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_streak_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_sun_particle_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_swordguy_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_texture_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_tile_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_tiles3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_tinyfont_fnt extends null { }
@:keep @:bind #if display private #end class __ASSET__gfx_tinyfont_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_tuffy_bold_italic_charmap_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_tuffy_bold_italic_charmap_s_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_xfilesfnt_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__atlas_a_hd_plist extends null { }
@:keep @:bind #if display private #end class __ASSET__atlas_atlas_xml extends null { }
@:keep @:bind #if display private #end class __ASSET__atlas_campfire_pex extends null { }
@:keep @:bind #if display private #end class __ASSET__atlas_campfiresmoke_pex extends null { }
@:keep @:bind #if display private #end class __ASSET__atlas_candle_pex extends null { }
@:keep @:bind #if display private #end class __ASSET__atlas_drugs_pex extends null { }
@:keep @:bind #if display private #end class __ASSET__atlas_exahust_pex extends null { }
@:keep @:bind #if display private #end class __ASSET__atlas_explode_pex extends null { }
@:keep @:bind #if display private #end class __ASSET__atlas_explosion_pex extends null { }
@:keep @:bind #if display private #end class __ASSET__atlas_explosion_plist extends null { }
@:keep @:bind #if display private #end class __ASSET__atlas_fire_pex extends null { }
@:keep @:bind #if display private #end class __ASSET__atlas_jellyfish_pex extends null { }
@:keep @:bind #if display private #end class __ASSET__atlas_level0_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__atlas_level1_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__atlas_love_pex extends null { }
@:keep @:bind #if display private #end class __ASSET__atlas_particle_pex extends null { }
@:keep @:bind #if display private #end class __ASSET__atlas_particlecoffee_pex extends null { }
@:keep @:bind #if display private #end class __ASSET__atlas_particlemushroom_pex extends null { }
@:keep @:bind #if display private #end class __ASSET__atlas_shower_pex extends null { }
@:keep @:bind #if display private #end class __ASSET__atlas_snow_pex extends null { }
@:keep @:bind #if display private #end class __ASSET__atlas_sprites_xml extends null { }
@:keep @:bind #if display private #end class __ASSET__atlas_sun_pex extends null { }
@:keep @:bind #if display private #end class __ASSET__atlas_torch_pex extends null { }


#elseif html5







































































































#else



#if (windows || mac || linux)


@:file("assets/graphics/04b.fnt") #if display private #end class __ASSET__gfx_04b_fnt extends lime.utils.ByteArray {}
@:image("assets/graphics/04b.png") #if display private #end class __ASSET__gfx_04b_png extends lime.graphics.Image {}
@:image("assets/graphics/04f.png") #if display private #end class __ASSET__gfx_04f_png extends lime.graphics.Image {}
@:image("assets/graphics/a-hd.png") #if display private #end class __ASSET__gfx_a_hd_png extends lime.graphics.Image {}
@:image("assets/graphics/about-bg.png") #if display private #end class __ASSET__gfx_about_bg_png extends lime.graphics.Image {}
@:image("assets/graphics/about-fade.png") #if display private #end class __ASSET__gfx_about_fade_png extends lime.graphics.Image {}
@:file("assets/graphics/alagard-bmfont.fnt") #if display private #end class __ASSET__gfx_alagard_bmfont_fnt extends lime.utils.ByteArray {}
@:image("assets/graphics/alagard-bmfont.png") #if display private #end class __ASSET__gfx_alagard_bmfont_png extends lime.graphics.Image {}
@:image("assets/graphics/arial.png") #if display private #end class __ASSET__gfx_arial_png extends lime.graphics.Image {}
@:image("assets/graphics/atlas.png") #if display private #end class __ASSET__gfx_atlas_png extends lime.graphics.Image {}
@:image("assets/graphics/b1.png") #if display private #end class __ASSET__gfx_b1_png extends lime.graphics.Image {}
@:image("assets/graphics/b2.png") #if display private #end class __ASSET__gfx_b2_png extends lime.graphics.Image {}
@:image("assets/graphics/background.png") #if display private #end class __ASSET__gfx_background_png extends lime.graphics.Image {}
@:image("assets/graphics/background3.png") #if display private #end class __ASSET__gfx_background3_png extends lime.graphics.Image {}
@:image("assets/graphics/block.png") #if display private #end class __ASSET__gfx_block_png extends lime.graphics.Image {}
@:image("assets/graphics/blocks.png") #if display private #end class __ASSET__gfx_blocks_png extends lime.graphics.Image {}
@:image("assets/graphics/btn-about-down.png") #if display private #end class __ASSET__gfx_btn_about_down_png extends lime.graphics.Image {}
@:image("assets/graphics/btn-about-normal.png") #if display private #end class __ASSET__gfx_btn_about_normal_png extends lime.graphics.Image {}
@:image("assets/graphics/btn-about-selected.png") #if display private #end class __ASSET__gfx_btn_about_selected_png extends lime.graphics.Image {}
@:image("assets/graphics/btn-about.png") #if display private #end class __ASSET__gfx_btn_about_png extends lime.graphics.Image {}
@:image("assets/graphics/btn-done-down.png") #if display private #end class __ASSET__gfx_btn_done_down_png extends lime.graphics.Image {}
@:image("assets/graphics/btn-done.png") #if display private #end class __ASSET__gfx_btn_done_png extends lime.graphics.Image {}
@:image("assets/graphics/btn-highscores-normal.png") #if display private #end class __ASSET__gfx_btn_highscores_normal_png extends lime.graphics.Image {}
@:image("assets/graphics/btn-highscores-selected.png") #if display private #end class __ASSET__gfx_btn_highscores_selected_png extends lime.graphics.Image {}
@:image("assets/graphics/btn-play-down.png") #if display private #end class __ASSET__gfx_btn_play_down_png extends lime.graphics.Image {}
@:image("assets/graphics/btn-play-normal.png") #if display private #end class __ASSET__gfx_btn_play_normal_png extends lime.graphics.Image {}
@:image("assets/graphics/btn-play-selected.png") #if display private #end class __ASSET__gfx_btn_play_selected_png extends lime.graphics.Image {}
@:image("assets/graphics/btn-play.png") #if display private #end class __ASSET__gfx_btn_play_png extends lime.graphics.Image {}
@:image("assets/graphics/character.png") #if display private #end class __ASSET__gfx_character_png extends lime.graphics.Image {}
@:image("assets/graphics/defaultSkin.png") #if display private #end class __ASSET__gfx_defaultskin_png extends lime.graphics.Image {}
@:image("assets/graphics/drugs_particle.png") #if display private #end class __ASSET__gfx_drugs_particle_png extends lime.graphics.Image {}
@:image("assets/graphics/esmoke.png") #if display private #end class __ASSET__gfx_esmoke_png extends lime.graphics.Image {}
@:image("assets/graphics/explosion.png") #if display private #end class __ASSET__gfx_explosion_png extends lime.graphics.Image {}
@:image("assets/graphics/f1.png") #if display private #end class __ASSET__gfx_f1_png extends lime.graphics.Image {}
@:image("assets/graphics/f2.png") #if display private #end class __ASSET__gfx_f2_png extends lime.graphics.Image {}
@:image("assets/graphics/fire.png") #if display private #end class __ASSET__gfx_fire_png extends lime.graphics.Image {}
@:image("assets/graphics/fire_particle.png") #if display private #end class __ASSET__gfx_fire_particle_png extends lime.graphics.Image {}
@:image("assets/graphics/fps_images.png") #if display private #end class __ASSET__gfx_fps_images_png extends lime.graphics.Image {}
@:image("assets/graphics/grossini.png") #if display private #end class __ASSET__gfx_grossini_png extends lime.graphics.Image {}
@:image("assets/graphics/grossinis_sister1-testalpha.png") #if display private #end class __ASSET__gfx_grossinis_sister1_testalpha_png extends lime.graphics.Image {}
@:image("assets/graphics/grossinis_sister1.png") #if display private #end class __ASSET__gfx_grossinis_sister1_png extends lime.graphics.Image {}
@:image("assets/graphics/grossinis_sister2.png") #if display private #end class __ASSET__gfx_grossinis_sister2_png extends lime.graphics.Image {}
@:image("assets/graphics/grossini_dance_atlas-mono.png") #if display private #end class __ASSET__gfx_grossini_dance_atlas_mono_png extends lime.graphics.Image {}
@:image("assets/graphics/grossini_dance_atlas.png") #if display private #end class __ASSET__gfx_grossini_dance_atlas_png extends lime.graphics.Image {}
@:image("assets/graphics/heart.png") #if display private #end class __ASSET__gfx_heart_png extends lime.graphics.Image {}
@:image("assets/graphics/jellyfish_particle.png") #if display private #end class __ASSET__gfx_jellyfish_particle_png extends lime.graphics.Image {}
@:image("assets/graphics/magenta.png") #if display private #end class __ASSET__gfx_magenta_png extends lime.graphics.Image {}
@:image("assets/graphics/menu.png") #if display private #end class __ASSET__gfx_menu_png extends lime.graphics.Image {}
@:image("assets/graphics/nesSkin.png") #if display private #end class __ASSET__gfx_nesskin_png extends lime.graphics.Image {}
@:file("assets/graphics/new_super_mario-littera.fnt") #if display private #end class __ASSET__gfx_new_super_mario_littera_fnt extends lime.utils.ByteArray {}
@:image("assets/graphics/new_super_mario-littera.png") #if display private #end class __ASSET__gfx_new_super_mario_littera_png extends lime.graphics.Image {}
@:image("assets/graphics/particle_circle.png") #if display private #end class __ASSET__gfx_particle_circle_png extends lime.graphics.Image {}
@:image("assets/graphics/pattern1.png") #if display private #end class __ASSET__gfx_pattern1_png extends lime.graphics.Image {}
@:image("assets/graphics/pirate.png") #if display private #end class __ASSET__gfx_pirate_png extends lime.graphics.Image {}
@:image("assets/graphics/powered.png") #if display private #end class __ASSET__gfx_powered_png extends lime.graphics.Image {}
@:image("assets/graphics/r1.png") #if display private #end class __ASSET__gfx_r1_png extends lime.graphics.Image {}
@:image("assets/graphics/r2.png") #if display private #end class __ASSET__gfx_r2_png extends lime.graphics.Image {}
@:image("assets/graphics/round_font-pixelizer.png") #if display private #end class __ASSET__gfx_round_font_pixelizer_png extends lime.graphics.Image {}
@:image("assets/graphics/slope.png") #if display private #end class __ASSET__gfx_slope_png extends lime.graphics.Image {}
@:image("assets/graphics/smoke.png") #if display private #end class __ASSET__gfx_smoke_png extends lime.graphics.Image {}
@:image("assets/graphics/snow.png") #if display private #end class __ASSET__gfx_snow_png extends lime.graphics.Image {}
@:image("assets/graphics/spark.png") #if display private #end class __ASSET__gfx_spark_png extends lime.graphics.Image {}
@:image("assets/graphics/spaz_font.png") #if display private #end class __ASSET__gfx_spaz_font_png extends lime.graphics.Image {}
@:image("assets/graphics/spritesheet1.png") #if display private #end class __ASSET__gfx_spritesheet1_png extends lime.graphics.Image {}
@:image("assets/graphics/stars.png") #if display private #end class __ASSET__gfx_stars_png extends lime.graphics.Image {}
@:image("assets/graphics/stars2.png") #if display private #end class __ASSET__gfx_stars2_png extends lime.graphics.Image {}
@:image("assets/graphics/streak.png") #if display private #end class __ASSET__gfx_streak_png extends lime.graphics.Image {}
@:image("assets/graphics/sun_particle.png") #if display private #end class __ASSET__gfx_sun_particle_png extends lime.graphics.Image {}
@:image("assets/graphics/swordguy.png") #if display private #end class __ASSET__gfx_swordguy_png extends lime.graphics.Image {}
@:image("assets/graphics/texture.png") #if display private #end class __ASSET__gfx_texture_png extends lime.graphics.Image {}
@:image("assets/graphics/tile.png") #if display private #end class __ASSET__gfx_tile_png extends lime.graphics.Image {}
@:image("assets/graphics/tiles3.png") #if display private #end class __ASSET__gfx_tiles3_png extends lime.graphics.Image {}
@:file("assets/graphics/tinyfont.fnt") #if display private #end class __ASSET__gfx_tinyfont_fnt extends lime.utils.ByteArray {}
@:image("assets/graphics/tinyfont.png") #if display private #end class __ASSET__gfx_tinyfont_png extends lime.graphics.Image {}
@:image("assets/graphics/tuffy_bold_italic-charmap.png") #if display private #end class __ASSET__gfx_tuffy_bold_italic_charmap_png extends lime.graphics.Image {}
@:image("assets/graphics/tuffy_bold_italic-charmap_s.png") #if display private #end class __ASSET__gfx_tuffy_bold_italic_charmap_s_png extends lime.graphics.Image {}
@:image("assets/graphics/xfilesfnt.png") #if display private #end class __ASSET__gfx_xfilesfnt_png extends lime.graphics.Image {}
@:file("assets/atlas/a-hd.plist") #if display private #end class __ASSET__atlas_a_hd_plist extends lime.utils.ByteArray {}
@:file("assets/atlas/atlas.xml") #if display private #end class __ASSET__atlas_atlas_xml extends lime.utils.ByteArray {}
@:file("assets/atlas/campfire.pex") #if display private #end class __ASSET__atlas_campfire_pex extends lime.utils.ByteArray {}
@:file("assets/atlas/campfireSmoke.pex") #if display private #end class __ASSET__atlas_campfiresmoke_pex extends lime.utils.ByteArray {}
@:file("assets/atlas/candle.pex") #if display private #end class __ASSET__atlas_candle_pex extends lime.utils.ByteArray {}
@:file("assets/atlas/drugs.pex") #if display private #end class __ASSET__atlas_drugs_pex extends lime.utils.ByteArray {}
@:file("assets/atlas/exahust.pex") #if display private #end class __ASSET__atlas_exahust_pex extends lime.utils.ByteArray {}
@:file("assets/atlas/explode.pex") #if display private #end class __ASSET__atlas_explode_pex extends lime.utils.ByteArray {}
@:file("assets/atlas/explosion.pex") #if display private #end class __ASSET__atlas_explosion_pex extends lime.utils.ByteArray {}
@:file("assets/atlas/explosion.plist") #if display private #end class __ASSET__atlas_explosion_plist extends lime.utils.ByteArray {}
@:file("assets/atlas/fire.pex") #if display private #end class __ASSET__atlas_fire_pex extends lime.utils.ByteArray {}
@:file("assets/atlas/jellyfish.pex") #if display private #end class __ASSET__atlas_jellyfish_pex extends lime.utils.ByteArray {}
@:file("assets/atlas/level0.tmx") #if display private #end class __ASSET__atlas_level0_tmx extends lime.utils.ByteArray {}
@:file("assets/atlas/level1.tmx") #if display private #end class __ASSET__atlas_level1_tmx extends lime.utils.ByteArray {}
@:file("assets/atlas/love.pex") #if display private #end class __ASSET__atlas_love_pex extends lime.utils.ByteArray {}
@:file("assets/atlas/particle.pex") #if display private #end class __ASSET__atlas_particle_pex extends lime.utils.ByteArray {}
@:file("assets/atlas/particleCoffee.pex") #if display private #end class __ASSET__atlas_particlecoffee_pex extends lime.utils.ByteArray {}
@:file("assets/atlas/particleMushroom.pex") #if display private #end class __ASSET__atlas_particlemushroom_pex extends lime.utils.ByteArray {}
@:file("assets/atlas/shower.pex") #if display private #end class __ASSET__atlas_shower_pex extends lime.utils.ByteArray {}
@:file("assets/atlas/snow.pex") #if display private #end class __ASSET__atlas_snow_pex extends lime.utils.ByteArray {}
@:file("assets/atlas/sprites.xml") #if display private #end class __ASSET__atlas_sprites_xml extends lime.utils.ByteArray {}
@:file("assets/atlas/sun.pex") #if display private #end class __ASSET__atlas_sun_pex extends lime.utils.ByteArray {}
@:file("assets/atlas/Torch.pex") #if display private #end class __ASSET__atlas_torch_pex extends lime.utils.ByteArray {}



#end

#if openfl

#end

#end
#end

