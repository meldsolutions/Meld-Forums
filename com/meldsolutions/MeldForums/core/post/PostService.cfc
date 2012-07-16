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
<cfcomponent name="PostService" output="false" extends="MeldForums.com.meldsolutions.core.MeldService">
<!---^^GENERATEDSTART^^--->
	<cffunction name="init" access="public" output="false" returntype="PostService">
		<cfreturn this/>
	</cffunction>

	<cffunction name="createPost" access="public" output="false" returntype="any">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="PostID" type="uuid" required="false" />
		<cfargument name="ThreadID" type="string" required="false" />
		<cfargument name="UserID" type="string" required="false" />
		<cfargument name="AdminID" type="string" required="false" />
		<cfargument name="Message" type="string" required="false" />
		<cfargument name="IsActive" type="boolean" required="false" />
		<cfargument name="IsDisabled" type="boolean" required="false" />
		<cfargument name="IsApproved" type="boolean" required="false" />
		<cfargument name="IsUserDisabled" type="boolean" required="false" />
		<cfargument name="IsModerated" type="boolean" required="false" />
		<cfargument name="DateModerated" type="string" required="false" />
		<cfargument name="DoBlockAttachment" type="boolean" required="false" />
		<cfargument name="AttachmentID" type="string" required="false" />
		<cfargument name="PostPosition" type="numeric" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<cfargument name="Idx" type="numeric" required="false" />
		<cfargument name="ParentID" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->
				
		<cfset var tmpObj = createObject("component","PostBean").init(argumentCollection=arguments) />
		<cfset tmpObj.setPostService( this ) />
		<cfreturn tmpObj />
	</cffunction>

	<cffunction name="getPost" access="public" output="false" returntype="any">
		<!---^^PRIMARY-START^^--->
		<cfargument name="PostID" type="uuid" required="true" />
		<!---^^PRIMARY-END^^--->
		
		<cfset var PostBean = createPost(argumentCollection=arguments) />
		<cfset getPostDAO().read(PostBean) />
		<cfreturn PostBean />
	</cffunction>

	<cffunction name="getPosts" access="public" output="false" returntype="array">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="PostID" type="uuid" required="false" />
		<cfargument name="ThreadID" type="string" required="false" />
		<cfargument name="UserID" type="string" required="false" />
		<cfargument name="AdminID" type="string" required="false" />
		<cfargument name="Message" type="string" required="false" />
		<cfargument name="IsActive" type="boolean" required="false" />
		<cfargument name="IsDisabled" type="boolean" required="false" />
		<cfargument name="IsApproved" type="boolean" required="false" />
		<cfargument name="IsUserDisabled" type="boolean" required="false" />
		<cfargument name="IsModerated" type="boolean" required="false" />
		<cfargument name="DateModerated" type="string" required="false" />
		<cfargument name="DoBlockAttachment" type="boolean" required="false" />
		<cfargument name="AttachmentID" type="string" required="false" />
		<cfargument name="PostPosition" type="numeric" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<cfargument name="Idx" type="numeric" required="false" />
		<cfargument name="ParentID" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="pageBean" type="any" required="false" />
		<cfargument name="orderby" type="string" required="false" />
		<cfargument name="siteID" type="string" required="false" default="" />

		<cfreturn getPostGateway().getByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="getBeanByAttributes" access="public" output="false" returntype="any">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="PostID" type="uuid" required="false" />
		<cfargument name="ThreadID" type="string" required="false" />
		<cfargument name="UserID" type="string" required="false" />
		<cfargument name="AdminID" type="string" required="false" />
		<cfargument name="Message" type="string" required="false" />
		<cfargument name="IsActive" type="boolean" required="false" />
		<cfargument name="IsDisabled" type="boolean" required="false" />
		<cfargument name="IsApproved" type="boolean" required="false" />
		<cfargument name="IsUserDisabled" type="boolean" required="false" />
		<cfargument name="IsModerated" type="boolean" required="false" />
		<cfargument name="DateModerated" type="string" required="false" />
		<cfargument name="DoBlockAttachment" type="boolean" required="false" />
		<cfargument name="AttachmentID" type="string" required="false" />
		<cfargument name="PostPosition" type="numeric" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<cfargument name="Idx" type="numeric" required="false" />
		<cfargument name="ParentID" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="siteID" type="string" required="false" default="" />

		<cfreturn getPostGateway().getBeanByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="getByArray" access="public" output="false" returntype="Any" >
		<cfargument name="idArray" type="array" required="true" />
		<cfargument name="format" type="string" required="false" default="query" />

		<cfreturn getPostGateway().getByArray( argumentCollection=arguments) />
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
			<cfset sReturn.count = getPostGateway().search(argumentCollection=arguments) />
			<cfset arguments.isCount = false>
		<cfelse>
			<cfset sReturn.count = arguments.count />
		</cfif>
		
		<cfset arrObjects = getPostGateway().search(argumentCollection=arguments) />

		<cfset sReturn.start		= arguments.start />
		<cfset sReturn.size			= arguments.size />
		<cfset sReturn.itemarray	= arrObjects />

		<cfreturn sReturn />
	</cffunction>

	<cffunction name="savePost" access="public" output="false" returntype="boolean">
		<cfargument name="PostBean" type="any" required="true" />

		<cfset var success 			= getPostDAO().save(PostBean) />
		<cfset var sArgs			= StructNew() />
		<cfset var searchableBean	= "" />
		<cfset var searchContent	= getmmUtility().stripAll( postBean.getTitle() & " ~ " & postBean.getMessage() ) />
		
		<cfif success>
			<cfset sArgs = PostBean.getMemento() />
			<cfset sArgs.searchBlock = searchContent />
			<cfset searchableBean = getSearchableService().createSearchable( argumentCollection=sArgs ) />
			<cfset searchableBean.save() />
		</cfif>
		
		<cfreturn success />
	</cffunction>
	
	<cffunction name="updatePost" access="public" output="false" returntype="boolean">
		<cfargument name="PostBean" type="any" required="true" />

		<cfset var success 			= getPostDAO().update(PostBean) />
		<cfset var sArgs			= StructNew() />
		<cfset var searchableBean	= "" />
		<cfset var searchContent	= getmmUtility().stripAll( postBean.getTitle() & " ~ " & postBean.getMessage() ) />
		
		<cfif success>
			<cfset sArgs.postID = PostBean.getPostID() />
			<cfset searchableBean = getSearchableService().getSearchable( argumentCollection=sArgs ) />
			<cfif searchableBean.beanExists()>
				<cfset searchableBean.setSearchBlock( searchContent ) />
				<cfset searchableBean.update() />
			<cfelse>
				<cfset sArgs = PostBean.getMemento() />
				<cfset sArgs.searchBlock = searchContent />
				<cfset searchableBean = getSearchableService().createSearchable( argumentCollection=sArgs ) />
				<cfset searchableBean.save() />
			</cfif>
		</cfif>
		
		<cfreturn success />
	</cffunction>

	<cffunction name="deletePost" access="public" output="false" returntype="boolean">
		<!---^^PRIMARY-START^^--->
		<cfargument name="PostID" type="uuid" required="true" />
		<!---^^PRIMARY-END^^--->
		
		<cfset var PostBean = createPost(argumentCollection=arguments) />
		<cfset var success  = getPostDAO().delete(PostBean) />
		
		<cfif success>
			<cfset searchableBean = getSearchableService().deleteSearchable( argumentCollection=arguments ) />
		</cfif>
		<cfreturn success />
	</cffunction>

	<cffunction name="setPostGateway" access="public" returntype="void" output="false">
		<cfargument name="PostGateway" type="any" required="true" />
		<cfset variables['postGateway'] = arguments.PostGateway />
	</cffunction>
	<cffunction name="getPostGateway" access="public" returntype="any" output="false">
		<cfreturn variables['postGateway'] />
	</cffunction>

	<cffunction name="setPostDAO" access="public" returntype="void" output="false">
		<cfargument name="PostDAO" type="any" required="true" />
		<cfset variables['postDAO'] = arguments.PostDAO />
	</cffunction>
	<cffunction name="getPostDAO" access="public" returntype="any" output="false">
		<cfreturn variables.PostDAO />
	</cffunction>

<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->

	<cffunction name="getCount" access="public" output="false" returntype="Numeric">
		<cfargument name="threadID" type="string" required="false" default="" />
		<cfargument name="siteID" type="string" required="false" default="" />

		<cfset var sArgs				= StructNew() >
		<cfset var qCount				= "">
		<cfset var total				= "">

		<cfif len(arguments.siteID)>
			<cfset sArgs.siteID			= arguments.siteID>
		</cfif>
		<cfif len(arguments.threadID)>
			<cfset sArgs.threadID		= arguments.threadID>
		</cfif>
		<cfset sArgs.isActive			= 1>
		<cfset sArgs.isCount			= true>
		
		<cfset total = getPostGateway().getByAttributesQuery( argumentCollection=sArgs ) /> 
		
		<cfreturn total />
	</cffunction>

	<cffunction name="setPageByPosition" access="public" output="false" returntype="Numeric">
		<cfargument name="threadID" type="uuid" required="true" />
		<cfargument name="pageBean" type="any" required="true" />

		<cfreturn getPostGateway().setPageByPosition( argumentCollection=arguments ) /> 
	</cffunction>

	<cffunction name="getPostPosition" access="public" output="false" returntype="Numeric">
		<cfargument name="threadID" type="uuid" required="false" />

		<cfreturn getPostGateway().getPostPosition( argumentCollection=arguments ) /> 
	</cffunction>

	<cffunction name="getForumIDByPostID" access="public" output="false" returntype="string" description="retrieves the forum id for a particular thread">
		<cfargument name="postID" type="uuid" required="true" />
		
		<cfreturn getPostGateway().getForumIDByPostID( argumentCollection=arguments ) /> 
	</cffunction>

	<cffunction name="getCrumbData" access="public" output="false" returntype="array">
		<cfargument name="siteID" type="string" required="true" />
		<cfargument name="postID" type="uuid" required="true" />
		<cfreturn getPostGateway().getCrumbData(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="blockByUserID" access="public" output="false" returntype="void">
		<cfargument name="userID" type="uuid" required="true" />
		<cfargument name="type" type="numeric" required="false" default="2" />

		<cfset getPostGateway().blockByUserID(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="unblockByUserID" access="public" output="false" returntype="void">
		<cfargument name="userID" type="uuid" required="true" />
		<cfargument name="type" type="numeric" required="false" default="2" />

		<cfset getPostGateway().unblockByUserID(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="getRecentActivity" access="public" output="false" returntype="array">
		<cfargument name="pageBean" type="any" required="true" />

		<cfreturn getPostGateway().getRecentActivity(argumentCollection=arguments) />
	</cffunction>

<!---^^CUSTOMEND^^--->

	<cffunction name="setSearchableService" access="public" returntype="void" output="false">
		<cfargument name="SearchableService" type="any" required="true" />
		<cfset variables['searchableservice'] = arguments.SearchableService />
	</cffunction>
	<cffunction name="getSearchableService" access="public" returntype="any" output="false">
		<cfreturn variables.SearchableService />
	</cffunction>

</cfcomponent>

