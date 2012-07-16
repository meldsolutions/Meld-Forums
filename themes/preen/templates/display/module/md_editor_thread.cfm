<cfsilent>
	<cfset local	= attributes.local />
	<cfset rc		= local.rc />

<cfparam name="form.title" default="#rc.threadbean.getTitle()#">
<cfparam name="form.message" default="#rc.threadbean.getMessage()#">

</cfsilent><cfoutput>
<form class="forumsform" id="forumsform" action="#rc.MFBean.getEditorAction( request.section,request.item,rc.threadbean.getForumID() )#" method="post" onsubmit="return validate(this);" enctype="multipart/form-data">
<div id="hiddenFields">
	<input type="hidden" id="threadID" name="threadID" value="#rc.threadbean.getThreadID()#">
	<input type="hidden" id="forumID" name="forumID" value="#rc.threadbean.getForumID()#">
</div>
<div id="formFields">
	<fieldset>
	<ul>
		<li class="req">
			<label for="txtTitle">#rc.mmRBF.key('title')#</label><br />
			<input class="text" type="text" maxlength="100" id="txtTitle" name="title" value="#form.title#" required="true" message="#rc.mmRBF.key('title')# #rc.mmRBF.key('isrequired')#">
		</li>
		<li class="req" id="iMessageContainer">
			<label for="txtMessage">#rc.mmRBF.key('message')#</label>
			<div class="messageblock">
			<textarea id="txtMessage" name="message" rows="5" required="true" style="width: 95%" message="#rc.mmRBF.key('message')# #rc.mmRBF.key('isrequired')#">#form.message#</textarea>
			</div>
		</li>
		<cfif rc.configurationBean.getDoAttachments()>
		<li>
			<label for="fAttachment">#rc.mmRBF.key('attachment')#</label>
			<input id="fAttachment" type="file" name="newAttachment"/>
		</li>
		<li class="inlinetip">
			#rc.mmRBF.key('allowedattachmentlist','tip')# #replace(rc.configurationBean.getallowAttachmentExtensions(),",",", ","all")#
		</li>
		</cfif>
		<cfif StructKeyExists(local.eventContent,"fields")>
		</fieldset>
		<fieldset>
			#local.eventContent['fields']#
		</cfif>
	</ul>
	</fieldset>
	<cfif rc.meldForumsBean.UserHasModeratePermissions()>
	<fieldset>
		<ul>
			<li>
				<label for="typeID">#rc.mmRBF.key('typeID')#<a href="##" class="tooltip">&nbsp;<span>#rc.mmRBF.key('typeID','tip')#</span></a></label><br />
				<select name="typeID" id="typeID" class="SELECT">
					<option value="0">#rc.mmRBF.key('normal')#</option>
					<option value="1"<cfif rc.threadbean.getTypeID() eq 1> selected</cfif>>#rc.mmRBF.key('sticky')#</option>
				</select>
			</li>
			<li class="checkbox">
				<input name="doSetClosed" class="checkbox" id="doSetClosed" type="CHECKBOX" value="1" <cfif rc.threadbean.getisClosed()>CHECKED</cfif>>
				<label for="doSetClosed">
					#rc.mmRBF.key('Closed')#<a href="##" class="tooltip">&nbsp;<span>#rc.mmRBF.key('threadClosed','tip')#</span></a>
				</label>
			</li>
			<li class="checkbox">
				<input name="doSetAnnouncement" class="checkbox" id="doSetAnnouncement" type="CHECKBOX" value="1" <cfif rc.threadbean.getIsAnnouncement()>CHECKED</cfif>>
				<label for="doSetAnnouncement">
					#rc.mmRBF.key('Announcement')#<a href="##" class="tooltip">&nbsp;<span>#rc.mmRBF.key('threadAnnouncement','tip')#</span></a>
				</label>
			</li>
		</ul>
	</fieldset>
	</cfif>
	<div class="buttons">
		<input id="submit" class="submit" name="btAction" type="button" value="#rc.mmRBF.key('cancel')#" onclick="history.go(-1);"/>
		<input id="submit" class="submit" name="btAction" type="submit" value="#rc.mmRBF.key('submit')#" onclick="return doSetAction('#rc.mmRBF.key('submit')#');"/>
	</div>
</div>
</form>
</cfoutput>