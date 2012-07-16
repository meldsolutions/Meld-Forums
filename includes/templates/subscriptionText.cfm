	<!--- 
		AVAILABLE: 
		rc.MFBean			(MeldForumsBean)
		rc.userBean			(post owner)
		rc.forumBean
		rc.threadBean
		rc.postBean
		rc.mmRBF
		rc.notifyType	(either post or thread)
		rc.cleanMessage (post message stripped of html/bbml)
		rc.postLink		(link to post)
		rc.unsubLink	(unsubscribe link)
		
		MERGE (subscribed user):
		[[INSERT_USERID]]
		[[INSERT_FIRSTNAME]]
		[[INSERT_LASTNAME]]
		[[INSERT_SCREENNAME]]
	--->
<cfoutput>
	<p>#rc.mmRBF.key('hello')# [[FIRSTNAME]],</p>
	<p>#rc.mmRBF.key('new#rc.notifyType#in')# <strong>#rc.forumBean.getTitle()#</strong> &raquo; <strong>#rc.threadBean.getTitle()#</strong></p>
	<blockquote>
	#left(rc.cleanMessage,100)#<cfif len(rc.cleanMessage) gt 100>...</cfif>
	</blockquote>
	
	<p><a href="http://#rc.postLink#">http://#rc.postLink#</a></p>
	<p>#rc.mmRBF.key('unsubscribelink')#: <a href="http://#rc.unsubLink#">http://#rc.unsubLink#</a></p>
</cfoutput>