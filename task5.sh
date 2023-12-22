#!/bin/bash
number_total=0
correct_guesses=0
round=1
number_history=()
COLOR_NORMAL='\033[0m'
COLOR_CORRECT='\033[32m'
COLOR_INCORRECT='\033[31m'

function prompt_and_play {
  local generated_number=$(( RANDOM % 10 ))
  echo "Step: $round"
  read -p "Please enter number from 0 to 9 (q to quit): " user_input
  case $user_input in
    [0-9])
      ((number_total++))
      if [[ $user_input -eq $generated_number ]]; then
        echo "Hit! My number: $generated_number"
        ((correct_guesses++))
        number_history+=("${COLOR_CORRECT}${generated_number}${COLOR_NORMAL}")
      else
        echo "Miss! My number: $generated_number"
        number_history+=("${COLOR_INCORRECT}${generated_number}${COLOR_NORMAL}")
      fi
      calculate_and_display_stats
      display_last_ten_guesses
      ((round++))
      ;;
    q)
      echo "Game finished. Thanks for playing."
      exit 0
      ;;
    *)
      echo "Invalid input! Only digits from 0-9 or q to quit."
      ;;
  esac
}

function calculate_and_display_stats {
  local hit_rate=$((correct_guesses * 100 / number_total))
  local miss_rate=$((100 - hit_rate))
  echo -e "Hit: ${hit_rate}% Miss: ${miss_rate}%"
}

function display_last_ten_guesses {
  if [[ ${#number_history[@]} -le 10 ]]; then
    echo -e "Numbers: ${number_history[*]}"
  else
    local last_elements=${number_history[@]: -10}
    echo -e "Numbers: ${last_elements[*]}"
  fi
}

while true; do
  prompt_and_play
done
