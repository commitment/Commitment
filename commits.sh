#!/bin/bash

# i?
dayInc=0
weekInc=0
cycleInc=0
commitCount=1

for i in {0..364}
	do
		# echo $i
		nd=`date -v -1y -v +sun -v +${i}d`
		weekSwitch=$(echo "${i} % 7" | bc)
		commits=0

		if [[ $weekSwitch -eq 0 ]];
			then 
				echo "Next week"
				weekInc=$(($weekInc+1))
				cycleInc=$(($cycleInc+1))
		fi;

		if [[ $cycleInc -eq 9 ]]
			then
				cycleInc=1
		fi

		echo "cycleInc: " + $cycleInc

		case $cycleInc in
	        1)
				commits=0
				;;
	         
	        2)
				commits=1
				;;
			3)
				commits=3
				;;
			4)
				commits=5
				;;
			5)
				commits=10
				;;
			6)
				commits=5
				;;
			7)
				commits=3
				;;
			8)
				commits=1
				;;
			*)
		esac
		
		# export GIT_AUTHOR_DATE=$nd
		# export GIT_COMMITTER_DATE=$nd
		echo $nd + ", Commits: " + $commits

		if [[ $commits != 0 ]]
			then
				for (( j = 0; j <= $commits ; j++ ))
					do
						out=$(echo "Commit " + $commitCount)
						# echo $out
						echo $out >> ./README.md
						git commit -am "$out" --date "$nd"
						# echo "export GIT_AUTHOR_DATE=$nd export GIT_COMMITTER_DATE=$nd"
						# git 
						commitCount=$(($commitCount+1))
				done
		fi


		dayInc=$(($dayInc+1))

done
