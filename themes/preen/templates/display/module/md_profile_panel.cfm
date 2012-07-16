<cfsilent>
	<cfset local	= attributes.local />
	<cfset rc		= local.rc />

	<cfset local.muraUserBean	= rc.userBean.getExternalUserBean() />
</cfsilent>
<cfoutput>
	<div class="clearfix">
	<dl class="mf-profile-details clearfix">
		<cfif rc.userBean.getIsBlocked()>
		<dt>#rc.mmRBF.key('isblocked')#:</dt>
		<dd><span class="highlight">#rc.mmRBF.key('yes')#</span><a href="##" class="tooltip">&nbsp;<span>#rc.mmRBF.key('isblocked')#</span></a></dd>
		</cfif>
		<dt>#rc.mmRBF.key('private')#:</dt>
		<dd><cfif rc.userBean.getIsPrivate()>#rc.mmRBF.key('yes')#<cfelse>#rc.mmRBF.key('no')#</cfif>
		<a href="##" class="tooltip">&nbsp;<span>#rc.mmRBF.key('isprivate')#</span></a>
		</dd>
		<dt>#rc.mmRBF.key('replynotifications')#:</dt>
		<dd><cfif rc.userBean.getdoReplyNotifications()>#rc.mmRBF.key('yes')#<cfelse>#rc.mmRBF.key('no')#</cfif>
		<a href="##" class="tooltip">&nbsp;<span>#rc.mmRBF.key('replynotifications')#</span></a>
		</dd>
		<dt>#rc.mmRBF.key('showonline')#:</dt>
		<dd><cfif rc.userBean.getDoShowOnline()>#rc.mmRBF.key('yes')#<cfelse>#rc.mmRBF.key('no')#</cfif></dd>
		<dt>#rc.mmRBF.key('user.name','mura')#:</dt>
		<dd>#local.muraUserBean.getFName()# #local.muraUserBean.getLName()#</dd>
		<dt>#rc.mmRBF.key('user.email','mura')#:</dt>
		<dd>#local.muraUserBean.getEmail()#</dd>
		<cfif local.muraUserBean.getAddresses().recordCount>
			<cfset attributes.qAddress = local.muraUserBean.getAddresses()>
			<dt>#rc.mmRBF.key('location')#:</dt>
			<dd><cfif len(attributes.qAddress.city[1])>#attributes.qAddress.city[1]#,</cfif> <cfif len(attributes.qAddress.state[1])>#attributes.qAddress.state[1]#,</cfif> #attributes.qAddress.country[1]#</dd>
		</cfif>
		<dt>#rc.mmRBF.key('user.website','mura')#:</dt>
		<dd>#local.muraUserBean.getWebsite()#</dd>
		<dt>#rc.mmRBF.key('user.company','mura')#:</dt>
		<dd>#local.muraUserBean.getCompany()#</dd>
		<dt>#rc.mmRBF.key('user.jobtitle','mura')#:</dt>
		<dd>#local.muraUserBean.getJobTitle()#</dd>
		<dt>#rc.mmRBF.key('user.interests','mura')#:</dt>
		<dd>#replace(local.muraUserBean.getInterests(),",",", ","all")#</dd>
	</dl>
	</div>
	<div class="clearfix">
		<h3>#rc.mmRBF.key('status')#</h3>
		<dl class="mf-profile-details clearfix">
			<dt>#rc.mmRBF.key('datejoined')#:</dt>
			<dd>#lsDateFormat(rc.userBean.getDateCreate(),session.datekeyformat)#</dd>
			<dt>#rc.mmRBF.key('datelastlogin')#:</dt>
			<dd>#lsDateFormat(rc.userBean.getDateLastLogin(),session.datekeyformat)#</dd>
			<dt>#rc.mmRBF.key('status')#:</dt>
			<dd><cfif rc.MFBean.getUserCache().IsOnline( rc.userBean.getUserID() )>#rc.mmRBF.key('online')#<cfelse>#rc.mmRBF.key('offline')#</cfif></dd>
		</dl>
	</div>
	<div class="clearfix">
		<h3>#rc.mmRBF.key('statistics')#</h3>
		<dl class="mf-profile-details clearfix">
			<dt>#rc.mmRBF.key('postcount')#:</dt>
			<dd>#rc.userBean.getPostCounter()#</dd>
			<dt>#rc.mmRBF.key('threadcount')#:</dt>
			<dd>#rc.userBean.getThreadCounter()#</dd>
		<cfif not isSimpleValue(rc.userBean.getThread())>
			<dt>#rc.mmRBF.key('lastThread')#:</dt>
			<dd><a href="#rc.MFBean.getThreadLink( rc.userBean.getThread() )#/">#lsDateFormat( rc.userBean.getThread().getDateCreate() ,session.datekeyformat)#, #lsTimeFormat( rc.userBean.getThread().getDateCreate(),"short")#</a></dd>
		</cfif>
		<cfif not isSimpleValue(rc.userBean.getPost())>
			<dt>#rc.mmRBF.key('lastpost')#:</dt>
			<dd><a href="#rc.MFBean.getLastPostLink( rc.userBean.getPost() )#">#lsDateFormat( rc.userBean.getPost().getDateCreate() ,session.datekeyformat)#, #lsTimeFormat( rc.userBean.getPost().getDateCreate(),"short")#</a></dd>
	</cfif>
	</dl>
</cfoutput>