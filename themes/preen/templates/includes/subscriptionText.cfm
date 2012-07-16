<cfset rc.postLink = $.siteConfig().getDomain() & $.globalConfig().getContext() & rc.MFBean.getPostLink(rc.threadBean,rc.postBean) & "/?pp=#rc.postBean.getPostPosition()###p#rc.postBean.getPostPosition()#" />
<cfset rc.unsubLink = $.siteConfig().getDomain() & $.globalConfig().getContext() & rc.MFBean.getSubscribeUrl(rc.threadBean.getThreadID(),"thread",1) />
<cfoutput>
	<p>[[FIRSTNAME]], this is your sub!</p>
	
	<blockquote>
	#left(rc.cleanMessage,100)#<cfif len(rc.cleanMessage) gt 100>...</cfif>
	</blockquote>
	
	<p><a href="http://#rc.postLink#">http://#rc.postLink#</a></p>
	<p>#rc.mmRBF.key('unsubscribelink')#: <a href="http://#rc.unsubLink#">http://#rc.unsubLink#</a></p>
</cfoutput>