<cfsilent>
	<cfset local	= attributes.local />
	<cfset rc		= local.rc />

	<cfset local.muraUserBean	= rc.userBean.getExternalUserBean() />
</cfsilent>
<cfoutput>
	<form id="mf-profile-form" class="mf-profile-form" action="./?panel=moderate" method="post" onsubmit="return validate(this);">
	<ul>
		<fieldset>
		<li class="req">
			<label for="screenname">#rc.mmRBF.key('screenname')#</label>
			<input class="text" type="text" maxlength="50" id="screenname" name="screenname" value="#rc.userBean.getScreenName()#" data-required="true" data-message="#rc.mmRBF.key('screenname')# #rc.mmRBF.key('required')#">
		</li>
		</fieldset>
		<fieldset>
		<legend>#rc.mmRBF.key('account')#</legend>
		<li class="checkbox">
			<input class="checkbox" type="checkbox" id="isConfirmed" name="isConfirmed" value="1" <cfif rc.userBean.getIsConfirmed()>CHECKED</cfif>>
			<label for="isConfirmed">#rc.mmRBF.key('confirmed')#<a href="##" class="tooltip">&nbsp;<span>#rc.mmRBF.key('confirmed','tip')#</span></a></label><br />
		</li>
		<li class="checkbox">
			<input class="checkbox" type="checkbox" id="inActive" name="inActive" value="1" <cfif local.muraUserBean.getinActive()>CHECKED</cfif>>
			<label for="inActive">#rc.mmRBF.key('inActive')#<a href="##" class="tooltip">&nbsp;<span>#rc.mmRBF.key('inActive','tip')#</span></a></label><br />
		</li>
		<li class="checkbox">
			<input class="checkbox" type="checkbox" id="isBlocked" name="isBlocked" value="1" <cfif rc.userBean.getisBlocked()>CHECKED</cfif>>
			<label for="isBlocked">#rc.mmRBF.key('blocked')#<a href="##" class="tooltip">&nbsp;<span>#rc.mmRBF.key('blocked','tip')#</span></a></label><br />
		</li>
		<li id="iMessageContainer" class="checkbox">
			<input name="doAddAdminMessage" id="doAddAdminMessage" type="CHECKBOX" value="1"  <cfif len(rc.userBean.getAdminMessage())>CHECKED</cfif>">
			<label for="txtMessage">
				#rc.mmRBF.key('adminmessage')#<a href="##" class="tooltip">&nbsp;<span>#rc.mmRBF.key('adminmessage','tip')#</span></a>
			</label>
			<div id="iMessage">
				<div style="clear: both">
				<textarea id="adminmessage" name="AdminMessage" rows="5" class="textarea" style="width: 100%">#rc.userBean.getAdminMessage()#</textarea>
				</div>
			</div>
		</li>
		</fieldset>
		<fieldset>
		<legend>#rc.mmRBF.key('moderatoruseractions')#</legend>
		<li class="checkbox">
			<input class="checkbox" type="checkbox" id="doDeleteAvatar" name="doDeleteAvatar" value="1">
			<label for="doDeleteAvatar">#rc.mmRBF.key('deleteavatar')#<a href="##" class="tooltip">&nbsp;<span>#rc.mmRBF.key('deleteavatar','tip')#</span></a></label><br />
		</li>
		<li class="checkbox">
			<input class="checkbox" type="checkbox" id="doBlockAll" name="doBlockAll" value="1">
			<label for="doBlockAll">#rc.mmRBF.key('blockallthreadsposts')#<a href="##" class="tooltip">&nbsp;<span>#rc.mmRBF.key('blockallthreadsposts','tip')#</span></a></label><br />
		</li>
		<li class="checkbox">
			<input class="checkbox" type="checkbox" id="doUnBlockAll" name="doUnBlockAll" value="1">
			<label for="doUnBlockAll">#rc.mmRBF.key('unblockallthreadsposts')#<a href="##" class="tooltip">&nbsp;<span>#rc.mmRBF.key('unblockallthreadsposts','tip')#</span></a></label><br />
		</li>
		</fieldset>
		<li>
			<input id="submit" class="submit" name="btAction" type="submit" value="#rc.mmRBF.key('submit')#" />
		</li>
	</ul>
</cfoutput>