function sa() {
    pat="$*"
    alias | grep -E "$pat"
}
openJenkinsJob () {
	JOB=$1 
	local url="http://gueaplatci01.skybet.net:8080/job/${JOB}/"
	local lastBuildUrl=${url}/lastBuild/buildNumber
	if [[ ${JOB} =~ "STAGE|LIVE|TEST_[1-8]" ]]
	then
		last_job=$( curl ${lastBuildUrl} ) 
		job_num=$(( last_job + 1)) 
		response_code=400 
		while [[ ${response_code} != 200 ]]
		do
			response_code=$(curl -I ${url}/${job_num}/console 2>/dev/null | awk 'NR==1{print $2}') 
			sleep 5
		done
		nohup xdg-open ${url}/${job_num}/console &>/dev/null
	fi
}
