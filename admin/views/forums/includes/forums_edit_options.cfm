<cfsilent>
	<cfset rc = rc>
</cfsilent>
<cfoutput>
	<div id="msTabs-Options">
		<h3>#rc.mmRBF.key('options')#</h3>
		<ul class="form">
			<li class="first">
				<label for="forumbean_orderno">#rc.mmRBF.key('orderno')#</label>
				<input class="text tiny" type="text" name="forumbean_orderno" id="forumbean_orderno" value="#form.forumbean_orderno#" size="30" maxlength="100" data-required="true" data-validate="string" data-message="#rc.mmRBF.key('forumname','validation')#" />
			</li>
			<li class="checkbox padded">
				<input class="checkbox" type="checkbox" name="forumbean_isactive" id="forumbean_isactive" value="1" <cfif form.forumbean_isactive>CHECKED</cfif>/>
				<label for="forumbean_isactive">#rc.mmRBF.key('isactive')#</label>
			</li>
		</ul>
	</div>
</cfoutput>