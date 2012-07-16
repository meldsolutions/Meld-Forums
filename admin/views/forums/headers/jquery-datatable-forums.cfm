<cfsilent>
<cfsavecontent variable="local.str">
<cfoutput>
<script src="#$.globalConfig().getContext()#/plugins/#rc.pluginConfig.getDirectory()#/admin/assets/js/datatable/jquery.datatables.forums.js" type="text/javascript" language="Javascript"></script></cfoutput>
</cfsavecontent>
<cfset arrayPrepend( rc.headLoader,local.str )>
</cfsilent>