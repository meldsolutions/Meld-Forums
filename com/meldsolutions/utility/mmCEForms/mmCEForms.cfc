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
<cfcomponent displayname="mmCEForms" hint="assists Form / Bean interaction" output="false">
	<cfset variables.instance = StructNew()>

	<cffunction name="init" access="public" output="false" returntype="mmCEForms">
		<cfreturn this/>
	</cffunction>

	<!--- 	
		#rc.mmCEForms.buildfield( name,type,defaultValue,optionList,optionValueList,rc.slotBean.getCustomValue(name) )#	
 	--->

	<cffunction name="buildField" access="public" output="false" returntype="string">
		<cfargument name="name" required="true" type="string">
		<cfargument name="label" required="true" type="string">
		<cfargument name="type" required="false" type="string" default="textfield">
		<cfargument name="defaultValue" required="false" type="string" default="">
		<cfargument name="currentValue" required="false" type="string" default="">
		<cfargument name="optionList" required="false" type="string" default="">
		<cfargument name="optionLabelList" required="false" type="string" default="">
		<cfargument name="isRequired" required="false" type="boolean" default="0">
		<cfargument name="validate" required="false" type="string" default="">
		<cfargument name="validateMessage" required="false" type="string" default="">
		<cfargument name="hint" required="false" type="string" default="">
		<cfargument name="regex" required="false" type="string" default="">

		<cfset var str			= "" />
		<cfset var fieldValue 	= "" />
		<cfset var iiX		 	= "" />
		<cfset var aOpts	 	= ArrayNew(1) />
		<cfset var aLabels	 	= ArrayNew(1) />

		<cfset var strHint		= "" />
		<cfset var strGeneric	= "" />
		<cfset var strLabel		= "" />
						
		<cfif len(currentValue)>
			<cfset fieldValue = arguments.currentValue />
		<cfelse>
			<cfset fieldValue = arguments.defaultValue />
		</cfif>	
						
		<cfif arguments.isRequired>
			<cfset strGeneric = strGeneric & ' data-required="true"' />
		</cfif>	
						
		<cfif len(arguments.hint)>
			<cfset strHint = arguments.hint />
		</cfif>	

		<cfif len(arguments.label)>
			<cfset strLabel = '<label for="custom_#arguments.name#">#arguments.label#</label>' />
		</cfif>	
						
		<cfif len(arguments.validate)>
			<cfif arguments.validate eq "regex">
				<cfset strGeneric = strGeneric & ' data-validate="regex" data-regex="#arguments.regex#"' />
			<cfelse>
				<cfset strGeneric = strGeneric & ' data-validate="#arguments.validate#"' />
			</cfif>
		</cfif>	
						
		<cfif len(arguments.validateMessage)>
			<cfif left(arguments.validateMessage,1) eq "_">
				<cfset strGeneric = strGeneric & ' data-message="#getmmResourceBundle().key(arguments.validateMessage)#"' />
			<cfelse>
				<cfset strGeneric = strGeneric & ' data-message="#arguments.validateMessage#"' />
			</cfif>
		</cfif>	

		<cfsavecontent variable="str" >
		<cfswitch expression="#arguments.type#">
			<cfcase value="checkbox" >
				<cfoutput>#strLabel#<input type="checkbox" name="custom_#arguments.name#" class="checkbox" value="#defaultValue#" <cfif len(currentValue)> checked="CHECKED"</cfif>></cfoutput>				
			</cfcase>
			<cfcase value="radiobox" >
				<cfset aOpts = ListToArray( arguments.optionList,"^" ) />
				<cfset aLabels = ListToArray( arguments.optionLabelList,"^" ) />
				<cfoutput>#strLabel#<select name="custom_#arguments.name#" class="select">
					<cfloop from="1" to="#ArrayLen(aOpts)#" index="iiX"><input type="radiobox"  value="#aLabels[iiX]#"<cfif aOpts[iiX] eq currentValue> SELECTED</cfif>>#aLabels[iiX]#</option>
					</cfloop>
				</select></cfoutput>				
			</cfcase>
			<cfcase value="textarea,htmleditor,bbmleditor" >
				<cfoutput>#strLabel#<textarea name="custom_#arguments.name#" class="textarea"#strGeneric#>#currentValue#</textarea></cfoutput>				
			</cfcase>
			<cfcase value="textarea,selectbox" >
				<cfset aOpts = ListToArray( arguments.optionList,"^" ) />
				<cfset aLabels = ListToArray( arguments.optionLabelList,"^" ) />
				<cfoutput>#strLabel#<select name="custom_#arguments.name#" class="select">
					<cfloop from="1" to="#ArrayLen(aOpts)#" index="iiX"><option value="#aLabels[iiX]#"<cfif aOpts[iiX] eq currentValue> SELECTED</cfif>>#aLabels[iiX]#</option>
					</cfloop>
				</select></cfoutput>				
			</cfcase>
			<cfdefaultcase>
				<cfoutput>#strLabel#<input type="text" name="custom_#arguments.name#" class="textarea" value="#currentValue#"#strGeneric# /></cfoutput>				
			</cfdefaultcase>
		</cfswitch>
		</cfsavecontent>

		<cfreturn str />
	</cffunction>

	<cffunction name="getmmResourceBundle" access="public" output="false" returntype="any">
		<cfreturn variables.mmResourceBundle />
	</cffunction>
	<cffunction name="setmmResourceBundle" access="public" output="false" returntype="void">
		<cfargument name="mmResourceBundle" type="any" required="true" />
		<cfset variables.mmResourceBundle = arguments.mmResourceBundle />
	</cffunction>
</cfcomponent>