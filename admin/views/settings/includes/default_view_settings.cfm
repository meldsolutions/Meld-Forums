<cfsilent>
	<cfset rc = rc>
</cfsilent>
<cfoutput>
<div>
	<dl class="oneColumn">
	<h4>#rc.mmRBF.key('general')#</h4>
	<ul class="metadata">
		<li>#rc.mmRBF.key('threadsperpage')#: <strong>#rc.settingsBean.getThreadsPerPage()#</strong></li>
		<li>#rc.mmRBF.key('postsperpage')#: <strong>#rc.settingsBean.getPostsPerPage()#</strong></li>
		<li>#rc.mmRBF.key('searchmode')#: <strong>#rc.settingsBean.getSearchMode()#</strong></li>
		<li>#rc.mmRBF.key('usercachesize')#: <strong>#rc.settingsBean.getuserCacheSize()#</strong></li>
	</ul>
	</dl>
	<dl class="oneColumn">
	<h4>#rc.mmRBF.key('permissions')#</h4>
	<ul class="metadata">
		<li>#rc.mmRBF.key('settingspermissions')#: <strong>#rc.settingsBean.getPermissionGroups()#</strong></li>
	</ul>
	</dl>
	<dl class="oneColumn">
	<h4>#rc.mmRBF.key('theme')#</h4>
	<ul class="metadata">
		<li>#rc.mmRBF.key('theme')#: <strong>#rc.themename#</strong></li>
	</ul>
	</dl>
	<dl class="oneColumn">
	<h4>#rc.mmRBF.key('files')#</h4>
	<ul class="metadata">
		<li>#rc.mmRBF.key('filesizelimit')#: <strong>#rc.settingsBean.getFileSizeLimit()#</strong></li>
		<li>#rc.mmRBF.key('tempdir')#: <strong>#rc.settingsBean.getTempDir()#</strong></li>
		<li>#rc.mmRBF.key('basetempdir')#: <strong>#rc.settingsBean.getBaseTempDir()#</strong></li>
		<li>#rc.mmRBF.key('allowedextensions')#: <strong>#replace(rc.settingsBean.getAllowedExtensions(),",",", ","all")#</strong></li>		
	</ul>
	</dl>
	<dl class="oneColumn">
	<h4>#rc.mmRBF.key('avatar')#</h4>
	<ul class="metadata">
		<li>#rc.mmRBF.key('avatarresizetype')#: <strong>#rc.settingsBean.getAvatarResizeType()#</strong></li>
		<li>#rc.mmRBF.key('avatarqualitytype')#: <strong>#rc.settingsBean.getAvatarQualityType()#</strong></li>
		<li>#rc.mmRBF.key('avataraspecttype')#: <strong>#rc.settingsBean.getAvatarAspectType()#</strong></li>
		<li>#rc.mmRBF.key('avatarcroptype')#: <strong>#rc.settingsBean.getAvatarCropType()#</strong></li>
	</ul>
	</dl>
</div>
</cfoutput>