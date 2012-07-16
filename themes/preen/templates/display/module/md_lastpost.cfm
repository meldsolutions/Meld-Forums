<cfsilent>
	<cfset local	= attributes.local />
	<cfset rc		= local.rc />
	<cfset attributes.user = rc.MFBean.getUser( attributes.postbean.getUserID() )>

	<cfparam name="attributes.showPostTitle" default="true">
</cfsilent><cfoutput>
		<ul class="meta">
			<cfif attributes.showPostTitle><li><a href="#rc.MFBean.getLastPostLink(attributes.postbean)#">#left(attributes.postbean.getTitle(),35)##iif(len(attributes.postbean.getTitle()) gt 35,de("..."),de(""))#</a></li></cfif>
			<li>#lsDateFormat(attributes.postbean.getDateLastUpdate(),session.datekeyformat)# #lsTimeFormat(attributes.postbean.getDateLastUpdate(),"short")# <a title="#rc.mmRBF.key('viewpost')#" href="#rc.MFBean.getLastPostLink(attributes.postbean)#">#rc.mmRBF.key('sortlink')#</a></li>
			<li><span class="heading">#rc.mmRBF.key('author')#:</span>
				<cfif attributes.user.beanExists()><a href="#rc.MFBean.getProfileLink(attributes.user.getUserID())#">#attributes.user.getScreenName()#</a>
				<cfelse>#rc.mmRBF.key('nulluser')#</cfif>
			</li>
		</ul>
</cfoutput>