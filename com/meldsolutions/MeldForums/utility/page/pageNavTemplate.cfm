<!--- 

Scoped variables:

		iiX				// for loops			

		sNavString  	// contains the entire page navigation block	
		sNavBack		// contains the back navigation	
		sNavNext		// contains the forward navigation
		sNavPage		// contains the page navigation
		iPageNumber		// current page number
		iPageCount		// total pages
		iPagingSize		// number of records / page
		themeBean		// number of records / page
		settingsBean	// number of records / page


 --->
<cfsilent>
<cfif pageBean.getPages()>
	<cfif pageBean.getPage() lte 1>
		<cfsavecontent variable="sNavBack">
			<cfoutput><ul class='mf-navlist mf-navlist-back mf-navlist-off'>
				<li class='first'>#rc.mmRBF.key('first')#</li><li class='previous'>#rc.mmRBF.key('previous')#</li>
			</ul></cfoutput>
		</cfsavecontent>
	<cfelse>
		<cfsavecontent variable="sNavBack">
			<cfoutput><ul class='mf-navlist mf-navlist-back'>
					<li class='mf-navlist-first'><a href='./?#getNavByPage(pageBean,0,1)#'>#rc.mmRBF.key('first')#</a></li>
					<li class='mf-navlist-previous'><a href='./?#getNavByPage(pageBean,-1)#'>#rc.mmRBF.key('previous')#</a></li>
				</ul></cfoutput>
		</cfsavecontent>
	</cfif>
	<cfif pageBean.getPage() gte pageBean.getPages()>
		<cfsavecontent variable="sNavNext">
			<cfoutput><ul class='mf-navlist mf-navlist-next mf-navlist-off'>
					<li class='next'>#rc.mmRBF.key('next')#</li><li class='last'>#rc.mmRBF.key('last')#</li>
				</ul></cfoutput>
		</cfsavecontent>
	<cfelse>
		<cfsavecontent variable="sNavNext">
			<cfoutput><ul class='mf-navlist mf-navlist-next mf-navlist-off'>
				<li class='next'><a href='?#getNavByPage(pageBean,1)#'>#rc.mmRBF.key('next')#</a></li>
				<li class='last'><a href='?#getNavByPage(pageBean,0,pageBean.getPageLimit())#'>#rc.mmRBF.key('last')#</a></li></ul>
				</ul></cfoutput>
		</cfsavecontent>
	</cfif>	
</cfif>
</cfsilent>
<cfif pageBean.getPages()>
	<cfoutput>
	#sNavBack#
	<ul class="mf-navlist mf-navlist-pages">
	</cfoutput>
	<cfloop from="#iPageNumber#" to="#iPageCount#" index="iiX">
		<cfif iiX eq pageBean.getPage()>
			<cfoutput><li class='mf-navlist-page current mf-navlist-page-#iiX#'>#iiX#</li>
			</cfoutput>
		<cfelse>
			<cfoutput><li class='mf-navlist-page mf-navlist-page-#iiX#'><a href='?#getNavByPage(pageBean,0,iiX)#'>#iiX#</a></li>
			</cfoutput>
		</cfif>
	</cfloop>
	<cfoutput>
	</ul>
	#sNavNext#
	<span class="mf-navlist-info">[ #pageBean.getPages()# <cfif pageBean.getPages() gt 1>#rc.mmRBF.key('pages')#<cfelse>#rc.mmRBF.key('page')#</cfif> ]</span>
	</cfoutput>
</cfif>
