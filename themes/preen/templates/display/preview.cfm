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
<cfsilent>
	<cfset local.rc = rc />
</cfsilent>
<cfoutput>
	<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	<link rel="stylesheet" href="#rc.themeDirectory#assets/css/base.css" type="text/css" media="all">
	</head>
	<body>
	<div class="meld-forums preview">
	<table class="mf-post-block">
		<tr class="mf-post-contents">
			<td class="mf-content">
				<div class="message preview">
				<cfif isDefined("form.data") and len(form.data)><cfmodule template="/#rc.pluginConfig.getPackage()#/includes/utilities/parseBBML.cfm" ConvertSmilies="false">#trim(rereplace(replacelist(form.data,"<,>","&lt;,&gt;"),"
					|\n","#chr(13)##chr(10)#","all"))#</cfmodule><cfelse>#rc.mmRBF.key('preview_empty')#</cfif>
				</div>
			</td>
		</tr>
	</table>
	</div>
	</body>
	</html>
	<cfset request.layout = false>
</cfoutput>