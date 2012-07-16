<!---
This file is part of Meld Forums.

Meld Forums is commercial software, use and installation is bound by the terms of the
included license agreement.  If you wish to purchase licenced copy of Meld Forums,
please visit http://www.clevertechnology.com/
--->
<cfcomponent displayname="MuraCrumbManager" hint="Manages Application Modifications to Breadcrumbs" output="false">

	<cfset variables.instance = StructNew()>

	<cffunction name="init" access="public" returntype="MuraCrumbManager" output="false">
		<cfreturn this>
	</cffunction>

	<cffunction name="createCrumb" access="public" returntype="struct" output="false">
		<cfargument name="siteid" type="string" required="false" default="">
		<cfargument name="menutitle" type="string" required="true">
		<cfargument name="filename" type="string" required="true">
		<cfargument name="filenamesuffix" type="string" required="false" default="">
		<cfargument name="type" type="string" required="false" default="Page">
		<cfargument name="target" type="string" required="false" default="_self">
		<cfargument name="contentid" type="string" required="false" default="">
		<cfargument name="parentid" type="string" required="false" default="">
		<cfargument name="restricted" type="string" required="false" default="">
		<cfargument name="restrictGroups" type="string" required="false" default="">
		<cfargument name="template" type="string" required="false" default="">
		<cfargument name="contenthistid" type="string" required="false" default="">
		<cfargument name="targetPrams" type="string" required="false" default="">
		<cfargument name="metadesc" type="string" required="false" default="">
		<cfargument name="metakeywords" type="string" required="false" default="">
		<cfargument name="sortBy" type="string" required="false" default="orderno">
		<cfargument name="sortDirection" type="string" required="false" default="asc">
		<cfargument name="inheritObjects" type="string" required="false" default="">
	
		<cfset var crumb	=	StructNew() />
		
		<cfset crumb.type=arguments.type />
		<cfset crumb.filename=arguments.filename />
		<cfif len(arguments.filenamesuffix)>
			<cfset crumb.filename=crumb.filename & arguments.filenamesuffix & "/" />
		</cfif>
		<cfset crumb.menutitle=arguments.menutitle />
		<cfset crumb.target=arguments.target />
		<cfset crumb.contentid=arguments.contentid />
		<cfset crumb.parentid=arguments.parentid />
		<cfset crumb.siteid=arguments.siteid />
		<cfset crumb.restricted=arguments.restricted />
		<cfset crumb.restrictGroups=arguments.restrictgroups />
		<cfset crumb.template=arguments.template />
		<cfset crumb.contenthistid=arguments.contenthistid />
		<cfset crumb.targetPrams=arguments.targetPrams />
		<cfset crumb.metadesc=arguments.metadesc />
		<cfset crumb.metakeywords=arguments.metakeywords />
		<cfset crumb.sortBy=arguments.sortBy />
		<cfset crumb.sortDirection=arguments.sortDirection />
		<cfset crumb.inheritObjects=arguments.inheritObjects />
	
		<cfreturn crumb>
	</cffunction>

	<cffunction name="setMuraManager" access="public" returntype="any" output="false">
		<cfargument name="MuraManager" type="any" required="true">
		<cfset variables.MuraManager = arguments.MuraManager>
	</cffunction>
	<cffunction name="getMuraManager" access="public" returntype="any" output="false">
		<cfreturn variables.MuraManager>
	</cffunction>
</cfcomponent>