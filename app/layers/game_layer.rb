class GameLayer < Joybox::Core::Layer
  include Joybox::TMX
  
  attr_reader :player
  
  scene

  def on_enter
    initialize_world
    load_background
    load_tile_map
    create_fixtures
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
  
  def create_fixtures
    create_walls_fixtures
    create_hazards_fixtures
  end
  
  def create_rectangular_fixture(layer, x, y)
    tw = layer.tileset.tileSize.width / 4
    th = layer.tileset.tileSize.height / 4
    
    p = layer.positionAt [x, y]
    x = p.x + tw + 4
    y = p.y + th + 4  

    # create the body, define the shape and create the fixture
    body = @world.new_body(
      position: [x, y], 
      type: Body::Static) do
        polygon_fixture box: [tw, th],
                        density: 1.0,
                        friction: 0.3,
                        restitution: 0.0
    end
  end
  
  def create_walls_fixtures
    @walls = @tile_map.tile_layers['walls']
    size = @walls.layerSize

    (0..size.height - 1).each do |y|
      (0..size.width - 1).each do |x|
        tile = @walls.tileAt([x, y])
        create_rectangular_fixture(@walls, x, y) if tile 
      end
    end
  end
  
  def create_hazards_fixtures
    @hazards = @tile_map.tile_layers['hazards']
    @hazard_tiles = []
    size = @hazards.layerSize

    (0..size.height - 1).each do |y|
      (0..size.width - 1).each do |x|
        tile = @hazards.tileAt([x, y])
        @hazard_tiles << create_rectangular_fixture(@walls, x, y) if tile 
      end
    end
  end

end