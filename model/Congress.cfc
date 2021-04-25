/**
 * Model for database interactions with the congress database
 */
component
{
    /**
     * Initalize the class
     */
    public model.Congress function init()
    {
        return this;
    }

    /**
    * Queries the database to get all of the supported states
    * @state optional query string for use with the type-ahead
    * @return {query} Query of all USA states
    */
    public query function getStates(string state = '')
    {
        var local = {};

        local.queryState = new Query();
        local.queryState.setDatasource('Congress');
        local.queryState.setSQL('
        
            SELECT DISTINCT State
            FROM Members
            WHERE 1 = 1
            #Len(arguments.state) ? ' state LIKE % :state % ': ''#
        ');

        if (Len(arguments.state) )
        {
            local.queryState.addParam(name="state", value = arguments.state, cfsqltype="cf_sql_varchar");
        }

        return local.queryState.execute().getResult();
    }

    /**
    * Queries the database to get the members of Congress
    * @chamber Either house or the senate
    * @memberName optional query string for use with the type-ahead
    * @state option state filter
    * @return {query} Query of all of the members of Congress
    */
    public query function getMembers(required string chamber, string memberName = '', string state = '')
    {
        var local = {};

        local.queryMembers = new Query();
        local.queryMembers.setDatasource('Congress');
        local.queryMembers.setSQL('

            DECLARE @memberName varchar(512) = ''%'' + :memberName + ''%'';
        
            SELECT id, name, district, state, party, picture, chamber
            FROM members
            WHERE Chamber = :chamber
            #Len(arguments.memberName) ? ' AND name LIKE @memberName': ''#
            #Len(arguments.state) ? ' AND state = :state ' : ''#
            ORDER BY state, 
                CASE
					WHEN (ISNUMERIC(District) = 1) THEN
						CAST(District as int)
				END
            
        ');

        local.queryMembers.addParam(name="chamber", value = arguments.chamber, cfsqltype="cf_sql_varchar");
        local.queryMembers.addParam(name="memberName", value = arguments.memberName, cfsqltype="cf_sql_varchar", null="#Len(arguments.memberName) EQ 0#");
        
        if (Len(arguments.state) )
        {
            local.queryMembers.addParam(name="state", value = arguments.state, cfsqltype="cf_sql_varchar");
        }

        return local.queryMembers.execute().getResult();
    }
}