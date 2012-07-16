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
<cfcomponent extends="mura.plugin.pluginGenericEventHandler">

		<cffunction name="onApplicationLoad">
		<cfargument name="$">
		<cfset variables.pluginConfig.addEventHandler(this)>
	</cffunction>

<!---
	<cffunction name="onMeldForumsDisplayConferenceForum">
		<cfargument name="$">
		
		<cfset var sStruct = StructNew() />
		<cfset var content = $.event().getValue("content") />
		
		<cfset structInsert( sStruct,"25","second<br>") />
		<cfset structInsert( sStruct,"4","first<br>") />
		<cfset structInsert( sStruct,"1322","third<br>") />
		
		<cfset StructAppend( content.stats,sStruct ) />
	</cffunction>

	<cffunction name="onMeldForumsDoWelcome">
		<cfargument name="$">
		
		<!---<cfset $.event('relocateURL',"http://www.meldsolutions.com") />--->
		<cfset $.event('relocate',false) />
		<cfset $.event('message','I am the welcome message') />
	</cffunction>

	<cffunction name="onMeldForumsPostButtonBarLLRender">
		<cfargument name="$">
		
		<cfset var button = "" />
		
		<cfif $.event('context') eq "forum" or $.event('context') eq "thread">
		<cfsavecontent variable="button" >
			<a class="submit newpost" href=""><span>Button</span></a>			
			<a class="submit newpost" href=""><span>Button</span></a>			
			<a class="submit newpost" href=""><span>Button</span></a>			
			<a class="submit newpost" href=""><span>Button</span></a>			
		</cfsavecontent>
		</cfif>
		<cfreturn button />
	</cffunction>


	<cffunction name="onMeldForumsDisplayConference">
		<cfargument name="$">
		
		<cfset var labels = $.event().getValue("labels") />

		<cfset labels.lastpost = "My Last Posts" />
		
	</cffunction>
	<cffunction name="onMeldForumsPostSignatureRender">
		<cfargument name="$">
	
		<cfset var sStr = "" />
		<cfsavecontent variable="sStr">
		<cfoutput>
		<p>This is the signature of #$.currentUser('screenname')#</p>
		#$.currentUser('signature')#
		</cfoutput>			
		</cfsavecontent>
		<cfreturn sStr />
	</cffunction>


	<cffunction name="onMeldForumsForumThreadIconRender">
		<cfargument name="$">
	
		<cfset var sStr = "" />
		<cfsavecontent variable="sStr">
<cfoutput><div style="width: 30px;height: 30px" class="mf-block-icon type#$.event().getValue('threadBean').getTypeID()#"</div></cfoutput>			
		</cfsavecontent>
		<cfreturn sStr />
	</cffunction>

	<cffunction name="onMeldForumsAttachmentRender" output="false">
		<cfargument name="$">
		<cfset variables.count = variables.count+1 />
				
		<cfreturn "#createUUID()#<br>"/>		
	</cffunction>

	<!---
	EXAMPLE: 
	
	replaces default image attachment rendering with custom rendering
	--->

	<cffunction name="onMeldForumsAttachmentRender">
		<cfargument name="$">
		
		<cfset var attach	= $.event('attachment') />
		<cfset var file		= $.event('file') />
		<cfset var rContent = "" />
		<cfset var image1	= "" />
		<cfset var image2	= "" />

		<cfset variables.count = variables.count+1 />

		<cfif file.contentType eq 'image'>
			<cfset image1 = $.createHREFForImage(siteid=file.siteID,fileid=file.fileID,fileExt=file.fileExt,width=100,height=50) />
			<cfset image2 = $.createHREFForImage(siteid=file.siteID,fileid=file.fileID,fileExt=file.fileExt,width=200,height=100) />
	
			<cfsavecontent variable="rContent">
				<cfoutput><img src="#image1#"><p>[#image1#]</p></cfoutput>
				<cfoutput><img src="#image2#"><p>[#image2#]</p></cfoutput>
			</cfsavecontent>
			<cfreturn rContent />
		</cfif>
		
	</cffunction>
--->

	<cffunction name="getFrameworkConfig" output="false">
		<cfset var framework = StructNew() />

		<cfinclude template="../../frameworkConfig.cfm" />
		<cfreturn framework />		
	</cffunction>
</cfcomponent>