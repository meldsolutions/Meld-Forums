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
<cfcomponent displayname="mmImageRenderer" hint="renders images (resize, crop, etc.)" output="false">

	<cfset variables.instance = StructNew()>

<!--- --------------------------------------------------------------------------- --->
	<cffunction name="init" returntype="mmImageRenderer" output="false">
		<cfset variables.renderer = "cfimage">
		<cfreturn this>
	</cffunction>

	<cffunction name="processImageRenderBeans" access="public" returntype="void" output="false">
		<cfargument name="LargeImageRenderBean" type="any" required="true">
		<cfargument name="MediumImageRenderBean" type="any" required="false">
		<cfargument name="SmallImageRenderBean" type="any" required="false">

		<cfset processImageRenderBean( arguments.LargeImageRenderBean ) />

		<cfif StructKeyExists( arguments,"MediumImageRenderBean" )>
			<cfset processImageRenderBean( arguments.MediumImageRenderBean ) />
		</cfif>
		<cfif StructKeyExists( arguments,"SmallImageRenderBean" )>
			<cfset processImageRenderBean( arguments.SmallImageRenderBean ) />
		</cfif>
	</cffunction>

<!--- Crop,Resize,CropResize --->
	<cffunction name="processImageRenderBean" access="public" returntype="void" output="false">
		<cfargument name="ImageRenderBean" type="any" required="true">

		<cfswitch expression="#arguments.ImageRenderBean.getResizeType()#">
			<cfcase value="CropResize">
				<cfset doCropResize( arguments.ImageRenderBean )>
			</cfcase>
			<cfcase value="Crop">
				<cfset doCrop( arguments.ImageRenderBean )>
			</cfcase>
			<cfcase value="Resize">
				<cfset doResize( arguments.ImageRenderBean )>
			</cfcase>
		</cfswitch>				
	</cffunction>

	<!--- --------------------------------------------------------------------------- --->
	<cffunction name="getBinary" access="public" returntype="any" output="false">
		<cfargument name="filePath" type="string" required="true">

		<cfset var iImage = "">
		<cfif not fileexists(arguments.filePath)>
			<cfreturn>
		</cfif>
		<cfimage action="read" name="iImage" source="#arguments.filePath#" />

		<cfreturn iImage>
	</cffunction>

<!--- --------------------------------------------------------------------------- --->
	<cffunction name="doCropResize" returntype="void" access="public" output="false">
		<cfargument name="ImageRenderBean" type="any" required="yes">
	
		<cfset var iImage = arguments.ImageRenderBean.getBinary()>
		<cfset var args = "">

		<cfif iImage.width gt arguments.ImageRenderBean.getWidth() or iImage.height gt arguments.ImageRenderBean.getHeight()>
			<cfset arguments.ImageRenderBean.setAspectType( 'MaxAspectXY' ) />
			<cfset doResize( arguments.ImageRenderBean )>
		</cfif>
		<cfif iImage.width gt arguments.ImageRenderBean.getWidth() or iImage.height gt arguments.ImageRenderBean.getHeight()>
			<cfset doCrop( arguments.ImageRenderBean )>
		</cfif>
	</cffunction>

<!--- --------------------------------------------------------------------------- --->
<!--- CenterXY,CenterX,CenteryY,BestXY,Crop --->
	<cffunction name="doCrop" returntype="void" access="public" output="false">
		<cfargument name="ImageRenderBean" type="any" required="yes">

		<cfset var iImage		= arguments.ImageRenderBean.getBinary()>
		<cfset var nWidth		= arguments.ImageRenderBean.getWidth()>
		<cfset var nHeight		= arguments.ImageRenderBean.getHeight()>
		<cfset var nImageWidth	= iImage.width>
		<cfset var nImageHeight	= iImage.height>
		<cfset var nQuality		= arguments.ImageRenderBean.getQualityType()>
		<cfset var nOffsetX		= 0>
		<cfset var nOffsetY		= 0>
		<cfset var sCrop		= arguments.ImageRenderBean.getCropType()>

		<cfif arguments.ImageRenderBean.getCropType() eq "none" or (nImageWidth lte nWidth and nImageHeight lte nHeight)>
			<cfreturn>
		</cfif>

		<cfswitch expression="#sCrop#">
			<cfcase value="CenterXY">
				<cfif nImageWidth lt nWidth>
					<cfset nWidth = nImageWidth>
				<cfelseif nImageHeight lt nHeight>
					<cfset nHeight = nImageHeight>
				</cfif>
				<cfset nOffsetX = int((nImageWidth - nWidth)/2)>
				<cfset nOffsetY = int((nImageHeight - nHeight)/2)>
				<cfset ImageCrop(iImage,nOffsetX,nOffsetY,nWidth,nHeight)>
			</cfcase>
			<cfcase value="CenterX">
				<cfif nImageWidth lt nWidth>
					<cfset nWidth = nImageWidth>
				</cfif>
				<cfset nOffsetX = int((nImageWidth - nWidth)/2)>
				<cfset nOffsetY = 0>
				<cfset ImageCrop(iImage,nOffsetX,nOffsetY,nWidth,nHeight)>
			</cfcase>
			<cfcase value="CenterY">
				<cfif nImageHeight lt nHeight>
					<cfset nHeight = nImageHeight>
				</cfif>
				<cfset nOffsetX = 0>
				<cfset nOffsetY = int((nImageHeight - nHeight)/2)>
				<cfset ImageCrop(iImage,nOffsetX,nOffsetY,nWidth,nHeight)>
			</cfcase>
			<cfcase value="BestXY">
				<cfif nImageWidth-nWidth lt nImageHeight-nHeight>
					<cfset arguments.ImageRenderBean.setCropType( "CenterY" )>
					<cfset doCrop( arguments.ImageRenderBean )>
					<cfreturn>
				<cfelse>
					<cfset arguments.ImageRenderBean.setCropType( "CenterX" )>
					<cfset doCrop( arguments.ImageRenderBean )>
					<cfreturn>
				</cfif>
			</cfcase>
			<cfdefaultcase>
				<cfif nImageWidth lt nWidth>
					<cfset nWidth = nImageWidth>
				<cfelseif nImageHeight lt nHeight>
					<cfset nHeight = nImageHeight>
				</cfif>
				<cfset imageCrop(iImage,0,0,nWidth,nHeight)>
			</cfdefaultcase>
		</cfswitch>

		<!--- ColdFusion 1 pixel errors --->
		<cfif
			(abs(iImage.width - nWidth) neq 0 and abs(iImage.width - nWidth) lt 2)
			OR
			(abs(iImage.height - nHeight) neq 0 and abs(iImage.height - nHeight) lt 2)>
			<cfset ImageResize(iImage,nWidth,nHeight,nQuality)>
		</cfif>

		<cfset arguments.ImageRenderBean.setBinary( iImage ) />
	</cffunction>

<!--- --------------------------------------------------------------------------- --->
<!--- AspectXY,AspectX,AspectY,MaxAspectXY,Resize --->
	<cffunction name="doResize" returntype="void" access="public" output="false">
		<cfargument name="ImageRenderBean" type="any" required="yes">
	
		<cfset var iImage		= arguments.ImageRenderBean.getBinary()>
		<cfset var nWidth		= arguments.ImageRenderBean.getWidth()>
		<cfset var nHeight		= arguments.ImageRenderBean.getHeight()>
		<cfset var nImageWidth	= iImage.width>
		<cfset var nImageHeight	= iImage.height>
		<cfset var nQuality		= arguments.ImageRenderBean.getQualityType()>
		<cfset var sAspect		= arguments.ImageRenderBean.getAspectType()>

		<cfif arguments.ImageRenderBean.getAspectType() eq "none" or (nImageWidth lte nWidth and nImageHeight lte nHeight)>
			<cfreturn>
		</cfif>

		<cfswitch expression="#sAspect#">
			<cfcase value="AspectXY">
				<!--- image can't be reduced and maintain aspect --->
				<cfif nImageWidth lt nWidth or nImageHeight lt nHeight>
					<cfreturn>
				</cfif>
				<cfset ImageScaleToFit(iImage,nWidth,nHeight,nQuality)>
			</cfcase>
			<cfcase value="AspectX">
				<!--- image is all ready smaller across x --->
				<cfif nImageWidth lt nWidth>
					<cfset nWidth = nImageWidth>
				</cfif>
				<cfset ImageScaleToFit(iImage,nWidth,"",nQuality)>
			</cfcase>
			<cfcase value="AspectY">
				<!--- image is all ready smaller across y --->
				<cfif nImageHeight lt nHeight>
					<cfset nHeight = nImageHeight>
				</cfif>
				<cfset ImageScaleToFit(iImage,"",nHeight,nQuality)>
			</cfcase>
			<cfcase value="MaxAspectXY">
				<cfif nImageWidth lt nWidth or nImageHeight lt nHeight>
					<cfreturn>
				<cfelseif ceiling(nWidth/nImageWidth*nImageHeight) gt nHeight>
					<cfset nHeight = ceiling(nWidth/nImageWidth*nImageHeight)>
				<cfelse>
					<cfset nWidth = ceiling(nHeight/nImageHeight*nImageWidth)>
				</cfif>
				<cfset ImageResize(iImage,nWidth,nHeight,nQuality)>
				<!--- ColdFusion 1 pixel errors --->
				<cfif
					(abs(iImage.width - nWidth) neq 0 and abs(iImage.width - nWidth) lt 2)
					OR
					(abs(iImage.height - nHeight) neq 0 and abs(iImage.height - nHeight) lt 2)>
					<cfset ImageResize(iImage,nWidth,nHeight,nQuality)>
				</cfif>
			</cfcase>
			<cfdefaultcase>
				<!--- check if we only reduce along one dimension --->
				<cfif nImageWidth lt nWidth>
					<cfset nWidth = nImageWidth>
				<cfelseif nImageHeight lt nHeight>
					<cfset nHeight = nImageHeight>
				</cfif>
				<cfset ImageResize(iImage,nWidth,nHeight,nQuality)>
				<!--- ColdFusion 1 pixel errors --->
				<cfif
					(abs(iImage.width - nWidth) neq 0 and abs(iImage.width - nWidth) lt 2)
					OR
					(abs(iImage.height - nHeight) neq 0 and abs(iImage.height - nHeight) lt 2)>
					<cfset ImageResize(iImage,nWidth,nHeight,nQuality)>
				</cfif>
			</cfdefaultcase>
		</cfswitch>
		<cfset arguments.ImageRenderBean.setBinary( iImage ) />
	</cffunction>

	<cffunction name="createImageRenderBean" access="public" output="false" returntype="any">
		<cfargument name="Width" type="numeric" required="false" />
		<cfargument name="Height" type="numeric" required="false" />
		<cfargument name="ResizeType" type="string" required="false" />
		<cfargument name="QualityType" type="string" required="false" />
		<cfargument name="AspectType" type="string" required="false" />
		<cfargument name="CropType" type="string" required="false" />
		<cfargument name="Binary" type="any" required="false" />
				
		<cfset var ImageRenderBean = createObject("component","ImageRenderBean").init(argumentCollection=arguments) />
		<cfreturn ImageRenderBean />
	</cffunction>

<!--- --------------------------------------------------------------------------- --->
	<!--- --------------------------------------------------------------------------- --->
	<cffunction name="getFileManager" access="public" returntype="any" output="false">
		<cfreturn getMuraManager().getServiceFactory().getBean("FileManager")>
	</cffunction>

	<!--- --------------------------------------------------------------------------- --->
	<cffunction name="setMuraManager" access="public" returntype="any" output="false">
		<cfargument name="MuraManager" type="any" required="true">
		<cfset variables.MuraManager = arguments.MuraManager>
	</cffunction>
	<cffunction name="getMuraManager" access="public" returntype="any" output="false">
		<cfreturn variables.MuraManager>
	</cffunction>

	<cffunction name="getPluginDirectory" access="public" returntype="string" output="false">
		<cfreturn variables.pluginDirectory />
	</cffunction>
</cfcomponent>