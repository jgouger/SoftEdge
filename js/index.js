$(document).ready(function()
{

    /**
     * Renders the members after a successful callback to the API
     * @param {object} data 
     * @returns {void}
     */
    var renderMember = function(data)
    {
        var searchResults = $('#search-results-body');

        $(searchResults).empty();

        var memberHTML = '<div class="card-group card-group-layout">' +
            '<div class="row flex-nowrap-a">';

        for (var r = 0; r < data.length; r++)
        {
            memberHTML += '<div class="card col-md-4 member-card" data-member-id="' + data[r].ID + '">' +
                '<div class="member-image-box"><img class="card-img-top member-image" src="' + data[r].PICTURE + '" alt="' + data[r].NAME + '"/></div>' +
                '<div class="card-body">' + 
                    '<h6 class="card-title">' + data[r].NAME + '</h6>' +
                    '<div> <strong>Party: </strong>' + data[r].PARTY + '</div>' +
                    '<div> <strong>State: </strong>' + data[r].STATE + '</div>';

            if (data[r].hasOwnProperty('DISTRICT') && data[r].DISTRICT.length > 0)
            {
                memberHTML += '<div> <strong>District: </strong>' + data[r].DISTRICT + '</div>';
            }

            memberHTML += '</div>' + // close card-body
            '</div>'; //close card

            if (r > 0 && (r + 1) % 3 == 0)
            {
                memberHTML += '</div>' + // close previous row's div
                '<div class="row flex-nowrap-a">';
            }
            else if (r === data.length - 1)
            {
                // create empty cards so the that layout looks corect
                if (( (data.length % 3 ) + data.length ) % 3 === 2)
                {
                    memberHTML += '<div class="card col-md-4 member-card">' +
                        '<div class="member-image-box"></div>' +
                        '<div class="card-body"></div>' +
                    '</div>';


                    memberHTML += '<div class="card col-md-4 member-card">' +
                        '<div class="member-image-box"></div>' +
                        '<div class="card-body"></div>' +
                    '</div>';
                }

                else if ( ( (data.length % 3 ) + data.length ) % 3 === 1)
                {
                    memberHTML += '<div class="card col-md-4 member-card">' +
                        '<div class="member-image-box"></div>' +
                        '<div class="card-body"></div>' +
                    '</div>';
                }

                memberHTML += '</div>';// close previous row's div
            }
        }

        memberHTML += '</div>'; // close the card group

        $(searchResults).append(memberHTML);
    };

    /**
     * Event handler function for the search button
     * @param {object} jQuery event object
     * @returns {void}
     */
    $('#search-btn').click(function(e)
    {
        $.ajax({
            method: 'post',
            url: 'controller/Congress.cfc?method=getMembers',
            data: $(this).parent('form').serialize()
        }).done(function(data)
        {
            var responseData = JSON.parse(data);
            
            // API call was successful. Build the Cards
            if (responseData.length > 0)
            {
               renderMember(responseData);
            }
            else if (responseData.length === 0)
            {
                alert('There were not any members of Congress \nmatched your search. Please try again.');
            }

            else
            {
                alert('An error occurred!');
            }
        });
    });
});