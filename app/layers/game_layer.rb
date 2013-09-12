class GameLayer < Joybox::Core::Layer
  include Joybox::TMX
  
  scene

  def on_enter
    @tile_map = TileMap.new file_name: 'tilemap.tmx'
    self << @tile_map
  end

  def on_exit
    # Tear down
  end

end