<cfsilent>
	<cfparam name="rc.conferenceID" default="" />
</cfsilent>
<cfoutput>

#view("forums/includes/default_actions")#
<br/>

<div class="row">
	<div class="span12">
		<table id="ms-datatable" class="table table-striped table-condensed table-bordered mura-table-grid clickable sorting"
			data-url="#$.globalConfig().getContext()#/plugins/#rc.pluginConfig.getDirectory()#/?action=admin:remote.forum&data"
			data-delete-message='#rc.mmRBF.key('deleteforum-msg')#'>
			<thead class="headers">
			<tr>
				<th class="varWidth">#rc.mmRBF.key('name')#</th>
				<th class="nosort">#rc.mmRBF.key('conference')#</th>
				<th class="nosort" data-class="center">#rc.mmRBF.key('threadcount')#</th>
				<th class="nosort" data-class="center">#rc.mmRBF.key('postcount')#</th>
				<th class="nosort" data-class="center">#rc.mmRBF.key('viewcount')#</th>
				<th class="nosort" data-class="center">#rc.mmRBF.key('status')#</th>
				<th class="nosort nopad" data-class="nopad">&nbsp;</th>
			</tr>
			</thead>
			<thead class="search" id="ms-datatable_search">
			<tr>
				<th><input class="searchable text full" type="text" id="flt_name" data-column="name"></th>
				<!---<cfif not len(rc.conferenceid)>--->
				<th>
				<select class="select" name="conferenceID" id="flt_conferenceid" data-column="conferenceid">
					<option value="">#rc.mmRBF.key('any')#</option>
					<cfloop from="1" to="#arrayLen(rc.aConferences)#" index="local.iiX">
						<option value="#rc.aConferences[local.iiX].getConferenceID()#"<cfif len(rc.conferenceID) and rc.aConferences[local.iiX].getConferenceID() eq rc.conferenceID>SELECTED</cfif>>#rc.aConferences[local.iiX].getName()#</option>
					</cfloop>
				</select>
				</th>
				<!---</cfif>--->
				<th></th>
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