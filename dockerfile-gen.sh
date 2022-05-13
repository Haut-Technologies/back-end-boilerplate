sed 's/RUN env/CMD env/g' Dockerfile |\
  sed 's/--release .*//g' |\
  sed 's/cp .*//g' |\
  sed 's/rm .*//g' |\
  sed 's+--from=builder .*/+bin/+g' |\
  awk '/FROM/{x=++i;}{ name=(x==1) ? "dev-builder" : "dev-server"; print > sprintf("%s.Dockerfile", name) }'