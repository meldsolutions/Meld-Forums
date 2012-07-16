<cfoutput>
	<table class="mf-dashboard-table">
		<tr>
			<th colspan="4">
			#rc.mmRBF.key('recentusers')#
			</th>
		</tr>
		<cfloop from="1" to="#ArrayLen(rc.aUsers)#" index="local.iiX">
			<cfset local.user = rc.settingsBean.getUserCache().getUser( rc.aUsers[local.iiX].getUserID() ) />
			<tr <cfif local.iiX mod 2>class="alt"</cfif>>
				<td class="varWidth">
					<a class="mf-user-icon" href="../../admin/?fuseaction=cPrivateUsers.edituser&userid=#local.user.getUserID()#" target="_new">&nbsp;</a>
					<a href="#rc.MeldForumsBean.getProfileLink( local.user )#" target="_new">#local.user.getScreenName()#</a>
				</td>
				<td class="midWidth">
					#lsdateFormat(local.user.getDateLastAction(),"short")# #lstimeFormat(local.user.getDateLastUpdate(),"short")#					
				</td>
			</tr>
		</cfloop>
	</table>
</cfoutput>