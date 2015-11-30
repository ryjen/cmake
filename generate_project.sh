#!/bin/sh

if [ ! -x $(which ed) ]; then
	echo "ed binary required for this script to work."
	exit 1
fi

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
	echo "Syntax: $0 <name> <version> <description>"
	exit 1
fi

basedir=`dirname $0`
template="$basedir/list_template.cmake"
listfile="./CMakeLists.txt"

if [ -f $listfile ]; then
	echo "$listfile already exists, overwrite? "
	read -n 1 c

	if [ $c != 'y' ] && [ $c != 'Y' ]; then
		exit 1
	fi
fi

cp -f $template $listfile

echo "Generating $listfile..."

echo "Setting project name:        $1"
ed -s $listfile <<EOF
,s/@PROJECT_NAME@/$1/g
w
EOF

echo "Setting project version:     $2"
ed -s $listfile <<EOF
,s/@PROJECT_VERSION@/$2/g
w
EOF

echo "Setting project description: $3"
ed -s $listfile <<EOF
,s/@PROJECT_DESCRIPTION@/$3/g
w
EOF

echo "Done."

exit 0

