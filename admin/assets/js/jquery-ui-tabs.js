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

$(document).ready(function() {
	var uiShowTabArray = [];

	$(function() {
		$resized = false;
		
		$("#msTabs").tabs();
		$("#msTabs-side").tabs().addClass('ui-tabs-vertical ui-helper-clearfix');
		$("#msTabs-side li").removeClass('ui-corner-top').addClass('ui-corner-left');
		$("#msTabs-side div").removeClass('ui-corner-bottom');
		$("#msTabs-side li").removeClass('ui-corner-top').addClass('ui-corner-left');
	});
	
} );

// cEf4FD7aE2