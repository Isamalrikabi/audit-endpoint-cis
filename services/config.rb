coreo_agent_selector_rule 'check-linux' do
    action :define
    timeout 30
    control 'check-linux' do
        describe os.linux? do
            it { should eq true }
        end
    end
end

coreo_agent_audit_profile 'cis-dil-benchmark' do
    action :define
    selectors ['check-linux']
    profile 'https://github.com/dev-sec/cis-dil-benchmark/archive/master.zip'
    timeout 120
end

coreo_agent_rule_runner 'cis-endpoints-agent-rules' do
    action :run
    profiles ${AUDIT_AGENT_ENDPOINTS_PROFILES_ALERT_LIST}
    filter(${FILTERED_OBJECTS}) if ${FILTERED_OBJECTS}
end
