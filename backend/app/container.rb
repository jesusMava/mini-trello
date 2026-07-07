module Container
  module_function

  def registry
    @registry ||= Shared::Events::Registry.new
  end

  def event_bus
    @event_bus ||=
      Shared::Events::EventBus.new(
        registry: registry
      )
  end
end
