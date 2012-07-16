<!DOCTYPE beans PUBLIC "-//SPRING//DTD BEAN//EN" "http://www.springframework.org/dtd/spring-beans.dtd">

<beans default-autowire="byName">
	<!-- Mura -->
	<bean id="MuraDisplayObjectManager" class="[plugin]com.meldsolutions.mura.muraDisplayObjectManager">
	</bean>

	<bean id="MuraManager" class="[plugin]com.meldsolutions.mura.MuraManager">
	</bean>
	
	<bean id="MuraCrumbManager" class="[plugin]com.meldsolutions.mura.MuraCrumbManager">
	</bean>

	<!-- Utility -->
	<bean id="mmErrorManager" class="[plugin]com.meldsolutions.utility.mmError.mmErrorManager">
	</bean>

	<bean id="mmBreadCrumbs" class="[plugin]com.meldsolutions.utility.mmBreadCrumbs.mmBreadCrumbs">
	</bean>

	<bean id="mmFormTools" class="[plugin]com.meldsolutions.utility.mmFormTools.mmFormTools">
	</bean>

	<bean id="mmFileUpload" class="[plugin]com.meldsolutions.utility.mmFileUpload.mmFileUpload">
		<constructor-arg name="fileDirectory"><value>${fileDirectory}</value></constructor-arg>
	</bean>

	<bean id="mmImageRenderer" class="[plugin]com.meldsolutions.utility.mmImageRenderer.mmImageRenderer">
	</bean>

	<bean id="mmUtility" class="[plugin]com.meldsolutions.utility.mmUtility.mmUtility">
	</bean>

	<bean id="PageManager" class="[plugin]com.meldsolutions.meldforums.utility.page.PageManager">
	</bean>

	<bean id="mmResourceBundle" class="[plugin]com.meldsolutions.utility.mmResourceBundle.mmResourceBundle">
		<constructor-arg name="applicationKey"><value>${applicationKey}</value></constructor-arg>
		<constructor-arg name="pluginFileRoot"><value>${pluginFileRoot}</value></constructor-arg>
		<constructor-arg name="rblocale"><value>${rblocale}</value></constructor-arg>
	</bean>

	<!-- remote -->
 	<bean id="MeldForumsRemote" class="[plugin]com.meldsolutions.MeldForums.remote.MeldForumsRemote" />
	<bean id="MeldForumsRemoteAOP" class="coldspring.aop.framework.RemoteFactoryBean" lazy-init="false">
		<property name="target">
			<ref bean="MeldForumsRemote" />
		</property>
		<property name="serviceName">
			<value>MeldForumsRemoteAOP</value>
		</property>
		<property name="relativePath">
			<value>|plugin|com/meldsolutions/MeldForums/remote</value>
		</property>
		<property name="remoteMethodNames">
			<value>*</value>
		</property>
		<property name="beanFactoryName">
			<value>MeldForumsBeanFactory</value>
		</property>
	</bean>

	<!-- Meld -->
	<bean id="MeldForumsManager" class="[plugin]com.meldsolutions.MeldForums.application.MeldForumsManager">
	</bean>

	<bean id="MeldForumsEventManager" class="[plugin]com.meldsolutions.meldforums.application.MeldForumsEventManager">
	</bean>

	<bean id="MeldForumsRequestManager" class="[plugin]com.meldsolutions.meldforums.application.MeldForumsRequestManager">
	</bean>

	<bean id="MeldForumsConfigurationManager" class="[plugin]com.meldsolutions.meldforums.application.MeldForumsConfigurationManager">
	</bean>

	<bean id="MeldForumsSettingsManager" class="[plugin]com.meldsolutions.meldforums.application.MeldForumsSettingsManager">
	</bean>

	<bean id="MeldForumsSearchManager" class="[plugin]com.meldsolutions.meldforums.application.MeldForumsSearchManager">
		<constructor-arg name="dsn"><value>${dsn}</value></constructor-arg>
		<constructor-arg name="dsnusername"><value>${dsnusername}</value></constructor-arg>
		<constructor-arg name="dsnpassword"><value>${dsnpassword}</value></constructor-arg>
		<constructor-arg name="dsnprefix"><value>${dsnprefix}</value></constructor-arg>
		<constructor-arg name="dsntype"><value>${dsntype}</value></constructor-arg>
	</bean>

	<!-- API -->
	<bean id="ConferenceDAO" class="[plugin]com.meldsolutions.MeldForums.core.conference.ConferenceDAO">
		<constructor-arg name="dsn"><value>${dsn}</value></constructor-arg>
		<constructor-arg name="dsnusername"><value>${dsnusername}</value></constructor-arg>
		<constructor-arg name="dsnpassword"><value>${dsnpassword}</value></constructor-arg>
		<constructor-arg name="dsnprefix"><value>${dsnprefix}</value></constructor-arg>
		<constructor-arg name="dsntype"><value>${dsntype}</value></constructor-arg>
	</bean>
	<bean id="ConferenceGateway" class="[plugin]com.meldsolutions.MeldForums.core.conference.ConferenceGateway">
		<constructor-arg name="dsn"><value>${dsn}</value></constructor-arg>
		<constructor-arg name="dsnusername"><value>${dsnusername}</value></constructor-arg>
		<constructor-arg name="dsnpassword"><value>${dsnpassword}</value></constructor-arg>
		<constructor-arg name="dsnprefix"><value>${dsnprefix}</value></constructor-arg>
		<constructor-arg name="dsntype"><value>${dsntype}</value></constructor-arg>
	</bean>
	<bean id="ConferenceService" class="[plugin]com.meldsolutions.MeldForums.core.conference.ConferenceService">
	</bean>


	<bean id="ConfigurationDAO" class="[plugin]com.meldsolutions.MeldForums.core.configuration.ConfigurationDAO">
		<constructor-arg name="dsn"><value>${dsn}</value></constructor-arg>
		<constructor-arg name="dsnusername"><value>${dsnusername}</value></constructor-arg>
		<constructor-arg name="dsnpassword"><value>${dsnpassword}</value></constructor-arg>
		<constructor-arg name="dsnprefix"><value>${dsnprefix}</value></constructor-arg>
		<constructor-arg name="dsntype"><value>${dsntype}</value></constructor-arg>
	</bean>
	<bean id="ConfigurationGateway" class="[plugin]com.meldsolutions.MeldForums.core.configuration.ConfigurationGateway">
		<constructor-arg name="dsn"><value>${dsn}</value></constructor-arg>
		<constructor-arg name="dsnusername"><value>${dsnusername}</value></constructor-arg>
		<constructor-arg name="dsnpassword"><value>${dsnpassword}</value></constructor-arg>
		<constructor-arg name="dsnprefix"><value>${dsnprefix}</value></constructor-arg>
		<constructor-arg name="dsntype"><value>${dsntype}</value></constructor-arg>
	</bean>
	<bean id="ConfigurationService" class="[plugin]com.meldsolutions.MeldForums.core.configuration.ConfigurationService">
	</bean>


	<bean id="DisplayDAO" class="[plugin]com.meldsolutions.MeldForums.core.display.DisplayDAO">
		<constructor-arg name="dsn"><value>${dsn}</value></constructor-arg>
		<constructor-arg name="dsnusername"><value>${dsnusername}</value></constructor-arg>
		<constructor-arg name="dsnpassword"><value>${dsnpassword}</value></constructor-arg>
		<constructor-arg name="dsnprefix"><value>${dsnprefix}</value></constructor-arg>
		<constructor-arg name="dsntype"><value>${dsntype}</value></constructor-arg>
	</bean>
	<bean id="DisplayGateway" class="[plugin]com.meldsolutions.MeldForums.core.display.DisplayGateway">
		<constructor-arg name="dsn"><value>${dsn}</value></constructor-arg>
		<constructor-arg name="dsnusername"><value>${dsnusername}</value></constructor-arg>
		<constructor-arg name="dsnpassword"><value>${dsnpassword}</value></constructor-arg>
		<constructor-arg name="dsnprefix"><value>${dsnprefix}</value></constructor-arg>
		<constructor-arg name="dsntype"><value>${dsntype}</value></constructor-arg>
	</bean>
	<bean id="DisplayService" class="[plugin]com.meldsolutions.MeldForums.core.display.DisplayService">
	</bean>


	<bean id="DisplaytypeDAO" class="[plugin]com.meldsolutions.MeldForums.core.displaytype.DisplaytypeDAO">
		<constructor-arg name="dsn"><value>${dsn}</value></constructor-arg>
		<constructor-arg name="dsnusername"><value>${dsnusername}</value></constructor-arg>
		<constructor-arg name="dsnpassword"><value>${dsnpassword}</value></constructor-arg>
		<constructor-arg name="dsnprefix"><value>${dsnprefix}</value></constructor-arg>
		<constructor-arg name="dsntype"><value>${dsntype}</value></constructor-arg>
	</bean>
	<bean id="DisplaytypeGateway" class="[plugin]com.meldsolutions.MeldForums.core.displaytype.DisplaytypeGateway">
		<constructor-arg name="dsn"><value>${dsn}</value></constructor-arg>
		<constructor-arg name="dsnusername"><value>${dsnusername}</value></constructor-arg>
		<constructor-arg name="dsnpassword"><value>${dsnpassword}</value></constructor-arg>
		<constructor-arg name="dsnprefix"><value>${dsnprefix}</value></constructor-arg>
		<constructor-arg name="dsntype"><value>${dsntype}</value></constructor-arg>
	</bean>
	<bean id="DisplaytypeService" class="[plugin]com.meldsolutions.MeldForums.core.displaytype.DisplaytypeService">
	</bean>


	<bean id="ForumDAO" class="[plugin]com.meldsolutions.MeldForums.core.forum.ForumDAO">
		<constructor-arg name="dsn"><value>${dsn}</value></constructor-arg>
		<constructor-arg name="dsnusername"><value>${dsnusername}</value></constructor-arg>
		<constructor-arg name="dsnpassword"><value>${dsnpassword}</value></constructor-arg>
		<constructor-arg name="dsnprefix"><value>${dsnprefix}</value></constructor-arg>
		<constructor-arg name="dsntype"><value>${dsntype}</value></constructor-arg>
	</bean>
	<bean id="ForumGateway" class="[plugin]com.meldsolutions.MeldForums.core.forum.ForumGateway">
		<constructor-arg name="dsn"><value>${dsn}</value></constructor-arg>
		<constructor-arg name="dsnusername"><value>${dsnusername}</value></constructor-arg>
		<constructor-arg name="dsnpassword"><value>${dsnpassword}</value></constructor-arg>
		<constructor-arg name="dsnprefix"><value>${dsnprefix}</value></constructor-arg>
		<constructor-arg name="dsntype"><value>${dsntype}</value></constructor-arg>
	</bean>
	<bean id="ForumService" class="[plugin]com.meldsolutions.MeldForums.core.forum.ForumService">
	</bean>


	<bean id="PostDAO" class="[plugin]com.meldsolutions.MeldForums.core.post.PostDAO">
		<constructor-arg name="dsn"><value>${dsn}</value></constructor-arg>
		<constructor-arg name="dsnusername"><value>${dsnusername}</value></constructor-arg>
		<constructor-arg name="dsnpassword"><value>${dsnpassword}</value></constructor-arg>
		<constructor-arg name="dsnprefix"><value>${dsnprefix}</value></constructor-arg>
		<constructor-arg name="dsntype"><value>${dsntype}</value></constructor-arg>
	</bean>
	<bean id="PostGateway" class="[plugin]com.meldsolutions.MeldForums.core.post.PostGateway">
		<constructor-arg name="dsn"><value>${dsn}</value></constructor-arg>
		<constructor-arg name="dsnusername"><value>${dsnusername}</value></constructor-arg>
		<constructor-arg name="dsnpassword"><value>${dsnpassword}</value></constructor-arg>
		<constructor-arg name="dsnprefix"><value>${dsnprefix}</value></constructor-arg>
		<constructor-arg name="dsntype"><value>${dsntype}</value></constructor-arg>
	</bean>
	<bean id="PostService" class="[plugin]com.meldsolutions.MeldForums.core.post.PostService">
	</bean>


	<bean id="SearchableDAO" class="[plugin]com.meldsolutions.MeldForums.core.searchable.SearchableDAO">
		<constructor-arg name="dsn"><value>${dsn}</value></constructor-arg>
		<constructor-arg name="dsnusername"><value>${dsnusername}</value></constructor-arg>
		<constructor-arg name="dsnpassword"><value>${dsnpassword}</value></constructor-arg>
		<constructor-arg name="dsnprefix"><value>${dsnprefix}</value></constructor-arg>
		<constructor-arg name="dsntype"><value>${dsntype}</value></constructor-arg>
	</bean>
	<bean id="SearchableGateway" class="[plugin]com.meldsolutions.MeldForums.core.searchable.SearchableGateway">
		<constructor-arg name="dsn"><value>${dsn}</value></constructor-arg>
		<constructor-arg name="dsnusername"><value>${dsnusername}</value></constructor-arg>
		<constructor-arg name="dsnpassword"><value>${dsnpassword}</value></constructor-arg>
		<constructor-arg name="dsnprefix"><value>${dsnprefix}</value></constructor-arg>
		<constructor-arg name="dsntype"><value>${dsntype}</value></constructor-arg>
	</bean>
	<bean id="SearchableService" class="[plugin]com.meldsolutions.MeldForums.core.searchable.SearchableService">
	</bean>


	<bean id="SettingsDAO" class="[plugin]com.meldsolutions.MeldForums.core.settings.SettingsDAO">
		<constructor-arg name="dsn"><value>${dsn}</value></constructor-arg>
		<constructor-arg name="dsnusername"><value>${dsnusername}</value></constructor-arg>
		<constructor-arg name="dsnpassword"><value>${dsnpassword}</value></constructor-arg>
		<constructor-arg name="dsnprefix"><value>${dsnprefix}</value></constructor-arg>
		<constructor-arg name="dsntype"><value>${dsntype}</value></constructor-arg>
	</bean>
	<bean id="SettingsGateway" class="[plugin]com.meldsolutions.MeldForums.core.settings.SettingsGateway">
		<constructor-arg name="dsn"><value>${dsn}</value></constructor-arg>
		<constructor-arg name="dsnusername"><value>${dsnusername}</value></constructor-arg>
		<constructor-arg name="dsnpassword"><value>${dsnpassword}</value></constructor-arg>
		<constructor-arg name="dsnprefix"><value>${dsnprefix}</value></constructor-arg>
		<constructor-arg name="dsntype"><value>${dsntype}</value></constructor-arg>
	</bean>
	<bean id="SettingsService" class="[plugin]com.meldsolutions.MeldForums.core.settings.SettingsService">
	</bean>


	<bean id="SubscribeDAO" class="[plugin]com.meldsolutions.MeldForums.core.subscribe.SubscribeDAO">
		<constructor-arg name="dsn"><value>${dsn}</value></constructor-arg>
		<constructor-arg name="dsnusername"><value>${dsnusername}</value></constructor-arg>
		<constructor-arg name="dsnpassword"><value>${dsnpassword}</value></constructor-arg>
		<constructor-arg name="dsnprefix"><value>${dsnprefix}</value></constructor-arg>
		<constructor-arg name="dsntype"><value>${dsntype}</value></constructor-arg>
	</bean>
	<bean id="SubscribeGateway" class="[plugin]com.meldsolutions.MeldForums.core.subscribe.SubscribeGateway">
		<constructor-arg name="dsn"><value>${dsn}</value></constructor-arg>
		<constructor-arg name="dsnusername"><value>${dsnusername}</value></constructor-arg>
		<constructor-arg name="dsnpassword"><value>${dsnpassword}</value></constructor-arg>
		<constructor-arg name="dsnprefix"><value>${dsnprefix}</value></constructor-arg>
		<constructor-arg name="dsntype"><value>${dsntype}</value></constructor-arg>
	</bean>
	<bean id="SubscribeService" class="[plugin]com.meldsolutions.MeldForums.core.subscribe.SubscribeService">
	</bean>


	<bean id="ThreadDAO" class="[plugin]com.meldsolutions.MeldForums.core.thread.ThreadDAO">
		<constructor-arg name="dsn"><value>${dsn}</value></constructor-arg>
		<constructor-arg name="dsnusername"><value>${dsnusername}</value></constructor-arg>
		<constructor-arg name="dsnpassword"><value>${dsnpassword}</value></constructor-arg>
		<constructor-arg name="dsnprefix"><value>${dsnprefix}</value></constructor-arg>
		<constructor-arg name="dsntype"><value>${dsntype}</value></constructor-arg>
	</bean>
	<bean id="ThreadGateway" class="[plugin]com.meldsolutions.MeldForums.core.thread.ThreadGateway">
		<constructor-arg name="dsn"><value>${dsn}</value></constructor-arg>
		<constructor-arg name="dsnusername"><value>${dsnusername}</value></constructor-arg>
		<constructor-arg name="dsnpassword"><value>${dsnpassword}</value></constructor-arg>
		<constructor-arg name="dsnprefix"><value>${dsnprefix}</value></constructor-arg>
		<constructor-arg name="dsntype"><value>${dsntype}</value></constructor-arg>
	</bean>
	<bean id="ThreadService" class="[plugin]com.meldsolutions.MeldForums.core.thread.ThreadService">
	</bean>


	<bean id="UserDAO" class="[plugin]com.meldsolutions.MeldForums.core.user.UserDAO">
		<constructor-arg name="dsn"><value>${dsn}</value></constructor-arg>
		<constructor-arg name="dsnusername"><value>${dsnusername}</value></constructor-arg>
		<constructor-arg name="dsnpassword"><value>${dsnpassword}</value></constructor-arg>
		<constructor-arg name="dsnprefix"><value>${dsnprefix}</value></constructor-arg>
		<constructor-arg name="dsntype"><value>${dsntype}</value></constructor-arg>
	</bean>
	<bean id="UserGateway" class="[plugin]com.meldsolutions.MeldForums.core.user.UserGateway">
		<constructor-arg name="dsn"><value>${dsn}</value></constructor-arg>
		<constructor-arg name="dsnusername"><value>${dsnusername}</value></constructor-arg>
		<constructor-arg name="dsnpassword"><value>${dsnpassword}</value></constructor-arg>
		<constructor-arg name="dsnprefix"><value>${dsnprefix}</value></constructor-arg>
		<constructor-arg name="dsntype"><value>${dsntype}</value></constructor-arg>
	</bean>
	<bean id="UserService" class="[plugin]com.meldsolutions.MeldForums.core.user.UserService">
	</bean>


	<bean id="ViewcounterDAO" class="[plugin]com.meldsolutions.MeldForums.core.viewcounter.ViewcounterDAO">
		<constructor-arg name="dsn"><value>${dsn}</value></constructor-arg>
		<constructor-arg name="dsnusername"><value>${dsnusername}</value></constructor-arg>
		<constructor-arg name="dsnpassword"><value>${dsnpassword}</value></constructor-arg>
		<constructor-arg name="dsnprefix"><value>${dsnprefix}</value></constructor-arg>
		<constructor-arg name="dsntype"><value>${dsntype}</value></constructor-arg>
	</bean>
	<bean id="ViewcounterGateway" class="[plugin]com.meldsolutions.MeldForums.core.viewcounter.ViewcounterGateway">
		<constructor-arg name="dsn"><value>${dsn}</value></constructor-arg>
		<constructor-arg name="dsnusername"><value>${dsnusername}</value></constructor-arg>
		<constructor-arg name="dsnpassword"><value>${dsnpassword}</value></constructor-arg>
		<constructor-arg name="dsnprefix"><value>${dsnprefix}</value></constructor-arg>
		<constructor-arg name="dsntype"><value>${dsntype}</value></constructor-arg>
	</bean>
	<bean id="ViewcounterService" class="[plugin]com.meldsolutions.MeldForums.core.viewcounter.ViewcounterService">
	</bean>

	<bean id="ThemeDAO" class="[plugin]com.meldsolutions.MeldForums.core.theme.ThemeDAO">
		<constructor-arg name="dsn"><value>${dsn}</value></constructor-arg>
		<constructor-arg name="dsnusername"><value>${dsnusername}</value></constructor-arg>
		<constructor-arg name="dsnpassword"><value>${dsnpassword}</value></constructor-arg>
		<constructor-arg name="dsnprefix"><value>${dsnprefix}</value></constructor-arg>
		<constructor-arg name="dsntype"><value>${dsntype}</value></constructor-arg>
	</bean>
	<bean id="ThemeGateway" class="[plugin]com.meldsolutions.MeldForums.core.theme.ThemeGateway">
		<constructor-arg name="dsn"><value>${dsn}</value></constructor-arg>
		<constructor-arg name="dsnusername"><value>${dsnusername}</value></constructor-arg>
		<constructor-arg name="dsnpassword"><value>${dsnpassword}</value></constructor-arg>
		<constructor-arg name="dsnprefix"><value>${dsnprefix}</value></constructor-arg>
		<constructor-arg name="dsntype"><value>${dsntype}</value></constructor-arg>
	</bean>
	<bean id="ThemeService" class="[plugin]com.meldsolutions.MeldForums.core.theme.ThemeService">
	</bean>
</beans>