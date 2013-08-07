<cfimport prefix="ui" taglib="../../../ui" />
<cfoutput>
	<div id="msTabs-General" class="tab-pane">
		<span id="extendset-container-tabbasictop" class="extendset-container"></span>

		<div class="fieldset">
			<!--- name --->
			<ui:TextInput key="conferencename"	name="conferencebean_name"  required="true" />

			<!--- title --->
			<ui:TextInput key="conferencetitle"	name="conferencebean_title" />

			<!--- friendlyname --->
			<ui:TextInput key="friendlyname" 	name="conferencebean_friendlyname" />

			<!--- description --->
			<ui:TextArea key="description" 		name="conferencebean_description" />

		</div><!--- /fieldset ---> 
	</div><!--- /tabbasic --->
</cfoutput>