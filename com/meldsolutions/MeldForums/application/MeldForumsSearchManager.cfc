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
<cfcomponent displayname="MeldForumsSearchManager" hint="Meld Event" output="false">
	<cfset variables.values		= StructNew()>

	<cffunction name="init" access="public" output="false" returntype="MeldForumsSearchManager">
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

		<cfreturn this/>
	</cffunction>
	
	<cffunction name="doSearch" access="public" output="false" returntype="array">
		<cfargument name="criteria" type="struct" required="true" />
		<cfargument name="pageBean" type="any" required="true" />
		<cfargument name="MFBean" type="any" required="true" />
		<cfargument name="isCount" type="boolean" required="false" default="false" />
		
		<cfset var arrObjects		= ArrayNew(1)>
		<cfset var arrIdArray		= ArrayNew(1)>
		<cfset var qList			= "" />
		<cfset var iiX				= "" />
		<cfset var sArgs			= StructNew() />

		<cfif NOT structKeyExists(arguments.criteria,"searchText") OR NOT len(arguments.criteria['searchText'])>
			<cfset getBeanFactory().getBean('mmErrorManager').addErrorByCode('1701') />
			<cfreturn arrObjects />
		</cfif>

		<cfset sArgs = structCopy(arguments) />

		<cfif not arguments.pageBean.getCount() and not arguments.isCount>
			<cfset sArgs.isCount = 1 />
			<cfset qList = doSearchQuery( argumentCollection=sArgs ) />
			<cfif qList.recordCount>
				<cfset arguments.pageBean.setCount( qList.total ) />
			</cfif>
		</cfif>
	
		<cfif not arguments.pageBean.getCount()>
			<cfreturn arrObjects />
		</cfif>
		
		<cfset sArgs.isCount = 0 />
		<cfset qList = doSearchQuery( argumentCollection=sArgs ) />
		
		<cfif qList.recordCount>
			<cfset arrObjects = getThreadService().getSearchedThreads( qList ) />
		</cfif>
		
		<cfreturn arrObjects />
	</cffunction>

	<cffunction name="doSearchQuery" access="public" output="false" returntype="query">
		<cfargument name="criteria" type="struct" required="true" />
		<cfargument name="pageBean" type="any" required="true" />
		<cfargument name="MFBean" type="any" required="true" />
		<cfargument name="isCount" type="boolean" required="false" default="false" />
		<cfargument name="orderby" type="string" required="false" default="sea.dateLastUpdate DESC" />
	
		<cfset var qList	= "" />		
		<cfset var qUser	= "" />		
		<cfset var qConfig	= "" />		
		<cfset var qExclude	= "" />		
		<cfset var qKeep	= "" />		
		<cfset var aSearchTerms = ArrayNew(1) />
		<cfset var iiX			= "" />
		<cfset var sType		= iif( arguments.criteria.searchType eq "AND",de("AND"),de("OR") ) />
		
		<cfif arguments.criteria.searchType neq "EXACT">
			<cfset aSearchTerms = listToArray(arguments.criteria.searchText," ") />
		</cfif>
		
		<cfset qUser = getUsergroupNames( arguments.MFBean ) />
		<cfset qConfig = getForumConfigurations( qUser ) />

		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				<cfif variables.dsntype eq "mssql" AND structKeyExists(arguments,"pageBean")> 	
					TOP  #( Ceiling(Val(arguments.pageBean.getPos())) + Ceiling(Val(arguments.pageBean.getSize())) )#
				</cfif>
				<cfif arguments.isCount>
					COUNT(DISTINCT sea.threadID) AS total
				<cfelse>
					sea.threadID,sea.postID,frm.forumID,frm.conferenceID,
					COALESCE(frm.configurationID, cnf.configurationID, '00000000-0000-0000-0000000000000001') as parentConfigurationID,
					con.restrictReadGroups
				</cfif>
			FROM	#variables.dsnprefix#mf_searchable sea
			JOIN
				#variables.dsnprefix#mf_post pos
			ON
				(
					sea.postID = pos.postID
					AND
					pos.isActive = 1
					AND
					pos.isDisabled = 0
					AND
					pos.isApproved = 1
				)
			JOIN
				#variables.dsnprefix#mf_thread thr
			ON
				(
					pos.threadID = thr.threadID
					AND
					thr.siteID = <cfqueryparam value="#arguments.criteria.SiteID#" CFSQLType="cf_sql_varchar" maxlength="25" />
					AND
					thr.isActive = 1
					AND
					thr.isDisabled = 0
					AND
					thr.isUserDisabled = 0
				)
			JOIN
				#variables.dsnprefix#mf_forum frm
			ON
				(
					thr.forumID = frm.forumID
					AND
					frm.isActive = 1
				)
			JOIN
				#variables.dsnprefix#mf_conference cnf
			ON
				(
					frm.conferenceID = cnf.conferenceID
					AND
					cnf.isActive = 1
				)
			LEFT JOIN
				#variables.dsnprefix#mf_configuration con
			ON
				(
					con.configurationID = COALESCE(frm.configurationID, cnf.configurationID, '00000000-0000-0000-0000000000000001')
				)
			WHERE
				0=0
			<cfif qConfig.recordCount and not MFBean.getCurrentUser().isSuperUser()>
			AND
				con.configurationID IN ( <cfqueryparam value="#valueList(qConfig.configurationID)#" list="true" CFSQLType="cf_sql_char" maxlength="35" />)
			</cfif>
			<cfif ArrayLen(aSearchTerms) gt 1>
				AND
				(
				0=0
				<cfloop from="1" to="#ArrayLen(aSearchTerms)#" index="iiX">
					#sType# Searchblock LIKE <cfqueryparam value="%#aSearchTerms[iiX]#%" CFSQLType="cf_sql_varchar" />
				</cfloop>
				)				
			<cfelseif ArrayLen(aSearchTerms) eq 1>
				AND Searchblock LIKE <cfqueryparam value="%#aSearchTerms[1]#%" CFSQLType="cf_sql_longvarchar" />
			<cfelse>
				AND Searchblock LIKE <cfqueryparam value="%#arguments.criteria.searchText#%" CFSQLType="cf_sql_varchar" />
			</cfif>
			
				<!---^^SEARCH-START^^--->

			<cfif structKeyExists(arguments.criteria,"ThreadID") and len(arguments.criteria.ThreadID)>
			AND sea.ThreadID = <cfqueryparam value="#arguments.criteria.ThreadID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"PostID") and len(arguments.criteria.PostID)>
			AND sea.PostID = <cfqueryparam value="#arguments.criteria.PostID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
				
			<cfif structKeyExists(arguments.criteria,"DateLastUpdate") and len(arguments.criteria.DateLastUpdate)>
			AND sea.DateLastUpdate LIKE <cfqueryparam value="%#arguments.criteria.DateLastUpdate#%" CFSQLType="cf_sql_timestamp" />
			</cfif>
						
			<!---^^SEARCH-END^^--->						
			<cfif not arguments.isCount AND len( arguments.orderBy )>
				GROUP BY sea.threadID
				<cfif variables.dsntype eq "mssql">,sea.postID,frm.forumID,frm.conferenceID,frm.configurationID,cnf.configurationID,con.restrictReadGroups,sea.DateLastUpdate</cfif>
				ORDER BY #arguments.orderBy#
			</cfif>
			<!--- if this is a MYSQL db, we can use LIMIT to get our start + count total and we are finished  --->
			<cfif variables.dsntype eq "mysql" and structKeyExists(arguments,"pageBean")>
				LIMIT <cfif len(arguments.pageBean.getPos())><cfqueryparam value="#arguments.pageBean.getPos()#" CFSQLType="cf_sql_integer"  />,</cfif> <cfqueryparam value="#arguments.pageBean.getSize()#" CFSQLType="cf_sql_integer"  />
			</cfif>
		</cfquery>
						
		<cfif arguments.isCount>
			<cfreturn qList />
		</cfif>

		<!--- if this is a MS SQL db, we have more work to do --->
		<cfif variables.dsntype eq "mssql" AND structKeyExists(arguments,"pageBean") AND arguments.pageBean.getPos() gt 0>
			<!--- first, get the first record set (start) we are excluding.  We only need the primary key.  --->
			<cfquery name="qExclude" dbtype="query" maxrows="#Ceiling(Val(arguments.pageBean.getPos()))#" >  
		       	SELECT
					postID  
				FROM
					qList    
			</cfquery>
				
			<!--- next, we get the (count) records we actually want returned  --->
			<cfquery name="qKeep" dbtype="query" maxrows="#Ceiling(Val(arguments.pageBean.getCount()))#">  
				SELECT
					*  
				FROM  
					qList  
				WHERE  
			<!--- now we use the primary key to exclude the 'start' records we retrieved above --->  
				postID NOT IN (<cfqueryparam value="#valueList(qExclude.postID)#" list="true" />)  
			</cfquery> 
				
			<!--- to finish, we re-assign the QoQ to the initial query variable --->  
			<cfset qList = qKeep> 
		</cfif>

		<cfreturn qList />
	</cffunction>

	<cffunction name="getUsergroupNames" returntype="query" access="public"  >
		<cfargument name="MFBean" type="any" required="true" >

		<cfset var qUser = "" />
		<cfset var globalConfig	= MFBean.getMuraScope().globalConfig() />

		<cfquery name="qUser" datasource="#globalConfig.getDatasource()#" username="#globalConfig.getDSNUserName()#" password="#globalConfig.getDSNPassword()#">
			SELECT groupname from
				tusersmemb
			JOIN
				tusers
			ON
				(tusers.userID =tusersmemb.groupID )
			WHERE
				tusersmemb.userID = <cfqueryparam value="#MFBean.getCurrentUser().getUserID()#" CFSQLType="cf_sql_char" maxlength="35" />
		</cfquery>

		<cfreturn qUser />
	</cffunction>

	<cffunction name="getForumConfigurations"  returntype="query" access="public"  >
		<cfargument name="qUserGroups" type="query" required="true" >

		<cfset var qConfig = "" />

		<cfquery name="qConfig" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT configurationID from
				#variables.dsnprefix#mf_configuration
			WHERE
				restrictReadGroups IS NULL
			<cfif qUserGroups.RecordCount>
			OR
				(
				restrictReadGroups IS NOT NULL
				AND
					(
					<cfloop query="qUserGroups">
						restrictReadGroups LIKE <cfqueryparam value="%,#qUserGroups.groupName#,%" CFSQLType="cf_sql_varchar" maxlength="35" />
						<cfif qUserGroups.currentRow lt qUserGroups.recordCount>OR</cfif>
					</cfloop>
					)
				)
			</cfif>
		</cfquery>
		
		<cfreturn qConfig />
	</cffunction>

	<cffunction name="getThreadService" access="public" output="false" returntype="any">
		<cfreturn variables.ThreadService />
	</cffunction>
	<cffunction name="setThreadService" access="public" output="false" returntype="void">
		<cfargument name="ThreadService" type="any" required="true" />
		<cfset variables.ThreadService = arguments.ThreadService />
	</cffunction>

	<cffunction name="getMeldForumsManager" access="public" output="false" returntype="any">
		<cfreturn variables.MeldForumsManager />
	</cffunction>
	<cffunction name="setMeldForumsManager" access="public" output="false" returntype="void">
		<cfargument name="MeldForumsManager" type="any" required="true" />
		<cfset variables.MeldForumsManager = arguments.MeldForumsManager />
	</cffunction>

	<cffunction name="getBeanFactory" access="public" output="false" returntype="any">
		<cfreturn getMeldForumsManager().getBeanFactory() />
	</cffunction>
</cfcomponent>