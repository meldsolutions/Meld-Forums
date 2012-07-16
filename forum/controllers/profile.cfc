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
<cfcomponent extends="controller">

	<cffunction name="before" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">
		
		<cfset super.before( argumentCollection=arguments ) />
	</cffunction>

	<cffunction name="default" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">
	
		<cfparam name="url.panel" default="overview" />

		<cfset rc.panel = url.panel />

		<cfset doGetUser( argumentCollection=arguments ) />
	</cffunction>

	<cffunction name="view" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">
	
		<cfparam name="url.panel" default="overview" />

		<cfset rc.panel = url.panel />

		<cfset doGetUser( argumentCollection=arguments ) />
	</cffunction>

	<cffunction name="panel" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">
	
		<cfparam name="url.panel" default="overview" />

		<cfset rc.panel = url.panel />

		<cfif len(url.panel) AND not fileExists(expandPath('/MeldForums/') & "forum/views/profile/panels/#url.panel#.cfm" )>
			<cflocation url="./?ecode=1019" addtoken="false" >
		</cfif>
		
		<cfif StructKeyExists(rc,"btaction")>
			<cfset doGetUser( argumentCollection=arguments ) />
			<cfset doUpdateUser( argumentCollection=arguments ) />
		</cfif>
		
		<cfset doGetUser( argumentCollection=arguments ) />
		<cfset doGetPanel( argumentCollection=arguments ) />
	</cffunction>

	<cffunction name="custom" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">
	
		<cfset doGetUser( argumentCollection=arguments ) />
		<cfset doGetPanel( argumentCollection=arguments ) />
	</cffunction>

	<cffunction name="doGetUser" access="private" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset var settingsManager	= getBeanFactory().getBean("MeldForumsSettingsManager") />
		<cfset var aIntercept		= rc.MFBean.getIntercept() />
		<cfset var userBean			= "" />
		
		<cfif ArrayLen(aIntercept) gte 3 and rc.mmUtility.isUUID( aIntercept[3] )>
			<cfset userBean = rc.MFBean.getUserCache().getUser(aIntercept[3]) />
		<cfelse>
			<cfset userBean = rc.MFBean.getUserCache().getUser("00000000-0000-0000-0000000000000001") />
		</cfif>
		
		<cfset rc.userBean	= userBean />
		<cfset rc.view		= aIntercept[2] />
		<cfset rc.userID	= aIntercept[3] />
	</cffunction>	

	<cffunction name="doGetPanel" access="private" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">
	</cffunction>	

	<cffunction name="doUpdateUser"  access="private" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset var meldEvent		= "" />

		<cfif not rc.MFBean.userHasProfilePermissions(rc.userID) and not rc.MFBean.userHasModeratePermissions(rc.userID)>
			<cflocation url="./?ecode=2020" addtoken="false" >
		</cfif>

		<cfset meldEvent		= rc.mmEvents.createEvent( rc.$ ) />

		<cfset meldEvent.setValue('form',form ) />
		<cfset meldEvent.setValue('panel',url.panel ) />
		<cfset meldEvent.setValue('userID',rc.userID ) />
		<cfset meldEvent.setValue('updateComplete',false ) />

		<cfset rc.mmEvents.announceEvent( rc.$,"onMeldForumsProfileUpdate",meldEvent ) />

		<cfif meldEvent.getValue('updateComplete') eq true>
			<cfreturn />
		</cfif>

		<cfswitch expression="#url.panel#">
			<cfcase value="avatar">
				<cfset doUpdateAvatar( argumentCollection=arguments ) />
			</cfcase> 	
			<cfcase value="moderate">
				<cfset doUpdateModerate( argumentCollection=arguments ) />
			</cfcase> 	
			<cfcase value="privacy">
				<cfset doUpdatePrivacy( argumentCollection=arguments ) />
			</cfcase> 	
			<cfcase value="settings">
				<cfset doUpdateSettings( argumentCollection=arguments ) />
			</cfcase> 	
		</cfswitch>		
	</cffunction>

	<cffunction name="doUpdateSettings"  access="private" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">
		
		<cfset var muraUserManager	= $.getBean('userManager') />
		<cfset var muraUserUtility	= $.getBean('userUtility') />
		<cfset var muraUserBean		= "" />
		<cfset var userBean			= rc.userBean />

		<cfif not len(form.fName)>
			<cfset getErrorManager().addError('#rc.mmRBF.key('user.fname','mura')# #rc.mmRBF.key('isrequired')#')>
		</cfif>
		<cfif not len(form.lname)>
			<cfset getErrorManager().addError('#rc.mmRBF.key('user.lname','mura')# #rc.mmRBF.key('isrequired')#')>
		</cfif>
		<cfif not len(form.email)>
			<cfset getErrorManager().addError('#rc.mmRBF.key('user.email','mura')# #rc.mmRBF.key('isrequired')#')>
		</cfif>

		<cfif getErrorManager().hasErrors()>
			<cfreturn />
		</cfif>

		<cfset muraUserBean = userBean.getExternalUserBean() />
		
		<cfif muraUserBean.getIsNew()>
			<cfreturn />
		</cfif>

		<cfset muraUserBean.setFName( form.fName ) />
		<cfset muraUserBean.setLName( form.lName ) />
		<cfset muraUserBean.setEmail( form.email ) />
		<cfset muraUserBean.setCompany( form.company ) />
		<cfset muraUserBean.setJobTitle( form.jobtitle ) />
		<cfset muraUserBean.setWebsite( form.Website ) />
		<cfset muraUserBean.setInterests( form.Interests ) />
		<cfset muraUserBean.save() />
		<cfset muraUserUtility.loginByUserID( rc.UserID,rc.siteID ) />
	</cffunction>

	<cffunction name="doUpdatePrivacy"  access="private" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">
		
		<cfset var userBean			= rc.userBean />

		<cfparam name="form.isPrivate"				default = "0" />
		<cfparam name="form.doReplyNotifications"	default = "0" />
		<cfparam name="form.doShowOnline"			default = "0" />

		<cfset userBean.setisPrivate(form.isPrivate) />
		<cfset userBean.setdoReplyNotifications(form.doReplyNotifications) />
		<cfset userBean.setdoShowOnline(form.doShowOnline) />
		<cfset userBean.save() />
		<cfset rc.MFBean.getUserCache().purgeUser(rc.userBean.getUserID()) />
	</cffunction>

	<cffunction name="doUpdateAvatar"  access="private" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">
		
		<cfset var mmFileUpload		= getBeanFactory().getBean("mmFileUpload") />
		<cfset var mmImageRenderer	= getBeanFactory().getBean("mmImageRenderer") />
		<cfset var fileUploadBean	= "" />
		<cfset var imageRenderBean	= "" />
		<cfset var userBean			= rc.userBean />
		<cfset var sArgs			= StructNew() /> 
		<cfset var settingsBean		= rc.MFBean.getSettings() />
		<cfset var themeBean		= rc.MFBean.getTheme() />
		<cfset var imageID			= createUUID() />

		<cfif len(form.avatarFile)>
			<!--- FILE --->
			<cfset sArgs.imageID			= imageID />
			<cfset sArgs.contentID			= userBean.getUserID() />
			<cfset sArgs.siteID				= rc.siteID />
			<cfset sArgs.moduleID			= rc.pluginConfig.getModuleID() />
			<cfset sArgs.FileSizeLimit		= settingsBean.getFileSizeLimit() />
			<cfset sArgs.doClearPrevious	= true />
			<cfset fileUploadBean			= mmFileUpload.createFileUploadBean( argumentCollection=sArgs ) />
	
			<!--- IMAGES --->
			<cfset sArgs					= StructNew() /> 
			<cfset sArgs.width				= 600 />
			<cfset sArgs.height				= 450 />
			<cfset sArgs.resizeType			= settingsBean.getAvatarResizeType() />
			<cfset sArgs.aspectType			= settingsBean.getAvatarAspectType() />
			<cfset sArgs.cropType			= settingsBean.getAvatarCropType() />
			<cfset sArgs.qualityType		= settingsBean.getAvatarQualityType() />
			<cfset imageRenderBean			= mmImageRenderer.createImageRenderBean( argumentCollection=sArgs ) />
	
			<cfset sArgs = StructNew() />
			<cfset sArgs.FormField				= "avatarFile" />
			<cfset sArgs.FileUploadBean			= fileUploadBean />
			<cfset sArgs.LargeImageRenderBean	= imageRenderBean />
	
			<cftry>
				<cfset fileID = mmFileUpload.uploadImage( argumentCollection=sArgs ) />
				<cfcatch>
					<cfset getErrorManager().addError('#cfcatch.message#')>
					<cfreturn />			
				</cfcatch>
			</cftry>

			<cfset userBean.setAvatarID( fileID ) />
			<cfset userBean.setAvatarFileType( fileUploadBean.getFileData().serverFileExt ) />
			<cfset userBean.save() />
			<cfset rc.MFBean.getUserCache().purgeUser(rc.userBean.getUserID()) />
		<cfelseif StructKeyExists(form,"doDeleteAvatar") and len( userBean.getAvatarID() )>
			<cfset mmFileUpload.deleteFileByFileID( userBean.getAvatarID() ) />
			<cfset userBean.setAvatarID('') />
			<cfset userBean.setAvatarFileType('') />
			<cfset userBean.save() />
			<cfset rc.MFBean.getUserCache().purgeUser(rc.userBean.getUserID()) />
		</cfif>
	</cffunction>

	<cffunction name="doUpdateModerate" access="private" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset var settingsManager	= getBeanFactory().getBean("MeldForumsSettingsManager") />
		<cfset var postService		= getBeanFactory().getBean("postService") />
		<cfset var threadService	= getBeanFactory().getBean("threadService") />
		<cfset var mmFileUpload		= getBeanFactory().getBean("mmFileUpload") />
		<cfset var aIntercept		= rc.MFBean.getIntercept() />
		<cfset var userBean			= rc.userBean />

		<cfif not userBean.beanExists()>
			<cfreturn />
		</cfif>
		
		<cfparam name="form.isConfirmed"	default="0" />
		<cfparam name="form.isBlocked"		default="0" />
		<cfparam name="form.isConfirmed"	default="0" />
		
		<cfif not len(form.screenname)>
			<cfset getErrorManager().addError('#rc.mmRBF.key('screenname')# #rc.mmRBF.key('isrequired')#')>
			<cfreturn />
		</cfif>		

		<cfset userBean.setScreenName( form.screenname ) />
		<cfset userBean.setIsConfirmed( form.isConfirmed ) />
		<cfset userBean.setIsBlocked( form.isBlocked ) />
		<cfif StructKeyExists(form,"doAddAdminMessage")>
			<cfset userBean.setAdminMessage( form.AdminMessage ) />
		<cfelse>
			<cfset userBean.setAdminMessage( "" ) />
		</cfif>

		<cfif StructKeyExists(form,"doDeleteAvatar") and len( userBean.getAvatarID() )>
			<cfset mmFileUpload.deleteFileByFileID( userBean.getAvatarID() ) />
			<cfset userBean.setAvatarID('') />
			<cfset userBean.setAvatarFileType('') />
		</cfif>

		<cfif StructKeyExists(form,"doUnBlockAll")>
			<cfset postService.unblockByUserID( userBean.getUserID(),2 ) />
			<cfset threadService.unblockByUserID( userBean.getUserID(),2 ) />
		<cfelseif StructKeyExists(form,"doBlockAll")>
			<cfset postService.blockByUserID( userBean.getUserID(),2 ) />
			<cfset threadService.blockByUserID( userBean.getUserID(),2 ) />
		</cfif>

		<cfset userBean.save() />
		<cfset rc.MFBean.getUserCache().purgeUser(rc.userBean.getUserID()) />
	</cffunction>

</cfcomponent>