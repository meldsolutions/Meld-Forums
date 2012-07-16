<cfsilent>
	<cfset attributes.rc			= rc />
	<cfset attributes.SettingsBean	= attributes.rc.meldForumsBean.getValue('SettingsBean') />
	<cfset attributes.userCache		= attributes.SettingsBean.getUserCache() />
</cfsilent>
<cfoutput>

<cfif attributes.externalUserBean.getInActive()>
<div class="columns2 profilepod clearfix">
	<div class="attention"><h4>#rc.mmRBF.key('disabledbyadministrator')#</h4></div>
</div>
</cfif>
<cfif not attributes.externalUserBean.getInActive() or attributes.rc.meldForumsBean.userHasFullPermissions()>
<div class="columns2 profilepod clearfix">
	<div class="col">
		<div id="personal" class="clearfix">
			<h3>#rc.mmRBF.key('aboutmember')# #attributes.profileUserBean.getScreenName()#</h3>
			<dl class="profile">
				<cfif not isSimpleValue(attributes.externalUserBean)>
					<cfif not attributes.profileUserBean.getIsPrivate()>
						<dt>#rc.mmRBF.key('user.name','mura')#:</dt>
						<dd>#attributes.externalUserBean.getFName()# #attributes.externalUserBean.getLName()#</dd>
						<cfif attributes.externalUserBean.getAddresses().recordCount>
							<cfset attributes.qAddress = attributes.externalUserBean.getAddresses()>
							<cfif len(attributes.qAddress.city[1])>
							<dt>#rc.mmRBF.key('location')#:</dt>
							<dd>#attributes.qAddress.city[1]#, #attributes.qAddress.state[1]#,  #attributes.qAddress.country[1]#</dd>
							</cfif>
							<dt>#rc.mmRBF.key('params.imservice')#:</dt>
							<dd>#attributes.externalUserBean.getimservice()# <cfif len(attributes.externalUserBean.getimname())>: #attributes.externalUserBean.getimname()#</cfif></dd>
						</cfif>
					</cfif>
				<dt>#rc.mmRBF.key('user.company','mura')#:</dt>
				<dd>#attributes.externalUserBean.getCompany()#</dd>
				<dt>#rc.mmRBF.key('user.jobtitle','mura')#:</dt>
				<dd>#attributes.externalUserBean.getJobTitle()#</dd>
				<cfif attributes.profileUserBean.getIsConfirmed()>
				<dt>#rc.mmRBF.key('user.website','mura')#:</dt>
				<dd>#attributes.externalUserBean.getWebsite()#</dd>
				</cfif>
				<dt>#rc.mmRBF.key('user.interests','mura')#:</dt>
				<dd>#replace(attributes.externalUserBean.getInterests(),",",", ","all")#</dd>
			</dl>
			</cfif>
		</div>
	</div>
	<div class="col">
		<div class="avatarFull clearfix">
			<cfif len(attributes.profileUserBean.getAvatarID() )>
			<img src="#attributes.rc.meldForumsBean.getSiteWebRoot()#/tasks/render/medium/?fileID=#attributes.profileUserBean.getAvatarID()#"
				class="avatar" alt="#rc.mmRBF.key('avatar')#" />
			<cfelse>
			<img src="#attributes.rc.meldForumsBean.getSiteWebRoot()#/tasks/render/medium/?fileID=#attributes.settingsBean.getAvatarID()#"
				class="avatar" alt="#rc.mmRBF.key('avatar')#" />
			</cfif>
		</div>	
	</div>
</div>
<div class="columns2 profilepod clearfix">
	<div class="col">
		<div id="account" class="clearfix">
			<h3>#rc.mmRBF.key('status')#</h3>
			<dl class="profile">
				<dt>#rc.mmRBF.key('datejoined')#:</dt>
				<dd>#lsDateFormat(attributes.profileUserBean.getDateCreate(),session.datekeyformat)#</dd>
				<dt>#rc.mmRBF.key('datelastlogin')#:</dt>
				<dd>#lsDateFormat(attributes.profileUserBean.getDateLastLogin(),session.datekeyformat)#</dd>
				<dt>#rc.mmRBF.key('status')#:</dt>
				<dd><cfif attributes.userCache.IsOnline( attributes.profileUserBean.getUserID() )>#rc.mmRBF.key('online')#<cfelse>#rc.mmRBF.key('offline')#</cfif></dd>
			</dl>
		</div>
	</div>
	<div class="col">
		<div id="statistics" class="clearfix">
			<h3>#rc.mmRBF.key('statistics')#</h3>
			<dl class="profile">
				<dt>#rc.mmRBF.key('postcount')#:</dt>
				<dd>#attributes.profileUserBean.getPostCounter()#</dd>
				<dt>#rc.mmRBF.key('threadcount')#:</dt>
				<dd>#attributes.profileUserBean.getThreadCounter()#</dd>
			<cfif not isSimpleValue(attributes.profileUserBean.getThread())>
				<dt>#rc.mmRBF.key('lastThread')#:</dt>
				<dd><a href="#attributes.rc.meldForumsBean.getForumWebRoot()#viewThread/#attributes.profileUserBean.getThread().getThreadID()#/">#lsDateFormat( attributes.profileUserBean.getThread().getDateCreate() ,session.datekeyformat)#, #lsTimeFormat( attributes.profileUserBean.getThread().getDateCreate(),"short")#</a></dd>
			</cfif>
			<cfif not isSimpleValue(attributes.profileUserBean.getPost())>
				<dt>#rc.mmRBF.key('lastpost')#:</dt>
				<dd><a href="#attributes.rc.meldForumsBean.getForumWebRoot()#viewThread/#attributes.profileUserBean.getPost().getThreadID()#/#attributes.profileUserBean.getPost().getPostPosition()#/">#lsDateFormat( attributes.profileUserBean.getPost().getDateCreate() ,session.datekeyformat)#, #lsTimeFormat( attributes.profileUserBean.getPost().getDateCreate(),"short")#</a></dd>
			</cfif>
			</dl>
		</div>
	</div>
</div>
</cfif>
