<cfoutput>
	<table class="table table-striped table-condensed table-bordered mura-table-grid">
		<tr>
			<th colspan="2">
			#rc.mmRBF.key('counts')#
			</th>
		</tr>
		<tr>
			<td >
				#rc.mmRBF.key('conferences')#
			</td>
			<td>
				#rc.conferenceCount#
			</td>
		</tr>
		<tr>
			<td >
				#rc.mmRBF.key('forums')#
			</td>
			<td>
				#rc.forumCount#
			</td>
		</tr>
		<tr>
			<td >
				#rc.mmRBF.key('threads')#
			</td>
			<td>
				#rc.threadCount#
			</td>
		</tr>
		<tr>
			<td >
				#rc.mmRBF.key('posts')#
			</td>
			<td>
				#rc.postCount#
			</td>
		</tr>
	</table>
</cfoutput>