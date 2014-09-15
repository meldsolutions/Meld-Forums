<!---

This file is part of the Meld Forums application.

Meld Forums is licensed under the GPL 2.0 license
Copyright (C) 2010 Meld Solutions Inc. http://www.meldsolutions.com/

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation, version 2 of that license..

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

--->
<cfoutput>
#view("conferences/includes/default_actions")#
<br/>

<div class="row">
	<div class="span12">
		<table id="ms-datatable" class="table table-striped table-condensed table-bordered mura-table-grid clickable sorting"
			data-url="#$.globalConfig().getContext()#/plugins/#rc.pluginConfig.getDirectory()#/?action=admin:remote.conf&data"
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
			<tbody role="alert" aria-live="polite" aria-relevant="all"></tbody>
		</table>
	</div>
</div>

</cfoutput>