<!---^^LICENSE-START^^--->
This file is part of the Meld Manager application.

Meld Manager is licensed under the GPL 2.0 license
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

<!---^^LICENSE-END^^--->
<cfcomponent displayname="ErrorBean" output="false">

	<cfset variables.instance = StructNew()>

	<cffunction name="init" access="public" output="false" returntype="ErrorBean">
		<cfargument name="message" type="string" required="true">
		<cfargument name="type" type="string" required="true">
		<cfargument name="code" type="string" required="false" default="">
		<cfargument name="detail" type="string" required="false" default="">

		<cfset setMessage(arguments.message)>
		<cfset setType(arguments.type)>
		<cfset setCode(arguments.code)>
		<cfset setDetail(arguments.detail)>

		<cfreturn this/>
	</cffunction>

	<cffunction name="setMemento" access="public" returntype="struct" output="false">
		<cfargument name="memento" type="struct" required="yes"/>
		<cfset variables.instance = arguments.memento />
		<cfreturn this />
	</cffunction>
	<cffunction name="getMemento" access="public" returntype="struct" output="false" >
		<cfreturn variables.instance />
	</cffunction>

	<cffunction name="setMessage" access="public" returntype="void" output="false">
		<cfargument name="Message" type="string" required="true" />
		<cfset variables.instance.Message = arguments.Message />
	</cffunction>
	<cffunction name="getMessage" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Message />
	</cffunction>

	<cffunction name="setType" access="public" returntype="void" output="false">
		<cfargument name="Type" type="string" required="true" />
		<cfset variables.instance.Type = arguments.Type />
	</cffunction>
	<cffunction name="getType" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Type />
	</cffunction>

	<cffunction name="setCode" access="public" ApprovalCode="void" output="false">
		<cfargument name="Code" Code="string" required="true" />
		<cfset variables.instance.Code = arguments.Code />
	</cffunction>
	<cffunction name="getCode" access="public" ApprovalCode="string" output="false">
		<cfreturn variables.instance.Code />
	</cffunction>

	<cffunction name="setDetail" access="public" returnDetail="void" output="false">
		<cfargument name="Detail" Detail="string" required="true" />
		<cfset variables.instance.Detail = arguments.Detail />
	</cffunction>
	<cffunction name="getDetail" access="public" returnDetail="string" output="false">
		<cfreturn variables.instance.Detail />
	</cffunction>
</cfcomponent>