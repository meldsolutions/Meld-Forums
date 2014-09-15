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
<cfsilent>
	<!--- rc --->
	<!--- headers --->
</cfsilent><cfoutput>
<div class="plugincontent">
	<div class="row">
		<div class="span12">
		<div id="meld-logo" class="clearfix">
			<a href="http://www.meldsolutions.com" target="_new"></a>
		</div>
		</div>
	</div>

		#view("/global/menu")#


	<cfif structKeyExists(rc,"error")>
		<div id="meld-error" class="section clearfix">
			<cfif rc.errorBean.hasErrors("notice")>
				<div class="notice">
					#rc.errorBean.hasErrors.displayErrorsHTML("notice")#
				</div>
			</cfif>
			<cfif rc.errorBean.hasErrors("custom")>
				<div class="error">
					#rc.errorBean.displayErrorsHTML("custom")#
				</div>
			</cfif>
			<cfif rc.errorBean.hasErrors("other")>
				<div class="error">
					#rc.errorBean.displayErrorsHTML("other")#
				</div>
			</cfif>
		</div>
	</cfif>
</div>
	#body#
</cfoutput>