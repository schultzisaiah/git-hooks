#!/bin/sh
#
# This script should be copied to the "hooks" subdirectory of your project's
# ".git" directory. If you want it to run before every commit, then rename this
# file to "pre-commit" (with NO file extension). If you want to run it before
# every push instead, then rename it to "pre-push" (with NO file extension).
# Make sure that this file is executable.
#
# If done properly, then git will automatically run this script before every
# commit/push!
#
# If you'd like to support a "ci skip" indicator in commit messages, that can
# also be done. If all commits involved in this hook have that indicator, the
# the hook will be skipped.

ci_skip_command = '\[ci-skip\]'

if (git log --oneline origin/master..HEAD | grep -v "$ci_skip_command")
then
	mvn test 2>&1 | tee commit.log
	grep -q "BUILD SUCCESS" commit.log
	exit $?
fi
