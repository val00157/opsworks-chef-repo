stack = node[:opsworks][:stack][:name] 
params = data_bag_item("monitor", stack)["CloudWatch"]

params["Alarms"].each do |cwParams|
puts cwParams["CW_ALARM_NAME"]
    bash "" do
      user "root"
      environment(
        "ACCESS_KEY"    => params["AWS_ACCESS_KEY"],
        "SECRET_KEY"    => params["AWS_SECRET_KEY"],
        "REGION"        => params["AWS_REGION"],
        "ALARM_NAME"    => cwParams["CW_ALARM_NAME"],
        "METRIC_NAME"   => cwParams["CW_METRIC_NAME"],
        "VALUE"         => cwParams["CW_THRESHOLD_VALUE"],
        "ARN"           => cwParams["CW_ALARM_ACTION_ARN"]
      )
      code <<-EOC
        source ~/.bashrc

        export AWS_GENERAL_OPTIONS="-I ${ACCESS_LEY} -S ${SECRET_KEY} --region ${REGION}"
        instanceId=`wget -q -O - http://169.254.169.254/latest/meta-data/instance-id`
        alarmName="${ALARM_NAME}-${instanceId}"
        metricName="${METRIC_NAME}"

        mon-put-metric-alarm \
            ${alarmName} \
            --comparison-operator LessThanOrEqualToThreshold \
            --evaluation-periods 1 \
            --metric-name $metricName \
            --namespace "System/Linux" \
            --period 300 \
            --statistic Average \
            --threshold ${VALUE} \
            --alarm-actions ${ARN} \
            $AWS_GENERAL_OPTIONS 
    EOC
end
end
