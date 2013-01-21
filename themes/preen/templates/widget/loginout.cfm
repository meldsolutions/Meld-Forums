﻿<cfsilent>
	<cfset local.rc = rc />
</cfsilent>
<cfoutput>
	<div class="meld-forums-widget-loginout">
		<cfif rc.MFBean.isLoggedIn()>
			<cfset local.userBean	= rc.userBean />
			<h5>#rc.mmRBF.key('widget.loggedinas')#: #local.userBean.getScreenName()#</h5>
			<ul class="menu">
			<li><a class="submit btn" href="./?doaction=logout">#rc.mmRBF.key('widget.logout')#</a></li>
			<li><a class="submit btn" href="#rc.MFBean.getProfileLink( local.userBean )#">#rc.mmRBF.key('widget.viewprofile')#</a></li>
			</ul>
		<cfelse>
			<a class="submit btn" href="./?display=login">#rc.mmRBF.key('widget.login')#</a>
		</cfif>
	</div>
</cfoutput>