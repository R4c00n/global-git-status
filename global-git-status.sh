script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";
source "${script_dir}/.env";

# Search for uncomitted changes in all git 
# repositories on this machine
email_body="";
for d in `sudo find $GIT_SEARCH_BASE_DIR -name ".git"`; do
  cd $d/..;
  if ! [[ `git status` =~ "nothing to commit" ]]; then
    email_body+="Please commit here: `pwd`";
    email_body+="\n"
  fi
done

# Send email if not commited changes were found
if ! [[ email_body == "" ]]; then
  swaks --body "$email_body" \
  --h-Subject "Some files waiting to get comitted!" \
  --to $EMAIL_TO \
  --from $EMAIL_FROM \
  --server $SMTP_HOST \
  --auth LOGIN \
  --auth-user $SMTP_USER \
  --auth-password $SMTP_PASSWORD \
  -tls &> /dev/null
  echo "Sent mail:";
  echo "$email_body";
else
  echo "Nothing to commit :)";
fi
