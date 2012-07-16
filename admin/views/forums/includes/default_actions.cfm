<cfsilent>
	<cfset rc = rc>
</cfsilent><cfoutput>
<ul class="meld-nav-secondary">
	<li>
		<a href="?action=forums.edit<cfif len(rc.conferenceID)>&conferenceID=#rc.conferenceID#</cfif>" title="#rc.mmRBF.key('addnewforum','tip')#">#rc.mmRBF.key('addnewforum')#</a>				
	</li>
</ul>
</cfoutput>