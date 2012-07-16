(function(jQuery) {
	jQuery.fn.suggested = function(settings) {

		settings = jQuery.extend({
			minChars: 0,
			idtype: 'organizationID',
			method: 'getOrganizationNames'
		}, settings);

		var $inputBox		= this;
		var $isActive		= false;
		var $searchResults	= $(".remoteSearchResults");

		$inputBox.keyup(function() {
			// Get the contacts from the server.

			if($isActive) {
				return;
			}

			if(settings.minChars != 0 && this.value.length < settings.minChars) {
				$searchResults.html("");
				return;
			}

			$isActive = true;

			$.getJSON('lib/com/meldsolutions/meldevents/remote/RemoteMeldEvents.cfc',
				{
					method: settings.method,
					name: this.value,
					limit: 20,
					returnFormat: "json"
				}
				,
				function( response ){
					// Check to see if the request was successful.
					if (response.SUCCESS){
						response.idtype = settings.idtype;
						$isActive = false;
						createList( response );
					} else {
						$isActive = false;
					}
				}
			);		
		});
		
		function createList( response ) {

			if(!response.LIST.length) {
				$searchResults.html("");
				return;				
			}

			$sResults = "<ul>";
			
			for(var i in response.LIST) {
				$sResults += "<li id='ib' data-id='" + response.LIST[i].ID + "'>" + response.LIST[i].NAME + "</li>";
			}
			$sResults += "</ul>";
			$searchResults.html($sResults);
			$searchResults.children("ul").children("li").bind('click',actionRecord);
			
		}
		
		function actionRecord() {
			$selection = $(this);
			$("#dialog #nameValue").html($selection.html());
			$action = $("#action");
			$parentID = $("#" + settings.idtype );
			$relationshipID = $("#relationshipID");
			$editform = $("#editform");

	        $('#dialog').dialog({
	            autoOpen: false,
	            width: 400,
	            modal: true,
	            resizable: false,
	            buttons: {
	                "Confirm": function() {
	                    $action.attr("value","attach");
						$parentID.attr("value",$selection.attr('data-id'));
						$relationshipID.attr("value","");
						$editform.submit();
	                },
	                "Cancel": function() {
	                    $(this).dialog("close");
	                }
	            }

	        });

           $('#dialog').dialog('open');
           return false;
			
		}
	};
})(jQuery);
