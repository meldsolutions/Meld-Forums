<cfsilent>
<cfsetting enablecfoutputonly='true' />

<cfparam name="attributes.mode" 	default="input" />

<!--- START TAG --->
<cfif thisTag.executionMode eq 'start'>

	<!--- nothing was passed in by default --->
	<cfparam name="attributes.files" default="" />

	<cfif len(trim(attributes.files))>
		<cfif !structKeyExists(request,'jscriptfiles')>
			<cfset request.jscriptfiles = attributes.files />
		<cfelse>
			<cfset request.jscriptfiles = listAppend(request.jscriptfiles,attributes.files) />
		</cfif>
	</cfif>

</cfif>

<!--- END TAG --->
<cfif thisTag.executionMode eq 'end'>

	<!--- input mode --->
	<cfif attributes.mode eq 'input' >
		<cfif !structKeyExists(request,'javascript')>
			<cfset request.javascript = thisTag.generatedContent />
		<cfelse>
			<cfset request.javascript = request.javascript & thisTag.generatedContent />
		</cfif>
		<cfset thisTag.generatedContent = '' />

	<!--- output mode --->
	<cfelseif attributes.mode eq 'output' >

		<cfif structKeyExists(request,'jscriptfiles')>
			<cfloop list="#request.jscriptfiles#" index="jFile">
				<cfset thisTag.generatedContent = thisTag.generatedContent & '<script src="#jFile#?v=#getFileHash(jFile)#"></script>'/>
			</cfloop>
		</cfif>
		<!--- script to be included in page --->
		<cfif structKeyExists(request,'javascript')>
			<cfset thisTag.generatedContent = thisTag.generatedContent & '<script type="text/javascript">#request.javascript#</script>' />'
		</cfif>

	<!--- clear app scope for this tag --->
	<cfelseif attributes.mode eq 'clear' >
		<cfset structDelete(application,'jscriptFileHashes') />
	</cfif>

</cfif>

<cffunction name="getFileHash" returntype="string">
	<cfargument name="inFile" type="string" required="true" />
	<!--- create struct if needed --->
	<cfif !structKeyExists(application,'jscriptFileHashes')>
		<cfset application.jscriptFileHashes = structNew() />
	</cfif>
	<!--- populate if possible --->
	<cfif !structKeyExists(application.jscriptFileHashes,arguments.inFile)>
		<cftry>
			<cffile action="read" file="#expandPath('../wwwroot/' & arguments.inFile)#" variable="fileHash" />
			<cfset application.jscriptFileHashes[arguments.inFile] = hash(fileHash) />
			<cfcatch>
				<cfset application.jscriptFileHashes[arguments.inFile] = hash(getTickCount()) /><!--- failsafe --->
			</cfcatch>
		</cftry>
	</cfif>

	<cfreturn application.jscriptFileHashes[arguments.inFile] />
</cffunction>

<cfsetting enablecfoutputonly='false' />
</cfsilent>