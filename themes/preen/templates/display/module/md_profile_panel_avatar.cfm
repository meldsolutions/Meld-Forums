<cfsilent>
	<cfset local	= attributes.local />
	<cfset rc		= local.rc />	
</cfsilent>
<cfoutput>
	<form id="mf-profile-form" class="mf-profile-form" action="./?panel=avatar" method="post" enctype="multipart/form-data">
	<ul>
		<fieldset>
		<li class="req">
			<label for="email">#rc.mmRBF.key('avatar')#</label>
			<input type="file" maxlength="50" id="avatarFile" name="avatarFile" />
		</li>
		<cfif len( rc.userBean.getAvatarID() )>
		<li>
			#rc.MFBean.getAvatarImage(userBean=rc.userBean,height=rc.MFBean.getTheme().getAvatarMediumHeight(),width=rc.MFBean.getTheme().getAvatarMediumWidth())#
		</li>
		<li class="checkbox">
			<input class="checkbox" type="checkbox" id="doDeleteAvatar" name="doDeleteAvatar" value="1">
			<label for="doDeleteAvatar">#rc.mmRBF.key('deleteavatar')#<a href="##" class="tooltip">&nbsp;<span>#rc.mmRBF.key('deleteavatar','tip')#</span></a></label><br />
		</li>
		</cfif>
		</fieldset>
		<li>
			<input id="submit" class="submit" name="btAction" type="submit" value="#rc.mmRBF.key('submit')#" />
		</li>
	</ul>
	</form>
</cfoutput>