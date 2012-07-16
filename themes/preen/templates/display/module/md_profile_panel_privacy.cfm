<cfsilent>
	<cfset local	= attributes.local />
	<cfset rc		= local.rc />
</cfsilent>
<cfoutput>
	<form id="mf-profile-form" class="mf-profile-form" action="./?panel=privacy" method="post" onsubmit="return validate(this);">
	<ul>
		<fieldset>
		<li class="checkbox">
			<input class="checkbox" type="checkbox" id="isPrivate" name="isPrivate" value="1" <cfif rc.userBean.getisPrivate() eq 1>CHECKED</cfif>>
			<label for="isPrivate">#rc.mmRBF.key('private')#<a href="##" class="tooltip">&nbsp;<span>#rc.mmRBF.key('private','tip')#</span></a></label><br />
		</li>
		<li class="checkbox">
			<input class="checkbox" type="checkbox" id="doReplyNotifications" name="doReplyNotifications" value="1" <cfif rc.userBean.getdoReplyNotifications() eq 1>CHECKED</cfif>>
			<label for="doReplyNotifications">#rc.mmRBF.key('replynotifications')#<a href="##" class="tooltip">&nbsp;<span>#rc.mmRBF.key('replynotifications','tip')#</span></a></label><br />
		</li>
		<li class="checkbox">
			<input class="checkbox" type="checkbox" id="doShowOnline" name="doShowOnline" value="1" <cfif rc.userBean.getdoShowOnline() eq 1>CHECKED</cfif>>
			<label for="doShowOnline">#rc.mmRBF.key('showonline')#<a href="##" class="tooltip">&nbsp;<span>#rc.mmRBF.key('showonline','tip')#</span></a></label><br />
		</li>
		</fieldset>
		<li>
			<input id="submit" class="submit" name="btAction" type="submit" value="#rc.mmRBF.key('submit')#" />
		</li>
	</ul>
	</form>
</cfoutput>