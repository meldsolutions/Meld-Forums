<cfoutput>
	<table class="mf-dashboard-table">
		<tr>
			<th colspan="3">
			#rc.mmRBF.key('recentactivity')#
			</th>
		</tr>
		<cfloop from="1" to="#ArrayLen(rc.aPosts)#" index="local.iiX">
			<cfset local.post = rc.aPosts[local.iiX] />
			<cfset local.user = rc.settingsBean.getUserCache().getUser( local.post.getUserID() ) />
			<tr <cfif local.iiX mod 2>class="alt"</cfif>>
				<td class="varWidth">
					<a href="#rc.MeldForumsBean.getLastPostLink( local.post )#" target="_new">#left(local.post.getTitle(),25)#<cfif len(local.post.getTitle()) gt 25>...</cfif>	</a>					
				</td>
				<td class="varWidth">
					<a href="#rc.MeldForumsBean.getProfileLink( local.user )#" target="_new">#local.user.getScreenName()#</a>					
				</td>
				<td class="midWidth">
					<cfif isDate( local.user.getDateLastUpdate() )>
						#lsdateFormat(local.post.getDateLastUpdate(),"short")# #lstimeFormat(local.post.getDateLastUpdate(),"short")#
					</cfif>					
				</td>
			</tr>
		</cfloop>
	</table>
</cfoutput>