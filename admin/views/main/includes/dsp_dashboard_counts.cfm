<cfoutput>
	<table class="mf-dashboard-table">
		<tr>
			<th colspan="2">
			#rc.mmRBF.key('counts')#
			</th>
		</tr>
		<tr>
			<td class="varWidth">
				#rc.mmRBF.key('conferences')#
			</td>
			<td>
				#rc.conferenceCount#
			</td>
		</tr>
		<tr class="alt">
			<td class="varWidth">
				#rc.mmRBF.key('forums')#
			</td>
			<td>
				#rc.forumCount#
			</td>
		</tr>
		<tr>
			<td class="varWidth">
				#rc.mmRBF.key('threads')#
			</td>
			<td>
				#rc.threadCount#
			</td>
		</tr>
		<tr class="alt">
			<td class="varWidth">
				#rc.mmRBF.key('posts')#
			</td>
			<td>
				#rc.postCount#
			</td>
		</tr>
	</table>
</cfoutput>