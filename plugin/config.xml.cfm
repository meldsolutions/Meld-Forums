<plugin>
<name>Meld Forums</name>
<package>MeldForums</package>
<directoryFormat>packageOnly</directoryFormat>
<loadPriority>4</loadPriority>
<version>Beta 2.0.2.1</version>
<provider>Meld Solutions Inc.</provider>
<providerURL>http://www.meldsolutions.com</providerURL>
<category>Application</category>
<settings>
	<setting>
		<name>dsntype</name>
		<label>Database Type</label>
		<hint>The type of database</hint>
		<type>select</type>
		<required>true</required>
		<validation></validation>
		<regex></regex>
		<message></message>
		<defaultvalue>mysql</defaultvalue>
		<optionlist>mysql^mssql</optionlist>
		<optionlabellist>mysql^mssql</optionlabellist>
	</setting>
	<setting>
		<name>dsn</name>
		<label>Datasource</label>
		<hint>Enter the name of the *existing* datasource you will use for the plug-in</hint>
		<type>text</type>
		<required>true</required>
		<validation></validation>
		<regex></regex>
		<message></message>
		<defaultvalue></defaultvalue>
		<optionlist></optionlist>
		<optionlabellist></optionlabellist>
	</setting>
	<setting>
		<name>dsnusername</name>
		<label>Datasource username</label>
		<hint>Username for the plug-in datasource</hint>
		<type>text</type>
		<required>false</required>
		<validation></validation>
		<regex></regex>
		<message></message>
		<defaultvalue></defaultvalue>
		<optionlist></optionlist>
		<optionlabellist></optionlabellist>
	</setting>
	<setting>
		<name>dsnpassword</name>
		<label>Datasource password</label>
		<hint>Password for the plug-in datasource</hint>
		<type>text</type>
		<required>false</required>
		<validation></validation>
		<regex></regex>
		<message></message>
		<defaultvalue></defaultvalue>
		<optionlist></optionlist>
		<optionlabellist></optionlabellist>
	</setting>
	<setting>
		<name>dsnprefix</name>
		<label>Datasource Table Prefix</label>
		<hint>Add a prefix to the table names. (optional)</hint>
		<type>text</type>
		<required>false</required>
		<validation></validation>
		<regex></regex>
		<message></message>
		<defaultvalue></defaultvalue>
		<optionlist></optionlist>
		<optionlabellist></optionlabellist>
	</setting>
</settings>

<scripts></scripts>

<eventHandlers>
	<eventHandler event="onApplicationLoad" component="events.eventHandler" persist="false"/>
</eventHandlers>

<displayobjects location="global">
	<displayobject
	    name="Conferences (Select)"
	    displaymethod="renderApp"
	    component="forum.display.displayManager"
	    configuratorInit="initConfConfigurator"
	    configuratorJS="forum/assets/js/confConfigurator.js"
	    persist="false" />
	<displayobject
	    name="Meld Forums: Widgets"
	    displaymethod="renderApp"
	    component="widget.display.displayManager"
	    persist="false" />
</displayobjects>

</plugin>
