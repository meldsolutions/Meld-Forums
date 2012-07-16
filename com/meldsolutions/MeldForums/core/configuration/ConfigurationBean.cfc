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
<cfcomponent displayname="ConfigurationBean" output="false" extends="MeldForums.com.meldsolutions.core.MeldBean">
<!---^^GENERATEDSTART^^--->
	<!---^^PROPERTIES-START^^--->
	<cfproperty name="ConfigurationID" type="uuid" default="" required="true" maxlength="35" />
	<cfproperty name="SiteID" type="string" default="" required="true" maxlength="25" />
	<cfproperty name="Name" type="string" default="" required="true" maxlength="100" />
	<cfproperty name="Description" type="string" default="" maxlength="255" />
	<cfproperty name="IsActive" type="boolean" default="0" required="true" />
	<cfproperty name="RestrictReadGroups" type="string" default="" maxlength="255" />
	<cfproperty name="RestrictContributeGroups" type="string" default="" maxlength="255" />
	<cfproperty name="RestrictModerateGroups" type="string" default="RestrictAll" required="true" maxlength="255" />
	<cfproperty name="DoRequireConfirmation" type="boolean" default="0" required="true" />
	<cfproperty name="DoAvatars" type="boolean" default="0" required="true" />
	<cfproperty name="DoClosed" type="boolean" default="0" required="true" />
	<cfproperty name="AllowAttachmentExtensions" type="string" default="" />
	<cfproperty name="DoAttachments" type="boolean" default="0" required="true" />
	<cfproperty name="IsMaster" type="boolean" default="0" required="true" />
	<cfproperty name="FilesizeLimit" type="numeric" default="0" required="true" />
	<cfproperty name="CharacterLimit" type="numeric" default="0" required="true" />
	<cfproperty name="DoInlineImageAttachments" type="boolean" default="0" required="true" />
	<cfproperty name="ImageWidthLimit" type="numeric" default="0" required="true" />
	<cfproperty name="ImageHeightLimit" type="numeric" default="0" required="true" />
	<cfproperty name="RemoteID" type="string" default="" maxlength="35" />
	<cfproperty name="DateCreate" type="date" default="" required="true" />
	<cfproperty name="DateLastUpdate" type="date" default="" required="true" />
	<!---^^PROPERTIES-END^^--->

	<cfset variables.instance = StructNew() />

	<!--- INIT --->
	<cffunction name="init" access="public" returntype="ConfigurationBean" output="false">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="ConfigurationID" type="uuid" required="false" default="#CreateUUID()#" />
		<cfargument name="SiteID" type="string" required="false" default="" />
		<cfargument name="Name" type="string" required="false" default="" />
		<cfargument name="Description" type="string" required="false" default="" />
		<cfargument name="IsActive" type="boolean" required="false" default="0" />
		<cfargument name="RestrictReadGroups" type="string" required="false" default="" />
		<cfargument name="RestrictContributeGroups" type="string" required="false" default="" />
		<cfargument name="RestrictModerateGroups" type="string" required="false" default="RestrictAll" />
		<cfargument name="DoRequireConfirmation" type="boolean" required="false" default="0" />
		<cfargument name="DoAvatars" type="boolean" required="false" default="0" />
		<cfargument name="DoClosed" type="boolean" required="false" default="0" />
		<cfargument name="AllowAttachmentExtensions" type="string" required="false" default="" />
		<cfargument name="DoAttachments" type="boolean" required="false" default="0" />
		<cfargument name="IsMaster" type="boolean" required="false" default="0" />
		<cfargument name="FilesizeLimit" type="numeric" required="false" default="0" />
		<cfargument name="CharacterLimit" type="numeric" required="false" default="0" />
		<cfargument name="DoInlineImageAttachments" type="boolean" required="false" default="0" />
		<cfargument name="ImageWidthLimit" type="numeric" required="false" default="0" />
		<cfargument name="ImageHeightLimit" type="numeric" required="false" default="0" />
		<cfargument name="RemoteID" type="string" required="false" default="" />
		<cfargument name="DateCreate" type="string" required="false" default="" />
		<cfargument name="DateLastUpdate" type="string" required="false" default="" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="BeanExists" type="boolean" required="false" default="false" />

		<!---^^SETTERS-START^^--->
		<cfset setConfigurationID( arguments.ConfigurationID ) />
		<cfset setSiteID( arguments.SiteID ) />
		<cfset setName( arguments.Name ) />
		<cfset setDescription( arguments.Description ) />
		<cfset setIsActive( arguments.IsActive ) />
		<cfset setRestrictReadGroups( arguments.RestrictReadGroups ) />
		<cfset setRestrictContributeGroups( arguments.RestrictContributeGroups ) />
		<cfset setRestrictModerateGroups( arguments.RestrictModerateGroups ) />
		<cfset setDoRequireConfirmation( arguments.DoRequireConfirmation ) />
		<cfset setDoAvatars( arguments.DoAvatars ) />
		<cfset setDoClosed( arguments.DoClosed ) />
		<cfset setAllowAttachmentExtensions( arguments.AllowAttachmentExtensions ) />
		<cfset setDoAttachments( arguments.DoAttachments ) />
		<cfset setIsMaster( arguments.IsMaster ) />
		<cfset setFilesizeLimit( arguments.FilesizeLimit ) />
		<cfset setCharacterLimit( arguments.CharacterLimit ) />
		<cfset setDoInlineImageAttachments( arguments.DoInlineImageAttachments ) />
		<cfset setImageWidthLimit( arguments.ImageWidthLimit ) />
		<cfset setImageHeightLimit( arguments.ImageHeightLimit ) />
		<cfset setRemoteID( arguments.RemoteID ) />
		<cfset setDateCreate( arguments.DateCreate ) />
		<cfset setDateLastUpdate( arguments.DateLastUpdate ) />
		<!---^^SETTERS-END^^--->
		<cfset setBeanExists( arguments.BeanExists ) />
		
		<cfreturn this />
	</cffunction>

	<cffunction name="setMemento" access="public" returntype="ConfigurationBean" output="false">
		<cfargument name="memento" type="struct" required="yes"/>
		<cfset variables.instance = arguments.memento />
		<cfreturn this />
	</cffunction>
	<cffunction name="getMemento" access="public" returntype="struct" output="false" >
		<cfreturn variables.instance />
	</cffunction>
	
	<!---^^ACCESSORS-START^^--->
	<cffunction name="setConfigurationID" access="public" returntype="void" output="false">
		<cfargument name="ConfigurationID" type="uuid" required="true" />
		<cfset variables.instance['configurationid'] = arguments.ConfigurationID />
	</cffunction>
	<cffunction name="getConfigurationID" access="public" returntype="uuid" output="false">
		<cfreturn variables.instance.ConfigurationID />
	</cffunction>
	
	<cffunction name="setSiteID" access="public" returntype="void" output="false">
		<cfargument name="SiteID" type="string" required="true" />
		<cfset variables.instance['siteid'] = arguments.SiteID />
	</cffunction>
	<cffunction name="getSiteID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.SiteID />
	</cffunction>
	
	<cffunction name="setName" access="public" returntype="void" output="false">
		<cfargument name="Name" type="string" required="true" />
		<cfset variables.instance['name'] = arguments.Name />
	</cffunction>
	<cffunction name="getName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Name />
	</cffunction>
	
	<cffunction name="setDescription" access="public" returntype="void" output="false">
		<cfargument name="Description" type="string" required="true" />
		<cfset variables.instance['description'] = arguments.Description />
	</cffunction>
	<cffunction name="getDescription" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Description />
	</cffunction>
	
	<cffunction name="setIsActive" access="public" returntype="void" output="false">
		<cfargument name="IsActive" type="boolean" required="true" />
		<cfset variables.instance['isactive'] = arguments.IsActive />
	</cffunction>
	<cffunction name="getIsActive" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.IsActive />
	</cffunction>
	
	<cffunction name="setRestrictReadGroups" access="public" returntype="void" output="false">
		<cfargument name="RestrictReadGroups" type="string" required="true" />
		<cfset variables.instance['restrictreadgroups'] = arguments.RestrictReadGroups />
	</cffunction>
	<cffunction name="getRestrictReadGroups" access="public" returntype="string" output="false">
		<cfreturn variables.instance.RestrictReadGroups />
	</cffunction>
	
	<cffunction name="setRestrictContributeGroups" access="public" returntype="void" output="false">
		<cfargument name="RestrictContributeGroups" type="string" required="true" />
		<cfset variables.instance['restrictcontributegroups'] = arguments.RestrictContributeGroups />
	</cffunction>
	<cffunction name="getRestrictContributeGroups" access="public" returntype="string" output="false">
		<cfreturn variables.instance.RestrictContributeGroups />
	</cffunction>
	
	<cffunction name="setRestrictModerateGroups" access="public" returntype="void" output="false">
		<cfargument name="RestrictModerateGroups" type="string" required="true" />
		<cfset variables.instance['restrictmoderategroups'] = arguments.RestrictModerateGroups />
	</cffunction>
	<cffunction name="getRestrictModerateGroups" access="public" returntype="string" output="false">
		<cfreturn variables.instance.RestrictModerateGroups />
	</cffunction>
	
	<cffunction name="setDoRequireConfirmation" access="public" returntype="void" output="false">
		<cfargument name="DoRequireConfirmation" type="boolean" required="true" />
		<cfset variables.instance['dorequireconfirmation'] = arguments.DoRequireConfirmation />
	</cffunction>
	<cffunction name="getDoRequireConfirmation" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.DoRequireConfirmation />
	</cffunction>
	
	<cffunction name="setDoAvatars" access="public" returntype="void" output="false">
		<cfargument name="DoAvatars" type="boolean" required="true" />
		<cfset variables.instance['doavatars'] = arguments.DoAvatars />
	</cffunction>
	<cffunction name="getDoAvatars" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.DoAvatars />
	</cffunction>
	
	<cffunction name="setDoClosed" access="public" returntype="void" output="false">
		<cfargument name="DoClosed" type="boolean" required="true" />
		<cfset variables.instance['doclosed'] = arguments.DoClosed />
	</cffunction>
	<cffunction name="getDoClosed" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.DoClosed />
	</cffunction>
	
	<cffunction name="setAllowAttachmentExtensions" access="public" returntype="void" output="false">
		<cfargument name="AllowAttachmentExtensions" type="string" required="true" />
		<cfset variables.instance['allowattachmentextensions'] = arguments.AllowAttachmentExtensions />
	</cffunction>
	<cffunction name="getAllowAttachmentExtensions" access="public" returntype="string" output="false">
		<cfreturn variables.instance.AllowAttachmentExtensions />
	</cffunction>
	
	<cffunction name="setDoAttachments" access="public" returntype="void" output="false">
		<cfargument name="DoAttachments" type="boolean" required="true" />
		<cfset variables.instance['doattachments'] = arguments.DoAttachments />
	</cffunction>
	<cffunction name="getDoAttachments" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.DoAttachments />
	</cffunction>
	
	<cffunction name="setIsMaster" access="public" returntype="void" output="false">
		<cfargument name="IsMaster" type="boolean" required="true" />
		<cfset variables.instance['ismaster'] = arguments.IsMaster />
	</cffunction>
	<cffunction name="getIsMaster" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.IsMaster />
	</cffunction>
	
	<cffunction name="setFilesizeLimit" access="public" returntype="void" output="false">
		<cfargument name="FilesizeLimit" type="numeric" required="true" />
		<cfset variables.instance['filesizelimit'] = arguments.FilesizeLimit />
	</cffunction>
	<cffunction name="getFilesizeLimit" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.FilesizeLimit />
	</cffunction>
	
	<cffunction name="setCharacterLimit" access="public" returntype="void" output="false">
		<cfargument name="CharacterLimit" type="numeric" required="true" />
		<cfset variables.instance['characterlimit'] = arguments.CharacterLimit />
	</cffunction>
	<cffunction name="getCharacterLimit" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.CharacterLimit />
	</cffunction>
	
	<cffunction name="setDoInlineImageAttachments" access="public" returntype="void" output="false">
		<cfargument name="DoInlineImageAttachments" type="boolean" required="true" />
		<cfset variables.instance['doinlineimageattachments'] = arguments.DoInlineImageAttachments />
	</cffunction>
	<cffunction name="getDoInlineImageAttachments" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.DoInlineImageAttachments />
	</cffunction>
	
	<cffunction name="setImageWidthLimit" access="public" returntype="void" output="false">
		<cfargument name="ImageWidthLimit" type="numeric" required="true" />
		<cfset variables.instance['imagewidthlimit'] = arguments.ImageWidthLimit />
	</cffunction>
	<cffunction name="getImageWidthLimit" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.ImageWidthLimit />
	</cffunction>
	
	<cffunction name="setImageHeightLimit" access="public" returntype="void" output="false">
		<cfargument name="ImageHeightLimit" type="numeric" required="true" />
		<cfset variables.instance['imageheightlimit'] = arguments.ImageHeightLimit />
	</cffunction>
	<cffunction name="getImageHeightLimit" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.ImageHeightLimit />
	</cffunction>
	
	<cffunction name="setRemoteID" access="public" returntype="void" output="false">
		<cfargument name="RemoteID" type="string" required="true" />
		<cfset variables.instance['remoteid'] = arguments.RemoteID />
	</cffunction>
	<cffunction name="getRemoteID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.RemoteID />
	</cffunction>
	
	<cffunction name="setDateCreate" access="public" returntype="void" output="false">
		<cfargument name="DateCreate" type="string" required="true" />
		<cfset variables.instance['datecreate'] = arguments.DateCreate />
	</cffunction>
	<cffunction name="getDateCreate" access="public" returntype="string" output="false">
		<cfreturn variables.instance.DateCreate />
	</cffunction>
	
	<cffunction name="setDateLastUpdate" access="public" returntype="void" output="false">
		<cfargument name="DateLastUpdate" type="string" required="true" />
		<cfset variables.instance['datelastupdate'] = arguments.DateLastUpdate />
	</cffunction>
	<cffunction name="getDateLastUpdate" access="public" returntype="string" output="false">
		<cfreturn variables.instance.DateLastUpdate />
	</cffunction>
	<!---^^ACCESSORS-END^^--->

	<!--- Services --->
	<cffunction name="save" access="public" output="true" return="boolean">
		<cfif not getServiceExists()>
			<cfreturn false />
		</cfif>
		
		<cfif getBeanExists()>
			<cfset getConfigurationService().updateConfiguration( this ) />
		<cfelse>
			<cfset getConfigurationService().saveConfiguration( this ) />
		</cfif>

		<cfreturn true>
	</cffunction>

	<cffunction name="update" access="public" output="true" return="boolean">
		<cfreturn save()>
	</cffunction>

	<cffunction name="delete" access="public" output="true" return="boolean">

		<cfset var sArgs = StructNew() />

		<cfif not getServiceExists()>
			<cfreturn false />
		</cfif>
		<cfset sArgs['ConfigurationID'] = getConfigurationID() /> 
		

		<cfset getConfigurationService().deleteConfiguration( argumentCollection=sArgs  ) />
		<cfreturn true>
	</cffunction>

	<cffunction name="dump" access="public" output="true" return="void">
		<cfargument name="abort" type="boolean" default="false" />
		<cfdump var="#getMemento()#" />
		<cfif arguments.abort>
			<cfabort />
		</cfif>
	</cffunction>

	<cffunction name="setBeanExists" access="public" output="false" returntype="void">
		<cfargument name="BeanExists" type="boolean" required="true" />
		<cfset variables.BeanExists = arguments.BeanExists >
	</cffunction>
	<cffunction name="BeanExists" access="public" output="false" returntype="boolean">
		<cfreturn variables.BeanExists>
	</cffunction>
	<cffunction name="getBeanExists" access="public" output="false" returntype="boolean">
		<cfreturn variables.BeanExists>
	</cffunction>

	<cffunction name="setConfigurationService" access="public" returntype="void" output="false">
		<cfargument name="ConfigurationService" type="any" required="yes"/>
		<cfset variables.ConfigurationService = arguments.ConfigurationService />
	</cffunction>
	<cffunction name="getConfigurationService" access="public" returntype="any" output="false" >
		<cfif getServiceExists()>
			<cfreturn variables.ConfigurationService />
		</cfif>
	</cffunction>
	<cffunction name="getServiceExists" access="public" returntype="boolean" output="false" >
		<cfreturn StructKeyExists(variables,"ConfigurationService")>
	</cffunction>

	<cffunction name="getKey" access="public" returntype="string" output="false" >
		<cfreturn "MeldForumsConfiguration">
	</cffunction>

	<cffunction name="getID" access="public" returntype="uuid" output="false" >
		<cfreturn getConfigurationID()>
	</cffunction>

<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->
	<cffunction name="getDoRestrictRead" access="public" returntype="boolean" output="false">
		<cfreturn len(variables.instance.RestrictReadGroups) gt 0 />
	</cffunction>

	<cffunction name="getDoRestrictModerate" access="public" returntype="boolean" output="false">
		<cfreturn len(variables.instance.RestrictModerateGroups) gt 0 />
	</cffunction>

	<cffunction name="getDoRestrictContribute" access="public" returntype="boolean" output="false">
		<cfreturn len(variables.instance.RestrictContributeGroups) gt 0 />
	</cffunction>
<!---^^CUSTOMEND^^--->
</cfcomponent>	




