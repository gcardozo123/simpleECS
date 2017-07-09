package simpleECS;

/**
 * A simple Component with its owner.
 * A Component is a feature/functionality that can be added to an Entity. 
 */
class Component
{
    /**
     * The class type of this component.
     */
    public var type(default, null):Class<Component>;
    /**
     * The owner of this component.
     */
    public var owner(default, null):Entity;
    /**
     * Indicates whether or not this component was destroyed.
     */
    private var _isDestroyed:Bool;
    /**
     * @param owner the Entity that owns this component.
     */
    public function new(owner:Entity) 
    {
        type = Type.getClass(this);
        this.owner = owner;
        _isDestroyed = false;
    }
    /**
     * A method to destroy this component.
     * When extending Component, you should always override this method so 
     * it properly destroys your component.
     */
    public function destroy():Void
    {
        owner = null;
    }
}
