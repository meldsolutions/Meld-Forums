<cfsilent>
	<!--- rc --->
	<!--- headers --->
		<cfset rc.Forums = rc.aForums['itemArray'] />
</cfsilent><cfoutput>
<script>
$(document).ready(function() {

	$('##doSort').sortable(
		{
			axis: "y",
			update: function( event, ui ) {
				var ordering = $(this).sortable('toArray').toString();
				$('##sortOrder').val( ordering );
			}
		}
	);	
});
	
</script>
<!--- global menu --->
<!--- begin content --->
		<!-- CONTENT HERE -->
	<div class="row">
		<div class="span12">
			#view("/global/bc")#
		</div>
	</div>

<div class="row">
	<div class="span12">

	<form method="post">
	<input type="hidden" id="sortOrder" name="sortOrder" value="" />
	<input type="hidden" name="btAction" value="sort" />
	<input type="hidden" name="conferenceID" value="#rc.conferenceID#" />
	
	
	<div class="fieldset">

		<div class="control-group">
			<div class="controls">
			<ul id="doSort" class="sortable">	
				<cfloop from="1" to="#ArrayLen(rc.Forums)#" index="rc.x">
					<li id="#rc.Forums[rc.x].ForumID#">
						#rc.Forums[rc.x]['name']#
					</li>
					
				</cfloop>
				
			</ul>		
			</div>
		</div>

			<div class="form-actions">
			
				<a href="#buildURL('admin:Forums.default')#" class="btn"><i class="icon-remove"></i>#rc.mmRBF.key('cancel')#</a>
				<button type="submit" class="btn"><i class="icon-check"></i>#rc.mmRBF.key('save')#</button>
				 
			</div><!--- /form-actions --->

	</div>
	</form>
		
	</div>		
</div>		

		
		
		
		
<!--- end content --->
</cfoutput> 
