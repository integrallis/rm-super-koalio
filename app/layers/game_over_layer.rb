class GameOverLayer < Joybox::Core::Layer
  
  scene

  def on_enter
    load_background
    create_retry_label
    configure_controls
  end
  
  def create_retry_label
    retry_label = Label.new(
      text: "Tap to Retry",
      font_size: 40,
      color: Color.new(255, 255, 255),
      position: [Screen.half_width, Screen.half_height],
    )
    self << retry_label
  end
  
  def load_background
    @blue_sky = LayerColor.new color: "#6365fc".to_color
    self << @blue_sky
  end
  
  def configure_controls
    on_touches_ended do |touches, event|
      Joybox.director.replace_scene GameLayer.scene
      Joybox.director.start_animation
    end
  end
  
end
