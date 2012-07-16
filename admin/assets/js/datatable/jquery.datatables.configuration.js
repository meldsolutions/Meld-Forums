$(document).ready(function() {
	var aoColumns		= [];
	var sColumns		= [];
	var tRecords		= 0;

	var aaSorting		= [[ 1, "asc" ]];

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
		"sDom"				: '<"header ui-widget-header ui-state-active"i>rt<"footer ui-widget-header ui-state-active"pl<"clear">',
		"fnInitComplete"	: function() { $('#ms-datatable').removeClass("hideTable"); }, 
		"fnRowCallback"		: function( nRow, aData, iDisplayIndex ) {
			if ( aData[2] == "*" )
			{
				$('td',nRow).addClass( 'highlight' );
			}
			return nRow;
		},

	} );


	
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
					nVal =  $("#" + sColumns[x]).attr("value");
					aoData.push( { "name": "criteria_" + nCol,"value": nVal} );
				}
			}


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

