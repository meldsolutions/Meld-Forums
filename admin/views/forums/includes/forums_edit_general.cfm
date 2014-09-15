<cfimport prefix="ui" taglib="../../../ui" />
<cfoutput>
	<div id="msTabs-General" class="tab-pane">
		<span id="extendset-container-tabbasictop" class="extendset-container"></span>

		<div class="fieldset">
			<!--- name --->
			<ui:TextInput key="forumname"	name="forumbean_name"  required="true" />

			<!--- title --->
			<ui:TextInput key="forumtitle"	name="forumbean_title" />

			<!--- friendlyname --->
			<ui:TextInput key="friendlyname" 	name="forumbean_friendlyname" />

			<div class="control-group">
				<label class="control-label" for="Conference">
					<cfif request.context.mmRBF.keyExists('Conference','tip')>
						<a href="##" rel="tooltip" title="#request.context.mmRBF.key('Conference','tip')#">#request.context.mmRBF.key('Conference')# <i class="icon-question-sign"></i></a>
					<cfelse>
						#request.context.mmRBF.key('Conference')#
					</cfif>
				</label>

				<div class="controls">
				<select class="select" name="forumbean_conferenceid" id="forumbean_conferenceid">
					<cfloop from="1" to="#arrayLen(rc.aConferences)#" index="local.iiX">
						<cfif rc.aConferences[local.iiX].getIsActive() or (len(rc.conferenceID) and rc.aConferences[local.iiX].getConferenceID() eq rc.conferenceID)>
						<option value="#rc.aConferences[local.iiX].getConferenceID()#"<cfif len(rc.conferenceID) and rc.aConferences[local.iiX].getConferenceID() eq rc.conferenceID>SELECTED</cfif>>#rc.aConferences[local.iiX].getName()#</option>
						</cfif>
					</cfloop>
				</select>
				</div>
			</div>
	

			<!--- description --->
			<ui:TextArea key="description" 		name="forumbean_description" />

		</div><!--- /fieldset ---> 
	</div><!--- /tabbasic --->
</cfoutput>