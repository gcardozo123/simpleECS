# simpleECS
A Haxe Unity3D-like entity-component system.


## Usage
* Add simpleECS to your classpaths.
* That's it, quite simple.

### Wait, where is my GameObject/Actor class?!
Well, I decided to call it Entity, after all you're not necessarily using this lib to make games. 

### Code samples
Your components should extend the Component class:
```haxe
package;
import simpleECS.Component;
import simpleECS.Entity;

class OneComponent extends Component 
{
    public function new(owner:Entity) 
    {
        super(owner);
    }
    public function oneComponentMethod():Void
    {
        trace("This is oneComponentMethod.");
    }   
    public function checkOtherComponent():Void
    {
        if (owner.getComponent(OtherComponent) != null)
            trace("Yay, we have OtherComponent!");
        else
            trace("We don't have OtherComponent.");
    }
    /*ALWAYS override this method so you can properly destroy your components.*/
    override public function destroy():Void
    {
        if (_isDestroyed) //preventing multiple destroy calls.
            return;
            
        _isDestroyed = true;
        //your component destruction code goes here...
        super.destroy();
        trace("OneComponent destroyed.");
    }
}

class OtherComponent extends Component 
{
    public function new(owner:Entity) 
    {
        super(owner);
    }   
    public function otherComponentMethod():Void
    {
        trace("This is otherComponentMethod");
    }
    /*ALWAYS override this method so you can properly destroy your components.*/
    override public function destroy():Void
    {
        if (_isDestroyed) //preventing multiple destroy calls.
            return;
            
        _isDestroyed = true;
        //your component destruction code goes here...
        super.destroy();
        trace("OtherComponent destroyed.");
    }
}
```

Then, somewhere else you can build your entities:
```haxe
var ent = new Entity();
ent.addComponent(new OneComponent(ent)).addComponent(new OtherComponent(ent));

var oneComp:OneComponent = ent.getComponent(OneComponent);
oneComp.oneComponentMethod();

var otherComp:OtherComponent = ent.getComponent(OtherComponent);
otherComp.otherComponentMethod();

ent.removeComponent(OtherComponent);
trace("ent.numComponents: " + ent.numComponents + "\n"); //ent.numComponents: 1
```
