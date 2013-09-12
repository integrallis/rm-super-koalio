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
  end

end