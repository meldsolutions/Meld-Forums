<cfsilent>
	<cfset local	= attributes.local />
	<cfset rc		= local.rc />

	<cfset local.muraUserBean	= rc.userBean.getExternalUserBean() />
</cfsilent>
<cfoutput>
	<form id="mf-profile-form" class="mf-profile-form" action="./?panel=settings" method="post" onsubmit="return validate(this);">
	<ul>
		<fieldset>
		<li class="req">
			<label for="fName">#rc.mmRBF.key('user.fname','mura')#</label>
			<input class="text" type="text" maxlength="50" id="fName" name="fName" value="#local.muraUserBean.getFName()#" data-required="true" data-message="#rc.mmRBF.key('user.fname','mura')# #rc.mmRBF.key('required')#">
		</li>
		<li class="req">
			<label for="lName">#rc.mmRBF.key('user.lname','mura')#</label>
			<input class="text" type="text" maxlength="50" id="lName" name="lName" value="#local.muraUserBean.getLName()#" data-required="true" data-message="#rc.mmRBF.key('user.lname','mura')# #rc.mmRBF.key('required')#">
		</li>
		<li class="req">
			<label for="email">#rc.mmRBF.key('user.email','mura')#</label>
			<input class="text" type="text" maxlength="50" id="email" name="email" value="#local.muraUserBean.getEmail()#" data-required="true" data-message="#rc.mmRBF.key('user.lname','mura')# #rc.mmRBF.key('required')#">
		</li>
		<li>
			<label for="company">#rc.mmRBF.key('user.company','mura')#</label>
			<input class="text" type="text" maxlength="50" id="company" name="company" value="#local.muraUserBean.getCompany()#" data-required="false">
		</li>
		<li>
			<label for="jobtitle">#rc.mmRBF.key('user.jobtitle','mura')#</label>
			<input class="text" type="text" maxlength="50" id="jobtitle" name="jobtitle" value="#local.muraUserBean.getJobTitle()#" data-required="false">
		</li>
		<li>
			<label for="website">#rc.mmRBF.key('user.website','mura')#</label>
			<input class="text" type="text" maxlength="50" id="website" name="website" value="#local.muraUserBean.getWebsite()#" data-required="false">
		</li>
		<li>
			<label for="interests">#rc.mmRBF.key('user.interests','mura')#</label>
			<input class="text" type="text" maxlength="300" id="interests" name="interests" value="#local.muraUserBean.getInterests()#" data-required="false">
		</li>
		</fieldset>
		<li>
			<input id="submit" class="submit" name="btAction" type="submit" value="#rc.mmRBF.key('submit')#" />
		</li>
	</ul>
	</form>
</cfoutput>