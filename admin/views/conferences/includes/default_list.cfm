<cfsilent>
	<cfset rc = rc>
</cfsilent>
<cfoutput>
<div class="section clearfix">
	<table class="ms-datatable display hideTable" id="ms-datatable"
		data-url="#$.globalConfig().getContext()#/plugins/#rc.pluginConfig.getDirectory()#/com/meldsolutions/meldforums/remote/MeldForumsRemoteAOP.cfc?siteID=#rc.siteID#&method=getConferenceList&data&returnFormat=json">
		<thead class="headers">
		<tr>
			<th class="nosort nopad ui-state-active" data-class="nopad">&nbsp;</th>
			<th class="varWidth ui-state-active">#rc.mmRBF.key('name')#</th>
			<th class="minWidth ui-state-active" data-class="center">#rc.mmRBF.key('forumcount')#</th>
			<th class="minWidth ui-state-active" data-class="center">#rc.mmRBF.key('threadcount')#</th>
			<th class="nosort minWidth ui-state-active" data-class="center">#rc.mmRBF.key('status')#</th>
		</tr>
		</thead>
		<thead class="search" id="ms-datatable_search">
		<tr>
			<th>
			<ul class='table-buttons two'>
				<li><span title="#rc.mmRBF.key('clearfilter')#" id="clearFilter" class="sb-button ui-state-active"><span class="ui-icon ui-icon-arrowreturnthick-1-w"></span></span></li>
				<li><span title="#rc.mmRBF.key('setfilter')#" id="setFilter" class="sb-button ui-state-active"><span class="ui-icon ui-icon-check"></span></span></li>
			</ul>
			</th>
			<th><input class="searchable text full" type="text" id="flt_name" data-column="name"></th>
			<th></th>
			<th></th>
			<th>
			<select class="select" name="isactive" id="flt_isactive" data-column="isactive">
				<option value="1">#rc.mmRBF.key('active1')#</option>
				<option value="0">#rc.mmRBF.key('active0')#</option>
			</select>
			</th>
		</tr>
		</thead>
		<tbody>
	</table>
</div>

</cfoutput>