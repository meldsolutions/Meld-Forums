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
<cfcomponent name="ThreadService" output="false" extends="MeldForums.com.meldsolutions.core.MeldService">
<!---^^GENERATEDSTART^^--->
	<cffunction name="init" access="public" output="false" returntype="ThreadService">
		<cfreturn this/>
	</cffunction>

	<cffunction name="createThread" access="public" output="false" returntype="any">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="ThreadID" type="uuid" required="false" />
		<cfargument name="ForumID" type="string" required="false" />
		<cfargument name="TypeID" type="numeric" required="false" />
		<cfargument name="SiteID" type="string" required="false" />
		<cfargument name="IsActive" type="boolean" required="false" />
		<cfargument name="IsClosed" type="boolean" required="false" />
		<cfargument name="IsDisabled" type="boolean" required="false" />
		<cfargument name="IsUserDisabled" type="boolean" required="false" />
		<cfargument name="IsDraft" type="boolean" required="false" />
		<cfargument name="UserID" type="string" required="false" />
		<cfargument name="AdminID" type="string" required="false" />
		<cfargument name="AdminMessage" type="string" required="false" />
		<cfargument name="Title" type="string" required="false" />
		<cfargument name="FriendlyName" type="string" required="false" />
		<cfargument name="OrderNo" type="numeric" required="false" />
		<cfargument name="PostCounter" type="numeric" required="false" />
		<cfargument name="LastPostID" type="string" required="false" />
		<cfargument name="DateLastPost" type="string" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<cfargument name="Idx" type="numeric" required="false" />
		<cfargument name="IsAnnouncement" type="boolean" required="false" />
		<!---^^ATTRIBUTES-END^^--->
				
		<cfset var tmpObj = createObject("component","ThreadBean").init(argumentCollection=arguments) />
		<cfset tmpObj.setThreadService( this ) />
		<cfreturn tmpObj />
	</cffunction>

	<cffunction name="getThread" access="public" output="false" returntype="any">
		<!---^^PRIMARY-START^^--->
		<cfargument name="ThreadID" type="uuid" required="true" />
		<!---^^PRIMARY-END^^--->
		
		<cfset var ThreadBean = createThread(argumentCollection=arguments) />
		<cfset getThreadDAO().read(ThreadBean) />
		<cfreturn ThreadBean />
	</cffunction>

	<cffunction name="getThreads" access="public" output="false" returntype="array">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="ThreadID" type="uuid" required="false" />
		<cfargument name="ForumID" type="string" required="false" />
		<cfargument name="TypeID" type="numeric" required="false" />
		<cfargument name="SiteID" type="string" required="false" />
		<cfargument name="IsActive" type="boolean" required="false" />
		<cfargument name="IsClosed" type="boolean" required="false" />
		<cfargument name="IsDisabled" type="boolean" required="false" />
		<cfargument name="IsUserDisabled" type="boolean" required="false" />
		<cfargument name="IsDraft" type="boolean" required="false" />
		<cfargument name="UserID" type="string" required="false" />
		<cfargument name="AdminID" type="string" required="false" />
		<cfargument name="AdminMessage" type="string" required="false" />
		<cfargument name="Title" type="string" required="false" />
		<cfargument name="FriendlyName" type="string" required="false" />
		<cfargument name="OrderNo" type="numeric" required="false" />
		<cfargument name="PostCounter" type="numeric" required="false" />
		<cfargument name="LastPostID" type="string" required="false" />
		<cfargument name="DateLastPost" type="string" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<cfargument name="Idx" type="numeric" required="false" />
		<cfargument name="IsAnnouncement" type="boolean" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		
		<cfreturn getThreadGateway().getByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="getBeanByAttributes" access="public" output="false" returntype="any">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="ThreadID" type="uuid" required="false" />
		<cfargument name="ForumID" type="string" required="false" />
		<cfargument name="TypeID" type="numeric" required="false" />
		<cfargument name="SiteID" type="string" required="false" />
		<cfargument name="IsActive" type="boolean" required="false" />
		<cfargument name="IsClosed" type="boolean" required="false" />
		<cfargument name="IsDisabled" type="boolean" required="false" />
		<cfargument name="IsUserDisabled" type="boolean" required="false" />
		<cfargument name="IsDraft" type="boolean" required="false" />
		<cfargument name="UserID" type="string" required="false" />
		<cfargument name="AdminID" type="string" required="false" />
		<cfargument name="AdminMessage" type="string" required="false" />
		<cfargument name="Title" type="string" required="false" />
		<cfargument name="FriendlyName" type="string" required="false" />
		<cfargument name="OrderNo" type="numeric" required="false" />
		<cfargument name="PostCounter" type="numeric" required="false" />
		<cfargument name="LastPostID" type="string" required="false" />
		<cfargument name="DateLastPost" type="string" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<cfargument name="Idx" type="numeric" required="false" />
		<cfargument name="IsAnnouncement" type="boolean" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="pageBean" type="any" required="false" />

		<cfreturn getThreadGateway().getBeanByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="getByArray" access="public" output="false" returntype="Any" >
		<cfargument name="idArray" type="array" required="true" />
		<cfargument name="format" type="string" required="false" default="query" />

		<cfreturn getThreadGateway().getByArray(argumentCollection=arguments) />
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
			<cfset sReturn.count = getThreadGateway().search(argumentCollection=arguments) />
			<cfset arguments.isCount = false>
		<cfelse>
			<cfset sReturn.count = arguments.count />
		</cfif>
		
		<cfset arrObjects = getThreadGateway().search(argumentCollection=arguments) />

		<cfset sReturn.start		= arguments.start />
		<cfset sReturn.size			= arguments.size />
		<cfset sReturn.itemarray	= arrObjects />

		<cfreturn sReturn />
	</cffunction>

	<cffunction name="saveThread" access="public" output="false" returntype="boolean">
		<cfargument name="ThreadBean" type="any" required="true" />
		<cfargument name="PostBean" type="any" required="false" />

		<cfset var fName = "" />

		<cfif not len( ThreadBean.getTitle() )>
			<cfset ThreadBean.setTitle( ThreadBean.getName() ) />
		</cfif>

		<cfif not len( ThreadBean.getFriendlyName() )>
			<cfset fName = getmmUtility().friendlyName( ThreadBean.getTitle() ) />
			<cfset ThreadBean.setFriendlyName( fName ) />
		<cfelse>
			<cfset fName = getmmUtility().friendlyName( ThreadBean.getFriendlyName() ) />
			<cfset ThreadBean.setFriendlyName( fName ) />
		</cfif>

		<cfif structKeyExists(arguments,"PostBean") and not isSimpleValue(arguments.PostBean)>
			<cfset ThreadBean.setLastPostID( arguments.PostBean.getPostID() ) />
			<cfset ThreadBean.setDateLastPost( arguments.PostBean.getDateCreate() ) />
		</cfif>

		<cfreturn getThreadDAO().save(ThreadBean) />
	</cffunction>
	
	<cffunction name="updateThread" access="public" output="false" returntype="boolean">
		<cfargument name="ThreadBean" type="any" required="true" />

		<cfset var fName = "" />

		<cfif not len( ThreadBean.getTitle() )>
			<cfset ThreadBean.setTitle( ThreadBean.getName() ) />
		</cfif>

		<cfif not len( ThreadBean.getFriendlyName() )>
			<cfset fName = getmmUtility().friendlyName( ThreadBean.getTitle() ) />
			<cfset ThreadBean.setFriendlyName( fName ) />
		<cfelse>
			<cfset fName = getmmUtility().friendlyName( ThreadBean.getFriendlyName() ) />
			<cfset ThreadBean.setFriendlyName( fName ) />
		</cfif>

		<cfreturn getThreadDAO().update(ThreadBean) />
	</cffunction>

	<cffunction name="deleteThread" access="public" output="false" returntype="boolean">
		<!---^^PRIMARY-START^^--->
		<cfargument name="ThreadID" type="uuid" required="true" />
		<!---^^PRIMARY-END^^--->
		
		<cfset var ThreadBean = createThread(argumentCollection=arguments) />
		<cfreturn getThreadDAO().delete(ThreadBean) />
	</cffunction>

	<cffunction name="setThreadGateway" access="public" returntype="void" output="false">
		<cfargument name="ThreadGateway" type="any" required="true" />
		<cfset variables['threadGateway'] = arguments.ThreadGateway />
	</cffunction>
	<cffunction name="getThreadGateway" access="public" returntype="any" output="false">
		<cfreturn ThreadGateway />
	</cffunction>

	<cffunction name="setThreadDAO" access="public" returntype="void" output="false">
		<cfargument name="ThreadDAO" type="any" required="true" />
		<cfset variables['threadDAO'] = arguments.ThreadDAO />
	</cffunction>
	<cffunction name="getThreadDAO" access="public" returntype="any" output="false">
		<cfreturn variables.ThreadDAO />
	</cffunction>

<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->
	<cffunction name="getThreadsWithLastPost" access="public" output="false" returntype="array">
		<cfargument name="forumID" type="uuid" required="false" />
		<cfargument name="pageBean" type="any" required="false" />
		<cfargument name="orderby" type="string" required="false" default="isSticky DESC,thr.dateLastPost DESC,thr.dateLastUpdate DESC" />
		
		<cfset var aThreads		= getThreads( argumentCollection=arguments )>
		<cfset var aLastPostIDs	= ArrayNew(1)>
		<cfset var sPosts		= StructNew()>

		<cfif arrayLen(aThreads)>
			<cfset aLastPostIDs = getPostIDArray( aThreads )>
			<cfset sPosts = getPostService().getByArray( aLastPostIDs,"struct" )>

			<cfloop from="1" to="#ArrayLen(aThreads)#" index="iiX">
				<cfif len( aThreads[iiX].getLastPostID() ) and StructKeyExists(sPosts, aThreads[iiX].getLastPostID() )>
					<cfset aThreads[iiX].setLastPost( sPosts[aThreads[iiX].getLastPostID()] )>
				</cfif>
			</cfloop>
		</cfif>

		<cfreturn aThreads />
	</cffunction>

	<cffunction name="getThreadWithPosts" access="public" output="false" returntype="any">
		<cfargument name="ThreadID" type="uuid" required="false" />
		<cfargument name="idx" type="numeric" required="false" />
		<cfargument name="pageBean" type="any" required="false" />
		
		<cfset var iiX			= 0>
		<cfset var sArgs		= StructNew() >
		<cfset var threadBean	= "" />
		<cfset var aPosts		= ArrayNew(1)>

		<cfif not StructKeyExists(arguments,"ThreadID") and not StructKeyExists(arguments,"idx")>
			<cfreturn createThread()/>
		</cfif>

		<cfif StructKeyExists(arguments,"threadID") and len(arguments.threadID)>
			<cfset sArgs.threadID = arguments.ThreadID />
		</cfif>
		<cfif StructKeyExists(arguments,"idx") and len(arguments.idx)>
			<cfset sArgs.idx = arguments.idx />
		</cfif>
		<cfset sArgs.isActive		= 1>

		<cfset threadBean	= getBeanByAttributes( argumentCollection=sArgs )>

		<cfif not threadBean.beanExists() or not threadBean.getisActive() or threadBean.getisDisabled()>
			<cfreturn createThread()/>
		</cfif>

		<cfset getThreadGateway().updateThreadCounter( threadBean.getThreadID(),threadBean.getForumID() )>

		<cfif not isNumeric(threadBean.getViewCounter())>
			<cfset threadBean.setViewCounter(1)>
		<cfelse>
			<cfset threadBean.setViewCounter( threadBean.getViewCounter()+1 )>
		</cfif>

		<!--- url.c is empty/0 --->
		<cfif not arguments.pageBean.getCount()>
			<cfset sArgs				= StructNew() >
			<cfset sArgs.threadID		= threadBean.getThreadID()>
			<cfset pageBean.setCount( getPostService().getCount( argumentCollection=sArgs ) ) />
		</cfif>

		<!--- get by page position (calculate because there might be deleted posts) --->
		<cfif pageBean.getPagePosition() gt 0 and not pageBean.getPage()>
			<cfset sArgs				= StructNew() >
			<cfset sArgs.threadID		= threadBean.getThreadID()>
			<cfset sArgs.pageBean		= pageBean>
			<cfset getPostService().setPageByPosition( argumentCollection=sArgs ) />
		</cfif>
		
		<cfset sArgs			= StructNew() >
		<cfset sArgs.pageBean = arguments.pageBean>
		<cfset sArgs.ThreadID = threadBean.getThreadID()>

		<cfset sArgs.isActive = 1>
		<cfset sArgs.withAttachments = 1>
		<cfset sArgs.orderBy = "pst.postPosition ASC">
		<cfset aPosts = getPostService().getPosts( argumentCollection=sArgs )>
				
		<cfset threadBean.setPosts( aPosts )>
		<cfreturn threadBean />
	</cffunction>

	<cffunction name="getPostIDArray" access="private" output="false" returntype="array">
		<cfargument name="aThreads" type="array" required="true" />
		
		<cfset var aIDs		= ArrayNew(1)>
		<cfset var iiX			= 0>
		
		<cfloop from="1" to="#ArrayLen(arguments.aThreads)#" index="iiX">
			<cfif len( arguments.aThreads[iiX].getLastPostID() )>
				<cfset ArrayAppend(	aIDs,arguments.aThreads[iiX].getLastPostID() )>
			</cfif>
		</cfloop>
		
		<cfreturn aIDs />
	</cffunction>

	<cffunction name="getForumIDByThreadID" access="public" output="false" returntype="string" description="retrieves the forum id for a particular thread">
		<cfargument name="threadID" type="uuid" required="true" />
		
		<cfreturn getThreadGateway().getForumIDByThreadID( argumentCollection=arguments ) /> 
	</cffunction>

	<cffunction name="getCount" access="public" output="false" returntype="Numeric" >
		<cfargument name="forumID" type="string" required="false" default="" />
		<cfargument name="siteID" type="string" required="false" default="" />

		<cfset var sArgs				= StructNew() >
		<cfset var qCount				= "">

		<cfif len(arguments.siteID)>
			<cfset sArgs.siteID			= arguments.siteID>
		</cfif>
		<cfif len(arguments.forumID)>
			<cfset sArgs.forumID			= arguments.forumID>
		</cfif>
		<cfset sArgs.isActive			= 1>
		<cfset sArgs.isCount			= true>
		
		<cfset qCount = getThreadGateway().getByAttributesQuery( argumentCollection=sArgs ) /> 
		
		<cfreturn qCount.total />
	</cffunction>

	<cffunction name="getSearchedThreads" access="public" output="false" returntype="array">
		<cfargument name="qSearch" type="query" required="true" />

		<cfreturn getThreadGateway().getSearchedThreads( argumentCollection=arguments ) /> 
	</cffunction>

	<cffunction name="getPostCount" access="public" output="false" returntype="numeric">
		<cfargument name="ThreadID" type="uuid" required="true" />
		<cfargument name="PostID" type="uuid" required="false" default=""/>
		<cfargument name="doIncrement" type="boolean" required="false" default="false" />
		<cfargument name="PostDate" type="date" required="false" default=""/>
		
		<cfreturn getThreadGateway().getPostCount( argumentCollection=arguments ) />
	</cffunction>

	<cffunction name="getCrumbData" access="public" output="false" returntype="array">
		<cfargument name="siteID" type="string" required="true" />
		<cfargument name="ThreadID" type="uuid" required="true" />
		<cfreturn getThreadGateway().getCrumbData(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="blockByUserID" access="public" output="false" returntype="void">
		<cfargument name="userID" type="uuid" required="true" />
		<cfargument name="type" type="numeric" required="false" default="2" />

		<cfset getThreadGateway().blockByUserID(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="unblockByUserID" access="public" output="false" returntype="void">
		<cfargument name="userID" type="uuid" required="true" />
		<cfargument name="type" type="numeric" required="false" default="2" />

		<cfset getThreadGateway().unblockByUserID(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="deleteThreads" access="public" output="false" returntype="boolean">
		<cfargument name="ForumID" type="uuid" required="true" />
		<cfargument name="inTransaction" type="boolean" required="false" default="true" />
	
		<cfif arguments.inTransaction>
			<cfset getThreadGateway().deleteThreads( argumentCollection=arguments ) />		
		<cfelse>
			<cftransaction>
				<cfset arguments.inTransaction = true />
				<cfset getThreadService().deleteThreads( argumentCollection=arguments ) />		
			</cftransaction>
		</cfif>
			
		<cfreturn true />
	</cffunction>


<!---^^CUSTOMEND^^--->
	<cffunction name="setPostService" access="public" returntype="any" output="false">
		<cfargument name="PostService" type="any" required="true">
		<cfset variables.PostService = arguments.PostService>
	</cffunction>
	<cffunction name="getPostService" access="public" returntype="any" output="false">
		<cfreturn variables.PostService>
	</cffunction>
</cfcomponent>













