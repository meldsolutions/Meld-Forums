<!---This file is part of the Meld Forums application.

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
<cfcomponent name="ConferenceService" output="false" extends="MeldForums.com.meldsolutions.core.MeldService">
<!---^^GENERATEDSTART^^--->
	<cffunction name="init" access="public" output="false" returntype="ConferenceService">
		<cfreturn this/>
	</cffunction>

	<cffunction name="createConference" access="public" output="false" returntype="any">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="ConferenceID" type="uuid" required="false" />
		<cfargument name="SiteID" type="string" required="false" />
		<cfargument name="ConfigurationID" type="string" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Title" type="string" required="false" />
		<cfargument name="Description" type="string" required="false" />
		<cfargument name="IsActive" type="boolean" required="false" />
		<cfargument name="FriendlyName" type="string" required="false" />
		<cfargument name="OrderNo" type="numeric" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<cfargument name="Idx" type="numeric" required="false" />
		<!---^^ATTRIBUTES-END^^--->
				
		<cfset var tmpObj = createObject("component","ConferenceBean").init(argumentCollection=arguments) />
		<cfset tmpObj.setConferenceService( this ) />
		<cfreturn tmpObj />
	</cffunction>

	<cffunction name="getConference" access="public" output="false" returntype="any">
		<!---^^PRIMARY-START^^--->
		<cfargument name="ConferenceID" type="uuid" required="true" />
		<!---^^PRIMARY-END^^--->
		<cfargument name="doForums" type="boolean" required="false" default="true" />
		
		<cfset var ConferenceBean 	= createConference(argumentCollection=arguments) />
		<cfset var aForums			= ArrayNew(1) />
		<cfset var sArgs			= structNew() />

		<cfset variables.ConferenceDAO.read(ConferenceBean) />

		<cfif not arguments.doForums>
			<cfreturn ConferenceBean />
		</cfif>	
		
		<cfset sArgs.conferenceID	= arguments.ConferenceID />
		<cfset sArgs.doLastPost		= 1 />
		<cfset sArgs.isActive		= 1 />
		
		<cfset aForums = getForumService().getForums( argumentCollection=sArgs )>
		<cfset ConferenceBean.setForums( aForums )>

		<cfreturn ConferenceBean />
	</cffunction>

	<cffunction name="getConferences" access="public" output="false" returntype="array">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="ConferenceID" type="uuid" required="false" />
		<cfargument name="SiteID" type="string" required="false" />
		<cfargument name="ConfigurationID" type="string" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Title" type="string" required="false" />
		<cfargument name="Description" type="string" required="false" />
		<cfargument name="IsActive" type="boolean" required="false" />
		<cfargument name="FriendlyName" type="string" required="false" />
		<cfargument name="OrderNo" type="numeric" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<cfargument name="Idx" type="numeric" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="doForums" type="boolean" required="false" default="false" />
		
		<cfset var aConferences		= getConferenceGateway().getByAttributes( argumentCollection=arguments )>
		<cfset var iiX				= 0 />
		<cfset var sArgs			= StructNEw() />
		<cfset var aForums			= ArrayNew(1) />

		<cfif not arguments.doForums>
			<cfreturn aConferences />
		</cfif>	
		
		<cfif doForums>
			<cfloop from="1" to="#ArrayLen(aConferences)#" index="iiX">
				<cfset sArgs.conferenceID	= aConferences[iiX].getConferenceID() />
				<cfset sArgs.doLastPost		= 1 />
				<cfset sArgs.isActive		= 1 />
				<cfset aForums = getForumService().getForums( argumentCollection=sArgs ) />
	
				<cfset aConferences[iiX].setForums( aForums )>
			</cfloop>
		</cfif>
		
		<cfreturn aConferences/>
	</cffunction>

	<cffunction name="getBeanByAttributes" access="public" output="false" returntype="any">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="ConferenceID" type="uuid" required="false" />
		<cfargument name="SiteID" type="string" required="false" />
		<cfargument name="ConfigurationID" type="string" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Title" type="string" required="false" />
		<cfargument name="Description" type="string" required="false" />
		<cfargument name="IsActive" type="boolean" required="false" />
		<cfargument name="FriendlyName" type="string" required="false" />
		<cfargument name="OrderNo" type="numeric" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<cfargument name="Idx" type="numeric" required="false" />
		<!---^^ATTRIBUTES-END^^--->

		<cfreturn getConferenceGateway().getBeanByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="getByArray" access="public" output="false" returntype="Query" >
		<cfargument name="idArray" type="array" required="true" />

		<cfreturn getConferenceGateway().getByArray(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="search" access="public" output="false" returntype="struct">
		<cfargument name="criteria" type="struct" required="true" />
		<cfargument name="fieldList" type="string" required="false" default="cnf.*" />
		<cfargument name="start" type="numeric" required="false" default="0"/>
		<cfargument name="size" type="numeric" required="false" default="10"/>
		<cfargument name="count" type="numeric" required="false" default="0"/>
		<cfargument name="isPaged" type="numeric" required="false" default="true" />
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var arrObjects		= ArrayNew(1)>
		<cfset var iiX				= "" >
		<cfset var isValid			= false >
		<cfset var sReturn			= StructNew()>
		
		<cfif arguments.isPaged and not arguments.count>
			<cfset arguments.isCount = true>
			<cfset sReturn.count = getConferenceGateway().search(argumentCollection=arguments) />
			<cfset arguments.isCount = false>
		<cfelse>
			<cfset sReturn.count = arguments.count />
		</cfif>
		
		<cfif sReturn.count gt 0>
			<cfset arrObjects = getConferenceGateway().search(argumentCollection=arguments) />
		</cfif>
		
		<cfset sReturn.start		= arguments.start />
		<cfset sReturn.size			= arguments.size />
		<cfset sReturn.itemarray	= arrObjects />

		<cfreturn sReturn />
	</cffunction>

	<cffunction name="saveConference" access="public" output="false" returntype="boolean">
		<cfargument name="ConferenceBean" type="any" required="true" />

		<cfset var fName = "" />

		<cfif not len( ConferenceBean.getTitle() )>
			<cfset ConferenceBean.setTitle( ConferenceBean.getName() ) />
		</cfif>

		<cfif not len( ConferenceBean.getFriendlyName() )>
			<cfset fName = getmmUtility().friendlyName( ConferenceBean.getTitle() ) />
			<cfset ConferenceBean.setFriendlyName( fName ) />
		<cfelse>
			<cfset fName = getmmUtility().friendlyName( ConferenceBean.getFriendlyName() ) />
			<cfset ConferenceBean.setFriendlyName( fName ) />
		</cfif>

		<cfreturn getConferenceDAO().save( ConferenceBean ) />
	</cffunction>
	
	<cffunction name="updateConference" access="public" output="false" returntype="boolean">
		<cfargument name="ConferenceBean" type="any" required="true" />

		<cfset var fName = "" />

		<cfif not len( ConferenceBean.getTitle() )>
			<cfset ConferenceBean.setTitle( ConferenceBean.getName() ) />
		</cfif>

		<cfif not len( ConferenceBean.getFriendlyName() )>
			<cfset fName = getmmUtility().friendlyName( ConferenceBean.getTitle() ) />
			<cfset ConferenceBean.setFriendlyName( fName ) />
		<cfelse>
			<cfset fName = getmmUtility().friendlyName( ConferenceBean.getFriendlyName() ) />
			<cfset ConferenceBean.setFriendlyName( fName ) />
		</cfif>

		<cfreturn getConferenceDAO().update(ConferenceBean) />
	</cffunction>

	<cffunction name="deleteConference" access="public" output="false" returntype="boolean">
		<!---^^PRIMARY-START^^--->
		<cfargument name="ConferenceID" type="uuid" required="true" />
		<!---^^PRIMARY-END^^--->
		<cfargument name="inTransaction" type="boolean" required="false" default="true" />
		
		<cfset var ConferenceBean = createConference(argumentCollection=arguments) />
		
		<cftransaction>
			<cfset getForumService().deleteForums( argumentCollection=arguments ) />		
			<cfset variables.ConferenceDAO.delete( ConferenceBean ) />
		</cftransaction>
		
		<cfreturn true />
	</cffunction>

	<cffunction name="setConferenceGateway" access="public" returntype="void" output="false">
		<cfargument name="ConferenceGateway" type="any" required="true" />
		<cfset variables['conferenceGateway'] = arguments.ConferenceGateway />
	</cffunction>
	<cffunction name="getConferenceGateway" access="public" returntype="any" output="false">
		<cfreturn ConferenceGateway />
	</cffunction>

	<cffunction name="setConferenceDAO" access="public" returntype="void" output="false">
		<cfargument name="ConferenceDAO" type="any" required="true" />
		<cfset variables['conferenceDAO'] = arguments.ConferenceDAO />
	</cffunction>
	<cffunction name="getConferenceDAO" access="public" returntype="any" output="false">
		<cfreturn variables.ConferenceDAO />
	</cffunction>

<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->
	<cffunction name="getTree" access="public" output="false" returntype="query">
		<cfargument name="value" type="any" required="false" />
		<cfargument name="OnlyActive" type="boolean" required="false" default="true" />

		<cfreturn getConferenceGateway().getTree(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="getIDs" access="public" output="false" returntype="array">
		<cfargument name="OnlyActive" type="boolean" required="false" default="true" />
		
		<cfreturn getConferenceGateway().getIDs(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="getCrumbData" access="public" output="false" returntype="array">
		<cfargument name="siteID" type="string" required="false" />
		<cfargument name="ConferenceID" type="uuid" required="false" />
		
		<cfreturn getConferenceGateway().getCrumbData(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="getCount" access="public" output="false" returntype="Numeric">
		<cfargument name="siteID" type="string" required="false" default="" />
		
		<cfreturn getConferenceGateway().getCount(argumentCollection=arguments) />
	</cffunction>

<!---^^CUSTOMEND^^--->

	<cffunction name="setForumService" access="public" returntype="any" output="false">
		<cfargument name="ForumService" type="any" required="true">
		<cfset variables.ForumService = arguments.ForumService>
	</cffunction>
	<cffunction name="getForumService" access="public" returntype="any" output="false">
		<cfreturn variables.ForumService>
	</cffunction>
</cfcomponent>











