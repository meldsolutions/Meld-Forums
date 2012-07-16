<cfsilent>
	<cfset local	= attributes.local />
	<cfset rc		= local.rc />

	<cfparam name="form.action" default="">
	<cfparam name="form.message" default="#rc.postbean.getMessage()#">
	<cfparam name="form.doSubscribe" default="">

	<cfinclude template="#rc.MFBean.getThemeRootDirectory()#event/e_md_editor_post.cfm">

</cfsilent><cfoutput>
<cfif rc.mode eq "newpost">
	<form class="forumsform" id="forumsform" action="#rc.MFBean.getEditorAction( request.section,request.item,rc.postbean.getThreadID() )#" method="post" name="posteditor" onsubmit="return validate(this);" enctype="multipart/form-data">
<cfelse>
<form class="forumsform" id="forumsform" action="#rc.MFBean.getEditorAction( request.section,request.item,rc.postbean.getPostID() )#" method="post" name="posteditor" onsubmit="return validate(this);" enctype="multipart/form-data">
</cfif>
<div id="hiddenFields">
	<input type="hidden" id="threadID" name="threadID" value="#rc.postbean.getThreadID()#">
	<input type="hidden" id="postID" name="postID" value="#rc.postbean.getpostID()#">
	<input type="hidden" id="parentID" name="parentID" value="#rc.postbean.getParentID()#">
</div>

<div id="formFields">
	<fieldset>
	<ul>
		<li id="iMessageContainer" class="req">
			<label for="txtMessage">#rc.mmRBF.key('message')#</label>
			<div class="messageblock">
				<textarea id="txtMessage" name="message" rows="5" style="width: 95%" required="true">#form.message#</textarea>
			</div>
		</li>
		<cfif rc.configurationBean.getdoAttachments()>
		<li>
			<label for="fAttachment">#rc.mmRBF.key('attachment')#</label>
			<input id="fAttachment" type="file" name="newAttachment"/>
		</li>
		<li class="inlinetip">
			#rc.mmRBF.key('allowedattachmentlist','tip')# #replace(rc.configurationBean.getallowAttachmentExtensions(),",",", ","all")#
		</li>
		<li class="inlinetip">
			#rc.mmRBF.key('filesizeLimit','tip')# #rc.configurationBean.getFilesizeLimit()#
		</li>
		</cfif>
		<cfif len( rc.postbean.getAttachmentID() )>
		<li class="checkbox">
			<input name="doDeleteAttachment" id="doDeleteAttachment" type="CHECKBOX" value="1">
			<label for="fAttachment">#rc.mmRBF.key('deleteattachment')#<a href="##" class="tooltip">&nbsp;<span>#rc.mmRBF.key('deleteattachment','tip')#</span></a></label>
		</li>
		</cfif>
		<cfif StructKeyExists(local.eventContent,"fields")>
		</fieldset>
		<fieldset>
			#local.eventContent['fields']#
		</cfif>
		<cfif rc.mode eq "editpost" and rc.MFBean.UserHasModeratePermissions()>
		</fieldset>
		<fieldset>
			<legend>#rc.mmRBF.key('moderatefields')#</legend>
			<li class="checkbox">
				<input name="doSetActive" id="doSetActive" type="CHECKBOX" value="1" <cfif rc.postbean.getIsActive()>CHECKED</cfif>>
				<label for="doSetActive">
					#rc.mmRBF.key('active')#<a href="##" class="tooltip">&nbsp;<span>#rc.mmRBF.key('postactive','tip')#</span></a>
				</label>
			</li>
			<li class="checkbox">
				<input name="doBlockAttachment" id="doBlockAttachment" type="CHECKBOX" value="1" <cfif rc.postbean.getDoBlockAttachment()>CHECKED</cfif>>
				<label for="doBlockAttachment">
					#rc.mmRBF.key('blockattachment')#<a href="javascript:void();" class="tooltip">&nbsp;<span>#rc.mmRBF.key('blockattachment','tip')#</span></a>
				</label>
			</li>
			<li class="checkbox">
				<input name="doSetModerated" id="doSetModerated" type="CHECKBOX" value="1" <cfif rc.postbean.getIsModerated()>CHECKED</cfif>>
				<label for="doSetModerated">
					#rc.mmRBF.key('moderated')#<a href="##" class="tooltip">&nbsp;<span>#rc.mmRBF.key('moderated','tip')#</span></a>
				</label>
			</li>
			<li class="checkbox">
				<input name="doSetDisabled" id="doSetDisabled" type="CHECKBOX" value="1" <cfif rc.postbean.getisDisabled()>CHECKED</cfif>>
				<label for="doSetDisabled">
					#rc.mmRBF.key('disabled')#<a href="##" class="tooltip">&nbsp;<span>#rc.mmRBF.key('postdisabled','tip')#</span></a>
				</label>
			</li>
			<cfif StructKeyExists(local.eventContent,"moderatefields")>
				#local.eventContent['moderatefields']#
			</cfif>
		<cfelse>
		<li class="checkbox">
			<input name="doSubscribe" id="doSubscribe" type="CHECKBOX" value="1" <cfif form.doSubscribe eq 1>checked</cfif> class="checkbox">
			<label for="doSubscribe">
				#rc.mmRBF.key('subscribe')#<a href="##" class="tooltip">&nbsp;<span>#rc.mmRBF.key('subscribe','tip')#</span></a>
			</label>
		</li>
		</cfif>
	</ul>
	</fieldset>
	<div class="buttons">
		<input id="submit" class="submit" name="btAction" type="button" value="#rc.mmRBF.key('cancel')#" onclick="history.go(-1);"/>
		<input id="submit" class="submit" name="btAction" type="submit" value="#rc.mmRBF.key('submit')#" />
	</div>
</div>
</form>
<cfif len( rc.postbean.getParentID() ) and rc.parentPostBean.beanExists()>
<div id="mf-replyto">
	<h5 id='mf-replyto-caption'>#rc.mmRBF.key('replyingto')#</h5>
	<div class="meld-forums preview">
	<table class="mf-post-block">
		<tr class="mf-post-contents">
			<td class="mf-content">
				<div class="message"><cfmodule template="/#rc.pluginConfig.getPackage()#/includes/utilities/parseBBML.cfm" ConvertSmilies="false">#rc.parentPostBean.getMessage()#</cfmodule></div>
			</td>
		</tr>
	</table>
	</div>
</div>
</cfif>
</cfoutput>