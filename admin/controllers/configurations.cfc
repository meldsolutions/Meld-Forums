<cfcomponent extends="controller">
	<cffunction name="default" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset var configurationService	= getBeanFactory().getBean("configurationService") />
		<cfset configurationService.verifyBaseConfiguration( rc.siteID ) />
	
	</cffunction>

	<cffunction name="edit" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">
	
		<cfset var configurationService	= getBeanFactory().getBean("configurationService") />
		<cfset var settingsService		= getBeanFactory().getBean("settingsService") />
		<cfset var mmFormTools			= getBeanFactory().getBean("mmFormTools") />
		<cfset var mmBreadCrumbs		= getBeanFactory().getBean("mmBreadCrumbs") />
		<cfset var mmResourceBundle		= getBeanFactory().getBean("mmResourceBundle") />
		<cfset var settingsBean			= "" />
		<cfset var configurationBean	= "" />
		<cfset var newConfigurationBean	= "" />
		<cfset var aConfiguration		= ArrayNew(1)>

		<cfset var qGroupsPublic		= rc.$.getBean("userManager").getPublicGroups( session.siteID ) />
		<cfset var qGroupsPrivate		= rc.$.getBean("userManager").getPrivateGroups( session.siteID ) />

		<cfset var sPresets			= StructNew() />
		<cfset var sArgs			= StructNew() />

		<cfset mmBreadCrumbs.addCrumb( rc,mmResourceBundle.key('configurations'),"?action=configurations" )>

		<!--- check if a button was clicked --->
		<cfif isDefined("arguments.rc.btaction")>
			<!--- cancel? --->
			<cfif arguments.rc.btaction eq 'cancel'>
				<cflocation url="?action=configurations" addtoken="false">
			<!--- save? --->
			<cfelseif arguments.rc.btaction eq 'save'>
				<cfset success = actionSaveConfiguration( arguments.rc )>
				<cfif success eq true>
					<cflocation url="?action=configurations" addtoken="false">
				</cfif> 
			<!--- update? --->
			<cfelseif arguments.rc.btaction eq 'update'>
				<cfset success = actionUpdateConfiguration( arguments.rc )>
				<cfif success eq true>
					<cflocation url="?action=configurations" addtoken="false">
				</cfif>
			</cfif>
		<cfelseif isDefined("arguments.rc.btdeleteconfirm") and arguments.rc.btdeleteconfirm eq "delete">
			<cfset success = actionDeleteConfiguration( arguments.rc )>
			<cfif success eq true>
				<cflocation url="?action=configurations" addtoken="false">
			</cfif> 
		</cfif>

		<cfif isDefined( "arguments.rc.copy" )>
			<cfset sArgs		= StructNew() />
			<cfset sArgs.prepend			= " (" & mmResourceBundle.key("copy") & ")" />
			<cfset sArgs.siteID				= arguments.rc.siteID />
			<cfset sArgs.configurationID	= arguments.rc.configurationID />
			<cfset configurationBean		= configurationService.duplicateConfiguration( argumentCollection=sArgs ) />

			<cfset mmBreadCrumbs.addCrumb( rc,configurationBean.getName() )>
			<cfset mmBreadCrumbs.addCrumb( rc,mmResourceBundle.key('editcopy') )>
		<cfelseif isDefined( "arguments.rc.configurationID" )>
			<cfset configurationBean = configurationService.getConfiguration( configurationID = arguments.rc.configurationID ) />
			<cfif configurationBean.beanExists()>
				<cfset mmBreadCrumbs.addCrumb( rc,configurationBean.getName() )>
			<cfelse>
				<!--- TODO: error codes --->
				<!--- does not exist --->
				<cflocation url="?action=configurations&eCode=2501" addtoken="false">
			</cfif>
			<cfset mmBreadCrumbs.addCrumb( rc,mmResourceBundle.key('edit') )>
		<cfelse>
			<!--- TODO: error codes --->
			<!--- id missing --->
			<cflocation url="?action=configurations&eCode=2500" addtoken="false">
		</cfif>
		
		<!--- set up for form --->
		<cfset mmFormTools.paramaterizeBeanForm(configurationBean,sPresets) />

		<cfset var aConfiguration		= configurationService.getConfigurations( siteID=arguments.rc.siteID )>

		<!--- Settings are by siteID --->
		<cfset sArgs = StructNew() />
		<cfset sArgs.siteID		= arguments.rc.siteID>
		<cfset settingsBean		= settingsService.getSettings( argumentCollection=sArgs ) />
		
		<!--- return vars --->
		<cfset arguments.rc.configurationBean	= configurationBean />
		<cfset arguments.rc.aConfiguration		= aConfiguration />

		<cfset arguments.rc.settingsBean		= settingsBean />

		<cfset arguments.rc.qGroupsPublic		= qGroupsPublic />
		<cfset arguments.rc.qGroupsPrivate		= qGroupsPrivate />
	</cffunction>

	<cffunction name="actionUpdateConfiguration" access="private" returntype="boolean">
		<cfargument name="rc" type="struct" required="true">

		<cfset var configurationService	= getBeanFactory().getBean("ConfigurationService") />
		<cfset var mmFormTools			= getBeanFactory().getBean("mmFormTools") />
		<cfset var configurationBean	= "" />
		<cfset var sArgs				= StructNew() />

		<!--- create a blank Configuration bean for the form params (i.e. unchecked checkboxes ) --->
		<cfset configurationBean 		= configurationService.createConfiguration() />
		
		<!--- we do paramaterizeBeanBooleans to 'fill in' the form's unsubmitted checkboxes --->
		<cfset mmFormTools.paramaterizeBeanBooleans(configurationBean) />
		<cfset formData = mmFormTools.scopeFormSubmission(form,false,true) />
	
		<!--- now get the existing bean --->
		<cfset configurationBean = ConfigurationService.getConfiguration( formData.configurationbean.configurationID ) />

		<!--- set the new values --->
		<cfset configurationBean.updateMemento( formData.configurationBean )>

		<!--- check for master id --->
		<cfif configurationBean.getConfigurationID() eq "00000000-0000-0000-0000000000000001">
			<cfset configurationBean.setIsMaster( 1 ) />
		</cfif>

		
		<!--- update the configuration --->
		<cfreturn ConfigurationService.updateConfiguration( configurationBean ) />		
	</cffunction>	

	<cffunction name="actionSaveConfiguration" access="private" returntype="boolean">
		<cfargument name="rc" type="struct" required="true">

		<cfset var configurationService	= getBeanFactory().getBean("ConfigurationService") />
		<cfset var mmFormTools			= getBeanFactory().getBean("mmFormTools") />
		<cfset var configurationBean	= "" />
		<cfset var sArgs				= StructNew() />

		<!--- create a blank Configuration bean for the form params (i.e. unchecked checkboxes ) --->
		<cfset configurationBean 		= configurationService.createConfiguration() />

		<cfset configurationBean.setSiteID( arguments.rc.siteID ) />
		
		<!--- we do paramaterizeBeanBooleans to 'fill in' the form's unsubmitted checkboxes --->
		<cfset mmFormTools.paramaterizeBeanBooleans(configurationBean) />
		<cfset formData = mmFormTools.scopeFormSubmission(form,false,true) />

		<!--- set the new values --->
		<cfset configurationBean.updateMemento( formData.configurationBean )>
		
		<!--- save the configuration --->
		<cfreturn ConfigurationService.saveConfiguration( configurationBean ) />		
	</cffunction>	

	<cffunction name="actionDeleteConfiguration" access="private" returntype="boolean">
		<cfargument name="rc" type="struct" required="true">
		<cfset var configurationService	= getBeanFactory().getBean("ConfigurationService") />
		<cfset var mmFormTools			= getBeanFactory().getBean("mmFormTools") />
		
		<cfset formData = mmFormTools.scopeFormSubmission(form,false,true) />
		
		<!--- save the configuration --->
		<cfreturn ConfigurationService.deleteConfiguration( formData.configurationbean.configurationID ) />		
	</cffunction>	
</cfcomponent>
