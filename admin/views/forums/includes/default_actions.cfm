<cfsilent>
	<cfset rc = rc>
</cfsilent><cfoutput>
<div class="row">
	<div class="span12 ">
		<!---<a href="#buildURL('admin:forums.reorder')#<cfif len(rc.conferenceID)>&conferenceID=#rc.conferenceID#</cfif>" title="#rc.mmRBF.key('reorder','tip')#" class="btn"><i class="icon-reorder"></i> #rc.mmRBF.key('reorder')#</a>--->
		<div class='pull-right'>
		<a href="#buildURL('admin:forums.edit')#<cfif len(rc.conferenceID)>&conferenceID=#rc.conferenceID#</cfif>" title="#rc.mmRBF.key('addnewforum','tip')#" class="btn"><i class="icon-plus-sign"></i> #rc.mmRBF.key('addnewforum')#</a>
		</div>
	</div>
</div>
</cfoutput>