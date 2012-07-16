<cfoutput>
	<!--- 
		AVAILABLE: 
		rc.meldForumsBean
		rc.userBean			(post owner)
		rc.threadBean
		rc.postBean
		rc.mmRBF
		
		MERGE (subscribed user):
		[[INSERT_USERID]]
		[[INSERT_FIRSTNAME]]
		[[INSERT_LASTNAME]]
		[[INSERT_SCREENNAME]]
	--->
	#rc.mmRBF.key('fromuser')# #rc.userBean.getScreenName()#:
	 #chr(13)##chr(10)# 
	 #left( rc.postBean.getMessage(),100 )##iif( len( message ) gt 100,de("..."),de("") )#
		
	- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 	
		
	#rc.mmRBF.key('viewthread')#: #rc.meldForumsBean.getSiteWebRoot()##rc.meldForumsBean.getForumWebRoot()#viewthread/#rc.threadBean.getThreadID()#/?pp=#rc.postBean.getPostPosition()###p#rc.postBean.getPostPosition()#
		
	- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 	
		
	#rc.mmRBF.key('subscriptionoptions')#: #rc.meldForumsBean.getSiteWebRoot()##rc.meldForumsBean.getForumWebRoot()#panel/subscriptions/[[INSERTUSERID]]
</cfoutput>