package simpleECS;

/**
 * Represents an Entity with its components.
 */
class Entity
{
    /**
     * Array of components.
     */
    private var _components:Array<Component>;
    /**
     * The current number of components.
     */
    public var numComponents(get, null):Int;
    
    public function new() 
    {
        _components = new Array<Component>();
    }
    /**
     * numComponents getter.
     * @return the number of components in this Entity.
     */
    private function get_numComponents():Int
    {
        return _components.length;
    }
    /**
     * Adds a component to the components array.
     * @param component to be added.
     * @return this Entity, so you can chain multiple calls.
     */
    public function addComponent(component:Component):Entity 
    {
        if (component != null)
        {
            if(getComponent(component.type) == null)
                _components.push(component);
            else
            {
                trace("Error: This Entity already has a component of type " + 
                    Type.getClassName(component.type) + ", you can call replaceComponent if you need.");
            }
        }
        else
            trace("Error: Entity.addComponent can't add a null component.");
            
        return this;
    }
    /**
     * Get the component's index.
     * @param classType the type of the component. 
     * @return The component's index or -1 if it doesn't exist.
     */
    private function getComponentIndex<T:Component>(classType:Class<T>):Int
    {
        for (i in 0 ... _components.length) 
        {
            if (_components[i].type == cast classType)
                return i;
        }
        return -1;
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
        var compIndex = getComponentIndex(classType);
        return compIndex == -1 ? null : cast _components[compIndex];
    }
    /**
     * Verifies if this Entity has a component.
     * @param classType the type of the component.
     * @return A boolean.
     */
    public function hasComponent<T:Component>(classType:Class<T>):Bool
    {
        return getComponentIndex(classType) != -1;
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
     * @return this Entity, so you can chain multiple calls.
     */
    public function removeComponent<T:Component>(classType:Class<T>):Entity
    {
        var compIndex = getComponentIndex(classType);
        if (compIndex == -1)
        {
            trace("Error: Entity.removeComponent, there's no component of type " + 
                Type.getClassName(classType) + " to be removed.");
            
            return this;
        }
        _components[compIndex].destroy();
        _components.splice(compIndex, 1);
        return this;
    }
    /**
     * Removes all components.
     * Calls component.destroy() on each one.
     */
    public function removeAllComponents():Void
    {
        for (c in _components)
            c.destroy();
        
        _components.splice(0, _components.length);
    }
    /**
     * Replaces a component.
     * @param newComponent the new component that is 
     * going to replace the old one.
     */
    public function replaceComponent(newComponent:Component):Void 
    {
        var compIndex = getComponentIndex(newComponent.type);
        if (compIndex == -1)
        {
            trace("Error: Entity.replaceComponent couldn't find a componenty of type " + 
                Type.getClassName(newComponent.type));
            
            return;
        }
        _components[compIndex].destroy();
        _components[compIndex] = newComponent;
    }
}
