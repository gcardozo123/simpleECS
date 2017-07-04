package simpleECS;

/**
 * A simple Component with its owner.
 * A Component is a feature/functionality that can be added to an Entity. 
 */
class Component<T:Component>
{
    /**
     * The class type of this component.
     */
    public var type(default, null):Class<T>;
    /**
     * The owner of this component.
     */
    public var owner(default, null):Entity;
    /**
     * @param type the class type of this component.
     * @param owner the Entity that owns this component.
     */
    public function new(type:Class<T>, owner:Entity) 
    {
        this.type = type;
        this.owner = owner;
    }
    /**
     * A method to destroy the component.
     * When extending Component, you should always override this method so 
     * it properly destroys your component.
     */
    public function destroy():Void
    {
    }
}
