<cfsilent>
	<cfset local.rc = rc />
</cfsilent>
<cfoutput>
	<div class="meld-forums-widget-loginout">
		<cfif rc.MFBean.isLoggedIn()>
			<cfset local.userBean	= rc.userBean />
			<h5>#rc.mmRBF.key('widget.loggedinas')#: #local.userBean.getScreenName()#</h5>
			<ul class="menu">
			<li><a class="submit btn" href="./?doaction=logout">#rc.mmRBF.key('widget.logout')#</a></li>
			<cfif findnocase("mf/profile",cgi.path_info)>
				<li><a class="submit btn" href="#rc.MFBean.getForumWebRoot()#">#rc.mmRBF.key('back')#</a></li>
			<cfelse>
				<li><a class="submit btn" href="#rc.MFBean.getProfileLink( local.userBean )#">#rc.mmRBF.key('widget.viewprofile')#</a></li>
			</cfif>
			</ul>
		<cfelse>
			<a class="submit btn" href="./?display=login">#rc.mmRBF.key('widget.login')#</a>
		</cfif>
	</div>
	
</cfoutput>