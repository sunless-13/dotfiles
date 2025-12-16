# bash prompt
PS1='$(date +%R) \w '
if [ -n "$GUIX_ENVIRONMENT" ]
then
		export PS1="$(date +%R) \w [dev] "
fi

# shell optional behaviors change
shopt -s autocd cdspell dirspell

# direnv
# eval "$(direnv hook bash)"
