<cfsilent>
	<cfset rc = rc>
</cfsilent>
<cfoutput>
	<div id="msTabs-General">
		<h3>#rc.mmRBF.key('general')#</h3>
		<ul class="form">
			<li class="first">
				<label for="conferencebean_name">#rc.mmRBF.key('conferencename')#<a href="##" class="tooltip"><span>#rc.mmRBF.key('conferencename','tip')#</span>&nbsp;</a></label>
				<input class="text" type="text" name="conferencebean_name" id="conferencebean_name" value="#form.conferencebean_name#" size="30" maxlength="100" data-required="true" data-validate="string" data-message="#rc.mmRBF.key('conferencename','validation')#" />
			</li>
			<li>
				<label for="conferencebean_title">#rc.mmRBF.key('conferencetitle')#<a href="##" class="tooltip"><span>#rc.mmRBF.key('conferencetitle','tip')#</span>&nbsp;</a></label>
				<input class="text" type="text" name="conferencebean_title" id="conferencebean_title" value="#form.conferencebean_title#" size="30" maxlength="100" data-required="true" data-validate="string" data-message="#rc.mmRBF.key('conferencetitle','validation')#" />
			</li>
			<li>
				<label for="conferencebean_name">#rc.mmRBF.key('friendlyname')#<a href="##" class="tooltip"><span>#rc.mmRBF.key('friendlyname','tip')#</span>&nbsp;</a> <div class="doShowHide" onclick="doClickShowHide('friendlyShowHide',false,'conferencebean_friendlyname')">#rc.mmRBF.key('show')#</div></label>
				<div id="friendlyShowHide" style="display: none">
				<input class="text" type="text" name="conferencebean_friendlyname" id="conferencebean_friendlyname" value="#form.conferencebean_friendlyname#" size="30" maxlength="100" />
				</div>
			</li>
			<li>
			<label for="conferencebean_description">#rc.mmRBF.key('description')#<a href="##" class="tooltip"><span>#rc.mmRBF.key('description','tip')#</span>&nbsp;</a></label>
			<textarea name="conferencebean_description" id="conferencebean_description"><cfif len(form.conferencebean_description)>#HTMLEditFormat(form.conferencebean_description)#<cfelse><br /></cfif></textarea>
			<script type="text/javascript" language="Javascript">
			var loadEditorCount = 0;
			jQuery('##conferencebean_description').ckeditor(
				{ 
				toolbar :
		        [
		            ['Source','-','Cut','Copy','Paste','PasteText','PasteWord','-','Bold','Italic','-','Image','-','OrderedList','UnorderedList','-','Link','Unlink','-','FitWindow','ShowBlocks','-','Style','-','About']
		        ],
				height:'200',
				customConfig : 'config.js.cfm' },htmlEditorOnComplete);
			</script>


			<!---<cfscript>
				fckEditor = createObject("component", "#application.configBean.getContext()#/wysiwyg/fckEditor");
				fckEditor.instanceName	= "conferencebean_description";
				fckEditor.value			= '#form.conferencebean_description#';
				fckEditor.basePath		= "#application.configBean.getContext()#/wysiwyg";
				fckEditor.config.EditorAreaCSS	= '#application.configBean.getContext()#/#rc.siteid#/css/editor.css';
				fckEditor.config.StylesXmlPath = '#application.configBean.getContext()#/#rc.siteid#/css/fckstyles.xml';
				fckEditor.width			= "99%";
				fckEditor.height		= "150px";
				fckEditor.toolbarset 	= 'DynamicToolbar';
				fckEditor.config.DynamicToolbar_buttons="Source,-,Cut,Copy,Paste,PasteText,PasteWord,-,Bold,Italic,-,Image,-,OrderedList,UnorderedList,-,Link,Unlink,-,FitWindow,ShowBlocks,-,Style,-,About";
				fckEditor.config.ToolbarStartExpanded	= true; 
				fckEditor.config.DefaultLanguage=lcase(session.rb);
				fckEditor.config.AutoDetectLanguage=false;
				fckEditor.config.BodyId		="primary";
				fckEditor.config.GoogleMaps_Key ='none';
				fckEditor.create(); // create the editor.
			</cfscript>--->
			</li>
		</ul>
	</div>
</cfoutput>