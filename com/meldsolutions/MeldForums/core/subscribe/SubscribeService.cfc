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
<cfcomponent name="SubscribeService" output="false" extends="MeldForums.com.meldsolutions.core.MeldService">
<!---^^GENERATEDSTART^^--->
	<cffunction name="init" access="public" output="false" returntype="SubscribeService">
		<cfreturn this/>
	</cffunction>

	<cffunction name="createSubscribe" access="public" output="false" returntype="any">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="SubscribeID" type="uuid" required="false" />
		<cfargument name="ConferenceID" type="string" required="false" />
		<cfargument name="ForumID" type="string" required="false" />
		<cfargument name="ThreadID" type="string" required="false" />
		<cfargument name="UserID" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<cfargument name="IsEmail" type="boolean" required="false" />
		<!---^^ATTRIBUTES-END^^--->
				
		<cfset var tmpObj = createObject("component","SubscribeBean").init(argumentCollection=arguments) />
		<cfset tmpObj.setSubscribeService( this ) />
		<cfreturn tmpObj />
	</cffunction>

	<cffunction name="getSubscribe" access="public" output="false" returntype="any">
		<!---^^PRIMARY-START^^--->
		<cfargument name="SubscribeID" type="uuid" required="true" />
		<!---^^PRIMARY-END^^--->
		
		<cfset var SubscribeBean = createSubscribe(argumentCollection=arguments) />
		<cfset getSubscribeDAO().read(SubscribeBean) />
		<cfreturn SubscribeBean />
	</cffunction>

	<cffunction name="getSubscribes" access="public" output="false" returntype="array">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="SubscribeID" type="uuid" required="false" />
		<cfargument name="ConferenceID" type="string" required="false" />
		<cfargument name="ForumID" type="string" required="false" />
		<cfargument name="ThreadID" type="string" required="false" />
		<cfargument name="UserID" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<cfargument name="IsEmail" type="boolean" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		
		<cfreturn getSubscribeGateway().getByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="getBeanByAttributes" access="public" output="false" returntype="any">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="SubscribeID" type="uuid" required="false" />
		<cfargument name="ConferenceID" type="string" required="false" />
		<cfargument name="ForumID" type="string" required="false" />
		<cfargument name="ThreadID" type="string" required="false" />
		<cfargument name="UserID" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<cfargument name="IsEmail" type="boolean" required="false" />
		<!---^^ATTRIBUTES-END^^--->

		<cfreturn getSubscribeGateway().getBeanByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="getByArray" access="public" output="false" returntype="Query" >
		<cfargument name="idArray" type="array" required="true" />

		<cfreturn getSubscribeGateway().getByArray(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="search" access="public" output="false" returntype="struct">
		<cfargument name="criteria" type="struct" required="true" />
		<cfargument name="fieldList" type="string" required="false" default="*" />
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
			<cfset sReturn.count = getSubscribeGateway().search(argumentCollection=arguments) />
			<cfset arguments.isCount = false>
		<cfelse>
			<cfset sReturn.count = arguments.count />
		</cfif>
		
		<cfset arrObjects = getSubscribeGateway().search(argumentCollection=arguments) />

		<cfset sReturn.start		= arguments.start />
		<cfset sReturn.size			= arguments.size />
		<cfset sReturn.itemarray	= arrObjects />

		<cfreturn sReturn />
	</cffunction>

	<cffunction name="saveSubscribe" access="public" output="false" returntype="boolean">
		<cfargument name="SubscribeBean" type="any" required="true" />

		<cfreturn getSubscribeDAO().save(SubscribeBean) />
	</cffunction>
	
	<cffunction name="updateSubscribe" access="public" output="false" returntype="boolean">
		<cfargument name="SubscribeBean" type="any" required="true" />

		<cfreturn getSubscribeDAO().update(SubscribeBean) />
	</cffunction>

	<cffunction name="deleteSubscribe" access="public" output="false" returntype="boolean">
		<!---^^PRIMARY-START^^--->
		<cfargument name="SubscribeID" type="uuid" required="true" />
		<!---^^PRIMARY-END^^--->
		
		<cfset var SubscribeBean = createSubscribe(argumentCollection=arguments) />
		<cfreturn getSubscribeDAO().delete(SubscribeBean) />
	</cffunction>

	<cffunction name="setSubscribeGateway" access="public" returntype="void" output="false">
		<cfargument name="SubscribeGateway" type="any" required="true" />
		<cfset variables['subscribeGateway'] = arguments.SubscribeGateway />
	</cffunction>
	<cffunction name="getSubscribeGateway" access="public" returntype="any" output="false">
		<cfreturn SubscribeGateway />
	</cffunction>

	<cffunction name="setSubscribeDAO" access="public" returntype="void" output="false">
		<cfargument name="SubscribeDAO" type="any" required="true" />
		<cfset variables['subscribeDAO'] = arguments.SubscribeDAO />
	</cffunction>
	<cffunction name="getSubscribeDAO" access="public" returntype="any" output="false">
		<cfreturn variables.SubscribeDAO />
	</cffunction>

<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->
	<cffunction name="doSubscribeToThread" access="public" output="false" returntype="boolean">
		<cfargument name="userID" type="string" required="true" />
		<cfargument name="threadID" type="string" required="true" />

		<cfif not getIsSubscribedToThread(argumentCollection=arguments)>
			<cfreturn getSubscribeGateway().doSubscribeToThread(argumentCollection=arguments) />	
		</cfif>
	</cffunction>

	<cffunction name="doUnSubscribeToThread" access="public" output="false" returntype="boolean">
		<cfargument name="userID" type="string" required="true" />
		<cfargument name="threadID" type="string" required="true" />

		<cfreturn getSubscribeGateway().doUnSubscribeToThread(argumentCollection=arguments) />	
	</cffunction>

	<cffunction name="doSubscribeToForum" access="public" output="false" returntype="boolean">
		<cfargument name="userID" type="string" required="true" />
		<cfargument name="forumID" type="string" required="true" />

		<cfif not getIsSubscribedToForum(argumentCollection=arguments)>
			<cfreturn getSubscribeGateway().doSubscribeToForum(argumentCollection=arguments) />	
		</cfif>
		<cfreturn false />
	</cffunction>

	<cffunction name="doUnSubscribeToForum" access="public" output="false" returntype="void">
		<cfargument name="userID" type="string" required="true" />
		<cfargument name="forumID" type="string" required="true" />

		<cfreturn getSubscribeGateway().doUnSubscribeToForum(argumentCollection=arguments) />	
	</cffunction>

	<cffunction name="getIsSubscribedToThread" access="public" output="false" returntype="boolean">
		<cfargument name="userID" type="string" required="true" />
		<cfargument name="threadID" type="string" required="true" />

		<cfreturn getSubscribeGateway().getIsSubscribedToThread(argumentCollection=arguments) />	
	</cffunction>

	<cffunction name="getIsSubscribedToForum" access="public" output="false" returntype="boolean">
		<cfargument name="userID" type="string" required="true" />
		<cfargument name="forumID" type="string" required="true" />

		<cfreturn getSubscribeGateway().getIsSubscribedToForum(argumentCollection=arguments) />	
	</cffunction>


	<cffunction name="processSubscriptions" access="public" output="false" returntype="boolean">
		<cfargument name="$" type="any" required="true" />
		<cfargument name="threadBean" type="any" required="true" />
		<cfargument name="postBean" type="any" required="true" />
		<cfargument name="userBean" type="any" required="true" />
		<cfargument name="siteID" type="string" required="true" />
		<cfargument name="subscriptionText" type="string" required="true" />
				
		<cfreturn getSubscribeGateway().processSubscriptions(argumentCollection=arguments) />
	</cffunction>

<!---^^CUSTOMEND^^--->
</cfcomponent>









