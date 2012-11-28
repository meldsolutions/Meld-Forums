<cfoutput>
    <div id="availableObjectParams"
        data-object="plugin"
        data-name="Conferences (Select)"
        data-objectid="#rc.$.event('objectID')#">
        	<input type="hidden" name="action" class="objectParam" value="conference.select">
        <dl class="singleColumn">
        <dt>Select Conferences</dt>
        <dd>
        <ul>
        <cfloop from="1" to="#ArrayLen(rc.aConferences)#" index="rc.x">
			<cfset rc.conferenceBean = rc.aConferences[rc.x] />
			<li><input type="checkbox" class="objectParam" name="conferenceIDList" value="#rc.conferenceBean.getConferenceID()#"
			<cfif listContains(rc.params.conferenceIDList,rc.conferenceBean.getConferenceID())> CHECKED="CHECKED"</cfif>
			> #rc.conferenceBean.getName()#</li>
		</cfloop>
        </ul>
			</dd>
		</dl>
    </div>
</cfoutput>
