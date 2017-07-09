package simpleECS;

/**
 * Represents an Entity with its components.
 */
class Entity
{
    /**
     * Array of components.
     */
    public var _components:Array<Component>;
    /**
     * The current number of components.
     */
    public var numComponents(get, null):Int;
    
    public function new() 
    {
        _components = new Array<Component>();
    }
    
    private function get_numComponents():Int
    {
        return _components.length;
    }
    /**
     * Adds a component to the components array.
     * @param component to be added.
     */
    public function addComponent(component:Component):Entity 
    {
        if (component != null)
        {
            if(getComponent(component.type) == null)
                _components.push(component);
            else
                trace("Error: This Entity already has a component of type " + Type.getClassName(component.type) + ", you can do Entity.replaceComponent if you need.");
        }
        else
            trace("Error: Entity.addComponent can't add null component");
            
        return this;
    }
    /**
     * Get the component you need.
     * @return 
     * component:T, for example: 
     * entity.getComponent(YourAwesomeComponent) 
     * returns YourAwesomeComponent.
     */
    public function getComponent<T:Component>(classType:Class<T>):T 
    {
        for (c in _components)
        {
            if (c.type == cast classType)
                return cast c;
        }
        return null;
    }
    /**
     * Get all of the components.
     * @return the components array.
     */
    public function getComponents():Array<Component> 
    {
        return _components;
    }
    /**
     * Removes a component.
     * @param classType the type of the component.
     * @param destroy should we destroy the component?
     * @return The component that was removed.
     */
    public function removeComponent<T:Component>(classType:Class<T>, ?destroy:Bool = false):T
    {
        for (i in 0 ... _components.length)
        {
            if (_components[i].type == cast classType)
            {
                var component = _components[i];
                _components.splice(i, 1);
                
                if (destroy)
                {
                    component.destroy();
                    return null;
                }
                return cast component;
            }
        }
        return null;
    }
    /**
     * Removes all components.
     */
    public function removeAllComponents():Void
    {
        _components.splice(0, _components.length);
    }
    /**
     * Replaces a component.
     * @param component the type of the component.
     * @param destroy should we destroy the old component?
     */
    public function replaceComponent(component:Component, ?destroy:Bool = false):Void 
    {
        for (i in 0 ... _components.length)
        {
            if (_components[i].type == component.type)
            {
                if (destroy)
                    _components[i].destroy();

                _components[i] = component;
                break;
            }
        }
        trace("Error: Entity.replaceComponent couldn't find a componenty of type " + Type.getClassName(component.type));
    }
}
