


<cfoutput>

#view("conferences/includes/default_actions")#
<br/>

<div class="row">
	<div class="span12">
		<table id="ms-datatable" class="table table-striped table-condensed table-bordered mura-table-grid clickable sorting"
			data-url="#$.globalConfig().getContext()#/plugins/#rc.pluginConfig.getDirectory()#/com/meldsolutions/meldforums/remote/MeldForumsRemoteAOP.cfc?siteID=#rc.siteID#&method=getConferenceList&data&returnFormat=json"
		   data-delete-message='#rc.mmRBF.key('deleteconference-msg')#'>
			<thead class="headers">
			<tr>
				<th class="varWidth" data-class="left">#rc.mmRBF.key('name')#</th>
				<th class="nosort" data-class="center">#rc.mmRBF.key('forumcount')#</th>
				<th class="nosort" data-class="center">#rc.mmRBF.key('threadcount')#</th>
				<th class="nosort" data-class="center">#rc.mmRBF.key('status')#</th>
				<th class="nosort nopad" data-class="nopad">&nbsp;</th>
			</tr>
			</thead>
			<thead class="search" id="ms-datatable_search">
			<tr>
				<th><input class="searchable text full" type="text" id="flt_name" data-column="name"></th>
				<th></th>
				<th></th>
				<th>
				<select class="select" name="isactive" id="flt_isactive" data-column="isactive">
					<option value="1">#rc.mmRBF.key('active1')#</option>
					<option value="0">#rc.mmRBF.key('active0')#</option>
				</select>
				</th>
				<th>
					<a  title="#rc.mmRBF.key('clearfilter')#" id="clearFilter" href='####'><i class='icon-refresh'></i></a>
					<a  title="#rc.mmRBF.key('setfilter')#" id="setFilter" href='####'><i class='icon-ok'></i></a>
				</th>
			</tr>
		</thead>
			<tbody role="alert" aria-live="polite" aria-relevant="all">
		</table>
	</div>
</div>

</cfoutput>