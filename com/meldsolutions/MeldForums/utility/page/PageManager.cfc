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
<cfcomponent displayname="PageManager" output="false">

	<cffunction name="init" returntype="PageManager" access="public" output="false">

		<cfreturn this>
	</cffunction>

	<cffunction name="getPageBean" returntype="any" output="false">
		<cfargument name="$" required="true" type="any" />
		<cfargument name="size" required="false" type="numeric" default="-1" />
		<cfargument name="start" required="false" type="numeric" default="-1" />
		<cfargument name="count" required="false" type="numeric" default="-1" />
		<cfargument name="page" required="false" type="numeric" default="0" />
		<cfargument name="pageposition" required="false" type="numeric" default="0" />
		<cfargument name="search" required="false" type="string" default="" />
		<cfargument name="searchtype" required="false" type="string" default="" />

		<cfset var pageBean = "" />

		<cfset arguments.pageManager = this />
		<cfset arguments.siteID = arguments.$.event('siteID') />
		
		<cfset pageBean = createObject("component","PageBean").init( argumentCollection=arguments )>
		
		<cfreturn pageBean />
	</cffunction>
	
	<cffunction name="createNav" returntype="string" access="public" output="false">
		<cfargument name="pageBean" required="true" type="any" />

		<cfset var sFullString	= "" />
		<cfset var sNavString	= "" />
		<cfset var sNavBack		= "" />
		<cfset var sNavNext		= "" />
		<cfset var sNavPage		= "" />
		<cfset var iiX			= "" />
		<cfset var iPageNumber	= pageBean.getPage()>
		<cfset var iPageCount	= 0 />
		<cfset var iPagingSize	= pageBean.getRange() />
		<cfset var settingsBean	= getMeldForumsSettingsManager().getSiteSettings( siteID=pageBean.getSiteID() ) />
		<cfset var themeBean	= settingsBean.getThemeBean() />
		
		<cfif not isDefined("rc")>
			<cfset rc = structNew() />
			<cfset rc.mmRBF = getmmRBF() />
		</cfif>

		<cfif not len( pageBean.getURL() )>
			<cfset pageBean.setURL( assembleURLStruct( pageBean ) ) />
		</cfif>
		
		<cfif not pageBean.getPage() or pageBean.getPage()*pageBean.getSize() gt pageBean.getCount()>
			<cfif not pageBean.getPage()>
				<!--- iPageNumber 0 --->
				<cfset pageBean.setPage(1)>
				<cfset iPageCount = ceiling(pageBean.getSize())>
			<!--- position is less than the distance from the pagingSize to the top --->
			<cfelseif pageBean.getPage()*pageBean.getSize() gt pageBean.getCount()>
				<cfset pageBean.setPage( ceiling(pageBean.getCount()/pageBean.getSize()) )>
			<!--- position is within the page range to the top --->
			</cfif>
		</cfif>

		<cfif pageBean.getPage() lte round(iPagingSize/2)>
			<!--- iPageNumber 1 --->
			<cfset iPageNumber = 1>
			<cfset iPageCount = iPageNumber+iPagingSize-1>
		<cfelseif (pageBean.getPages()-int(iPagingSize/2)) lt pageBean.getPage()>
			<cfset iPageNumber = pageBean.getPage()-int(iPagingSize-(pageBean.getPages()-pageBean.getPage()+1))>
			<cfset iPageCount = iPageNumber+iPagingSize-1>
		<!--- position is less than the distance from the pagingSize to the top --->
		<cfelseif (iPagingSize-int(pageBean.getSize()/2))+(iPagingSize-1) lt pageBean.getPages()>
			<cfset iPageNumber = pageBean.getPage()-int(iPagingSize/2)>
			<cfset iPageCount = iPageNumber+iPagingSize-1>
		<!--- position is within the page range to the top --->
		<cfelse>
			<cfset iPageNumber = pageBean.getPages()-iPagingSize+1>
			<cfset iPageCount = pageBean.getPages()>
		</cfif>

		<!--- deals with pages that are less than the page range --->				
		<cfif iPageNumber lte 1>
			<cfset iPageNumber = 1>
			<cfset iPageCount = iPagingSize>
		</cfif>
		<cfif iPageCount gt pageBean.getPages()>
			<cfset iPageCount = pageBean.getPages()>
		</cfif>
	
		<cfsavecontent variable="sNavString" >
		<cfif not fileExists( expandPath("/MeldForums/themes/#themeBean.getPackageName()#/templates/includes/pageNavTemplate.cfm") )>
			<cfinclude template="./pageNavTemplate.cfm" />
		<cfelse>
			<cfinclude template="/MeldForums/themes/#themeBean.getPackageName()#/templates/includes/pageNavTemplate.cfm" />
		</cfif>
		</cfsavecontent>
<!---
		<cfoutput>#sNavString#
		iPageNumber: #iPageNumber#<br/>
		iPageCount: #iPageCount#<br/>
		pages:	#pageBean.getPages()#<br/>
		</cfoutput>
		<cfdump var="#pageBean.getMemento()#">
		<cfabort>
--->

		<cfreturn sNavString />
	</cffunction>

	<cffunction name="getNavByPage" >
		<cfargument name="pageBean" required="true" type="any" />
		<cfargument name="addPage" required="true" type="numeric" default="0" />
		<cfargument name="setPage" required="true" type="numeric" default="0" />

		<cfset var strURL		= pageBean.getURL() />
		<cfset var pg			= pageBean.getPage() />
		<cfset var retString	= '' />
		<cfset var iiX			= '' />
		
		<cfif setPage>
			<cfset pg = setPage />
		<cfelseif addPage>
			<cfset pg = pg + addPage />
		</cfif>

		<cfset retString = "pg=#pg#&pgs=#pageBean.getPages()##pageBean.getUrl()#" />
		
		<cfreturn retString />
	</cffunction>
	
	<cffunction name="assembleURLStruct" returntype="string" access="public" output="false">
		<cfargument name="pageBean" required="true" type="any" />

		<cfset var strQueryString	= StructNew() />
		<cfset var retString		= "" />
		<cfset var aQString			= ListToArray(cgi.QUERY_STRING,"&") />
		<cfset var aKeyVal			= "" />
		<cfset var iiX				= "" />
		<cfset var sStr				= "" />
<!---
		<cfset strQueryString['pg'] = pageBean.getPage() />
		<cfset strQueryString['p'] = pageBean.getStart() />
--->
		<cfset strQueryString['s'] = pageBean.getSize() />
		<cfset strQueryString['c'] = pageBean.getCount() />

		<cfloop from="1" to="#ArrayLen(aQString)#" index="iiX">
			<cfset aKeyVal = ListToArray(aQString[iiX],"=") />
			<cfif ArrayLen(aKeyVal) eq 2>
				<cfswitch expression="#aKeyVal[1]#">
					<!---
					<cfcase value="p" >
						<cfset strQueryString['p'] = pageBean.getStart() />
					</cfcase>
					<cfcase value="pg" >
						<cfset strQueryString['pg'] = pageBean.getPage() />
					</cfcase>
					--->
					<cfcase value="p" >
						<!--- ignore --->
					</cfcase>
					<cfcase value="pg" >
						<!--- ignore --->
					</cfcase>
					<cfcase value="pp" >
						<!--- ignore --->
					</cfcase>
					<cfcase value="s" >
						<cfset strQueryString['s'] = pageBean.getSize() />
					</cfcase>
					<cfcase value="c" >
						<cfset strQueryString['c'] = pageBean.getCount() />
					</cfcase>
					<cfcase value="k" >
						<cfset strQueryString['k'] = urlEncodedFormat(pageBean.getSearch()) />
					</cfcase>
					<cfcase value="st" >
						<cfset strQueryString['st'] = pageBean.getSearchType() />
					</cfcase>
					<cfdefaultcase >
						<cfif left(aKeyVal[1],1) eq "_">
							<cfset strQueryString[lcase(aKeyVal[1])] = aKeyVal[2] />
						</cfif>
					</cfdefaultcase>
				</cfswitch>
			</cfif>
		</cfloop>

		<cfif not structKeyExists(strQueryString,"k") and len( pageBean.getSearch() )>
			<cfset strQueryString['k'] = urlEncodedFormat(pageBean.getSearch()) />
		</cfif>
		<cfif not structKeyExists(strQueryString,"st") and len( pageBean.getSearchType() )>
			<cfset strQueryString['st'] = pageBean.getSearchType() />
		</cfif>

		<cfloop collection="#strQueryString#" item="iiX" >
			<cfset retString = retString & "&" & iiX & "=" & strQueryString[iiX] />
		</cfloop>
		
		<cfreturn retString />
	</cffunction>
		
	<cffunction name="setmmResourceBundle" access="public" returntype="any" output="false">
		<cfargument name="mmResourceBundle" type="any" required="true">
		<cfset variables.mmResourceBundle = arguments.mmResourceBundle>
	</cffunction>
	<cffunction name="getmmResourceBundle" access="public" returntype="any" output="false">
		<cfreturn variables.mmResourceBundle>
	</cffunction>
	<cffunction name="getMMRBF" access="public" returntype="any" output="false">
		<cfreturn variables.mmResourceBundle>
	</cffunction>

	<cffunction name="setMeldForumsSettingsManager" access="public" returntype="any" output="false">
		<cfargument name="MeldForumsSettingsManager" type="any" required="true">
		<cfset variables.MeldForumsSettingsManager = arguments.MeldForumsSettingsManager>
	</cffunction>
	<cffunction name="getMeldForumsSettingsManager" access="public" returntype="any" output="false">
		<cfreturn variables.MeldForumsSettingsManager>
	</cffunction>


</cfcomponent>
















