<cfsilent>
	<cfset local	= attributes.local />
	<cfset rc		= local.rc />

	<cfparam name="attributes.rowClass" default="">
	<cfparam name="attributes.row" default="1">
	<cfparam name="attributes.count" default="1">
	
	<cfif attributes.row eq 1>
		<cfset attributes.rowclass="first">
	<cfelseif  attributes.count eq attributes.row>
		<cfset attributes.rowclass="last">
	</cfif>
</cfsilent><cfoutput>
	<tr>
		<th colspan="#local.columns#" class="mf-masthead">
			<span class="mf-wrapper">
				<cfif arraylen(local.aConferences) gt 1>
				<h3><a href="#rc.MFBean.getconferenceLink(local.conferenceBean)#/">#local.conferenceBean.getTitle()#</a></h3>
				<cfelse>
				<h3>#local.conferenceBean.getTitle()#</h3>
				</cfif>
				<cfif len( local.conferenceBean.getDescription() )><div class="description">#local.conferenceBean.getDescription()#</div></cfif>
			</span>
		</th>
	</tr>
	<tr class="mf-headings">
		<cfif len(local.eventContent['columns'])>
			#local.eventContent['columns']#
		<cfelse>
			<th class="mf-block-icon mf-heading">&nbsp;</th>
			<th class="mf-block-info mf-heading">#rc.mmRBF.key('forum')#</th>
			<th class="mf-block-stats mf-heading">#rc.mmRBF.key('stats')#</th>
			<th class="mf-block-lastpost mf-heading">#rc.mmRBF.key('lastpost')#</th>
		</cfif>
	</tr>
</cfoutput>