/*
<!---
This file is part of the Meld Forums application.

Meld Forums is licensed under the GPL 2.0 license
Copyright (C) 2010 2011 Meld Solutions Inc. http://www.meldsolutions.com/

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation, version 2 of that license..

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
--->
*/
function doShowHide( src,tgt ) {
	if ( $("#"+src).is(':checked') ) {
		$("#"+tgt).show();
	}
	else {
		$("#"+tgt).hide();
	}
}
function doConfirmDelete( frm,msg,tgt,val ) {
	var $form	= $("#"+frm);
	var $tgt	= $("#"+tgt);
	
	if( confirm(msg) ) {
		$tgt.val( val );
		$form.submit();
		return true;
	}
	return false;
}
function doSetAction(act) {
	$("#action").val(act);
	return true;
}
$(document).ready(function() {
	doShowHide('doAddAdminMessage','iMessage');
	
	$('#doAddAdminMessage').click(function() {
		if ( $(this).is(':checked') ) {
			$("#iMessage").show();
		}
		else {
			$("#iMessage").hide();
		}
	});
	
});