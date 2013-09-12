class GameLayer < Joybox::Core::Layer
  include Joybox::TMX
  
  scene

  def on_enter
    load_background
    load_tile_map
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

end