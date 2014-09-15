<cfimport prefix="ui" taglib="../../ui" />
<cfsilent>
	
	<!--- rc --->
	<!--- headers --->
	<cfinclude template="/#rc.pluginConfig.getPackage()#/admin/includes/headers/jquery-ui-tabs.cfm">
	<cfinclude template="/#rc.pluginConfig.getPackage()#/admin/includes/headers/jquery-ui.cfm">
</cfsilent><cfoutput>
<!--- global menu --->
<!--- begin content --->
	<div class="row">
		<div class="span12">
			#view("/global/bc")#
		</div>
	</div>

	<cfif rc.forumBean.getBeanExists()>
		<form action="#buildURL('admin:forums.edit?btaction=update')#" method="post">	
	<cfelse>
		<form action="#buildURL('admin:forums.edit?btaction=save')#" method="post">	
	</cfif>

	<input type="hidden" name="forumID" value="#rc.forumBean.getforumID()#">

	<span id="msg"></span>
		
	<div class="tabbable tabs-left">

		<ul class="nav nav-tabs tabs initActiveTab">
			<li><a href="##msTabs-General" data-toggle="tab"><span>#rc.mmRBF.key('general')#</span></a></li>
			<li><a href="##msTabs-Config" data-toggle="tab"><span>#rc.mmRBF.key('configuration')#</span></a></li>
		</ul><!--- /nav-tabs --->

		<div class="tab-content row-fluid">
			#view("forums/includes/forums_edit_general")#
			#view("forums/includes/forums_edit_config")#
	
			<div class="load-inline tab-preloader"></div>
	
			<div class="form-actions">
			
				<a href="#buildURL('admin:conferences.default')#" class="btn"><i class="icon-remove"></i> #rc.mmRBF.key('cancel')#</a>
				<button type="submit" class="btn"><i class="icon-check"></i> #rc.mmRBF.key('save')#</button>
				 
			</div><!--- /form-actions --->
	
		</div>
	</div>	
</form>
<!--- end content --->
</cfoutput> 