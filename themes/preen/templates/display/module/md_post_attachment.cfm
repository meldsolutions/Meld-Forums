<cfsilent>
	<cfset local	= attributes.local />
	<cfset rc		= local.rc />

	<cfset local.attachment = rc.$.getBean('fileManager').read( attributes.postBean.getAttachmentID() ) />
	<cfset local.filePath = rc.$.globalConfig().getContext() & "/tasks/render/file/?fileID=#local.attachment.fileID#" />
	<cfif local.attachment.contentType eq "image" and rc.MFBean.showInlineImages()>
		<cfset local.imagePath = rc.$.createHREFForImage(local.attachment.siteID,local.attachment.fileID,local.attachment.fileExt,'large') />
	</cfif>
</cfsilent>
<cfoutput>
	<cfif local.attachment.contentType eq "image" and rc.MFBean.showInlineImages()>
		<cfset local.imagePath = rc.$.createHREFForImage(local.attachment.siteID,local.attachment.fileID,local.attachment.fileExt,'large') />
		<div class="mf-attachment-image">
			<a ref="nofollow" title="#local.attachment.filename#" target="_blank" href="#local.imagePath#"><img 
				src="#local.imagePath#" class="mf-attachment" alt="#local.attachment.filename# - #int(local.attachment.filesize/1024)#kb" /></a>
		</div>
	</cfif>
	<div class="mf-attachment-info">
		<ul class="meta">
			<li><a ref="nofollow" target="_blank" href="#local.filePath#">#local.attachment.filename#</a>, #int(local.attachment.filesize/1024)#kb</li>
		</ul>
	</div>
</cfoutput>
