<cfsilent>
	<cfset local	= attributes.local />
	<cfset rc		= local.rc />

</cfsilent><cfoutput>
<table class="mf-searchform">
	<tr>
		<form action="#rc.MFBean.getSearchURL()#" method="post">
		<td>
			<ul class="mf-searchform-form">
			<li>
				<input class="input" id="k" name="k" size="25" maxlength="250" value="#$.event('k')#" />
			</li>
			<li>
			<select class="select" name="st">
				<option value="OR">#rc.mmRBF.key('searchany')#</option>
				<option value="AND" <cfif $.event('st') eq "AND"> SELECTED</cfif>>#rc.mmRBF.key('searchall')#</option>
				<option value="EXACT" <cfif $.event('st') eq "EXACT"> SELECTED</cfif>>#rc.mmRBF.key('searchexact')#</option>
			</select>
			</li>
			<li>
				<input type="submit" class="submit" name="#rc.mmRBF.key('search')#" value="#rc.mmRBF.key('search')#" />
			</li>
			</ul>
		</td>
		</form>
	</tr>
</table>
</cfoutput>