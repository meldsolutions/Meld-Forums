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

			<!--- description --->
			<ui:TextArea key="description" 		name="forumbean_description" />

		</div><!--- /fieldset ---> 
	</div><!--- /tabbasic --->
</cfoutput>