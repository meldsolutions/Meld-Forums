<cfsilent>
	<cfset rc = rc>
</cfsilent>
<cfoutput>
	<div id="msTabs-Options">
		<h3>#rc.mmRBF.key('options')#</h3>
		<ul class="form">
			<li class="first">
				<label for="conferencebean_orderno">#rc.mmRBF.key('orderno')#<a href="##" class="tooltip"><span>#rc.mmRBF.key('orderno','tip')#</span>&nbsp;</a></label>
				<input class="text tiny" type="text" name="conferencebean_orderno" id="conferencebean_orderno" value="#form.conferencebean_orderno#" size="30" maxlength="100" data-required="true" data-validate="string" data-message="#rc.mmRBF.key('conferencename','validation')#" />
			</li>
			<li class="checkbox padded">
				<input class="checkbox" type="checkbox" name="conferencebean_isactive" id="conferencebean_isactive" value="1" <cfif form.conferencebean_isactive>CHECKED</cfif>/>
				<label for="conferencebean_isactive">#rc.mmRBF.key('isactive')#<a href="##" class="tooltip"><span>#rc.mmRBF.key('isactive','tip')#</span>&nbsp;</a></label>
			</li>
		</ul>
	</div>
</cfoutput>