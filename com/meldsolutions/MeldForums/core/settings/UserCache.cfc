This file is part of Meld Forums.

Meld Forums is commercial software, use and installation is bound by the terms of the
included license agreement.  If you wish to purchase licenced copy of Meld Forums,
please visit http://www.clevertechnology.com/
--->
<cfcomponent displayname="userCache" hint="A collection of users for a page" output="false">

	<cfset variables.instance = StructNew()>
	<cfset variables.instance.nullUser = CreateUUID()>
	<cfset variables.userHolder = "">


	<cffunction name="init" access="public" returntype="userCache" output="false">
		<cfargument name="siteID" type="string" required="true">
		<cfargument name="UserService" type="any" required="true">
		<cfargument name="CacheFactory" type="any" required="true">
		<cfargument name="CacheTimeLength" type="numeric" required="false" default="10">
		<cfargument name="ActivityTimeLength" type="numeric" required="false" default="5">
		<cfargument name="ActivityTimeLimit" type="numeric" required="false" default="5">
		<cfargument name="userCacheSize" type="numeric" required="false" default="50">

		<cfset variables.instance.siteID			= arguments.siteID>
		<cfset variables.instance.userCache			= StructNew()>
		<cfset variables.instance.userActive		= StructNew()>
		<cfset variables.instance.userActiveSorted	= ArrayNew(1)>
		<cfset variables.instance.activeMonitorAge	= int(getTickCount())>

		<cfset variables.UserService =arguments.UserService>
		<cfset variables.CacheFactory =arguments.CacheFactory>
		<cfset variables.userHolder = getUserService().createUser()>

		<!--- length of time in minutes between list purge --->
		<cfset setCacheTimeLength(arguments.CacheTimeLength)>
		<!--- length of time in minutes between list purge --->
		<cfset setActivityTimeLength(arguments.ActivityTimeLength)>
		<!--- length of time a user is considered 'active' from last update --->
		<cfset setActivityTimeLimit(arguments.ActivityTimeLimit)>
		<!--- max number of cached users --->
		<cfset setuserCacheSize(arguments.userCacheSize)>

		<cfreturn this>
	</cffunction>

	<cffunction name="setMemento" access="public" returntype="struct" output="false">
		<cfargument name="memento" type="struct" required="yes"/>
		<cfset variables.instance = arguments.memento />
		<cfreturn this />
	</cffunction>
	<cffunction name="getMemento" access="public" returntype="struct" output="false" >
		<cfreturn variables.instance />
	</cffunction>

<!--- ACTIVITY --->
	<cffunction name="setActive" access="public" returntype="void" output="false">
		<cfargument name="userID" type="string" required="true">
		<cfset variables.instance.userActive[userID]	= getTickCount()>
	</cffunction>

	<cffunction name="getOnlineCount" access="public" returntype="numeric" output="false">
		<cfif getActiveMonitorAge() gt getActivityTimeLength()>
			<cfset cleanActiveCache()>
		</cfif>
		<cfreturn StructCount(variables.instance.userActive)>
	</cffunction>

	<cffunction name="getOnlineList" access="public" returntype="array" output="false">
		<cfif getActiveMonitorAge() gt getActivityTimeLength()>
			<cfset cleanActiveCache()>
		<cfelseif arrayLen( variables.instance.userActiveSorted ) neq StructCount(variables.instance.userActive)>
			<cfset variables.instance.userActiveSorted = StructSort(variables.instance.userActive,"numeric","DESC")>
		</cfif>
		
		<cfreturn variables.instance.userActiveSorted>
	</cffunction>

	<cffunction name="IsOnline" access="public" returntype="boolean" output="false">
		<cfargument name="userID" type="string" required="true">

		<cfif StructKeyExists(variables.instance.userActive,userID)	and	isActive(userID)>
			<cfreturn true>
		</cfif>
		<cfreturn false>
	</cffunction>

	<cffunction name="cleanActiveCache" access="public" returntype="void" output="false">
		<cfset var userID = "">

		<cflock scope="Application" timeout="15">
			<cfloop collection="#variables.instance.userActive#" item="userID">
				<cfif not isActive(userID)>
					<cfset StructDelete(variables.instance.userActive,userID)>
				</cfif>
			</cfloop>
		</cflock>
		<cfset variables.instance.activeMonitorAge		= int(getTickCount())>
		<cfset variables.instance.userActiveSorted = StructSort(variables.instance.userActive,"numeric","DESC")>
	</cffunction>

	<cffunction name="getActiveMonitorAge" access="public" returntype="numeric" output="false">
		<cfreturn getTickCount()-variables.instance.activeMonitorAge>
	</cffunction>

	<cffunction name="isActive" access="public" returntype="numeric" output="false">
		<cfargument name="userID" type="string" required="true">
		
		<cfif not structKeyExists(variables.instance.userActive,arguments.userID)>
			<cfreturn false>
		</cfif>
		
		<cfreturn getTickCount()-variables.instance.userActive[arguments.userID] lt getActivityTimeLength()>
	</cffunction>

<!--- CACHE --->
	<cffunction name="cleanuserCache" access="public" returntype="void" output="false">
		<cfset var userID = "">

		<cfreturn />

		<cflock scope="Application" timeout="10">
			<cfloop collection="#variables.instance.userCache#" item="userID">
				<cfif isUserStale(userID)>
					<cfset markDirty(userID)>
				</cfif>
			</cfloop>
		</cflock>
	</cffunction>

	<cffunction name="purgeUserCache" access="public" returntype="void" output="false">
		<cfreturn />
		<cfloop collection="#variables.instance.userCache#" item="userID">
			<cfset purgeUser(userID)>
		</cfloop>
	</cffunction>

	<cffunction name="purgeUser" access="public" returntype="void" output="false">
		<cfargument name="userID" type="string" required="true">
		<cfset getCacheFactory().purge(arguments.userID)>
		<cfset StructDelete(variables.instance.userCache,arguments.userID)>
		<cfset StructDelete(variables.instance.userActive,userID)>
	</cffunction>

	<cffunction name="cacheAllUsers" access="public" returntype="void" output="false">
		<cfloop collection="#variables.instance.userCache#" item="userID">
			<cfset createUser(userID)>
		</cfloop>
	</cffunction>

	<cffunction name="createNullUser" access="public" returntype="any" output="false">
		<cfargument name="userID" type="string" required="true">
		<cfset var userBean = "">
		<cfset var data = StructNew()>

		<cfset data.userID = "00000000-0000-0000-0000000000000001">
		<cfset data.screenName = "n/a">
		<cfset userBean = getUserService().createUser( argumentCollection=data ) />
		<cfreturn userBean>
	</cffunction>

	<cffunction name="createUser" access="public" returntype="any" output="false">
		<cfargument name="userID" type="string" required="true">
		<cfset var userBean			= "">
		<cfset var success			= false>

		<cfif not isUserInCache(arguments.userID)>
			<cfset addUser(arguments.userID)>
		</cfif>

		<!--- user is not in the bean Cache --->
		<cfif not isUserInBeanCache(arguments.userID)>
			<cfset userBean = getUserService().getUser( arguments.userID )>
			
			<cfif not userBean.beanExists()>
				<cfset success = getUserService().importUser( argumentCollection=arguments )>

				<cfif not success>
					<cfset userBean = createNullUser(arguments.userID)>
					<cfreturn userBean>
				</cfif>
				<cfset userBean = getUserService().getUser( arguments.userID )>
			</cfif>
	
			<cfset getCacheFactory().set( arguments.userID,userBean.getMemento() )>
		</cfif>

		<cfreturn userBean>
	</cffunction>

	<cffunction name="getuserCache" access="public" returntype="struct" output="false">

		<cfreturn variables.instance.userCache>
	</cffunction>

	<cffunction name="getUser" access="public" returntype="any" output="false">
		<cfargument name="userID" type="string" required="true">
		<cfargument name="doFullUser" type="boolean" required="false" default="false">
		<cfset var userBean = "">

		<cfif not len(arguments.userID)>
			<cfset arguments.userID = variables.instance.nullUser>
		</cfif>

		<cfif not isUserInCache(arguments.userID)>
			<cfset addUser(arguments.userID)>
		</cfif>

		<cfif not isUserInBeanCache(arguments.userID) and not arguments.doFullUser>
			<cfset userBean = createUser(arguments.userID)>
			<cfreturn userBean>
		</cfif>
		
		<cfif arguments.doFullUser>
			<cfset userBean = getUserService().getFullUser( arguments.userID ) />
		<cfelse>
			<!---<cfset userBean = getUserService().createUser( argumentCollection=getCacheFactory().get( arguments.userID ) ) />--->
			<cfset userBean = variables.userHolder.setMemento( getCacheFactory().get( arguments.userID ) ) />
			
			<cfif userBean.getUserID() eq arguments.userID and userID neq "00000000-0000-0000-0000000000000001">
				<cfset userBean.setBeanExists(1) />
			</cfif>
		</cfif>

		<cfreturn userBean>
	</cffunction>

	<cffunction name="getUsers" access="public" returntype="struct" output="false">
		<cfset var uStruct = StructNew()>

		<cfloop collection="#variables.instance.userCache#" item="userID">
			<cfset uStruct[userID] = getUser(userID)>
		</cfloop>

		<cfreturn uStruct>
	</cffunction>

	<cffunction name="isUserInCache" access="public" returntype="boolean" output="false">
		<cfargument name="userID" type="string" required="true">

		<cfif StructKeyExists(variables.instance.userCache,arguments.userID)>
			<cfif isUserStale( arguments.userID )>
				<cfset purgeUser( arguments.userID )>
				<cfreturn false>
			<cfelse>
				<!--- touch the time for the request --->
				<cfset variables.instance.userCache[arguments.userID] = getTickCount()>
				<cfreturn true>
			</cfif>
			<cfreturn true>
		</cfif>
		<cfreturn false>
	</cffunction>

	<cffunction name="isUserInBeanCache" access="public" returntype="boolean" output="false">
		<cfargument name="userID" type="string" required="true">

		<cfif isUserInCache(arguments.userID) AND getCacheFactory().has(arguments.userID)>
			<cfreturn true>
		</cfif>
		<cfreturn false>
	</cffunction>

	<cffunction name="addUser" access="public" returntype="void" output="false">
		<cfargument name="userID" type="string" required="true">

		<cfif StructCount(variables.instance.userCache) gt getuserCacheSize()>
			<cfset cleanuserCache()>
		</cfif>

		<cfset variables.instance.userCache[arguments.userID] = getTickCount()>
	</cffunction>

	<cffunction name="getOrderedCache" access="public" returntype="any" output="false">
		<cfset var aKeys = StructSort(variables.instance.userCache,"numeric")>
		<cfset var aData = ArrayNew(1)>
		<cfset var sItem = StructNew()>
		<cfset var iiX = "">

		<cfloop from="1" to="#ArrayLen(aKeys)#" index="iiX">
			<cfset sItem = StructNew()>
			<cfset sItem.id = aKeys[iiX]>
			<cfset sItem.age = int((currentTickCount-variables.instance.userCache[aKeys[iiX]])/1000)>
			<cfset ArrayAppend(aData,sItem)>
		</cfloop>

		<cfreturn aData>
	</cffunction>

	<cffunction name="markDirty" access="public" returntype="void" output="false">
		<cfargument name="userID" type="string" required="true">
		<cfif StructKeyExists(variables.instance.userCache,userID)>
			<cfset variables.instance.userCache[arguments.userID] = 0>
		</cfif>
	</cffunction>

	<cffunction name="isUserStale" access="public" returntype="boolean" output="false">
		<cfargument name="userID" type="string" required="true">

		<cfif not StructKeyExists(variables.instance.userCache,userID)>
			<cfreturn true>		
		<cfelseif  getTickCount()-variables.instance.userCache[userID] gt getCacheTimeLength()>
			<cfreturn true>
		</cfif>

		<cfreturn false>
	</cffunction>

	<cffunction name="setCacheTimeLength" access="public" returntype="void" output="false">
		<cfargument name="CacheTimeLength" type="numeric">
		<cfset variables.instance.CacheTimeLength = arguments.CacheTimeLength>
	</cffunction>
	<cffunction name="getCacheTimeLength" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.CacheTimeLength*60000>
	</cffunction>

	<cffunction name="setuserCacheSize" access="public" returntype="void" output="false">
		<cfargument name="userCacheSize" type="numeric">
		<cfset variables.instance.userCacheSize = arguments.userCacheSize>
	</cffunction>
	<cffunction name="getuserCacheSize" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.userCacheSize>
	</cffunction>

	<cffunction name="setActivityTimeLength" access="public" returntype="void" output="false">
		<cfargument name="ActivityTimeLength" type="numeric">
		<cfset variables.instance.ActivityTimeLength = arguments.ActivityTimeLength>
	</cffunction>
	<cffunction name="getActivityTimeLength" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.ActivityTimeLength*60000>
	</cffunction>

	<cffunction name="setActivityTimeLimit" access="public" returntype="void" output="false">
		<cfargument name="ActivityTimeLimit" type="numeric">
		<cfset variables.instance.ActivityTimeLimit = arguments.ActivityTimeLimit>
	</cffunction>
	<cffunction name="getActivityTimeLimit" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.ActivityTimeLimit*60000>
	</cffunction>

	<cffunction name="getCacheFactory" access="public" returntype="any" output="false">
		<cfreturn variables.CacheFactory>
	</cffunction>
	<cffunction name="getUserService" access="public" returntype="any" output="false">
		<cfreturn variables.UserService>
	</cffunction>
</cfcomponent>