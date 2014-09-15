$(document).ready(function() {

/* Set the defaults for DataTables initialisation */

/* Default class modification */
$.extend( $.fn.dataTableExt.oStdClasses, {
	"sWrapper": "dataTables_wrapper form-inline"
} );


/* API method to get paging information */
$.fn.dataTableExt.oApi.fnPagingInfo = function ( oSettings )
{
	return {
		"iStart":         oSettings._iDisplayStart,
		"iEnd":           oSettings.fnDisplayEnd(),
		"iLength":        oSettings._iDisplayLength,
		"iTotal":         oSettings.fnRecordsTotal(),
		"iFilteredTotal": oSettings.fnRecordsDisplay(),
		"iPage":          oSettings._iDisplayLength === -1 ?
			0 : Math.ceil( oSettings._iDisplayStart / oSettings._iDisplayLength ),
		"iTotalPages":    oSettings._iDisplayLength === -1 ?
			0 : Math.ceil( oSettings.fnRecordsDisplay() / oSettings._iDisplayLength )
	};
};


/* Bootstrap style pagination control */
$.extend( $.fn.dataTableExt.oPagination, {
	"bootstrap": {
		"fnInit": function( oSettings, nPaging, fnDraw ) {
			var oLang = oSettings.oLanguage.oPaginate;
			var fnClickHandler = function ( e ) {
				e.preventDefault();
				if ( oSettings.oApi._fnPageChange(oSettings, e.data.action) ) {
					fnDraw( oSettings );
				}
			};

			$(nPaging).addClass('pagination').append(
				'<ul>'+
					'<li class="prev disabled"><a href="#">&larr; '+oLang.sPrevious+'</a></li>'+
					'<li class="next disabled"><a href="#">'+oLang.sNext+' &rarr; </a></li>'+
				'</ul>'
			);
			var els = $('a', nPaging);
			$(els[0]).bind( 'click.DT', { action: "previous" }, fnClickHandler );
			$(els[1]).bind( 'click.DT', { action: "next" }, fnClickHandler );
		},

		"fnUpdate": function ( oSettings, fnDraw ) {
			$( ".doDelete" ).click(function() {
				confirmDialog( "<h2>" + $(this).attr('data-title') + "</h2>" + $( "#ms-datatable" ).attr('data-delete-message'), "?action=forums.delete&forumID=" + $(this).attr('data-id'));				
				}
			);

			var iListLength = 5;
			var oPaging = oSettings.oInstance.fnPagingInfo();
			var an = oSettings.aanFeatures.p;
			var i, ien, j, sClass, iStart, iEnd, iHalf=Math.floor(iListLength/2);

			if ( oPaging.iTotalPages < iListLength) {
				iStart = 1;
				iEnd = oPaging.iTotalPages;
			}
			else if ( oPaging.iPage <= iHalf ) {
				iStart = 1;
				iEnd = iListLength;
			} else if ( oPaging.iPage >= (oPaging.iTotalPages-iHalf) ) {
				iStart = oPaging.iTotalPages - iListLength + 1;
				iEnd = oPaging.iTotalPages;
			} else {
				iStart = oPaging.iPage - iHalf + 1;
				iEnd = iStart + iListLength - 1;
			}

			for ( i=0, ien=an.length ; i<ien ; i++ ) {
				// Remove the middle elements
				$('li:gt(0)', an[i]).filter(':not(:last)').remove();

				// Add the new list items and their event handlers
				for ( j=iStart ; j<=iEnd ; j++ ) {
					sClass = (j==oPaging.iPage+1) ? 'class="active"' : '';
					$('<li '+sClass+'><a href="#">'+j+'</a></li>')
						.insertBefore( $('li:last', an[i])[0] )
						.bind('click', function (e) {
							e.preventDefault();
							oSettings._iDisplayStart = (parseInt($('a', this).text(),10)-1) * oPaging.iLength;
							fnDraw( oSettings );
						} );
				}

				// Add / remove disabled classes from the static elements
				if ( oPaging.iPage === 0 ) {
					$('li:first', an[i]).addClass('disabled');
				} else {
					$('li:first', an[i]).removeClass('disabled');
				}

				if ( oPaging.iPage === oPaging.iTotalPages-1 || oPaging.iTotalPages === 0 ) {
					$('li:last', an[i]).addClass('disabled');
				} else {
					$('li:last', an[i]).removeClass('disabled');
				}
			}
		}
	}
} );


/*
 * TableTools Bootstrap compatibility
 * Required TableTools 2.1+
 */
if ( $.fn.DataTable.TableTools ) {
	// Set the classes that TableTools uses to something suitable for Bootstrap
	$.extend( true, $.fn.DataTable.TableTools.classes, {
		"container": "DTTT btn-group",
		"buttons": {
			"normal": "btn",
			"disabled": "disabled"
		},
		"collection": {
			"container": "DTTT_dropdown dropdown-menu",
			"buttons": {
				"normal": "",
				"disabled": "disabled"
			}
		},
		"print": {
			"info": "DTTT_print_info modal"
		},
		"select": {
			"row": "active"
		}
	} );

	// Have the collection use a bootstrap compatible dropdown
	$.extend( true, $.fn.DataTable.TableTools.DEFAULTS.oTags, {
		"collection": {
			"container": "ul",
			"button": "li",
			"liner": "a"
		}
	} );
}

	var aoColumns		= [];
	var sColumns		= [];
	var tRecords		= 0;

//	var aaSorting		= [[ 0, "asc" ]];
	var aaSorting		= [[ 6, "asc" ]];

	var oCache = {
		iCacheLower: -1,
		force: false
	};

	$('#ms-datatable .headers th').each( function () {
		if ( $(this).hasClass( 'nosort' ) ) {
			aoColumns.push( { "bSortable": false,"sClass": $(this).attr('data-class') } );
		} else {
			aoColumns.push( {"sClass": $(this).attr('data-class') } );
		}
	} );

	$('[data-column]','#ms-datatable_search').each( function () {
		sColumns.push( $(this).attr('id') );
	} );
	
	$("#setFilter").click(function() {
		oCache.force = true;
		oTable.fnDraw ( 0 );
	});
	$("#clearFilter").click(function() {
		$(':input','#ms-datatable_search').val('');
		oTable.fnSort( [[ 6, "asc" ]] );		
		oCache.force = true;
		oTable.fnDraw ( 0 );
	});
	$("input",'#ms-datatable_search').bind("keypress", function(e) {
		if (e.keyCode == 13) {
			oCache.force = true;
			oTable.fnDraw(0);
		}
	});
	$("select",'#ms-datatable_search').bind("change", function(e) {
		oCache.force = true;
		oTable.fnDraw(0);
	});
	$("#flt_sku").bind("keypress", function(e) {
		if (e.keyCode == 13) {
			oCache.force = true;
			oTable.fnDraw(0);
		}
	});
	var oTable = $('#ms-datatable').dataTable( {
		"aoColumns": aoColumns,
		"sPaginationType"	: "full_numbers",
		"bJQueryUI"			: true,
		"bProcessing"		: true,
		"bServerSide"		: true,
		"aaSorting"			: aaSorting,
		"sAjaxSource"		: $('#ms-datatable').attr('data-url'),
		"fnServerData"		: fnDataTablesPipeline,
		"sDom": "<'row-fluid'<'span6'l>r>t<'row-fluid'<'span6'i><'span6'p>>",
		"sPaginationType": "bootstrap",
		"oLanguage": {
			"sLengthMenu": "_MENU_ records per page"
		},
		"fnInitComplete"	: function() { $('#ms-datatable').removeClass("hideTable"); } 
	} );

	$('#flt_name').focus();


	
	function fnSetKey( aoData, sKey, mValue )
	{
		for ( var i=0, iLen=aoData.length ; i<iLen ; i++ )
		{
			if ( aoData[i].name == sKey )
			{
				aoData[i].value = mValue;
			}
		}
	}
	
	function fnGetKey( aoData, sKey )
	{
		for ( var i=0, iLen=aoData.length ; i<iLen ; i++ )
		{
			if ( aoData[i].name == sKey )
			{
				return aoData[i].value;
			}
		}
		return null;
	}
	
	function fnDataTablesPipeline ( sSource, aoData, fnCallback ) {
		var iPipe = 5; // Adjust the pipe size
		
		var bNeedServer = false;
		var sEcho = fnGetKey(aoData, "sEcho");
		var iRequestStart = fnGetKey(aoData, "iDisplayStart");
		var iRequestLength = fnGetKey(aoData, "iDisplayLength");
		var iRequestEnd = iRequestStart + iRequestLength;
		var nCol = "";
		var nVal = "";
		oCache.iDisplayStart = iRequestStart;
			
		// outside pipeline?
		if ( oCache.iCacheLower < 0 || iRequestStart < oCache.iCacheLower || iRequestEnd > oCache.iCacheUpper || oCache.force )
		{
			oCache.force = false;
			bNeedServer = true;
		}

		// sorting etc changed?
		if ( oCache.lastRequest && !bNeedServer )
		{
			for( var i=0, iLen=aoData.length ; i<iLen ; i++ )
			{
				if ( aoData[i].name != "iDisplayStart" && aoData[i].name != "iDisplayLength" && aoData[i].name != "sEcho" )
				{
					if ( aoData[i].value != oCache.lastRequest[i].value )
					{
						bNeedServer = true;
					}
				}
			}
		}
		
		// Store the request for checking next time around
		oCache.lastRequest = aoData.slice();
		
		if ( bNeedServer )
		{
			if ( iRequestStart < oCache.iCacheLower )
			{
				iRequestStart = iRequestStart - (iRequestLength*(iPipe-1));
				if ( iRequestStart < 0 )
				{
					iRequestStart = 0;
				}
			}
			oCache.iCacheLower = iRequestStart;
			oCache.iCacheUpper = iRequestStart + (iRequestLength * iPipe);
			oCache.iDisplayLength = fnGetKey( aoData, "iDisplayLength" );
			fnSetKey( aoData, "iDisplayStart", iRequestStart );
			fnSetKey( aoData, "iDisplayLength", iRequestLength*iPipe );

			for(var x in sColumns) {
				if( sColumns[x] != null ) {
					nCol =  $("#" + sColumns[x]).attr("data-column");
					nVal =  $("#" + sColumns[x]).val();
					aoData.push( { "name": "criteria_" + nCol,"value": nVal} );
				}
			}
			aoData.push( { "name": "nca","value": Math.floor(Math.random()*9999999)} );


//			aoData.push( { "name": iTotalRecords,"value": json.iTotalRecords} );

			$.getJSON( sSource, aoData, function (json) { 
				// Callback processing
				oCache.lastJson = jQuery.extend(true, {}, json);
				if ( oCache.iCacheLower != oCache.iDisplayStart )
				{
					json.aaData.splice( 0, oCache.iDisplayStart-oCache.iCacheLower );
				}
				json.aaData.splice( oCache.iDisplayLength, json.aaData.length );
				fnCallback(json);
				return;
			} );
		}
		else
		{
			json = jQuery.extend(true, {}, oCache.lastJson);
			json.sEcho = sEcho; // Update the echo for each response
			json.aaData.splice( 0, iRequestStart-oCache.iCacheLower );
			json.aaData.splice( iRequestLength, json.aaData.length );
			fnCallback(json);
		}
	}
} );

