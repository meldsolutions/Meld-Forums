<!---
This file is part of the Meld Manager application.

Meld Manager is licensed under the GPL 2.0 license
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
<cfcomponent displayname="mmResourceBundle" hint="Creates and manages resource bundles" output="false">
	<cfset variables.instance = StructNew()>

	<cffunction name="init" access="public" output="false" returntype="mmResourceBundle">
		<cfargument name="MeldConfig" type="any" required="true">

		<cfset variables.MeldConfig = arguments.MeldConfig />
			
		<cfset structAppend(variables.instance,structCopy(variables.MeldConfig.getAllValues()),true) />
		<cfset structAppend(variables,structCopy(variables.MeldConfig.getAllValues()),true) />
		
		<cfset setApplicationKey( variables.applicationKey ) />
		<cfset setpluginFileRoot( variables.pluginFileRoot ) />
		<cfset setBaseRBLocale( variables.rblocale ) />
		
		<cfset variables.rbValid		= false>
		<cfset variables.sRB			= StructNew() />
				
		<cfset doValidateBaseResourceBundle() />

		<cfif not getRBValid()>
			<cfreturn this />
		</cfif>

		<cfset doConnectBaseResourceBundle() />

		<cfreturn this/>
	</cffunction>

	<cffunction name="key" access="public" returntype="string" output="false">
		<cfargument name="value" type="string" required="true" />
		<cfargument name="context" type="string" required="false" default="label" />
		<cfargument name="locale" type="string" required="false" default="#getBaseRBLocale()#" />

		<cfset var fullKey		= getApplicationKey() />
		<cfset var keyValue		= "" />
		
		<cfif not getRBValid()>
			<cfreturn arguments.value & "_z" />
		</cfif>

		<cfif arguments.context eq "mura">
			<cfset fullKey = arguments.value />
		<cfelse>
			<cfset fullKey = fullKey & "." & arguments.context />
			<cfset fullKey = fullKey & "." & arguments.value />
		</cfif>
		
		<cfset keyValue = getRBFactory().getKeyValue(arguments.locale,fullKey) /> 
									
		<cfif keyValue eq "#fullKey#_missing" and getBaseRBLocale() eq "en" and not getHasCustom()>
			<cfreturn appendKey( fullKey,arguments.value,arguments.locale,true,true ) />
		</cfif>

		<cfreturn keyValue />
	</cffunction>

	<cffunction name="getKey" access="public" returntype="string" output="false">
		<cfargument name="value" type="string" required="true" />
		<cfargument name="context" type="string" required="false" default="label" />
		<cfargument name="locale" type="string" required="false" default="#getBaseRBLocale()#" />

		<cfreturn key( argumentCollection=arguments ) />
	</cffunction>


	<cffunction name="keyExists" access="public" returntype="boolean" output="false">
		<cfargument name="value" 	type="string" required="true" />
		<cfargument name="context" 	type="string" required="false" default="label" />
		<cfargument name="locale" 	type="string" required="false" default="#getBaseRBLocale()#" />

		<cfset var fullKey		= getApplicationKey() />
		<cfset var keyValue		= "" />

		<cfif not getRBValid()>
			<cfreturn arguments.value & "_z" />
		</cfif>

		<cfif arguments.context eq "mura">
			<cfset fullKey = arguments.value />
		<cfelse>
			<cfset fullKey = fullKey & "." & arguments.context />
			<cfset fullKey = fullKey & "." & arguments.value />
		</cfif>
		
		<cfset keyValue = getRBFactory().getKeyValue(arguments.locale,fullKey) />

		<!--- 
		<cfdump var="#arguments#" />
				<cfoutput>#fullkey#|#keyvalue#</cfoutput>
				<cfabort /> --->
		
		<cfreturn right(keyValue,8) neq "_missing" and not getHasCustom() />
	</cffunction>


	<cffunction name="setKey" access="public" returntype="string" output="false">
		<cfargument name="name" type="string" required="true" />
		<cfargument name="value" type="string" required="true" />
		<cfargument name="context" type="string" required="false" default="label" />
		<cfargument name="application" type="string" required="false" default="#getApplicationKey()#" />
		<cfargument name="locale" type="string" required="false" default="#getBaseRBLocale()#" />

		<cfset var fullKey		= arguments.application />
		<cfset var keyValue		= "" />

		<cfif arguments.context eq "mura">
			<cfreturn false />
		<cfelse>
			<cfset fullKey = fullKey & "." & arguments.context />
			<cfset fullKey = fullKey & "." & arguments.name />
		</cfif>

		<cfset keyValue = getRBFactory().getKeyValue(arguments.locale,fullKey) /> 

		<cfif keyValue neq "#fullKey#_missing">
			<cfreturn updateKey( fullKey,arguments.value,arguments.locale,false,false ) />
		</cfif>
	</cffunction>

	<cffunction name="updateKey" access="private" returntype="string" output="false">
		<cfargument name="fullKey" type="string" required="true" />
		<cfargument name="value" type="string" required="true" />
		<cfargument name="locale" type="string" required="false" default="#getBaseRBLocale()#" />

		<cfset var contextFile	= "" />
		<cfset var str			= "" />

		<cfset keyValue = getRBFactory().getKeyValue(arguments.locale,fullKey) /> 

		<cfif keyValue neq "#fullKey#_missing">
			<cfreturn modifyKey( fullKey,arguments.value,arguments.locale,false ) />
		<cfelse>
			<cfthrow message="KEY NOT FOUND">
		</cfif>
		
		<cfreturn arguments.value />
	</cffunction>

	<cffunction name="appendKey" access="private" returntype="string" output="false">
		<cfargument name="fullKey" type="string" required="true" />
		<cfargument name="value" type="string" required="true" />
		<cfargument name="locale" type="string" required="false" default="#getBaseRBLocale()#" />
		<cfargument name="isMissing" type="boolean" required="false" default="false" />
		<cfargument name="appendLocation" type="boolean" required="false" default="false" />

		<cfset var contextFile	= "" />
		<cfset var strKey		= "" />
		<cfset var strValue		= "" />
		<cfset var strLocation	= "" />
		<cfset var keyValue		= "" />
		
		<cfif arguments.isMissing>
			<cfset strValue = "#arguments.value#_?" />
		<cfelse>
			<cfset strValue = arguments.value />
		</cfif>

		<cfset strKey = "#arguments.fullKey#=#strValue#" />

		<cfif arguments.appendLocation>
			<cftry>
				<cfthrow message="get context">
				<cfcatch>
					<cfset contextFile = cfcatch.TagContext[3].template>
				</cfcatch>
			</cftry> 
			<cfset strLocation = "
			######LOCATION OF #arguments.fullKey#: #contextFile#######" />
		</cfif>

		<cflock timeout="10" scope="Application" >
			<cffile action="append" file="#getRBFile()#" output="#strKey##strLocation#" addnewline="true" >
		</cflock>
		
		<cfset resetRBFactory( argumentCollection=arguments ) />
		<cfset keyValue = getRBFactory().getKeyValue(arguments.locale,value) /> 
		
		<cfreturn keyValue />
	</cffunction>

	<cffunction name="modifyKey" access="private" returntype="string" output="false">
		<cfargument name="fullKey" type="string" required="true" />
		<cfargument name="value" type="string" required="true" />
		<cfargument name="locale" type="string" required="false" default="#getBaseRBLocale()#" />

		<cfset var rbFile		= "" />
		<cfset var newRBFile	= "" />
		<cfset var mStart		= 0 />
		<cfset var mEnd			= 0 />
		<cfset var strLocation	= "" />
		<cfset var keyValue		= "" />

		<cffile action="read" variable="rbFile" file="#getRBFile()#" >

		<cfset mStart = refindNoCase(fullKey,rbFile) />

		<cfif not mStart>
			<cfreturn false />
		</cfif>
		<cfset mEnd = refindNoCase("#chr(10)#|#chr(13)#",rbFile,mStart) />
		<cfif not mEnd>
			<cfset mEnd = len(rbFile) />
		</cfif>
		
		<cfset strKey = "#arguments.fullKey#=#arguments.value#" />
		<cfset newRBFile = mid(rbFile,1,mStart-1) & strKey & mid(rbFile,mEnd,len(rbFile)+1) />

		<cflock timeout="10" scope="Application">
			<cffile action="write" file="#getRBFile()#" output="#newRBFile#" addnewline="false" >
		</cflock>
	
		<cfset resetRBFactory( argumentCollection=arguments ) />
		<cfset keyValue = getRBFactory().getKeyValue(arguments.locale,value) /> 
		<cfreturn keyValue />
	</cffunction>
	
	<cffunction name="doConnectBaseResourceBundle" access="private" returntype="void" output="false">
		<cfset getRBFactory() />
	</cffunction>
	
	<cffunction name="getRBFactory" access="public" returntype="any" output="false">
		<cfargument name="locale" type="string" required="false" default="#getBaseRBLocale()#" />
		
		<cfset var rbFactory 	= "" />

		<cfif not StructKeyExists( variables.sRB,arguments.locale ) >
			<cfset resetRBFactory( argumentCollection=arguments ) />
		</cfif>

		<cfreturn variables.sRB[ arguments.locale ] />
	</cffunction>
	
	<cffunction name="resetRBFactory" access="public" returntype="void" output="false">
		<cfargument name="locale" type="string" required="false" default="#getBaseRBLocale()#" />
		
		<cfset var rbFactory 	= "" />
		<cfset var rbCustomFactory 	= "" />
		<cfset var parent		= "" />

		<cfif structKeyExists(variables.instance,"ParentFactory")>
			<cfset parent = getParentFactory() />
		<cfelse>
			<cfset parent = application.rbFactory />
		</cfif>

		<cfif getHasCustom()>
			<cfset rbFactory = createObject("component","mura.resourceBundle.resourceBundleFactory").init(application.rbFactory,getRBPath(),getBaseRBLocale() ) />
			<cfset rbCustomFactory = createObject("component","mura.resourceBundle.resourceBundleFactory").init(rbFactory,getRBCustomPath(),getBaseRBLocale() ) />
			<cfset variables.sRB[ arguments.locale ] = rbCustomFactory />
		<cfelse>
			<cfset rbFactory = createObject("component","mura.resourceBundle.resourceBundleFactory").init(application.rbFactory,getRBPath(),getBaseRBLocale() ) />
			<cfset variables.sRB[ arguments.locale ] = rbFactory />
		</cfif>
	</cffunction>

	<cffunction name="doValidateBaseResourceBundle" access="private" returntype="void" output="false">
		<cfset var path			= getpluginFileRoot() & "/resourceBundles" />
		<cfset var customPath	= getpluginFileRoot() & "/resourceBundles/custom" />
		<cfset var file			= path & "/" & getBaseRBLocale() & ".properties" />
		<cfset var customFile	= customPath & "/" & getBaseRBLocale() & ".properties" />

		<cfset variables.instance.rbCustomPath = "" />
		<cfset variables.instance.rbCustomFile = "" />

		<cfif not len( getpluginFileRoot() ) or not directoryExists( getpluginFileRoot() )>
			<cfset variables.rbValid = false>
			<cfreturn>
		</cfif>

		<cfif not directoryExists( path  )>
			<cfdirectory action="create" directory="#path#">
		</cfif>

		<cfif not fileExists( file )>
			<cffile action="write" file="#file#" output="## Created by mmResourceBundle #lsDateFormat(now(),"short")#">
		</cfif>

		<cfif fileExists( customFile )>
			<cfset variables.instance.rbCustomPath = customPath />
			<cfset variables.instance.rbCustomFile = customFile />
		</cfif>

		<cfset variables.instance.rbPath	= path />
		<cfset variables.instance.rbFile	= file />

		<cfset variables.rbValid = true>
	</cffunction>

	<cffunction name="getRBFile" access="public" returntype="string" output="false">
		<cfreturn variables.instance.rbFile />
	</cffunction>
	<cffunction name="getRBCustomFile" access="public" returntype="string" output="false">
		<cfreturn variables.instance.rbCustomFile />
	</cffunction>
	<cffunction name="getRBPath" access="public" returntype="string" output="false">
		<cfreturn variables.instance.rbPath & "/" />
	</cffunction>
	<cffunction name="getRBCustomPath" access="public" returntype="string" output="false">
		<cfreturn variables.instance.rbCustomPath & "/" />
	</cffunction>
	<cffunction name="getHasCustom" access="public" returntype="string" output="false">
		<cfreturn StructKeyExists(variables.instance,"rbCustomFile") and len(variables.instance.rbCustomFile) />
	</cffunction>
	<cffunction name="getRBValid" access="public" returntype="string" output="false">
		<cfreturn variables.rbValid />
	</cffunction>
	
	<!--- 
	mmResourceBundle will instantiate and manage resource bundles.  It may also be useful to have it actually add
	"null" values to the current resourceBundle where they don't exist.
	--->
	<cffunction name="setpluginFileRoot" access="public" returntype="void" output="false">
		<cfargument name="pluginFileRoot" type="string" required="true" />
		<cfset variables.instance.pluginFileRoot = arguments.pluginFileRoot />
	</cffunction>
	<cffunction name="getpluginFileRoot" access="public" returntype="string" output="false">
		<cfreturn variables.instance.pluginFileRoot />
	</cffunction>

	<cffunction name="setApplicationKey" access="public" returntype="void" output="false">
		<cfargument name="ApplicationKey" type="string" required="true" />
		<cfset variables.instance.ApplicationKey = arguments.ApplicationKey />
	</cffunction>
	<cffunction name="getApplicationKey" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ApplicationKey />
	</cffunction>

	<cffunction name="setBaseRBLocale" access="public" returntype="void" output="false">
		<cfargument name="BaseRBLocale" type="string" required="true" />
		<cfset variables.instance.BaseRBLocale = arguments.BaseRBLocale />
	</cffunction>
	<cffunction name="getBaseRBLocale" access="public" returntype="string" output="false">
		<cfif isDefined("session") and structKeyExists(session,"RB")>
			<cfif session.rb eq "en_US">
				<cfreturn "en">
			<cfelse>
				<cfreturn session.RB />
			</cfif>
		<cfelse>
			<cfreturn variables.instance.BaseRBLocale />
		</cfif>
	</cffunction>

	<cffunction name="setParentFactory" access="public" returntype="void" output="false">
		<cfargument name="ParentFactory" type="any" required="true" />
		<cfset variables.instance.ParentFactory = arguments.ParentFactory />
		<cfset resetRBFactory() />
	</cffunction>
	<cffunction name="getParentFactory" access="public" returntype="any" output="false">
		<cfreturn variables.instance.ParentFactory />
	</cffunction>
</cfcomponent>