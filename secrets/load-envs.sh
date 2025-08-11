function load-envs {
  repo="$1"
  environment="$2"

  allowed_repos=$(
    find ~/secrets -maxdepth 1 -type d -mindepth 1 | xargs basename
  )
  if ! printf "${allowed_repos}" | grep -x "$repo"; then
    echo "You don't know what u r doing :(, Unknown repo: $repo"
    return 1
  fi

  if [[ -z "$environment" ]]; then
    echo "Loading $repo:default secrets"
    eval "$(ansible-vault view "$HOME/secrets/$repo/secret.sh")"
  else
    echo "Loading $repo:$environment secrets"
    eval "$(ansible-vault view "$HOME/secrets/$repo/$environment/secret.sh")"
  fi
}
