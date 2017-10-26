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

coreo_agent_rule_runner 'agent-rules' do
    action :run
    rules ${AUDIT_AGENT_RULES_ALERT_LIST}
    profiles ${AUDIT_AGENT_PROFILES_ALERT_LIST}
    filter(${FILTERED_OBJECTS}) if ${FILTERED_OBJECTS}
end