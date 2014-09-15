<cfimport prefix="ui" taglib="../../../ui" />
<cfoutput>
	<div id="tabBasic" class="tab-pane">
		<span id="extendset-container-tabbasictop" class="extendset-container"></span>
		<div class="fieldset">

			<ui:TextInput key="configurationname"	name="configurationbean_name" required="true"/>

			<ui:TextArea key="description"			name="configurationbean_description" />
		</div><!--- /fieldset ---> 
	</div>
</cfoutput>