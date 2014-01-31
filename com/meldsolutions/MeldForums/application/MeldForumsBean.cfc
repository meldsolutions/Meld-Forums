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
<cfcomponent displayname="MeldForumsBean" hint="MeldForumsBean" output="false" extends="MeldForums.com.meldsolutions.core.MeldBean" >
	<cfset variables.values	= StructNew() />

	<cffunction name="init" access="public" output="false" returntype="MeldForumsBean">
		<cfargument name="BeanFactory" type="any" required="true" />
		<cfargument name="$" type="any" required="true" />
		<cfargument name="ConferenceBean" type="any" required="false" default="" />
		<cfargument name="ForumBean" type="any" required="false" default="" />
		<cfargument name="ThreadBean" type="any" required="false" default="" />
		<cfargument name="Intercept" type="Array" required="false" default="#ArrayNew(1)#" />
		<cfargument name="Ident" type="String" required="false" default="" />
		<cfargument name="Action" type="String" required="false" default="" />
		<cfargument name="displayRoot" type="String" required="false" default="" />

		<cfset var siteID					= $.event().getValue("siteID") />
		<cfset var sArgs					= StructNew() />
		<cfset var settingsBean				= "" />
		<cfset var themeBean				= "" />

		<cfset setConferenceBean( arguments.ConferenceBean ) />
		<cfset setForumBean( arguments.ForumBean ) />
		<cfset setThreadBean( arguments.ThreadBean ) />
		<cfset setIntercept( arguments.Intercept ) />
		<cfset setIdent( arguments.Ident ) />
		<cfset setAction( arguments.Action ) />

		<cfset variables.BeanFactory		= arguments.BeanFactory />
		<cfset variables.$					= arguments.$ />
		<cfset variables.displayRoot		= arguments.displayRoot />
		<cfset variables.event				= arguments.$.event() />
		<cfset variables.siteID				= siteID />
		<cfset variables.pluginConfig		= variables.BeanFactory.getBean("MeldForumsManager").getPluginConfig() />
		<cfset variables.requestManager		= variables.BeanFactory.getBean("MeldForumsRequestManager") />
		<cfset variables.mmRBF				= variables.BeanFactory.getBean("mmResourceBundle") />

		<cfset variables.SettingsManager	= variables.BeanFactory.getBean("MeldForumsSettingsManager") />
		<cfset variables.themeService		= variables.BeanFactory.getBean("ThemeService") />
		<cfset variables.mmUtility			= variables.BeanFactory.getBean("mmUtility") />

		<cfset sArgs.siteID					= siteID />
		<cfset settingsBean					= variables.SettingsManager.getSiteSettings( argumentCollection=sArgs ) />

		<cfset setValue("mmRBF",mmRBF ) />
		<cfset setValue("settingsBean",settingsBean ) />

		<cfreturn this/>
	</cffunction>

	<cffunction name="getUser" access="public" output="false" returntype="any" description="retrieves a forum user (userData)">
		<cfargument name="userID" type="string" required="true" />

		<cfreturn getUserCache().getUser( argumentCollection=arguments ) />
	</cffunction>

	<cffunction name="getSettings" access="public" output="false" returntype="any">
		<cfreturn getValue("settingsBean") />
	</cffunction>

	<cffunction name="getTheme" access="public" output="false" returntype="any">
		<cfreturn getSettings().getThemeBean() />
	</cffunction>

	<cffunction name="getUserCache" access="public" output="false" returntype="any">
		<cfreturn getSettings().getUserCache() />
	</cffunction>

	<!--- ---------------------------------------------------------------------- --->

<!--- urls --->
	<cffunction name="getEditorAction" access="public" returntype="string" output="false">
		<cfargument name="section" type="string" required="true">
		<cfargument name="item" type="string" required="true">
		<cfargument name="useID" type="string" required="true">
		<cfset var rString = getForumWebRoot() & getUrlKey() & "#arguments.section#/#arguments.item#/#arguments.useID#/">
		<cfreturn rString>
	</cffunction>

	<cffunction name="getNewThreadAction" access="public" returntype="string" output="false">
		<cfargument name="forumID" type="string" required="true">
		<cfset var rString = "#getForumWebRoot()#newthread/#arguments.forumID#/" />
		<cfreturn rString>
	</cffunction>

	<cffunction name="getLogOutUrl" access="public" returntype="string" output="false">
		<cfset var rString = "#getForumWebRoot()#?display=logout" />
		<cfreturn rString>
	</cffunction>

	<cffunction name="getLogInUrl" access="public" returntype="string" output="false">
		<cfset var rString = "#getForumWebRoot()##getMuraScope().siteConfig().getLoginURL()#" />
		<cfreturn rString>
	</cffunction>

	<cffunction name="getCurrentUser" access="public" returntype="any" output="false">
		<cfreturn variables.$.currentUser()>
	</cffunction>

	<cffunction name="getMuraScope" access="public" returntype="any" output="false">
		<cfreturn variables.$>
	</cffunction>

	<cffunction name="getLogInOutLink" access="public" returntype="string" output="false">
		<cfif variables.$.currentUser().isLoggedIn()>
			<cfreturn getLogOutButton()>
		<cfelse>
			<cfreturn getLogInButton()>
		</cfif>
	</cffunction>

	<cffunction name="getDoLink" access="public" returntype="string" output="false">
		<cfset var rString = getForumWebRoot() & getUrlKey() & "do/" />
		<cfreturn rString />
	</cffunction>

	<cffunction name="getConferenceLink" access="public" returntype="string" output="false">
		<cfargument name="conferenceBean" type="any" required="true">

		<cfset var rString = getForumWebRoot() & getUrlKey() & "c" & conferenceBean.getIDX() & "-" & conferenceBean.getFriendlyName() />
		<cfreturn rString />
	</cffunction>

	<cffunction name="getForumLink" access="public" returntype="string" output="false">
		<cfargument name="forumBean" type="any" required="true">

		<cfset var rString = getForumWebRoot() & getUrlKey() & "f" & forumBean.getIDX() & "-" & forumBean.getFriendlyName() />
		<cfreturn rString />
	</cffunction>

	<cffunction name="getThreadLink" access="public" returntype="string" output="false">
		<cfargument name="threadBean" type="any" required="true">

		<cfset var rString = getForumWebRoot() & getUrlKey() & "t" & threadBean.getIDX() & "-" & threadBean.getFriendlyName() />
		<cfreturn rString />
	</cffunction>

	<cffunction name="getPostLink" access="public" returntype="string" output="false">
		<cfargument name="threadBean" type="any" required="true">
		<cfargument name="postBean" type="any" required="true">

		<cfset var rString = getForumWebRoot() & getUrlKey() & "t" & threadBean.getIDX() & "-" & threadBean.getFriendlyName() />
		<cfreturn rString />
	</cffunction>

	<cffunction name="getLastPostLink" access="public" returntype="string" output="false">
		<cfargument name="postBean" type="any" required="true">

		<cfset var rString = getForumWebRoot() & getUrlKey() & "t" & postBean.getThreadIDX() & "-" & postBean.getThreadFriendlyName() & "/?pp=#postBean.getPostPosition()###p#postBean.getPostPosition()#" />
		<cfreturn rString />
	</cffunction>

	<cffunction name="getProfileLink" access="public" returntype="string" output="false">
		<cfargument name="user" type="any" required="false" default="">

		<cfset var userID	= "" />

		<cfif isSImpleValue(user) and getUtility().isUUID( arguments.user )>
			<cfset userID = arguments.user />
			<cfset rString = getForumWebRoot() & getUrlKey() & "profile/view/" & userID & "/" />
		<cfelseif not  isSImpleValue(user)>
			<cfset userID = user.getUserID() />
			<cfset rString = getForumWebRoot() & getUrlKey() & "profile/view/" & userID & "/" />
		<cfelse>
			<cfset rString = getForumWebRoot() & getUrlKey() & "profile/view/" />
		</cfif>

		<cfreturn rString />
	</cffunction>

	<cffunction name="getThemeWebRoot" access="public" returntype="string" output="false">
		<cfreturn getPluginWebRoot() & "/themes/" & getTheme().getPackageName() & "/">
	</cffunction>

	<cffunction name="getThemeDirectory" access="public" returntype="string" output="false">
		<cfreturn getThemeRootDirectory() & getTheme().getPackageName()>
	</cffunction>

	<cffunction name="getThemeRootDirectory" access="public" returntype="string" output="false">
		<cfreturn "/" & variables.pluginConfig.getPackage() & "/themes/">
	</cffunction>

	<cffunction name="getForumWebRoot" access="public" returntype="string" output="false">

		<cfif not len(variables.displayRoot)>
			<cfif len( variables.$.event().getValue("currentFileName") )>
				<cfset variables.displayRoot = $.globalConfig().getContext() & $.getURLStem( variables.siteID, variables.$.event().getValue("currentFileName") ) />
			<cfelse>
				<cfset variables.displayRoot = $.globalConfig().getContext() & $.getURLStem( variables.siteID, "/" ) />
			</cfif>
		</cfif>
		<cfreturn variables.displayRoot />
	</cffunction>

	<cffunction name="setForumWebRoot" access="public" returntype="string" output="false">
		<cfargument name="ForumWebRoot" type="string" required="true" />
		<cfset variables.displayRoot = arguments.ForumWebRoot />
	</cffunction>
	
	<cffunction name="getPluginWebRoot" access="public" returntype="string" output="false">
		<cfreturn "#$.globalConfig().getContext()#/plugins/#variables.pluginConfig.getDirectory()#">
	</cffunction>

	<cffunction name="getUrlKey" access="public" returntype="string" output="false">
		<cfreturn getValue("settingsBean").getURLKey() />
	</cffunction>

	<cffunction name="getAvatarImage" access="public" returntype="string" output="false">
		<cfargument name="userBean" type="any" required="true">
		<cfargument name="size" type="string" required="false" default="">
		<cfargument name="doLink" type="boolean" required="false" default="false">
		<cfargument name="height" type="numeric" required="false" default="0">
		<cfargument name="width" type="numeric" required="false" default="0">

		<cfset var strImg		= getAvatarImageURL( argumentCollection=arguments )>
		<cfset var strReturn	= "">

		<cfif arguments.doLink>
			<cfsavecontent variable="strReturn">
				<cfoutput><a class="avatar" href="#getProfileLink(userBean)#"><img src="#strImg#" title="#userBean.getScreenName()#'s #variables.mmRBF.key('avatar')#" <cfif arguments.height> height="#arguments.height#"</cfif> <cfif arguments.width> height="#arguments.width#"</cfif>></a></cfoutput>
			</cfsavecontent>
		<cfelse>
		<cfsavecontent variable="strReturn">
			<cfoutput><img src="#strImg#" title="#userBean.getScreenName()#'s #variables.mmRBF.key('avatar')#" <cfif arguments.height> height="#arguments.height#"</cfif> <cfif arguments.width> height="#arguments.width#"</cfif>></cfoutput>
		</cfsavecontent>
		</cfif>
		

		<cfreturn strReturn />
	</cffunction>

	<cffunction name="getAvatarImageURL" access="public" returntype="string" output="false">
		<cfargument name="userBean" type="any" required="true">
		<cfargument name="size" type="string" required="false" default="">
		<cfargument name="height" type="numeric" required="false" default="0">
		<cfargument name="width" type="numeric" required="false" default="0">

		<cfset var strImg		= "">
		<cfset var sArgs		= StructNEw() />
		
		<cfif not len( userBean.getAvatarID() )>
			<cfset strImg = "#getThemeWebRoot()#/assets/images/anonymous.png" />
			<cfreturn strImg />
		</cfif>

		<cfset sArgs.siteID			= userBean.getSiteID() />
		<cfset sArgs.fileID			= userBean.getAvatarID() />
		<cfset sArgs.fileExt		= userBean.getAvatarFileType() />

		<cfif len(arguments.size)>
			<cfset sArgs.size			= arguments.size />
		</cfif>
		<cfif arguments.height gt 0>
			<cfset sArgs.height			= arguments.height />
		</cfif>
		<cfif arguments.width gt 0>
			<cfset sArgs.width			= arguments.width />
		</cfif>

		<cftry>
			<cfsavecontent variable="strImg">
				<cfoutput>#variables.$.createHREFForImage( argumentCollection=sArgs )#</cfoutput>
			</cfsavecontent>
			<cfcatch>
				<cfreturn "" />
			</cfcatch>
		</cftry>
				
		<cfreturn strImg>
	</cffunction>

<!--- links --->

	<cffunction name="getProfileEditButton" access="public" returntype="string" output="false">
		<cfargument name="userID" type="uuid" required="true">

		<cfset var link = "">

		<!--- isn't group member --->
		<cfif not userHasProfilePermissions(arguments.userID)>
			<cfreturn "">
		</cfif>

		<cfsavecontent variable="link"><cfoutput><a class="submit profile" href="#getForumWebRoot()##getUrlKey()#profile/panel/#arguments.userID#/"><span>#variables.mmRBF.key('editprofile')#</span></a></cfoutput></cfsavecontent>
		<cfreturn link>
	</cffunction>

	<cffunction name="getProfileModerateButton" access="public" returntype="string" output="false">
		<cfargument name="userID" type="string" required="true">
		<cfset var link = "">

		<!--- isn't group member --->
		<cfif not UserHasModeratePermissions()>
			<cfreturn "">
		</cfif>	

		<cfsavecontent variable="link"><cfoutput><a class="submit profile moderate" href="#getForumWebRoot()##getUrlKey()#profile/panel/#arguments.userID#/?panel=moderate"><span>#variables.mmRBF.key('moderate')#</span></a></cfoutput></cfsavecontent>
		<cfreturn link>
	</cffunction>


	<cffunction name="getSubscribeButton" access="public" returntype="string" output="false">
		<cfargument name="id" type="any" required="true">
		<cfargument name="type" type="string" required="true">
		<cfargument name="isSubscribed" type="boolean" required="true">

		<cfset var link = "">
		<cfset var mode = "add">

		<cfif not variables.$.currentUser().isLoggedIn()>
			<cfreturn "" />
		</cfif>

		<cfif arguments.isSubscribed>
			<cfset mode = "remove">
		</cfif>

		<cfsavecontent variable="link"><cfoutput><a class="submit profile" href="#getSubscribeLink(argumentCollection=arguments)#"><span>#variables.mmRBF.key('#mode#subscribe')#</span></a></cfoutput></cfsavecontent>
		<cfreturn link>
	</cffunction>

	<cffunction name="getSubscribeLink" access="public" returntype="string" output="false">
		<cfargument name="id" type="any" required="true">
		<cfargument name="type" type="string" required="true">
		<cfargument name="isSubscribed" type="boolean" required="true">

		<cfset var link = "">
		<cfset var mode = "add">
		
		<!--- isn't group member --->
		<cfif not isLoggedIn()>
			<cfreturn "">
		</cfif>

		<cfif arguments.isSubscribed>
			<cfset mode = "remove">
		</cfif>
		<cfsavecontent variable="link"><cfoutput>#getForumWebRoot()##getUrlKey()#subscribe/#arguments.type#/#mode#/#id#/</cfoutput></cfsavecontent>

		<cfreturn link>
	</cffunction>

	<cffunction name="getNewThreadButton" access="public" returntype="string" output="false">
		<cfargument name="forumBean" type="any" required="true">
		<cfset var link				 = "">

		<!--- isn't group member --->
		<cfif not CanUserCreateThread()>
			<cfreturn "">
		</cfif>
		<cfsavecontent variable="link"><cfoutput><a class="submit newthread" href="#getForumWebRoot()##getUrlKey()#thread/new/#arguments.ForumBean.getforumID()#/"><span>#variables.mmRBF.key('newthread')#</span></a></cfoutput></cfsavecontent>
		<cfreturn link>
	</cffunction>

	<cffunction name="getEditThreadButton" access="public" returntype="string" output="false">
		<cfargument name="threadBean" type="any" required="true">
		<cfset var link			= "">

		<!--- refuse if not editor AND not owner AND (owner AND locked) --->
		<cfif not CanUserEditThread(threadBean,arguments.threadBean.getUserID())>
			<cfreturn "">
		</cfif>

		<cfsavecontent variable="link">
			<cfoutput><a class="submit editthread" href="#getForumWebRoot()##getUrlKey()#thread/edit/#arguments.threadBean.getThreadID()#/"><span>#variables.mmRBF.key('editthread')#</span></a></cfoutput>
		</cfsavecontent>
		<cfreturn link>
	</cffunction>

	<cffunction name="getReplyPostButton" access="public" returntype="string" output="false">
		<cfargument name="postBean" type="any" required="true">
		<cfargument name="threadBean" type="any" required="true">
		<cfargument name="doQuote" type="boolean" required="false" default="false">

		<cfset var link 		= "">
		<cfset var replyString	= "reply" />

		<cfif doQuote>
			<cfset replyString = "quote" />
		</cfif>		

		<cfif not canUserCreatePost(arguments.threadBean)>
			<cfreturn "">
		<cfelseif canUserCreatePost(arguments.threadBean) and isPostLocked(arguments.postBean) and isThreadLocked(arguments.threadBean)>
			<!--- in theory you could return a "disabled" button here --->
			<cfreturn "">
		<cfelse>
			<cfsavecontent variable="link"><cfoutput><a class="submit #replyString#post" href="#getForumWebRoot()##getUrlKey()#post/new/#arguments.threadBean.getThreadID()#/#arguments.postBean.getPostID()#/#doQuote#/"><span>#variables.mmRBF.key('#replyString#post')#</span></a></cfoutput></cfsavecontent>
		</cfif>

		<cfreturn link>
	</cffunction>

	<cffunction name="getNewPostButton" access="public" returntype="string" output="false">
		<cfargument name="threadBean" type="any" required="true">
		<cfset var link = "">

		<cfif not CanUserCreatePost(arguments.threadBean)>
			<cfreturn "">
		<cfelseif CanUserCreatePost(arguments.threadBean) and isThreadLocked(arguments.threadBean)>
			<!--- in theory you could return a "disabled" button here --->
			<cfreturn "">
		<cfelse>
			<cfsavecontent variable="link"><cfoutput><a class="submit newpost" href="#getForumWebRoot()##getUrlKey()#post/new/#arguments.threadBean.getThreadID()#/"><span>#variables.mmRBF.key('newpost')#</span></a></cfoutput></cfsavecontent>
		</cfif>

		<cfreturn link>
	</cffunction>

	<cffunction name="getSearchURL" access="public" returntype="string" output="false">

			<cfreturn "#getForumWebRoot()##getUrlKey()#search/">
	</cffunction>

	<cffunction name="getEditPostButton" access="public" returntype="string" output="false">
		<cfargument name="postBean" type="any" required="true">
		<cfargument name="threadBean" type="any" required="true">
		<cfset var link			= "">

		<cfif not CanUserEditPost(argumentCollection=arguments)>
			<cfreturn "">
		</cfif>

		<cfsavecontent variable="link"><cfoutput><a class="submit editpost" href="#getForumWebRoot()##getUrlKey()#post/edit/#arguments.postBean.getPostID()#/"><span>#variables.mmRBF.key('editpost')#</span></a></cfoutput></cfsavecontent>
		<cfreturn link>
	</cffunction>

	<cffunction name="getLogOutButton" access="public" returntype="string" output="false">
		<cfset var link = "">
		<cfsavecontent variable="link"><cfoutput><a class="submit logout" href="#getLogOutUrl()#"><span>#variables.mmRBF.key('logout')#</span></a></cfoutput></cfsavecontent>
		<cfreturn link>
	</cffunction>

	<cffunction name="getLogInButton" access="public" returntype="string" output="false">
		<cfset var link = "">
		<cfsavecontent variable="link"><cfoutput><a class="submit login" href="#getLogInUrl()#"><span>#variables.mmRBF.key('login')#</span></a></cfoutput></cfsavecontent>
		<cfreturn link>
	</cffunction>

	<cffunction name="getThreadViewIcon" access="public" returntype="string" output="false">
		<cfargument name="threadBean" type="any" required="true" />
		<cfargument name="iconType" type="numeric" required="false" default="0" />

		<cfset var icon = "">
		<cfset var type = 0 />
		<cfset var newFrom = getLastDateIsNewFrom( $.currentUser().getUserID() ) />
		<cfset var dateComp = dateCompare( newFrom,arguments.threadBean.getDateLastPost() ) />

		<cfif not getThreadViewed( arguments.threadBean ) and dateComp lte 0>
			<cfset arguments.iconType = arguments.iconType & "_new" />
		</cfif>

		<cfsavecontent variable="icon"><cfoutput><div class="mf-icon type#arguments.iconType#" title="#variables.mmRBF.key('threadtype#arguments.iconType#')#">&nbsp;</div></cfoutput></cfsavecontent>

		<cfreturn icon>
	</cffunction>

	<cffunction name="setThreadViewed" access="public" returntype="string" output="false">
		<cfargument name="threadBean" type="any" required="true" />

		<cfset setViewedSession() />
		
		<cfset listAppend(session.meld.meldforums.threadsviewed,arguments.threadBean.getIDX()) />
		<cfif StructKeyExists(cookie,"meldforums_threadsviewed")
			and not ListFind( cookie['meldforums_threadsviewed'],threadBean.getIDX() )>
			<cfset cookie['meldforums_threadsviewed'] = listAppend(cookie['meldforums_threadsviewed'],arguments.threadBean.getIDX()) />
		</cfif>
	</cffunction>

	<cffunction name="getThreadViewed" access="public" returntype="string" output="false">
		<cfargument name="threadBean" type="any" required="true" />

		<cfset var isViewed = false /> 

		<cfset setViewedSession() />

		<cfset isViewed = ListFind( session.meld.meldforums['threadsviewed'],threadBean.getIDX() )> 
				
		<cfif not isViewed and StructKeyExists(cookie,"meldforums_threadsviewed")>
			<cfset isViewed = ListFind( cookie['meldforums_threadsviewed'],threadBean.getIDX() )>
		</cfif>
		
		<cfreturn isViewed />
	</cffunction>

	<cffunction name="setViewedSession" access="public" returntype="void" output="false">

		<cfcookie name="meldforums_datelastacttion" expires="never" value="#now()#" />

		<cfif not isDefined("session.meld.meldforums.threadsviewed")>
			<cflock scope="session" timeout="10">
				<cfif not StructKeyExists(session,"meld")>
					<cfset session.meld = StructNew() />
				</cfif>
				<cfif not StructKeyExists(session.meld,"meldforums")>
					<cfset session.meld.meldforums = StructNew() />
				</cfif>
				<cfif not StructKeyExists(session.meld,"threadsviewed") or true>
					<cfset session.meld.meldforums.threadsviewed = "" />
				</cfif>
			</cflock>
		</cfif>
		
		<cfif not StructKeyExists(cookie,"meldforums_datenewfrom")>
			<cfif StructKeyExists(cookie,"meldforums_datelastacttion")>
				<cfcookie name="meldforums_datenewfrom" expires="never" value="#cookie.meldforums_datelastacttion#" />
			<cfelse>
				<cfcookie name="meldforums_datenewfrom" expires="never" value="#now()#" />
			</cfif>
		</cfif>
		<cfif not StructKeyExists(cookie,"meldforums_threadsviewed")>
			<cfcookie name="meldforums_threadsviewed" expires="never" value="1" />
		</cfif>
	</cffunction>

	<cffunction name="getLastDateIsNewFrom" access="public" output="false" returntype="date">
		<cfargument name="userID" type="string" required="true" />

		<cfif structKeyExists(session,"meld")
				and structKeyExists(session.meld,"meldforums")
				and structKeyExists(session.meld.meldforums,"datenewfrom")>
			<cfreturn session.meld.meldforums['datenewfrom'] />
		<cfelseif structKeyExists(cookie,"meldforums_datenewfrom")>
			<cfreturn cookie['meldforums_datenewfrom'] />
		<cfelse>
			<cfreturn now() />
		</cfif>
	</cffunction>

	<cffunction name="setIntercept" access="public" returntype="void" output="false">
		<cfargument name="Intercept" type="array" required="true" />
		<cfset variables.instance['intercept'] = arguments.Intercept />
	</cffunction>
	<cffunction name="getIntercept" access="public" returntype="array" output="false">
		<cfreturn variables.instance.Intercept />
	</cffunction>

	<cffunction name="setIdent" access="public" returntype="void" output="false">
		<cfargument name="Ident" type="string" required="true" />
		<cfset variables.instance['ident'] = arguments.Ident />
	</cffunction>
	<cffunction name="getIdent" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Ident />
	</cffunction>

	<cffunction name="setAction" access="public" returntype="void" output="false">
		<cfargument name="Action" type="string" required="true" />
		<cfset variables.instance['action'] = arguments.Action />
	</cffunction>
	<cffunction name="getAction" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Action />
	</cffunction>

	<cffunction name="setConferenceBean" access="public" returntype="void" output="false">
		<cfargument name="ConferenceBean" type="any" required="true" />
		<cfset variables.instance['conferencebean'] = arguments.ConferenceBean />
	</cffunction>
	<cffunction name="getConferenceBean" access="public" returntype="any" output="false">
		<cfreturn variables.instance.ConferenceBean />
	</cffunction>

	<cffunction name="setForumBean" access="public" returntype="void" output="false">
		<cfargument name="ForumBean" type="any" required="true" />
		<cfset variables.instance['forumbean'] = arguments.ForumBean />
	</cffunction>
	<cffunction name="getForumBean" access="public" returntype="any" output="false">
		<cfreturn variables.instance.ForumBean />
	</cffunction>

	<cffunction name="setThreadBean" access="public" returntype="void" output="false">
		<cfargument name="ThreadBean" type="any" required="true" />
		<cfset variables.instance['threadbean'] = arguments.ThreadBean />
	</cffunction>
	<cffunction name="getThreadBean" access="public" returntype="any" output="false">
		<cfreturn variables.instance.ThreadBean />
	</cffunction>

<!--- permission/evaluation --->
	<cffunction name="isLoggedIn" access="public" returntype="boolean" output="false">
		<cfreturn variables.$.currentUser().isLoggedIn()>	
	</cffunction>

	<cffunction name="userIsOwner" access="public" returntype="boolean" output="false">
		<cfargument name="userID" type="string" required="true">
		<cfreturn (variables.$.currentUser().getUserID() eq arguments.userID)>	
	</cffunction>

	<cffunction name="isThreadLocked" access="public" returntype="boolean" output="false">
		<cfargument name="threadBean" type="any" required="true">

		<cfif threadBean.getIsClosed() or threadBean.getIsDisabled() or not threadBean.getIsActive() or threadBean.getIsAnnouncement()>
			<cfreturn true>
		</cfif>
		<cfreturn false>
	</cffunction>

	<cffunction name="isPostLocked" access="public" returntype="boolean" output="false">
		<cfargument name="postBean" type="any" required="true">

		<cfif postBean.getIsDisabled() or not postBean.getIsActive()>
			<cfreturn true>
		</cfif>
		<cfreturn false>
	</cffunction>

	<cffunction name="showInlineImages" access="public" returntype="boolean" output="false">
		<cfset var configurationBean = getConfigurationBean()>

		<!--- false if user is not moderator, not owner or owner and thread is closed  --->
		<cfif configurationBean.getdoInlineImageAttachments()>
			<cfreturn true>
		</cfif>
		<cfreturn false>
	</cffunction>

	<cffunction name="canUserCreateThread" access="public" returntype="boolean" output="false">
		<cfset var configurationBean = getConfigurationBean()>

		<!--- false if user is not moderator, not owner or owner and thread is closed  --->
		<cfif UserHasModeratePermissions()>
			<cfreturn true>
		<cfelseif UserHasContributePermissions() and not configurationBean.getDoClosed()>	
			<cfreturn true>
		</cfif>
		<cfreturn false>
	</cffunction>

	<cffunction name="canUserEditThread" access="public" returntype="boolean" output="false">
		<cfargument name="threadBean" type="any" required="true">

		<cfif UserHasModeratePermissions()>
			<cfreturn true>
		<cfelseif UserHasContributePermissions() AND UserIsOwner(arguments.threadBean.getUserID()) AND not isThreadLocked(arguments.threadBean)>
			<cfreturn true>
		</cfif>

		<cfreturn false>
	</cffunction>

	<cffunction name="canUserCreatePost" access="public" returntype="boolean" output="false">
		<cfargument name="threadBean" type="any" required="true">

		<!--- false if user is not moderator, not owner or owner and post/thread is closed  --->
		<cfif UserHasModeratePermissions()>
			<cfreturn true>
		<cfelseif UserHasContributePermissions() AND not isThreadLocked(arguments.threadBean)>
			<cfreturn true>
		</cfif>

		<cfreturn false>
	</cffunction>

	<cffunction name="canUserEditPost" access="public" returntype="boolean" output="false">
		<cfargument name="postBean" type="any" required="true">
		<cfargument name="threadBean" type="any" required="true">

		<cfif UserHasModeratePermissions()>
			<cfreturn true>
		<cfelseif UserHasContributePermissions()
			AND UserIsOwner(arguments.postBean.getUserID())
			AND not isPostLocked(arguments.postBean)
			AND not isThreadLocked(arguments.threadBean)>
			<cfreturn true>
		</cfif>

		<cfreturn false>
	</cffunction>
	
	<cffunction name="strip" access="public" returntype="string" output="false">
		<cfargument name="value" type="string" required="true">
		<cfargument name="stripHTML" type="boolean" required="false" default="true">
		<cfargument name="stripBBML" type="boolean" required="false" default="true">

		<cfset var sReturn = arguments.value>

		<cfif arguments.stripHTML>
			<cfset sReturn = rereplace(trim(sReturn),"<.[^<>]*>","","all")>
		</cfif>
		<cfif arguments.stripBBML>
			<cfset sReturn = rereplace(trim(sReturn),"\[.[^\[\]]*\]","","all")>
		</cfif>

		<cfreturn sReturn>
	</cffunction>

	<cffunction name="userHasProfilePermissions" access="public" returntype="boolean" output="false">
		<cfargument name="userID" type="uuid" required="true">

		<cfif isDefined("variables.instance.HasProfilePermissions")>
			<cfreturn variables.instance.HasProfilePermissions>
		</cfif>

		<cfif variables.$.currentUser().isSuperUser()>
			<cfset variables.instance.HasProfilePermissions = true>
			<cfreturn true>
		<cfelseif isDefined("variables.instance.HasFullPermissions")>
			<cfreturn variables.instance.HasFullPermissions>
		<cfelseif getRequestManager().getHasFullPermissions(variables.$,variables.siteID)>
			<cfset variables.instance.HasProfilePermissions = true>
			<cfreturn true>
		<cfelseif variables.$.currentUser().isLoggedIn() and variables.$.currentUser().getUserID() eq arguments.userID>
			<cfreturn true>
		</cfif>

		<cfreturn false>
	</cffunction>

		
	<cffunction name="userHasReadPermissions" returntype="boolean" access="public" output="false">
		<cfset var hasPerm			 = false>
		<cfset var configurationBean = getConfigurationBean()>

		<cfif variables.$.currentUser().isSuperUser()>
			<cfset variables.instance.hasReadPermissions = true>
			<cfreturn true>
		<cfelseif isDefined("variables.instance.hasReadPermissions")>
			<cfreturn variables.instance.hasReadPermissions>
		<cfelseif getRequestManager().getHasFullPermissions(variables.$,variables.siteID)>
			<cfset variables.instance.hasModeratePermissions = true>
			<cfreturn true>
		</cfif>
		
		<cfif isSimpleValue( configurationBean )>
			<cfset variables.instance.hasReadPermissions = false>
			<cfreturn variables.instance.hasReadPermissions>
		</cfif>

		<cfset variables.instance.hasReadPermissions = getHasPermissions( configurationBean.getConfigurationID(),"read" )>

		<cfreturn variables.instance.hasReadPermissions>
	</cffunction>
		
	<cffunction name="userHasContributePermissions" returntype="boolean" access="public" output="false">
		<cfset var hasPerm			 = false>
		<cfset var configurationBean = getConfigurationBean()>

		<cfif variables.$.currentUser().isSuperUser()>
			<cfset variables.instance.hasContributePermissions = true>
			<cfreturn true>
		<cfelseif isDefined("variables.instance.hasContributePermissions")>
			<cfreturn variables.instance.hasContributePermissions>
		<cfelseif getRequestManager().getHasFullPermissions(variables.$,variables.siteID)>
			<cfset variables.instance.hasModeratePermissions = true>
			<cfreturn true>
		</cfif>
		
		<cfif isSimpleValue( configurationBean )>
			<cfset variables.instance.hasContributePermissions = false>
			<cfreturn false>
		</cfif>

		<cfset variables.instance.hasContributePermissions	= getHasPermissions( configurationBean.getConfigurationID(),"post" )>
		<cfreturn variables.instance.hasContributePermissions>
	</cffunction>

	<cffunction name="userHasModeratePermissions" returntype="boolean" access="public" output="false">
		<cfset var hasPerm			 = false>
		<cfset var configurationBean = getConfigurationBean()>

		<cfif isDefined("variables.instance.HasModeratePermissions")>
			<cfreturn variables.instance.HasModeratePermissions>
		</cfif>

		<cfif variables.$.currentUser().isSuperUser()>
			<cfset variables.instance.hasModeratePermissions = true>
			<cfreturn true>
		<cfelseif getRequestManager().getHasFullPermissions(variables.$,variables.siteID)>
			<cfset variables.instance.hasModeratePermissions = true>
			<cfreturn true>
		<cfelseif isSimpleValue( configurationBean ) or not variables.$.currentUser().isLoggedIn()>
			<cfset variables.instance.hasModeratePermissions = false>
			<cfreturn false>
		</cfif>

		<cfset variables.instance.hasModeratePermissions = getHasPermissions( configurationBean.getConfigurationID(),"edit" )>
		<cfreturn variables.instance.hasModeratePermissions>
	</cffunction>

	<cffunction name="userHasFullPermissions" returntype="boolean" access="public" output="false">
		<cfset var hasPerm			 = false>

		<cfif isDefined("variables.instance.HasFullPermissions")>
			<cfreturn variables.instance.HasFullPermissions>
		</cfif>
		
		<cfif not variables.$.currentUser().isLoggedIn()>
			<cfset variables.instance.HasFullPermissions = false>
		<cfelseif variables.$.currentUser().isSuperUser()>
			<cfset variables.instance.HasFullPermissions = true>
		<cfelseif getRequestManager().getHasFullPermissions(variables.$,variables.siteID)>
			<cfset variables.instance.HasFullPermissions = true>
		<cfelse>
			<cfset variables.instance.HasFullPermissions = false>
		</cfif>

		<cfreturn variables.instance.HasFullPermissions>
	</cffunction>

	<cffunction name="getHasPermissions" returntype="boolean" access="public" output="false">
		<cfargument name="configurationID" type="uuid" required="false" />
		<cfargument name="permType" type="string" required="false" default="read" />

		<cfset var sArgs	= StructNew() />
		<cfset sArgs.$					= variables.$ />

		<cfif StructKeyExists( arguments,"configurationID" ) and len( arguments.configurationID )>
			<cfset sArgs.configurationID	= arguments.configurationID />
		<cfelse>
			<cfset sArgs.configurationID	= getConfigurationBean().getConfigurationID() />
		</cfif>		
		<cfset sArgs.permType			= arguments.permType />
		
		<cfreturn getRequestManager().getHasPermissions( argumentCollection=sArgs )>
	</cffunction>

	<cffunction name="initConfiguration" access="public" returntype="any" output="false">
		<cfargument name="ConfigurationBean" type="any" required="true">

		<cfif hasConfiguration()>
			<cfreturn variables.ConfigurationBean>
		</cfif>

		<cfset variables.ConfigurationBean = arguments.ConfigurationBean>

	</cffunction>
	<cffunction name="hasConfiguration" access="public" returntype="any" output="false">
		<cfif structKeyExists( variables,"ConfigurationBean" )>
			<cfreturn true>
		</cfif>
		<cfreturn false>
	</cffunction>

	<cffunction name="getConfigurationBean" access="public" returntype="any" output="false">
		
		<cfif not hasConfiguration()>
			<cfset initConfiguration( variables.BeanFactory.getBean("MeldForumsConfigurationManager").initConfiguration(variables.$) ) />
		</cfif>
		
		<cfreturn variables.ConfigurationBean>
	</cffunction>

	<cffunction name="getRequestManager" access="public" output="false" returntype="any">
		<cfreturn variables.RequestManager />
	</cffunction>

	<cffunction name="getVariables" access="public" output="false" returntype="struct">
		<cfreturn variables />
	</cffunction>

	<cffunction name="getUtility" access="public" output="false" returntype="struct">
		<cfreturn variables.mmUtility />
	</cffunction>

	<cffunction name="getBeanFactory" access="public" returntype="any" output="false">
		<cfreturn variables.BeanFactory>
	</cffunction>

	<cffunction name="getResourceBundle" access="public" returntype="any" output="false">
		<cfreturn variables.mmRBF>
	</cffunction>
</cfcomponent>
