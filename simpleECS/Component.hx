package simpleECS;

/**
 * A simple Component with its owner.
 * A Component is a feature/functionality that can be added to an Entity. 
 */
class Component
{
    /**
     * The class type of this component.
     * If you're extending Component, in the constructor of the extended class
     * you must have: 
     * this.type = MyExtendedComponent;
     */
    public var type(default, null):Any;
    /**
     * The owner of this component.
     */
    public var owner(default, null):Entity;
    /**
     * @param owner the Entity that owns this component.
     */
    public function new(owner:Entity) 
    {
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