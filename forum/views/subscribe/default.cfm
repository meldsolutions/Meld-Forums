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
<cfoutput>
	<cfif rc.success>
		<div class="notice">#rc.mmRBF.key('subscriptionstatus#rc.mode#')#</div>
	<cfelse>
		<div class="message">
			<div class="notice">#rc.mmRBF.key('unsubscribefailed')#</div>
			<cfif not isSimpleValue(rc.forumBean)>
				<h4>#rc.mmRBF.key('unsubscribe')# #rc.mmRBF.key('toforum')# <em>#rc.forumBean.getTitle()#</em></h4>
				<div class="message">
					#rc.MFBean.getSubscribeButton(rc.forumBean.getForumID(),'forum',1)#
					<br/>
				</div>
			</cfif>
		</div>
	</cfif>
</cfoutput>