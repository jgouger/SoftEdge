/**
 * Controller Class for the Congress Model
 */
component
{
    // setup constants
    variables.chambers =
    [
        'House', 'Senate'
    ];
    
    /**
     * Initialize the class
     */
    public Congress function init()
    {
        variables.model = new SoftEdge.model.Congress();
        return this;
    }

    /**
     * Initalizes the private variables in case this is called remotely
     */
    private void function checkInit()
    {
        if (! StructKeyExists(variables, 'model') )
        {
            init();
        }
    }

    /**
    * Returns the chambers constant
    * @returns {array} An array of supported chambers
    */
    public array function getChambers()
    {
        return variables.chambers;
    }

    /**
     * Gets the supported states
     * @state optional partial or complete state name
     * @returns {string} A JSON encoded array of the states
     */
    remote string function getStates (string state = '') returnFormat="json"
    {
        checkInit();
        return serializeJSON(variables.model.getStates(arguments.state), 'struct');
    }

    /**
    * Gets the members of congress
    * @chamber Either house or the senate
    * @memberName optional query string for use with the type-ahead
    * @state option state filter
    * @returns {string} A JSON encoded array which looks like this: [{"name": "Name", "district": "District", etc}]
    */
    remote string function getMembers(required string chamber, string memberName = '', string state = '') returnFormat="json"
    {
        checkInit();
        return serializeJSON(variables.model.getMembers(arguments.chamber, arguments.memberName, arguments.state), 'struct');
    }
}