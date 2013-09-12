class GameLayer < Joybox::Core::Layer
  include Joybox::TMX
  
  attr_reader :player
  
  scene

  def on_enter
    initialize_world
    load_background
    load_tile_map
    load_player
    game_loop
  end
  
  private 
  
  def load_tile_map
    @tile_map = TileMap.new file_name: 'tilemap.tmx'
    self << @tile_map
  end
  
  def load_background
    @blue_sky = LayerColor.new color: "#6365fc".to_color
    self << @blue_sky
  end
  
  def initialize_world
    @world = World.new(gravity: [0, -9.8])
  end
  
  def load_player
    @player = PlayerSprite.new(@world)
    @tile_map.add_child @player, 15
  end
  
  def game_loop
    schedule_update do |delta|
      @world.step delta: delta
    end
  end

end