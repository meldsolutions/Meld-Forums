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
<cfcomponent displayname="MeldService">

	<cffunction name="queryRowToStruct" access="private" output="false" returntype="struct">
		<cfargument name="qry" type="query" required="true">
		<cfscript>
			/**
			 * Makes a row of a query into a structure.
			 * 
			 * @param query 	 The query to work with. 
			 * @param row 	 Row number to check. Defaults to row 1. 
			 * @return Returns a structure. 
			 * @author Nathan Dintenfass (nathan@changemedia.com) 
			 * @version 1, December 11, 2001 
			 */
			var row = 1;
			var ii = 1;
			var cols = listToArray(qry.columnList);
			var stReturn = structnew();
			if(arrayLen(arguments) GT 1)
				row = arguments[2];
			for(ii = 1; ii lte arraylen(cols); ii = ii + 1){
				stReturn[lcase(cols[ii])] = qry[cols[ii]][row];
			}		
			return stReturn;
		</cfscript>
	</cffunction>

	<cffunction name="setmmUtility" access="public" returntype="any" output="false">
		<cfargument name="mmUtility" type="any" required="true">
		<cfset variables.mmUtility = arguments.mmUtility>
	</cffunction>
	<cffunction name="getmmUtility" access="public" returntype="any" output="false">
		<cfreturn variables.mmUtility>
	</cffunction>

	<cffunction name="setmmErrorManager" access="public" returntype="any" output="false">
		<cfargument name="mmErrorManager" type="any" required="true">
		<cfset variables.mmErrorManager = arguments.mmErrorManager>
	</cffunction>
	<cffunction name="getmmErrorManager" access="public" returntype="any" output="false">
		<cfreturn variables.mmErrorManager>
	</cffunction>
</cfcomponent>