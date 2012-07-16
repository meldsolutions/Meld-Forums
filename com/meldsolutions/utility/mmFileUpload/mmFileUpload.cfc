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
<cfcomponent displayname="mmFileUpload" hint="Manages File Upload, Delete, etc." output="false">

	<cfset variables.instance = StructNew()>

	<cffunction name="init" returntype="mmFileUpload" access="public" output="false">
		<cfargument name="tempDirectory" type="string" required="false" default="">
		<cfargument name="fileDirectory" type="string" required="false" default="">

		<cfset variables.tempDirectory = arguments.tempDirectory>
		<cfset variables.fileDirectory = arguments.fileDirectory>

		<cfreturn this>
	</cffunction>
	
	<cffunction name="uploadFile" access="public" returntype="string" output="false">
		<cfargument name="FormField" type="string" required="true">
		<cfargument name="FileUploadBean" type="any" required="true">
	
		<cfset var fileObj	= "">
		<cfset var file		= doUpload( argumentCollection=arguments )>
		<cfset var sArgs	= StructNew() />

		<cfif not isStruct(file)>
			<cfreturn false>
		</cfif>

		<cffile action="readBinary"
			file="#getTempDir()#/#file.serverfile#"
			variable="fileObj" />

		<cfset arguments.FileUploadBean.setFileData( file ) />
		<cfset arguments.FileUploadBean.setLargeFile( fileObj ) />

		<cfif FileUploadBean.getDoclearPrevious()>
			<cfset deleteFileByContentID( arguments.FileUploadBean.getContentID() )>
		</cfif>
		
		<cfset fileID = doCreateMuraFile( arguments.FileUploadBean )>
		
		<cfreturn fileID>
	</cffunction>
	
	<cffunction name="uploadImage" access="public" returntype="string" output="false">
		<cfargument name="FormField" type="string" required="true">
		<cfargument name="FileUploadBean" type="any" required="true">
		<cfargument name="LargeImageRenderBean" type="any" required="true">
		<cfargument name="MediumImageRenderBean" type="any" required="false">
		<cfargument name="SmallImageRenderBean" type="any" required="false">
	
		<cfset var file		= doUpload( argumentCollection=arguments )>

		<cfif not isStruct(file) or not isImageFile( "#getTempDir()#/#file.serverfile#" ) >
			<cfreturn false>
		</cfif>

		<cfset arguments.FileUploadBean.setFileData( file ) />
		<cfset arguments.FileUploadBean.setFilePath( "#getTempDir()##file.serverfile#" ) />

		<cfif FileUploadBean.getDoclearPrevious()>
			<cfset deleteFileByContentID( arguments.FileUploadBean.getContentID() )>
		</cfif>

		<cfset fileID = doCreateMuraImage( argumentCollection=arguments )>
		
		<cfreturn fileID>
	</cffunction>
	
	<cffunction name="processLocalImage" access="public" returntype="string" output="false">
		<cfargument name="FileID" type="string" required="true">
		<cfargument name="ContentID" type="string" required="true">
		<cfargument name="LargeImageRenderBean" type="any" required="true">
		<cfargument name="MediumImageRenderBean" type="any" required="false">
		<cfargument name="SmallImageRenderBean" type="any" required="false">
		<cfargument name="MuraFileID" type="string" required="false">
	
		<cfset var imgFile			= ""/>
		<cfset var fileMeta			= getMuraFileManager().read( arguments.fileID,false )/>
		<cfset var filePath			= "#variables.fileDirectory#/#fileMeta.SiteID#/cache/file/#arguments.FileID#.#fileMeta.fileExt#">
		<cfset var sArgs			= StructNew() />
		<cfset var sFileData		= StructNew() />
		<cfset var fileUploadBean	= "" /> 

		<cfset sFileData.clientFile		= fileMeta.filename />
		<cfset sFileData.serverFileExt	= fileMeta.fileExt />
		<cfset sFileData.contentType	= fileMeta.contentType />
		<cfset sFileData.ContentSubType	= fileMeta.contentSubType />
		<cfset sFileData.FileSize		= fileMeta.fileSize />

		<cfset sArgs.siteID				= fileMeta.siteID />
		<cfset sArgs.moduleID			= fileMeta.moduleID />
		<cfset sArgs.contentID			= arguments.contentID />
		<cfset sArgs.fileName			= fileMeta.siteID />
		<cfset sArgs.siteID				= fileMeta.siteID />
		<cfset sArgs.DoClearPrevious	= false />
		<cfset sArgs.FilePath			= filePath />
		<cfset sArgs.DoClearPrevious	= false />
		<cfset sArgs.FileData			= sFileData />
		<cfif structKeyExists(arguments,"MuraFileID")>
			<cfset sArgs.MuraFileID		= arguments.MuraFileID />
		</cfif>

		<cfset fileUploadBean = createFileUploadBean( argumentCollection=sArgs ) />

		<cfset arguments.fileUploadBean = fileUploadBean />

		<cfset fileID = doRenderMuraImage( argumentCollection=arguments )>
		
		<cfreturn fileID>
	</cffunction>

	<cffunction name="doUpload" access="private" returntype="struct" output="false">
		<cfargument name="FormField" type="string" required="true">
		<cfargument name="FileUploadBean" type="any" required="true">
	
		<cfset var barredFileTypes	= "html,htm,php,php2,php3,php4,php5,phtml,pwml,inc,asp,aspx,ascx,jsp,cfm,cfml,cfc,pl,bat,exe,com,dll,vbs,js,reg,cgi,htaccess,asis,sh,shtml,shtm,phtm,ade,adp,app,asa,ashx,asmx,asp,bas,bat,cdx,cer,chm,class,cmd,com,config,cpl,crt,csh,dll,exe,fxp,hlp,hta,htr,htw,ida,idc,idq,ins,isp,its,jse,ksh,lnk,mad,maf,mag,mam,maq,mar,mas,mat,mau,mav,maw,mda,mdb,mde,mdt,mdw,mdz,msc,msh,msh1,msh1xml,msh2,msh2xml,mshxml,msi,msp,mst,ops,pcd,pif,prf,prg,printer,pst,reg,rem,scf,scr,sct,shb,shs,soap,stm,url,vb,vbe,vbs,ws,wsc,wsf,wsh">
		<cfset var fileID			= "">

		<cffile action="upload"
			filefield=#arguments.FormField#
			destination="#getTempDir()#"
			nameconflict="makeunique"/>

		<cfif not listFindNoCase(arguments.FileUploadBean.getAllowedExtensions(),cffile.ServerFileExt)>
			<cfset deleteFile("#getTempDir()#/#cffile.ServerFile#")>
			<cfthrow type="custom" message="#getmmResourceBundle().key('filetypenotallowed','error')# #replace(arguments.FileUploadBean.getAllowedExtensions(),",",", ","all")#" errorcode="2501">
			<cfreturn>
		<cfelseif listFindNoCase("png,gif,jpg,jpeg",cffile.ServerFileExt) and not isImageFile("#getTempDir()#/#file.ServerFile#")>
			<cfset deleteFile("#getTempDir()#/#cffile.ServerFile#")>
			<cfthrow type="custom" message="#getmmResourceBundle().key('filenotimage','error')#" errorcode="2502">
			<cfreturn>
		<cfelseif listFindNoCase(barredFileTypes,cffile.ServerFileExt)>
			<cfset deleteFile("#getTempDir()#/#cffile.ServerFile#")>
			<cfthrow type="custom" message="#getmmResourceBundle().key('filetypebarred','error')#" errorcode="2503">
			<cfreturn>
		<cfelseif cffile.FileSize gt arguments.FileUploadBean.getFileSizeLimit()*1000>
			<cfset deleteFile("#getTempDir()#/#cffile.ServerFile#")>
			<cfthrow type="custom" message="#getmmResourceBundle().key('filetoolarge','error')#: #int(cffile.FileSize/1000)# #getmmResourceBundle().key('kilobytes')# (#getmmResourceBundle().key('maxfilesizeallowedis')# #int(arguments.FileUploadBean.getFileSizeLimit())# #getmmResourceBundle().key('kilobytes')#)" errorcode="2504">
			<cfreturn>
		</cfif>

		<cfset cleanTempDirectory()>
		
		<cfreturn cffile>
	</cffunction>

	<cffunction name="doCreateMuraImage" access="public" returntype="string" output="false">
		<cfargument name="FileUploadBean" type="any" required="true">
		<cfargument name="LargeImageRenderBean" type="any" required="true">
		<cfargument name="MediumImageRenderBean" type="any" required="false">
		<cfargument name="SmallImageRenderBean" type="any" required="false">

		<cfset var fileID			= "">
		<cfset var filePath			= arguments.FileUploadBean.getFilePath()>
		<cfset var fileExt			= arguments.FileUploadBean.getFileData().serverFileExt>
		<cfset var sArgs			= StructNew()>
		<cfset var tName			= CreateUUID() />

		<!--- binary images --->
		<cfset arguments.LargeImageRenderBean.setBinary( getmmImageRenderer().getBinary( filePath ) ) />
		<cfset getmmImageRenderer().processImageRenderBean( arguments.LargeImageRenderBean )>

		<!--- to save LOTS of processing time, we are going to write the newly sized image and use that to create our medium/small --->
		<cfif StructKeyExists( arguments,"MediumImageRenderBean" ) or StructKeyExists( arguments,"SmallImageRenderBean" )>
			<cfimage
				action="write"
				destination="#getTempDir()##tName#.#fileExt#"
				source="#arguments.LargeImageRenderBean.getBinary()#"
				quality="1">
		</cfif>
		
		<cfif StructKeyExists( arguments,"MediumImageRenderBean" )>
			<cfset arguments.MediumImageRenderBean.setBinary( getmmImageRenderer().getBinary( "#getTempDir()##tName#.#fileExt#" ) ) />
			<cfset getmmImageRenderer().processImageRenderBean( arguments.MediumImageRenderBean )>
		</cfif>
		<cfif StructKeyExists( arguments,"SmallImageRenderBean" )>
			<cfset arguments.SmallImageRenderBean.setBinary( getmmImageRenderer().getBinary( "#getTempDir()##tName#.#fileExt#" ) ) />
			<cfset getmmImageRenderer().processImageRenderBean( arguments.SmallImageRenderBean )>
		</cfif>
		
		<cfset doRenderImagesToBinary( argumentCollection=arguments )>
		<cfset fileID = doCreateMuraFile( arguments.FileUploadBean ) />
		<cfreturn fileID>
	</cffunction>

	<cffunction name="doRenderMuraImage" access="public" returntype="string" output="false">
		<cfargument name="FileUploadBean" type="any" required="true">
		<cfargument name="LargeImageRenderBean" type="any" required="true">
		<cfargument name="MediumImageRenderBean" type="any" required="false">
		<cfargument name="SmallImageRenderBean" type="any" required="false">

		<cfset var fileID			= "">
		<cfset var filePath			= arguments.FileUploadBean.getFilePath()>
		<cfset var fileExt			= arguments.FileUploadBean.getFileData().serverFileExt>
		<cfset var sArgs			= StructNew()>
		<cfset var tName			= CreateUUID() />

		<!--- binary images --->
		<cfset arguments.LargeImageRenderBean.setBinary( getmmImageRenderer().getBinary( filePath ) ) />
		<cfset getmmImageRenderer().processImageRenderBean( arguments.LargeImageRenderBean )>
		
		<cfif StructKeyExists( arguments,"MediumImageRenderBean" )>
			<cfset arguments.MediumImageRenderBean.setBinary( getmmImageRenderer().getBinary( filePath ) ) />
			<cfset getmmImageRenderer().processImageRenderBean( arguments.MediumImageRenderBean )>
		</cfif>
		<cfif StructKeyExists( arguments,"SmallImageRenderBean" )>
			<cfset arguments.SmallImageRenderBean.setBinary( getmmImageRenderer().getBinary( filePath ) ) />
			<cfset getmmImageRenderer().processImageRenderBean( arguments.SmallImageRenderBean )>
		</cfif>
		
		<cfset doRenderImagesToBinary( argumentCollection=arguments )>
		<cfset fileID = doCreateMuraFile( arguments.FileUploadBean ) />
		<cfreturn fileID>
	</cffunction>


	<cffunction name="doCreateMuraFile" access="private" returntype="string" output="false">
		<cfargument name="FileUploadBean" type="any" required="true">

		<cfset var sArgs		= StructNew() />
		<cfset var fileData		= arguments.FileUploadBean.getFileData() />

		<!--- mura filemanager.create() struct --->
		<cfif len( arguments.fileUploadBean.getMuraFileID() )>
			<cfset sArgs.fileID			= arguments.FileUploadBean.getMuraFileID() />
		</cfif>
		<cfset sArgs.fileObj			= arguments.FileUploadBean.getLargeFile() />
		<cfset sArgs.contentID			= arguments.FileUploadBean.getContentID() />
		<cfset sArgs.siteID				= arguments.FileUploadBean.getSiteID() />
		<cfset sArgs.fileName			= fileData.ClientFile />
		<cfset sArgs.contentType		= fileData.ContentType />
		<cfset sArgs.ContentSubType		= fileData.ContentSubType />
		<cfset sArgs.FileSize			= fileData.FileSize />
		<cfset sArgs.moduleID			= arguments.FileUploadBean.getModuleID() />
		<cfset sArgs.fileExt			= fileData.serverFileExt />
		<cfset sArgs.fileObjSmall		= arguments.FileUploadBean.getSmallFile() />
		<cfset sArgs.fileObjMedium		= arguments.FileUploadBean.getMediumFile() />

		<cfreturn getMuraFileManager().create( argumentCollection=sArgs ) />
	</cffunction>

	<cffunction name="doRenderImagesToBinary" access="public" returntype="void" output="false">
		<cfargument name="FileUploadBean" type="any" required="true">
		<cfargument name="LargeImageRenderBean" type="any" required="true">
		<cfargument name="MediumImageRenderBean" type="any" required="false">
		<cfargument name="SmallImageRenderBean" type="any" required="false">

		<cfset var imageStruct	= StructNew()>
		<cfset var img			= "">
		<cfset var iName		= "">
		<cfset var fileObj		= "">
		<cfset var fileExt		= arguments.FileUploadBean.getFileData().ServerFileExt>		
		<cfset var tryCT		= 0>		
		<cfset var thread		= CreateObject("java", "java.lang.Thread")>
		
		<cfset imageStruct['large'] = LargeImageRenderBean.getBinary() />
		<cfif StructKeyExists( arguments,"MediumImageRenderBean" )>
			<cfset imageStruct['medium'] = MediumImageRenderBean.getBinary() />
		</cfif>
		<cfif StructKeyExists( arguments,"SmallImageRenderBean" )>
			<cfset imageStruct['small'] = SmallImageRenderBean.getBinary() />
		</cfif>
		
		<cfloop collection="#imageStruct#" item="img">
			<cfset iName = createUUID() & "img">
			<!--- this sad dance is because Mac/CF cfimage does not support writing gif
				(at least not in CF9) --->
			<cfif fileExt eq "gif" and not listfindnocase(getWriteableImageFormats(),"gif")>
				<cfimage
					action="write"
					destination="#getTempDir()#/#iName#.png"
					source="#imageStruct[img]#"
					quality="1">
				<cffile
					action="rename"
					source="#getTempDir()#/#iName#.png"
					destination="#iName#.gif">
			<cfelse>
				<cfimage
					action="write"
					destination="#getTempDir()##iName#.#fileExt#"
					source="#imageStruct[img]#"
					quality="1">
			</cfif>
			
			<cffile action="readBinary"
				file="#getTempDir()##iName#.#fileExt#"
				variable="fileObj" />
			
			<cfswitch expression="#img#">
				<cfcase value="large">
					<cfset arguments.FileUploadBean.setLargeFile( fileObj ) />
				</cfcase>
				<cfcase value="medium">
					<cfset arguments.FileUploadBean.setMediumFile( fileObj ) />
				</cfcase>
				<cfcase value="small">
					<cfset arguments.FileUploadBean.setSmallFile( fileObj ) />
				</cfcase>
			</cfswitch>
			<!--- we have read in the binary data, so we can delete the file we just created --->

			<cftry>
			<cffile
				action="delete"
				file="#getTempDir()##iName#.#fileExt#">
			<cfcatch></cfcatch>
			</cftry>

			<cfset cleanTempDirectory() />
		</cfloop>
	</cffunction>

	<cffunction name="readFileData" access="public" returntype="any" output="false">
		<cfargument name="filePath" type="string" required="yes">

		<cfset var bContent = "">
		<cfset var dir		= rereplace(arguments.filePath,"(.*[\\|\/]).*","\1")>
		<cfset var file		= rereplace(arguments.filePath,".*[\\|\/]","")>

		<cftry>
		<cfdirectory action="list"
			directory="#dir#"
			name="bContent"
			filter="#file#" />
		<cfcatch><cfreturn ""></cfcatch></cftry>
		
		<cfreturn bContent>
	</cffunction>

	<cffunction name="deleteFileByContentID" access="public" returntype="boolean" output="false">
		<cfargument name="contentID" type="string" required="true">

		<cfset getMuraFileManager().deleteAll( arguments.contentID )>
		
		<cfreturn true>
	</cffunction>

	<cffunction name="deleteFileByFileID" access="public" returntype="boolean" output="false">
		<cfargument name="fileID" type="string" required="true">

		<cfset getMuraFileManager().deleteVersion( arguments.fileID )>
		
		<cfreturn true>
	</cffunction>

	<cffunction name="deleteFile" access="public" returntype="boolean" output="false">
		<cfargument name="source" type="string" required="yes">

		<cftry>
		<cffile action="delete" file="#arguments.source#">
		<cfcatch><cfreturn false></cfcatch></cftry>
		
		<cfset cleanTempDirectory() />
		
		<cfreturn true>
	</cffunction>

	<cffunction name="cleanTempDirectory" access="public" returntype="void" output="false">
		<cfset var dirList = "">
		<cfdirectory action="list" directory="#getTempDir()#" name="dirList">
		
		<cfloop query="dirList">
			<cfif type eq "file" AND dateDiff('n',dateLastModified,now()) gt 5>
				<cftry>
				<cffile action="delete" file="#getTempDir()#/#name#">
				<cfcatch></cfcatch></cftry>
			</cfif>
		</cfloop>
	</cffunction>

	<cffunction name="createFileUploadBean" access="public" output="false" returntype="any">
		<cfargument name="SiteID" type="string" required="false" />
		<cfargument name="ModuleID" type="string" required="false" />
		<cfargument name="ContentID" type="string" required="false" />
		<cfargument name="FileSizeLimit" type="numeric" required="false" />
		<cfargument name="AllowedExtensions" type="string" required="false" />
		<cfargument name="DoClearPrevious" type="boolean" required="false" />
		<cfargument name="fileName" type="string" required="false" />
		<cfargument name="FilePath" type="string" required="false" />
		<cfargument name="FileData" type="struct" required="false" />
		
		<cfset var FileUploadBean = createObject("component","FileUploadBean").init(argumentCollection=arguments) />
		<cfreturn FileUploadBean />
	</cffunction>

	<cffunction name="getTempDir" access="private" output="false" returntype="any">
		<cfif len( variables.tempDirectory )>
			<cfreturn variables.tempDirectory />
		<cfelse>
			<cfreturn getTempDirectory() />
		</cfif>
	</cffunction>

	<cffunction name="getMuraFileManager" access="public" output="false" returntype="any">
		<cfreturn getMuraManager().getBean("FileManager") />
	</cffunction>

	<cffunction name="getmmImageRenderer" access="public" output="false" returntype="any">
		<cfreturn variables.mmImageRenderer />
	</cffunction>
	<cffunction name="setmmImageRenderer" access="public" output="false" returntype="void">
		<cfargument name="mmImageRenderer" type="any" required="true" />
		<cfset variables.mmImageRenderer = arguments.mmImageRenderer />
	</cffunction>

	<cffunction name="getmmResourceBundle" access="public" output="false" returntype="any">
		<cfreturn variables.mmResourceBundle />
	</cffunction>
	<cffunction name="setmmResourceBundle" access="public" output="false" returntype="void">
		<cfargument name="mmResourceBundle" type="any" required="true" />
		<cfset variables.mmResourceBundle = arguments.mmResourceBundle />
	</cffunction>

	<cffunction name="getMuraManager" access="public" output="false" returntype="any">
		<cfreturn variables.MuraManager />
	</cffunction>
	<cffunction name="setMuraManager" access="public" output="false" returntype="void">
		<cfargument name="MuraManager" type="any" required="true" />
		<cfset variables.MuraManager = arguments.MuraManager />
	</cffunction>
</cfcomponent>