<cfscript>
    request.pageTitle = 'Search for Members of Congress';
    variables.states = DeserializeJSON(request.controller.getStates());
    variables.chambers = request.controller.getChambers();
</cfscript>

<cfoutput>
    <div class="card" id="search">
        <div class="card-header">
            Search for Member of Congresss
           <span class="float-right glyphicon glyphicon-chevron-down" aria-hidden="true"></span>
        </div>
        <div class="card-body">
            <form method="post">

                <div class="form-row">

                    <!--- TODO: both of these need to be type aheads --->
                    <div class="form-group col-md-6">
                        <label for="memberName">Search by Name:</label>
                        <input type="text" class="form-control" id="memberName" name="memberName" /> 
                    </div>

                    <div class="form-group col-md-6">
                        <label for="state" name="state">State:</label>
                        <select id="state" name="state" class="form-control">
                            <option value="">Select...</option>
                            <cfloop from="1" to="#ArrayLen(variables.states)#" index="variables.s">
                                <option value="#variables.states[variables.s]['STATE']#">#variables.states[variables.s]['STATE']#</option>
                            </cfloop>  
                        </select>
                    </div>

                </div>

                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label for="type">Chamber:</label>
                        <select id="chamber" name="chamber" class="form-control">
                            <cfloop from="1" to="#ArrayLen(variables.chambers)#" index="variables.c">
                                <option value="#variables.chambers[variables.c]#">#variables.chambers[variables.c]#</option>
                            </cfloop>  
                        </select>
                    </div>

                </div>
                
                <buutton id="search-btn" class="btn btn-primary float-right">Search for Members of Congress</button>
            </form>
        </div>
    </div>

    <div style="margin-bottom: 20px;"></div>
    
    <div class="card collaspe" id="search-results-card">
        <div class="card-header">Search Results</div>
        <div class="card-body" id="search-results-body">Please search above....</div>
    </div>
</cfoutput>