class PlayerSprite < Joybox::Physics::PhysicsSprite
  
  def initialize(world)
    @world = world
    @player_body = @world.new_body(
      position: [16*1, 16*9],
      type: Body::Dynamic,
      fixed_rotation: true
    ) do
      polygon_fixture(
        box: [18 / 4, 60 / 4],
        friction: 0.7,
        density: 1.0
      )
    end
    super file_name: 'koalio_stand.png', body: @player_body
    @alive = true
  end
  
  def alive?     
    @alive && above_ground?
  end
  
  def move_forward
    if alive?
      self.body.apply_force force:[5, 0], as_impulse: true
    end
  end
  
  def jump
    if alive?
      self.body.apply_force force:[10, 40]
      SimpleAudioEngine.sharedEngine.playEffect 'jump.wav'
    end
  end
  
  def die
    @alive = false
    self.run_action Blink.with times:50
    SimpleAudioEngine.sharedEngine.playEffect 'hurt.wav'
    SimpleAudioEngine.sharedEngine.pauseBackgroundMusic
  end
  
  def above_ground?
    @player_body.position.y > 0
  end

end