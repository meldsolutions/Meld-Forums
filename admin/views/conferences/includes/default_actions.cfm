﻿<!---
This file is part of the Meld Forums application.

Meld Forums is licensed under the GPL 2.0 license
Copyright (C) 2010 2011 Meld Solutions Inc. http://www.meldsolutions.com/

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
<div class="row">
	<div class="span12">
		<a href="#buildURL('admin:conferences.reorder')#" title="#rc.mmRBF.key('reorder','tip')#" class="btn"><i class="icon-reorder"></i> #rc.mmRBF.key('reorder')#</a>
		<a href="#buildURL('admin:conferences.edit')#" title="#rc.mmRBF.key('addnewconference','tip')#" class="btn pull-right"><i class="icon-plus-sign"></i> #rc.mmRBF.key('addnewconference')#</a>
	</div>
</div>
</cfoutput>