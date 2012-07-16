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
<cfcomponent displayname="SubscribeGateway" output="false" extends="MeldForums.com.meldsolutions.core.MeldGateway">
<!---^^GENERATEDSTART^^--->
	<cffunction name="init" access="public" output="false" returntype="SubscribeGateway">
		<cfargument name="dsn" type="string" required="true">
		<cfargument name="dsnusername" type="string" required="true">
		<cfargument name="dsnpassword" type="string" required="true">
		<cfargument name="dsnprefix" type="string" required="true">
		<cfargument name="dsntype" type="string" required="true">

		<cfset variables.dsn = arguments.dsn>
		<cfset variables.dsnusername = arguments.dsnusername>
		<cfset variables.dsnpassword = arguments.dsnpassword>
		<cfset variables.dsnprefix = arguments.dsnprefix>
		<cfset variables.dsntype = arguments.dsntype>

		<cfreturn this />
	</cffunction>
	
	<cffunction name="getByAttributesQuery" access="public" output="false" returntype="query">
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
		<cfargument name="orderby" type="string" required="false" />
		<cfset var qList = "" />		
		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				*,1 AS BeanExists
			FROM	#variables.dsnprefix#mf_subscribe
			WHERE	0=0
		<!---^^VALUES-START^^--->
			<cfif structKeyExists(arguments,"SubscribeID") and len(arguments.SubscribeID)>
				AND SubscribeID = <cfqueryparam value="#arguments.SubscribeID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"ConferenceID") and len(arguments.ConferenceID)>
				AND ConferenceID = <cfqueryparam value="#arguments.ConferenceID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"ForumID") and len(arguments.ForumID)>
				AND ForumID = <cfqueryparam value="#arguments.ForumID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"ThreadID") and len(arguments.ThreadID)>
				AND ThreadID = <cfqueryparam value="#arguments.ThreadID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"UserID") and len(arguments.UserID)>
				AND UserID = <cfqueryparam value="#arguments.UserID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"DateCreate") and len(arguments.DateCreate)>
				AND DateCreate = <cfqueryparam value="#arguments.DateCreate#" CFSQLType="cf_sql_timestamp" />
			</cfif>
			
			<cfif structKeyExists(arguments,"DateLastUpdate") and len(arguments.DateLastUpdate)>
				AND DateLastUpdate = <cfqueryparam value="#arguments.DateLastUpdate#" CFSQLType="cf_sql_timestamp" />
			</cfif>
			
			<cfif structKeyExists(arguments,"IsEmail") and len(arguments.IsEmail)>
				AND IsEmail = <cfqueryparam value="#arguments.IsEmail#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			<!---^^VALUES-END^^--->
		<cfif structKeyExists(arguments, "orderby") and len(arguments.orderBy)>
			ORDER BY #arguments.orderby#
		</cfif>
		</cfquery>
		
		<cfreturn qList />
	</cffunction>

	<cffunction name="getByAttributes" access="public" output="false" returntype="array">
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
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = getByAttributesQuery(argumentCollection=arguments) />		
		<cfset var arrObjects = arrayNew(1) />
		<cfset var tmpObj = "" />
		<cfset var iiX = "" />
		<cfloop from="1" to="#qList.recordCount#" index="i">
			<cfset tmpObj = createObject("component","SubscribeBean").init(argumentCollection=queryRowToStruct(qList,iiX)) />
			<cfset tmpObj.setSubscribeService( getSubscribeService() ) />
			<cfset arrayAppend(arrObjects,tmpObj) />
		</cfloop>
				
		<cfreturn arrObjects />
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
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = getByAttributesQuery(argumentCollection=arguments) />		
		<cfset var arrObjects = arrayNew(1) />
		<cfset var tmpObj = "" />
		<cfset var iiX = "" />

		<cfif qList.recordCount gt 1>
			<cfset tmpObj = createObject("component","SubscribeBean").init(argumentCollection=queryRowToStruct(qList))>
			<cfset tmpObj.setSubscribeService( getSubscribeService() ) />
			<cfreturn tmpObj />
		<cfelseif qList.recordCount>
			<cfset tmpObj = createObject("component","SubscribeBean").init(argumentCollection=queryRowToStruct(qList)) />
			<cfset tmpObj.setSubscribeService( getSubscribeService() ) />
			<cfreturn tmpObj />
		<cfelse>
			<cfset tmpObj = createObject("component","SubscribeBean").init()>
			<cfset tmpObj.setSubscribeService( getSubscribeService() ) />
			<cfreturn tmpObj />
		</cfif>
	</cffunction>

	<cffunction name="getByArray" access="public" output="false" returntype="Query" >
		
		<cfargument name="aSubscribeID" type="array" required="true" />
		
		
		<cfset var qList			= "" />		
		<cfset var strObjects		= StructNew() />
		<cfset var tmpObj			= "" />
		<cfset var IDList			= "" />
		<cfset var iiX 				= "" />

		<cfif not arrayLen(arguments.idArray)>
			<cfreturn QueryNew('null') />
		</cfif>

		<cfset IDList = ArrayToList(arguments.idArray) />

		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				*
			FROM
				#variables.dsnprefix#mf_subscribe
			WHERE
				0=0
		
			AND
			SubscribeID IN (<cfqueryparam value="#aSubscribeID#" CFSQLType="cf_sql_char" list="true" maxlength="35" />)
		
		</cfquery>
		
		<cfreturn qList />
	</cffunction>

	<cffunction name="search" access="public" output="false" returntype="any">
		<cfargument name="criteria" type="struct" required="true" />
		<cfargument name="fieldList" type="string" required="true" />
		<cfargument name="start" type="numeric" required="false" default="0"/>
		<cfargument name="size" type="numeric" required="false" default="30"/>
		<cfargument name="orderby" type="string" required="false" default=""/>
		<cfargument name="isCount" type="boolean" required="false" default="false"/>
		
		<cfset var arrObjects		= ArrayNew(1)>
		<cfset var qList			= "" />
		<cfset var qExclude			= "" />
		<cfset var qKeep			= "" />
		<cfset var iiX				= "" />
		<cfset var returnFields		= rereplace(arguments.fieldList,";.*","") />
		<cfset var returnOrder		= rereplace(arguments.orderby,";.*","") />

		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				<cfif not arguments.isCount and arguments.size gt 0 AND variables.dsntype eq "mssql"> 	
					TOP #Ceiling(Val(arguments.start+arguments.size))#
				</cfif>
				<cfif arguments.isCount>
					COUNT(*) AS total
				<cfelse>
					#returnFields#
				</cfif>
			FROM	#variables.dsnprefix#mf_subscribe
			WHERE
				0=0
				<!---^^SEARCH-START^^--->
			<cfif structKeyExists(arguments.criteria,"SubscribeID") and len(arguments.criteria.SubscribeID)>
			AND SubscribeID = <cfqueryparam value="#arguments.criteria.SubscribeID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"ConferenceID") and len(arguments.criteria.ConferenceID)>
			AND ConferenceID = <cfqueryparam value="#arguments.criteria.ConferenceID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"ForumID") and len(arguments.criteria.ForumID)>
			AND ForumID = <cfqueryparam value="#arguments.criteria.ForumID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"ThreadID") and len(arguments.criteria.ThreadID)>
			AND ThreadID = <cfqueryparam value="#arguments.criteria.ThreadID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"UserID") and len(arguments.criteria.UserID)>
			AND UserID = <cfqueryparam value="#arguments.criteria.UserID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"DateCreate") and len(arguments.criteria.DateCreate)>
			AND DateCreate LIKE <cfqueryparam value="%#arguments.criteria.DateCreate#%" CFSQLType="cf_sql_timestamp" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"DateLastUpdate") and len(arguments.criteria.DateLastUpdate)>
			AND DateLastUpdate LIKE <cfqueryparam value="%#arguments.criteria.DateLastUpdate#%" CFSQLType="cf_sql_timestamp" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"IsEmail") and len(arguments.criteria.IsEmail)>
			AND IsEmail = <cfqueryparam value="#arguments.criteria.IsEmail#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			<!---^^SEARCH-END^^--->						
			<cfif not arguments.isCount AND len( arguments.orderBy )>
				ORDER BY #returnOrder#
			</cfif>
			<cfif not arguments.isCount and arguments.size gt 0 AND variables.dsntype eq "mysql">
				LIMIT <cfqueryparam value="#arguments.start#" CFSQLType="cf_sql_integer" />,<cfqueryparam value="#arguments.size#" CFSQLType="cf_sql_integer" />
			</cfif>
		</cfquery>

		<cfif not arguments.isCount AND variables.dsntype eq "mssql" AND arguments.start gt 0>
			<cfquery name="qExclude" dbtype="query" maxrows="#arguments.start#" >  
	        	SELECT
				
					SubscribeID
				FROM
					qList    
			</cfquery>
			
			<cfquery name="qKeep" dbtype="query" maxrows="#arguments.count#">  
				SELECT
					*  
				FROM  
					qList  
				WHERE  
					0=0
					(
					AND
					SubscribeID NOT IN (<cfqueryparam value="#valueList(qExclude.SubscribeID)#" list="true" CFSQLType="cf_sql_char" maxlength="35" />)
					)  
				
			</cfquery> 

			<cfset qList = qKeep> 
		</cfif>

		<cfif arguments.isCount>
			<cfreturn qList.total >
		<cfelse>
			<cfloop from="1" to="#qList.recordCount#" index="iiX">
				<cfset tmpObj = queryRowToStruct(qList,iiX) />
				<cfset arrayAppend(arrObjects,tmpObj) />
			</cfloop>
		</cfif>
		<cfreturn arrObjects />
	</cffunction>

	<cffunction name="setSubscribeService" access="public" returntype="void" output="false">
		<cfargument name="SubscribeService" type="any" required="true" />
		<cfset variables['subscribeService'] = arguments.SubscribeService />
	</cffunction>
	<cffunction name="getSubscribeService" access="public" returntype="any" output="false">
		<cfreturn variables.SubscribeService />
	</cffunction>


<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->
	<cffunction name="doUnSubscribeToThread" access="public" output="false" returntype="boolean">
		<cfargument name="userID" type="string" required="true" />
		<cfargument name="threadID" type="string" required="true" />
		
		<cfset var qCheck = "" />		
		<cfset var qChange = "" />		

		<cfquery name="qCheck" datasource="#variables.dsn#" username="#variables.dsnusername#"  password="#variables.dsnpassword#" maxrows="1">
			SELECT
				userID
			FROM	#variables.dsnprefix#mf_subscribe
			WHERE	userID = <cfqueryparam value="#arguments.userID#" CFSQLType="cf_sql_char" />
			AND		threadID = <cfqueryparam value="#arguments.threadID#" CFSQLType="cf_sql_char" />
		</cfquery>
		
		<cfif not qCheck.RecordCount>
			<cfreturn false />
		</cfif>

		<cfquery name="qChange" datasource="#variables.dsn#" username="#variables.dsnusername#"  password="#variables.dsnpassword#" maxrows="1">
			DELETE
			FROM	#variables.dsnprefix#mf_subscribe
			WHERE	userID = <cfqueryparam value="#arguments.userID#" CFSQLType="cf_sql_char" />
			AND		threadID = <cfqueryparam value="#arguments.threadID#" CFSQLType="cf_sql_char" />
		</cfquery>
		
		<cfreturn true />
	</cffunction>

	<cffunction name="doSubscribeToThread" access="public" output="false" returntype="boolean">
		<cfargument name="userID" type="string" required="true" />
		<cfargument name="threadID" type="string" required="true" />
		
		<cfset var qChange = "" />		
		<cfset var count = 0>

		<cfquery name="qChange" datasource="#variables.dsn#" username="#variables.dsnusername#"  password="#variables.dsnpassword#">
			INSERT INTO
				#variables.dsnprefix#mf_subscribe
				(subscribeID,userID,threadID,dateCreate,dateLastUpdate)
			VALUES
				(
				<cfqueryparam value="#createUUID()#" CFSQLType="cf_sql_char" />,
				<cfqueryparam value="#arguments.userID#" CFSQLType="cf_sql_char" />,
				<cfqueryparam value="#arguments.threadID#" CFSQLType="cf_sql_char" />,
				<cfqueryparam value="#createODBCDateTime(now())#" CFSQLType="cf_sql_timestamp" />,
				<cfqueryparam value="#createODBCDateTime(now())#" CFSQLType="cf_sql_timestamp" />
				)
		</cfquery>

		<cfreturn true>
	</cffunction>

	<cffunction name="getIsSubscribedToThread" access="public" output="false" returntype="boolean">
		<cfargument name="userID" type="string" required="true" />
		<cfargument name="threadID" type="string" required="true" />

		<cfset var qExists = "" />		

		<cfquery name="qExists" datasource="#variables.dsn#" username="#variables.dsnusername#"  password="#variables.dsnpassword#" maxrows="1">
			SELECT count(1) as idexists
			FROM	#variables.dsnprefix#mf_subscribe
			WHERE	userID = <cfqueryparam value="#arguments.userID#" CFSQLType="cf_sql_char" />
			AND		threadID = <cfqueryparam value="#arguments.threadID#" CFSQLType="cf_sql_char" />
		</cfquery>
	
		<cfif qExists.idexists>
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>

	<cffunction name="doUnSubscribeToForum" access="public" output="false" returntype="void">
		<cfargument name="userID" type="string" required="true" />
		<cfargument name="forumID" type="string" required="true" />
		
		<cfset var qChange = "" />		

		<cfquery name="qChange" datasource="#variables.dsn#" username="#variables.dsnusername#"  password="#variables.dsnpassword#" maxrows="1">
			DELETE
			FROM	#variables.dsnprefix#mf_subscribe
			WHERE	userID = <cfqueryparam value="#arguments.userID#" CFSQLType="cf_sql_char" />
			AND		ForumID = <cfqueryparam value="#arguments.forumID#" CFSQLType="cf_sql_char" />
		</cfquery>
	</cffunction>

	<cffunction name="doSubscribeToForum" access="public" output="false" returntype="boolean">
		<cfargument name="userID" type="string" required="true" />
		<cfargument name="forumID" type="string" required="true" />
		
		<cfset var qChange = "" />		

		<cfquery name="qChange" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			INSERT INTO
				#variables.dsnprefix#mf_subscribe
				(subscribeID,userID,forumID,dateCreate,dateLastUpdate)
			VALUES
				(
				<cfqueryparam value="#createUUID()#" CFSQLType="cf_sql_char" />,
				<cfqueryparam value="#arguments.userID#" CFSQLType="cf_sql_char" />,
				<cfqueryparam value="#arguments.forumID#" CFSQLType="cf_sql_char" />,
				<cfqueryparam value="#createODBCDateTime(now())#" CFSQLType="cf_sql_timestamp" />,
				<cfqueryparam value="#createODBCDateTime(now())#" CFSQLType="cf_sql_timestamp" />
				)
		</cfquery>
		<cfreturn true>
	</cffunction>

	<cffunction name="getIsSubscribedToForum" access="public" output="false" returntype="boolean">
		<cfargument name="userID" type="string" required="true" />
		<cfargument name="forumID" type="string" required="true" />

		<cfset var qExists = "" />		

		<cfquery name="qExists" datasource="#variables.dsn#" username="#variables.dsnusername#"  password="#variables.dsnpassword#" maxrows="1">
			SELECT count(1) as idexists
			FROM	#variables.dsnprefix#mf_subscribe
			WHERE	userID = <cfqueryparam value="#arguments.userID#" CFSQLType="cf_sql_char" />
			AND		forumID = <cfqueryparam value="#arguments.forumID#" CFSQLType="cf_sql_char" />
		</cfquery>
	
		<cfif qExists.idexists>
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>

	<cffunction name="processSubscriptions" access="public" output="false" returntype="boolean">
		<cfargument name="$" type="any" required="true" />
		<cfargument name="threadBean" type="any" required="true" />
		<cfargument name="postBean" type="any" required="true" />
		<cfargument name="userBean" type="any" required="true" />
		<cfargument name="siteID" type="string" required="true" />
		<cfargument name="subscriptionText" type="string" required="true" />

		<cfset var mailer				= $.getBean("mailer")>
		<cfset var qData				= "">
		<cfset var qList				= "">
		<cfset var qUsers				= "">
		<cfset var sendToUserBean		= "">
		<cfset var sendBody				= "">
		<cfset var txtSubscribe			= ""> 
		<cfset var txtNotify			= "">

		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#"  password="#variables.dsnpassword#">
			SELECT
				DISTINCT userID
			FROM
				#variables.dsnprefix#mf_subscribe sub
			WHERE
				(
				threadID = <cfqueryparam value="#arguments.threadBean.getThreadID()#" CFSQLType="cf_sql_char" />
				OR
				forumID = <cfqueryparam value="#arguments.threadBean.getForumID()#" CFSQLType="cf_sql_char" />
				)
			AND
				userID !=  <cfqueryparam value="#arguments.postBean.getUserID()#" CFSQLType="cf_sql_char" />
			AND
				userID !=  <cfqueryparam value="#arguments.threadBean.getUserID()#" CFSQLType="cf_sql_char" />
			AND
				userID !=  <cfqueryparam value="#arguments.userBean.getUserID()#" CFSQLType="cf_sql_char" />
		</cfquery>

		<cfif not qList.recordCount>
			<cfreturn true />
		</cfif>
		
		<cfquery name="qUsers" datasource="#$.globalConfig().getDatasource()#" username="#$.globalConfig().getDSNUsername()#"  password="#$.globalConfig().getDSNPassword()#">
			SELECT
				fName,lName,email
			FROM
				tusers
			WHERE
				userID IN  (<cfqueryparam value="#valueList(qList.userID)#" list="true" CFSQLType="cf_sql_char" />)
		</cfquery>

		<cfif not qUsers.recordCount>
			<cfreturn true />
		</cfif>

		<cfquery name="qData" datasource="#variables.dsn#" username="#variables.dsnusername#"  password="#variables.dsnpassword#">
			SELECT
				frm.name as forumName,cnf.name as conferenceName
			FROM
				#variables.dsnprefix#mf_forum frm
			JOIN
				#variables.dsnprefix#mf_conference cnf
			ON
				(frm.conferenceID = cnf.conferenceID)
			WHERE
				forumID = <cfqueryparam value="#arguments.threadBean.getForumID()#" CFSQLType="cf_sql_char" />
		</cfquery>

		<cfset txtSubscribe = getmmResourceBundle().key('newthreadin') & " " & qData.forumName & " : " & arguments.threadBean.getTitle()> 
		<cfset txtNotify = getmmResourceBundle().key('newpostin') & " " & qData.forumName & " : " & arguments.threadBean.getTitle()>

		<cfloop query="qUsers">
			<cfset sendBody = replace(arguments.subscriptionText,"[[USERID]]",userID,"all")>
			<cfset sendBody = replace(sendBody,"[[FIRSTNAME]]",qUsers.FName,"all")>
			<cfset sendBody = replace(sendBody,"[[LASTNAME]]",qUsers.LName,"all")>

			<cfset mailer.sendHTML(sendBody,
				email,
				"",
				txtSubscribe,
				arguments.siteID,
				$.siteConfig().getContactEmail() ) />
		</cfloop>

		<!--- notify user only if they aren't the poster --->
		<cfif arguments.postBean.getUserID() eq arguments.threadBean.getUserID()>
			<cfreturn true>
		</cfif>

		<cfset sendToUserBean = getMeldForumsSettingsManager().getUserFromCache( arguments.threadBean.getUserID(),arguments.siteID )>

		<cfif sendToUserBean.beanExists()>
			<cfif sendToUserBean.getDoReplyNotifications()>
				<cfset sendBody = replace(arguments.subscriptionText,"[[USERID]]",sendToUserBean.getUserID(),"all")>
				<cfset sendBody = replace(sendBody,"[[FIRSTNAME]]",sendToUserBean.getExternalUserBean().getFname(),"all")>
				<cfset sendBody = replace(sendBody,"[[LASTNAME]]",sendToUserBean.getExternalUserBean().getLname(),"all")>
	
				<cfset mailer.sendHTML(sendBody,
					sendToUserBean.getExternalUserBean().getEmail(),
					sendToUserBean.getScreenName(),
					txtNotify,
					arguments.siteID,
					$.siteConfig().getContactEmail() ) />
			</cfif>
			<cfreturn true />
		</cfif>
		
		<cfreturn false />
	</cffunction>

<!---^^CUSTOMEND^^--->

	<cffunction name="setMeldForumsSettingsManager" access="public" returntype="any" output="false">
		<cfargument name="MeldForumsSettingsManager" type="any" required="true">
		<cfset variables.MeldForumsSettingsManager = arguments.MeldForumsSettingsManager>
	</cffunction>
	<cffunction name="getMeldForumsSettingsManager" access="public" returntype="any" output="false">
		<cfreturn variables.MeldForumsSettingsManager>
	</cffunction>

	<cffunction name="setmmResourceBundle" access="public" returntype="any" output="false">
		<cfargument name="mmResourceBundle" type="any" required="true">
		<cfset variables.mmResourceBundle = arguments.mmResourceBundle>
	</cffunction>
	<cffunction name="getmmResourceBundle" access="public" returntype="any" output="false">
		<cfreturn variables.mmResourceBundle>
	</cffunction>
</cfcomponent>	


