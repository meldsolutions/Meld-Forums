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
<cfcomponent displayname="mmFormTools" hint="assists Form / Bean interaction" output="false">
	<cfset variables.instance = StructNew()>

	<cffunction name="init" access="public" output="false" returntype="mmFormTools">
		<cfreturn this/>
	</cffunction>
	
	<!---
		Will cfparam an entire bean using the cfproperty tags as a guide.  Very useful for
		bean CRUD (and we all love our bean CRUD)
		
		Process is:
		1) if the form value exists, it is used
		2) if a preset value has been passed in, it is used
			(good for init'ing new beans or drawing values from nested beans)
		3) the existing bean value is used
	 --->
	
	<cffunction name="paramaterizeBeanForm" access="public" output="false" returntype="void">
		<cfargument name="sourceBean" required="true" type="any">
		<cfargument name="sPresets" required="false" type="struct" default="#StructNew()#">
		<cfargument name="bPrefix" required="false" type="boolean" default="true">
		<cfargument name="sSub" required="false" type="string" default="">

		<cfset var metaData			= getmetadata(arguments.sourceBean) />
		<cfset var aParams			= metaData.properties />
		<cfset var cValue			= "">
		<cfset var cFunctionName	= "">
		<!--- prefix is the beans display name --->
		<cfset var prefix			= "">
		<!--- use sub if there are multiple copies of the bean in the form --->
		<cfset var sub				= "">
		<cfset var iiX				= "">

		<cfif arguments.bPrefix>
			<cfset prefix = metaData.displayName & "_">
		</cfif>

		<cfif len(arguments.sSub)>
			<cfset sub = arguments.sSub & "_">
		</cfif>

		<cfloop from="1" to="#arrayLen(aParams)#" index="iiX">
			<cfset cValue = "">

			<cfset cFunctionName = "get" & aParams[iiX].name>

			<cfif StructKeyExists(form,"#lcase("#prefix##sub##aParams[iiX].name#")#")>
				<!--- not necessary, as it is already the value --->
				<!---<cfset cValue = form[aParams[iiX].name]>--->
			<cfelseif StructKeyExists(sPresets,aParams[iiX].name)>
				<cfset cValue = sPresets[aParams[iiX].name]>
			<cfelseif StructKeyExists(arguments.sourceBean,cFunctionName)>
				<cfset cValue = evaluate("arguments.sourceBean." & cFunctionName & "()")>
			<cfelse>
				<cfset cValue = "">
			</cfif>
	
			<cfif isSimpleValue(cValue)>
				<cfif aParams[iiX].type eq "boolean" and not isBoolean(cValue)>
					<cfset cValue = "0">
				<cfelseif aParams[iiX].type eq "date" and (len(aParams[iiX].default) or isDate(cValue))>
					<cfif isDate( cValue )>
						<cfset useDate = cValue>
					<cfelse>
						<cfset useDate = now()>
					</cfif>
					<cfswitch expression="#aParams[iiX].default#">
						<cfcase value="odbcdatetime">
							<!--- create a AM/PM form value as well --->
							<cfparam name="form.#prefix##sub##aParams[iiX].name#_TT" default="#timeformat(useDate,"TT")#">
						</cfcase>
						<cfcase value="datetime">
							<cfset cValue = dateformat(useDate,"mm/dd/yyyy") & " " & timeformat(useDate,"hh:mm")>
							<!--- create a AM/PM form value as well --->
							<cfparam name="form.#prefix##sub##aParams[iiX].name#_TT" default="#timeformat(useDate,"TT")#">
						</cfcase>
						<cfcase value="time">
							<cfset cValue = timeformat(useDate,"hh:mm")>
							<!--- create a AM/PM form value as well --->
							<cfparam name="form.#prefix##sub##aParams[iiX].name#_TT" default="#timeformat(useDate,"TT")#">
						</cfcase>
						<cfdefaultcase><!--- ie "now" --->
							<cfset cValue = dateformat(useDate,"mm/dd/yyyy")>
						</cfdefaultcase>
					</cfswitch>
				</cfif>
	
				<cfparam name="form['#lcase("#prefix##sub##aParams[iiX].name#")#']" default="#cValue#">
			</cfif>
		</cfloop>
	</cffunction>

	<cffunction name="paramaterizeBeanBooleans" access="public" output="false" returntype="void">
		<cfargument name="sourceBean" required="true" type="any">
		<cfargument name="sPresets" required="false" type="struct" default="#StructNew()#">
		<cfargument name="bPrefix" required="false" type="boolean" default="true">
		<cfargument name="sSub" required="false" type="string" default="">

		<cfset var metaData			= getmetadata(arguments.sourceBean) />
		<cfset var aParams			= metaData.properties />
		<cfset var iiX				= "">
		<!--- prefix is the beans display name --->
		<cfset var prefix			= "">
		<!--- use sub if there are multiple copies of the bean in the form --->
		<cfset var sub				= "">

		<cfif arguments.bPrefix>
			<cfset prefix = metaData.displayName & "_">
		</cfif>

		<cfif len(arguments.sSub)>
			<cfset sub = arguments.sSub & "_">
		</cfif>

		<cfloop from="1" to="#arrayLen(aParams)#" index="iiX">
			<cfif aParams[iiX].type eq "boolean">
				<cfset cFunctionName = "get" & aParams[iiX].name>

				<cfif not StructKeyExists(form,aParams[iiX].name)>
					<cfset cValue = "0">
				</cfif>
			
				<cfparam name="form['#lcase("#prefix##sub##aParams[iiX].name#")#']" default="#cValue#">
			</cfif>
		</cfloop>
	</cffunction>

	<!--- 
		Will process the form (or any submitted struct) who's values have been
		prefixed with "scopename_".  This is useful in cases where a single form
		is submitting values that belong to multiple beans, or where specific control
		over a set of values is desired.
		
		Very useful when combined with paramaterizeBeanForm()
	 --->
	<cffunction name="scopeFormSubmission" access="public" output="false" returntype="struct">
		<cfargument name="formStruct" required="false" type="struct" default="#form#">
		<cfargument name="skipEmpty" required="false" type="boolean" default="false">
		<cfargument name="appendGlobal" required="false" type="boolean" default="false">
		<cfargument name="subScope" required="false" type="boolean" default="false">

		<cfset var sForm		= StructNew() />
		<cfset var sGlobal		= StructNew() />
		<cfset var iiX			= "" />
		<cfset var cScopeName	= "" />
		<cfset var cValueName	= "" />
		<cfset var sSubScope	=  StructNew()/>
		
		<cfloop collection="#arguments.formStruct#" item="iiX">
			<cftry>	
			<cfif find("_",iiX)>
				<cfset cScopeName = rereplace(iiX,"\_.*$","") />
				<cfif arguments.skipEmpty and not len(formStruct[iiX])>
				<cfelse>
					<cfset cValueName = rereplace(iiX,"^.[^\_]*\_","") />
					<cfif find("_",cValueName)>
						<cfset sSubScope[cScopeName] = true>
					</cfif>
					<cfif not StructKeyExists(sForm,cScopeName)>
						<cfset sForm[cScopeName] = StructNew() />
					</cfif>
					<cfset sForm[cScopeName][cValueName] = formStruct[iiX]>
				</cfif>
			<cfelseif iiX neq "fieldnames">
				<cfif not arguments.subScope and not StructKeyExists(sForm,"mm_global")>
					<cfset sForm["mm_global"] = StructNew() />
				</cfif>
				<!---
					if this is a nested call, i.e. multiple "_" in the name
					we may have a struct; in this case we replace the previous
					form scope with the structure
				 --->
				<cfif not isSimpleValue(formStruct[iiX])>
					<cfset sForm[cScopeName][cValueName] = formStruct[iiX]>
				<cfelseif arguments.skipEmpty and not len(formStruct[iiX])>
				<cfelseif arguments.subScope>
					<cfset cValueName = rereplace(iiX,"^.[^\_]*\_","") />
					<cfset sForm[cValueName] = formStruct[iiX]>
				<cfelse> 
					<cfset cScopeName = rereplace(iiX,"\_.*$","") />
					<cfset cValueName = rereplace(iiX,"^.[^\_]*\_","") />
					<cfset sGlobal[cValueName] = formStruct[iiX]>
				</cfif>
			</cfif>
			<cfcatch>
				<cfdump var="#cfcatch#"><cfabort>
			</cfcatch>
			</cftry>
		</cfloop>

		<cfif StructKeyExists(sForm,"mm_global")>
			<cfset structappend(sForm['mm_global'],sGlobal,true)>
	
			<cfif arguments.appendGlobal>
				<cfloop collection="#sForm#" item="iiX">
					<cfset structappend(sForm[iiX],sGlobal,true)>
				</cfloop>
			</cfif>
		</cfif>

		<!--- process multiple-"_" --->	
		<cfloop collection="#sSubScope#" item="iiX">
			<cfif iiX neq "mm_global" and StructKeyExists(sForm,iiX)>
				<cfset sForm[iiX] = scopeFormSubmission( sForm[iiX],arguments.skipEmpty,false,true )>
			</cfif>		
		</cfloop>
		<cfreturn sForm/>
	</cffunction>
</cfcomponent>