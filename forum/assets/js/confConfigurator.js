function initConfConfigurator(data){
    initConfigurator(
        data,
        {
        url:'../plugins/MeldForums/index.cfm?action=admin:configurator&',
        pars:'',
        title: 'Conferences (Select)',
        init: function(){},
        destroy: function(){},
        validate: function(){
                    return true;
                    }
        }
    );
    return true;
}